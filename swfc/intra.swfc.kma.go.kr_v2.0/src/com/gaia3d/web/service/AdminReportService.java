package com.gaia3d.web.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.SocketException;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.commons.lang.time.DateUtils;
import org.apache.commons.net.PrintCommandListener;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.joda.time.LocalDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.security.access.hierarchicalroles.UserDetailsWrapper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.interceptor.DefaultTransactionAttribute;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.gaia3d.web.controller.ReportController.ForecastReportType;
import com.gaia3d.web.dto.ChartSummaryDTO;
import com.gaia3d.web.dto.ForecastReportDTO;
import com.gaia3d.web.dto.ChartSummaryDTO.DataType;
import com.gaia3d.web.dto.ChartSummaryDTO.Duration;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.mapper.ChartDataMapper;
import com.gaia3d.web.mapper.DailySituationReportMapper;
import com.gaia3d.web.mapper.ForecastReportMapper;
import com.gaia3d.web.user.WebUser;
import com.gaia3d.web.util.PageNavigation;
import com.google.common.base.Function;
import com.google.common.base.Predicate;
import com.google.common.collect.Iterables;
import com.google.common.collect.ListMultimap;
import com.google.common.collect.Multimaps;

@SuppressWarnings("deprecation")
@Service
public class AdminReportService extends BaseService  {
	
	/**
	 * 트랜젝션 처리를 위한 변수
	 */
	@Autowired(required=true)
	private PlatformTransactionManager txManager;
	
	private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	private static final SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Value("${comis.ftp.host}")
	private String comisFtpHost;
	
	@Value("${comis.ftp.port}")
	private String comisFtpPort;
	
	@Value("${comis.ftp.user}")
	private String comisFtpUser;
	
	@Value("${comis.ftp.password}")
	private String comisFtpPassword;
	
	@Value("${comis.ftp.workingDir}")
	private String comisFtpWorkingDir;
	
	@Value("${forecast.report.notice1Desc}")
	private String notice1Desc;
	
	@Value("${forecast.report.notice2Desc}")
	private String notice2Desc;
	
	@Value("${forecast.report.notice3Desc}")
	private String notice3Desc;
	
	@Value("${forecast.report.fileTitle}")
	private String fileTitle;
	
	@Autowired
    private ServletContext servletContext;
	
	private FileSystemResource ForecastReportLocationSystem;
	
	public FileSystemResource getForecastReportLoationSystem() {
		return ForecastReportLocationSystem;
	}
	
	public void setForecastReportLocaiontSystem(FileSystemResource forecastReportLocationSystem) {
		ForecastReportLocationSystem = forecastReportLocationSystem;
	}
	
	public String[] not1_desc() {
		return notice1Desc.split("\\r?\\n");
	}
	
	public String[] not2_desc() {
		return notice2Desc.split("\\r?\\n");
	}
	
	public String[] not3_desc() {
		return notice3Desc.split("\\r?\\n");
	}
	
	public String[] file_title() {
		return fileTitle.split("\\r?\\n");
	}
	
	/**
	 * 보고서를 검색한다.
	 * 
	 * @param params
	 * @return
	 */
	public Map<String, Object> listAdminReport(Map<String, Object> params) {
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		Map<String, Object> data = new HashMap<String, Object>();

		Calendar cal = Calendar.getInstance();
		
		// 발표일시 검색종료 일자가 없을 경우
		if(!params.containsKey("endDate")){
			// 금일을 검색종료 일자로 파라메터에 추가한다.
			params.put("endDate", sdf.format(cal.getTime()));
		}
		
		// 발표일시 검색종료 시간이 없을 경우
		if(!params.containsKey("endHour")){
			// 현재 시간을 검색종료 시간으로 파라메터에 추가한다.
			String endHour = String.valueOf( cal.get(Calendar.HOUR_OF_DAY) ); 
			// 현재 시간이 한자리인 경우 두자리의 문자열로...
			if(endHour.length() <= 1) endHour = "0" + endHour;
			
			params.put("endHour", endHour);
		}
		
		// 캘린더를 1년 전으로 설정한다.
		cal.add(Calendar.YEAR, -1);
		
		// 발표일시 검색시작 일자가 없을 경우
		if(!params.containsKey("startDate")){
			// 1년 전의 현재 일자를 검색시작 일자로 파라메터에 추가한다.
			params.put("startDate", sdf.format(cal.getTime()));
		}
		
		// 발표일시 검색시작 시간이 없을 경우
		if(!params.containsKey("startHour")){
			// 1년 전의 현재 시간을 검색시작 시간으로 파라메터에 추가한다.
			String startHour = String.valueOf( cal.get(Calendar.HOUR_OF_DAY) ); 
			// 현재 시간이 한자리인 경우 두자리의 문자열로...
			if(startHour.length() <= 1) startHour = "0" + startHour;
			
			params.put("startHour", startHour);
		}
		
		// 총 검색수
		int count = mapper.Count(params);
		// 현재 페이지
		int page = Integer.parseInt(String.valueOf(params.get("page")));
		// 페이지당 표출될 게시물의 수
		int pageSize = Integer.parseInt(String.valueOf(params.get("pageSize")));
		
		// 페이징 처리를 하기위한 페이지네비게이션
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		
		params.put("startRow", navigation.getStartRow());
		params.put("endRow", navigation.getEndRow());
		
		// 보고서 목록을 검색한다.
		List<ForecastReportDTO> list = mapper.SelectMany(params);
		
		// 검색결과를 Map에 담는다.
		data.put("list", list);
		// 페이지네비게이션을 Map에 담는다.
		data.put("pageNavigation", navigation);
		// 검색조건을 Map에 담는다.
		data.put("searchInfo", params);
		
		// 검색결과를 반환한다.
		return data;
	}
	
	/**
	 * 보고서를 조회한다.
	 * 
	 * @param params
	 * @return
	 */
	public ForecastReportDTO selectAdminReport(Map<String, Object> params) {
		ForecastReportDTO report = null;
		
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class); 
		
		// 보고서를 조회한다.
		report = mapper.SelectOne(params);
		
		if(ForecastReportType.WRN == report.getRpt_type()){
			report.setFile_path1(report.getFile_path1());
			report.setFile_path2(report.getFile_path2());
		}
		
		// 조회결과를 반환한다.
		return report;
	}

	/**
	 * 보고서 등록화면의 기본 설정 데이타를 가져온다.
	 * 
	 * @param rpt_type
	 * @param params
	 * @return
	 */
	public ForecastReportDTO getDefaultReportData(ForecastReportType rpt_type, Map<String, Object> params) {
		ForecastReportDTO report = null;
		
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		
		report = new ForecastReportDTO();
		
		report.setRpt_type(rpt_type);
		report.setRpt_kind(params.get("rpt_kind").toString());
		report.setWrite_dt(new Date());
		
		// 보고서 발표자를 로그인유저로 설정한다.
		UserDetailsWrapper userDetailWrapper = (UserDetailsWrapper)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		WebUser user = (WebUser)userDetailWrapper.getUnwrappedUserDetails();
		String writer = user.getDetail().getName();
		report.setWriter(writer);
		
		// 발표일시를 설정한다.
		setPublishDate(report);
		// 상세정보를 설정한다.
		setNoticeDesc(report);
		
		// 발행호수를 설정한다.
		report.setPublish_seq_n(mapper.selectNextPublishSeqN(report));
		
		if(rpt_type == ForecastReportType.FCT) {
			if("N".equals(params.get("rpt_kind").toString())) {
				// 신통보문의 기본 데이타를 가져온다.
				getDefaultNewForecastReportData(report, params);
			} else {
				// 구통보문의 기본 데이타를 가져온다.
				getDefaultOldForecastReportData(report, params);
			}
		}
		
		if(rpt_type == ForecastReportType.WRN) {
			String rmk1 = mapper.selectNextWrnPublishSeqN(report);
			int wrnPublishSeq = -1;
			try{
				wrnPublishSeq = Integer.parseInt( rmk1 );
			}catch(NumberFormatException e){
				wrnPublishSeq = 1;
			}
			report.setRmk1(String.valueOf(wrnPublishSeq));
		}
		
		return report;
	}
	
	/**
	 * 보고서를 등록한다.
	 * 
	 * @param report
	 * @param params
	 */
	public void insertAdminReport(ForecastReportDTO report, Map<String, Object> params) {
		
		DefaultTransactionDefinition def = new DefaultTransactionAttribute();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus = txManager.getTransaction(def);
		
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		
		try {
			
			mapper.Insert(report);
			
			txManager.commit(txStatus);
		} catch (Exception e) {
//			e.printStackTrace();
			txManager.rollback(txStatus);
		}
	}
	
	/**
	 * 보고서를 등록한다.
	 * 
	 * @param report
	 * @param params
	 */
	public void updateAdminReport(ForecastReportDTO report, Map<String, Object> params) {
		
		DefaultTransactionDefinition def = new DefaultTransactionAttribute();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus = txManager.getTransaction(def);
		
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		
		try {
			
			mapper.Update(report);
			
			txManager.commit(txStatus);
		} catch (Exception e) {
			// TODO: handle exception
			txManager.rollback(txStatus);
		}
	}
	
	/**
	 * 보고서의 저장 경로와 파일명을 등록한다.
	 * 
	 * @param report
	 */
	public void updateAdminReportFileInfo(ForecastReportDTO report) {
		
		DefaultTransactionDefinition def = new DefaultTransactionAttribute();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus = txManager.getTransaction(def);
		
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		
		try {
			mapper.updateAdminReportFileInfo(report);
			
			txManager.commit(txStatus);
		} catch (Exception e) {
			txManager.rollback(txStatus);
		}
	}
	
	/**
	 * 보고서의 저장경로와 파일명을 조회한다.
	 * 
	 * @param params
	 * @return
	 */
	public ForecastReportDTO selectAdminReportFileInfo(Map<String, Object> params) {
		ForecastReportDTO report = null;
		
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class); 
		
		// 보고서를 조회한다.
		report = mapper.selectAdminReportFileInfo(params);
		
		// 조회결과를 반환한다.
		return report;
	}
	
	/**
	 * 보고서를 삭제한다.
	 * @param params
	 */
	public void deleteAdminReport(MapperParam params) {
		DefaultTransactionDefinition def = new DefaultTransactionAttribute();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus = txManager.getTransaction(def);
		
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		
		try {
			mapper.Delete(params);
			
			txManager.commit(txStatus);
		} catch (Exception e) {
			// TODO: handle exception
			txManager.rollback(txStatus);
		}
	}
	
	/**
	 * COMIS 전송
	 * @param result
	 * @param params
	 * @return
	 */
	public Map<String, Object> submitComis(Map<String, Object> result, Map<String, Object> params) {
		
		DefaultTransactionDefinition def = new DefaultTransactionAttribute();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus = txManager.getTransaction(def);
		
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		
		try{
			ForecastReportDTO report = mapper.SelectOne(params);
			
			if(mapper.duplCheckPublishSeqN(report) > 1) {
				String message = "중복되는 발행호수가 존재합니다.";
				makeMessages(result, message, false);
				throw new Exception();
			}
			
			if(report.getSubmit_dt() != null) {
				String message = "이미 전송된 예특보입니다.";
				makeMessages(result, message, false);
				throw new Exception();
			}
			
			transferFileUsingFTP(report, result);
			
			if(result.get("success").toString().equalsIgnoreCase("true")) {
				mapper.UpdateSubmit(Integer.parseInt(params.get("rpt_seq_n").toString()));
			}
			
			txManager.commit(txStatus);
		} catch (Exception e) {
			// TODO: handle exception
			txManager.rollback(txStatus);
		}
		
		return result;
	}
	
	/**
	 * 발표일시를 설정한다.
	 * 
	 * @param report
	 */
	private void setPublishDate(ForecastReportDTO report) {
		Calendar cal = Calendar.getInstance();
		
		cal.set(Calendar.HOUR_OF_DAY, 16);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		
		report.setPublish_dt(cal.getTime());
	}
	
	/**
	 * 상세정보를 설정한다.
	 * 
	 * @param report
	 */
	private void setNoticeDesc(ForecastReportDTO report) {
		report.setNot1_desc(new String[]{"영향없음"});
		report.setNot2_desc(new String[]{"영향없음"});
		report.setNot3_desc(new String[]{"영향없음"});
	}
	
	/**
	 * 신통보문의 기본 데이타를 설정한다.
	 * 
	 * @param report
	 * @param params
	 */
	private void getDefaultNewForecastReportData(ForecastReportDTO report, Map<String, Object> params) {
		//최근 3일간 우주기상 정보
		LocalDate endDate = LocalDate.fromDateFields(report.getWrite_dt());
		LocalDate startDate = endDate.minusDays(2);
		ChartDataMapper mapper = sessionTemplate.getMapper(ChartDataMapper.class);
		
		////////////////////////////////////////////////////
		//우주기상 실황
		//////////////////////////////////////////////////
		List<ChartSummaryDTO> recentSummaryList = mapper.SelectRecentSummary();
		ChartSummaryDTO 태양X선플럭스 = Iterables.tryFind(recentSummaryList, new Predicate<ChartSummaryDTO>() {
			@Override
			public boolean apply(ChartSummaryDTO arg0) {
				return arg0.getDataType() == DataType.XRAY;
			}
		}).orNull();
		if(태양X선플럭스 != null) {
			report.setXray(태양X선플럭스.getVal());
		}
		
		ChartSummaryDTO 태양양성자플럭스 = Iterables.tryFind(recentSummaryList, new Predicate<ChartSummaryDTO>() {
			@Override
			public boolean apply(ChartSummaryDTO arg0) {
				return arg0.getDataType() == DataType.PROTON;
			}
		}).orNull();
		if(태양양성자플럭스 != null) {
			report.setProton(태양양성자플럭스.getVal());
		}
		
		ChartSummaryDTO 지구자기장교란지수 = Iterables.tryFind(recentSummaryList, new Predicate<ChartSummaryDTO>() {
			@Override
			public boolean apply(ChartSummaryDTO arg0) {
				return arg0.getDataType() == DataType.KP;
			}
		}).orNull();
		if(지구자기장교란지수 != null) {
			report.setKp(지구자기장교란지수.getVal());
		}
		
		ChartSummaryDTO 지구자기권계면위치 = Iterables.tryFind(recentSummaryList, new Predicate<ChartSummaryDTO>() {
			@Override
			public boolean apply(ChartSummaryDTO arg0) {
				return arg0.getDataType() == DataType.MP;
			}
		}).orNull();
		if(지구자기권계면위치 != null) {
			report.setMp(지구자기권계면위치.getVal());
		}				
		
		////////////////////////////////////////////////////
		//최근 3일간 우주기상 정보 (최대값)
		//////////////////////////////////////////////////
		//List<ChartSummaryDTO> summaryList = mapper.SelectMaxSummaryForEachDay(startDate, endDate);
		List<ChartSummaryDTO> summaryList = mapper.SelectMaxSummaryForEachDayNew(sdf2.format(report.getWrite_dt()));
		
		List<String> dateList = new ArrayList<String>();
		for(LocalDate date=endDate;date.isAfter(startDate) || date.isEqual(startDate); date = date.minusDays(1)) {
			dateList.add(date.toString("yyyyMMdd"));
		}
		
		for(ChartSummaryDTO summary : summaryList) {
			switch(summary.getDataType()) {
			case XRAY:
				if(summary.getDuration() == Duration.NOW)
					report.setXray(summary.getVal());
				break;
			case PROTON:
				if(summary.getDuration() == Duration.NOW)
					report.setProton(summary.getVal());
				break;
			case KP:
				if(summary.getDuration() == Duration.NOW)
					report.setKp(summary.getVal());
				break;
			case MP:
				if(summary.getDuration() == Duration.NOW)
					report.setMp(summary.getVal());
				break;
			}
		}
		
		//데이터를 날짜별로 묶는다.
		ListMultimap<String, ChartSummaryDTO> summaryListByTM = Multimaps.index(summaryList, new Function<ChartSummaryDTO, String>() {
			@Override
			public String apply(ChartSummaryDTO arg0) {
				return arg0.getTm();
			}
		});
		
		for(String tm : summaryListByTM.keySet()) {
			ChartSummaryDTO 기상위성운영 = ChartSummaryDTO.기상위성운영최대비율(summaryListByTM.get(tm), Duration.D1);
			ChartSummaryDTO 극항로항공기상 = ChartSummaryDTO.극항로항공기상최대비율(summaryListByTM.get(tm), Duration.D1);
			ChartSummaryDTO 전리권기상 = ChartSummaryDTO.전리권기상최대비율(summaryListByTM.get(tm), Duration.D1);
			int index = dateList.indexOf(tm);
			
			
			//System.out.println(tm +" index=>" + index + "="+ 기상위성운영.getVal() + "=" + 기상위성운영.getPercentage());
			//System.out.println(tm +" index=>" + index + "="+ 극항로항공기상.getVal() + "=" + 극항로항공기상.getPercentage());
			//System.out.println(tm +" index=>" + index + "="+ 전리권기상.getVal() + "=" + 전리권기상.getPercentage());
			
			
			//0 최근날 -> 2 지난날
			switch(index) {
			//startDate값
			case 0:
				if(기상위성운영 != null)report.setNot1_max_val1(기상위성운영.getPercentage());
				if(극항로항공기상 != null)report.setNot2_max_val1(극항로항공기상.getPercentage());
				if(전리권기상 != null)report.setNot3_max_val1(전리권기상.getPercentage());
				break;
			case 1:
				if(기상위성운영 != null)report.setNot1_max_val2(기상위성운영.getPercentage());
				if(극항로항공기상 != null)report.setNot2_max_val2(극항로항공기상.getPercentage());
				if(전리권기상 != null)report.setNot3_max_val2(전리권기상.getPercentage());
				break;
			//endDate값
			case 2:
				if(기상위성운영 != null)report.setNot1_max_val3(기상위성운영.getPercentage());
				if(극항로항공기상 != null) report.setNot2_max_val3(극항로항공기상.getPercentage());
				if(전리권기상 != null) report.setNot3_max_val3(전리권기상.getPercentage());
				break;
			}
		}
	}
	
	/**
	 * 구통보문의 기본 데이타를 설정한다.
	 * 
	 * @param report
	 * @param params
	 */
	private void getDefaultOldForecastReportData(ForecastReportDTO report, Map<String, Object> params) {
		//최근 3일간 우주기상 정보
		LocalDate endDate = LocalDate.fromDateFields(report.getWrite_dt());
		LocalDate startDate = endDate.minusDays(2);
		
		ChartDataMapper mapper = sessionTemplate.getMapper(ChartDataMapper.class);
		
		////////////////////////////////////////////////////
		//최근 3일간 우주기상 정보 (최대값)
		//////////////////////////////////////////////////
		List<ChartSummaryDTO> summaryList = mapper.SelectMaxSummaryForEachDayNew(sdf2.format(report.getWrite_dt()));
		List<String> dateList = new ArrayList<String>();
		for(LocalDate date=endDate;date.isAfter(startDate) || date.isEqual(startDate); date = date.minusDays(1)) {
			dateList.add(date.toString("yyyyMMdd"));
		}
		
		//데이터를 날짜별로 묶는다.
		ListMultimap<String, ChartSummaryDTO> summaryListByTM = Multimaps.index(summaryList, new Function<ChartSummaryDTO, String>() {
			@Override
			public String apply(ChartSummaryDTO arg0) {
				return arg0.getTm();
			}
		});
		
		for(String tm : summaryListByTM.keySet()) {
			ChartSummaryDTO xrayDailyMaxPercentage = ChartSummaryDTO.getXrayDailyMaxPercentage(summaryListByTM.get(tm), Duration.D1);
			ChartSummaryDTO protonDailyMaxPercentage = ChartSummaryDTO.getProtonDailyMaxPercentage(summaryListByTM.get(tm), Duration.D1);
			ChartSummaryDTO kpDailyMaxPercentage = ChartSummaryDTO.getKpDailyMaxPercentage(summaryListByTM.get(tm), Duration.D1);
			int index = dateList.indexOf(tm);
			
//			System.out.println(tm + "==>" + index + "::" + xrayDailyMaxPercentage.getVal() + "==" + xrayDailyMaxPercentage.getPercentage());
//			System.out.println(tm + "==>" + index + "::" + protonDailyMaxPercentage.getVal() + "==" + protonDailyMaxPercentage.getPercentage());
//			System.out.println(tm + "==>" + index + "::" + kpDailyMaxPercentage.getVal() + "==" + kpDailyMaxPercentage.getPercentage());
			
			//최종 결과값은 가장 최근 날짜가 인덱스 0
			switch(index) {
			//startDate값
			case 0:
				if(xrayDailyMaxPercentage != null) report.setNot1_max_val1(xrayDailyMaxPercentage.getPercentage());
				if(protonDailyMaxPercentage != null) report.setNot2_max_val1(protonDailyMaxPercentage.getPercentage());
				if(kpDailyMaxPercentage != null) report.setNot3_max_val1(kpDailyMaxPercentage.getPercentage());
				break;
			case 1:
				if(xrayDailyMaxPercentage != null) report.setNot1_max_val2(xrayDailyMaxPercentage.getPercentage());
				if(protonDailyMaxPercentage != null) report.setNot2_max_val2(protonDailyMaxPercentage.getPercentage());
				if(kpDailyMaxPercentage != null) report.setNot3_max_val2(kpDailyMaxPercentage.getPercentage());
				break;
				//endDate값
			case 2:
				if(xrayDailyMaxPercentage != null) report.setNot1_max_val3(xrayDailyMaxPercentage.getPercentage());
				if(protonDailyMaxPercentage != null) report.setNot2_max_val3(protonDailyMaxPercentage.getPercentage());
				if(kpDailyMaxPercentage != null) report.setNot3_max_val3(kpDailyMaxPercentage.getPercentage());
				break;
			}
		}
		
		// 보고일
//		Date publishDate = (Date)report.getPublish_dt();
		Date WriteDate = (Date)report.getWrite_dt();
		
//		Date publishDateUtc = DateUtils.addHours(publishDate, -9);
//		Date publishDateUtc = DateUtils.addHours(WriteDate, -9);
		Date writeDateUtc = DateUtils.addHours(WriteDate, -9);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH");
//		String[] dateParameter = sdf.format(publishDateUtc).split("-"); 
		String[] dateParameter = sdf.format(writeDateUtc).split("-"); 
		String yyyy = dateParameter[0];
		String mm = dateParameter[1];
		String dd = dateParameter[2];
		String hh = dateParameter[3];
		String fullDate = yyyy+mm+dd+hh;
		
		String geomagImgPattern = "/{0}/{1}/{2}/{3}";
				
		String file_path1 = MessageFormat.format(geomagImgPattern, yyyy, mm, dd, hh);;
		
		report.setFile_path1(file_path1);
		report.setFile_nm1(fullDate + "_geomag_B.png");
	}
	
	
	
	/**
	 * FTP 전송
	 * @param report
	 * @param result
	 * @return
	 */
	private Map<String, Object> transferFileUsingFTP(ForecastReportDTO report, Map<String, Object> result) {
//		test FTP 서버
//		String ip = "172.19.12.71";
//		String port = "21";
//		String id = "sat";
//		String password = "sat";
//		String save_dir = "/";
		
		int reply = 0;
		boolean isSuccess = false;
		String message = "";
		String file_dir = report.getRpt_file_path();
		String file_nm = report.getRpt_file_nm();
		
		/*
		System.out.println("comisFtpHost ==>" +comisFtpHost);
		System.out.println("comisFtpPort ==>" +comisFtpPort);
		System.out.println("comisFtpUser ==>" +comisFtpUser);
		System.out.println("comisFtpPassword ==>" +comisFtpPassword);
		System.out.println("comisFtpWorkingDir ==>" + comisFtpWorkingDir);
		*/
		if(file_dir == null || "".equals(file_dir)) {
			message = "파일이 존재하지 않습니다.";
			makeMessages(result, message, isSuccess);
			return result;
		}
		
		FTPClient ftp = new FTPClient();
		ftp.setControlEncoding("UTF-8");
		
		try {
			
			ftp.connect(comisFtpHost, Integer.parseInt(comisFtpPort));
			
			if(!ftp.login(comisFtpUser, comisFtpPassword)) {
				ftp.logout();
				message = "로그인 실패";
			}
			else {
			
				reply = ftp.getReplyCode();
				
				if(!FTPReply.isPositiveCompletion(reply)) {
					ftp.disconnect();
					
					message = "접속 오류";
				}
				else {
					ftp.enterLocalPassiveMode();
					ftp.setKeepAlive(true);
					ftp.setControlKeepAliveTimeout(30);
					ftp.addProtocolCommandListener(new PrintCommandListener(System.out, true));
					ftp.setBufferSize(1024000);
					ftp.setFileType(FTP.BINARY_FILE_TYPE);
					ftp.changeWorkingDirectory(comisFtpWorkingDir);
					
					FileInputStream fis = null;
					File uploadFile = new File(ForecastReportLocationSystem.getPath() + File.separator + file_dir, file_nm);
					
					//업로드되는 파일명이 신통보문일 경우 파일명을 구통보문 파일 규칙으로 변경한다.
					String uploadFileName = uploadFile.getName();
					if(uploadFileName != null && uploadFileName.indexOf("_n.") != -1){
						uploadFileName = uploadFileName.replace("_n.", ".");
					}
					
					try {
						fis = new FileInputStream(uploadFile);
						isSuccess = ftp.storeFile(uploadFileName, fis);
						message = "전송 성공";
					} catch(FileNotFoundException fnfe) {
						message = "파일이 존재하지 않습니다.";
//						fnfe.printStackTrace();
					} catch(IOException ioe) {
						message = "입출력 오류";
//						ioe.printStackTrace();
					} finally { if(fis != null) fis.close(); }
				}
			}
		} catch(SocketException se) {
			message = "접속 오류";
//			se.printStackTrace();
		} catch(IOException ioe) {
			message = "입출력 오류";
//			ioe.printStackTrace();
		} finally {
			
			makeMessages(result, message, isSuccess);
			
			if(ftp != null && ftp.isConnected()) {
				try {
					ftp.disconnect();
				} catch(IOException ioe) {
//					ioe.printStackTrace();
				}
			}
		}
		
		return result;
	}
	
	/**
	 * 메세지를 만든다.
	 * @param result
	 * @param message
	 * @param isSuccess
	 */
	private void makeMessages(Map<String, Object> result, String message, boolean isSuccess) {
		result.put("success", isSuccess);
		result.put("messages", message);
	}
	
	
	
	
	/**
	 * 검색일로부터의 -24시간의 데이터중에 최신 값을 가져온다.
	 * @param params
	 * @return
	 */
	public List<Map<String, String>> getDailyMaxData(Object params){
		ChartDataMapper mapper = sessionTemplate.getMapper(ChartDataMapper.class); 
		return mapper.selectDailyMaxValues(params);
	}
	
	/**
	 * 검색일로부터의 -24시간의 데이터중에 최신 값을 가져온다.
	 * @param params
	 * @return
	 */
	public ForecastReportDTO selectOnePreviousWrnIssueReport(Object params){
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		return mapper.SelectOnePreviousWrnIssueReport(params);
	}
}
