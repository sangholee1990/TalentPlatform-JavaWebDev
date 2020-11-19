package com.gaia3d.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.web.dto.ForecastReportDTO;
import com.gaia3d.web.exception.ArticleFileNotFoundException;
import com.gaia3d.web.exception.ReportNotFoundException;
import com.gaia3d.web.mapper.ForecastReportMapper;
import com.gaia3d.web.service.DailySituationReportService;
import com.gaia3d.web.util.PageNavigation;
import com.gaia3d.web.util.PageStatus;
import com.gaia3d.web.view.DefaultDownloadView.DownloadModelAndView;

@Controller
@RequestMapping("/report")
public class ReportController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(ReportController.class);
	
	private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	@Autowired(required=false)
	@Qualifier(value="FigureLocationResource")
	private FileSystemResource FigureLocationResource;
	
	@Autowired(required=false)
	@Qualifier(value="DailyReportLocationResource")
	private FileSystemResource DailyReportLocationResource;
	
	@Autowired
	private DailySituationReportService dailySituationReportService;
	
	public enum ForecastReportType{
		FCT,
		WRN,
		DSR
	}
	
	/**
	 * 미사용 
	@PostConstruct
	private void postConstruct() {

	}
	 */
	
	/**
	 * 미사용
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
	private String not1_desc;
	
	@Value("${forecast.report.notice2Desc}")
	private String not2_desc;
	
	@Value("${forecast.report.notice3Desc}")
	private String not3_desc;
	*/
	@Autowired
    private ServletContext servletContext;
	
	@Autowired(required=false)
	@Qualifier(value="ForecastReportLocationResource")
	private FileSystemResource ForecastReportLocationResource;
	
	@Autowired(required=true)
	private PlatformTransactionManager txManager;
	
	/**
	 * 미사용
	@ModelAttribute("not1_desc")
	private String[] not1_desc() {
		return not1_desc.split("\\r?\\n");
	}
	
	@ModelAttribute("not2_desc")
	private String[] not2_desc() {
		return not2_desc.split("\\r?\\n");
	}
	
	@ModelAttribute("not3_desc")
	private String[] not3_desc() {
		return not3_desc.split("\\r?\\n");
	}
	*/
	
	@RequestMapping("forecast_list.do")
	public void forecast_list(HttpServletRequest request,
			ModelMap model,
			@ModelAttribute("pageStatus") PageStatus pageStatus,
			@RequestParam Map<String, Object> requestParams,
			final BindingResult bindingResult) {
		
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		
		// 관리자페이지인지를 구분하는 파라미터
		// 관리자페이지가 아니라면 -1
		requestParams.put("isAdmin", request.getServletPath().indexOf("admin"));
		
		Calendar cal = Calendar.getInstance();
		
		if(!requestParams.containsKey("endDate")){
			requestParams.put("endDate", sdf.format(cal.getTime()));
		}
		
		if(!requestParams.containsKey("endHour")){
			String endHour = String.valueOf( cal.get(Calendar.HOUR_OF_DAY) ); 
			if(endHour.length() <= 1) endHour = "0" + endHour;
			
			requestParams.put("endHour", endHour);
		}
		
		cal.add(Calendar.YEAR, -1);
		
		if(!requestParams.containsKey("startDate")){
			requestParams.put("startDate", sdf.format(cal.getTime()));
		}
		
		if(!requestParams.containsKey("startHour")){
			String startHour = String.valueOf( cal.get(Calendar.HOUR_OF_DAY) ); 
			if(startHour.length() <= 1) startHour = "0" + startHour;
			
			requestParams.put("startHour", startHour);
		}
		//requestParams.put("startDate", sd);
		//requestParams.put("endDate", ed);
		
		requestParams.put("rpt_types", Arrays.asList( new String[]{"FCT", "WRN"} ));
		
		int count = mapper.Count(requestParams);
		
		PageNavigation navigation = new PageNavigation(pageStatus.getPage(), count, 10);
		requestParams.put("startRow", String.valueOf( navigation.getStartRow() ));
		requestParams.put("endRow", String.valueOf( navigation.getEndRow() ));
		
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		model.addAttribute("searchInfo", requestParams);
	}
	
	/**
	 * 저장된 보고서를 웹에 표출한다.
	 * 
	 * @param response
	 * @param rpt_seq_n
	 * @param rpt_type
	 * @throws Exception
	 */
	@RequestMapping("covert_report_to_pdf.do")
	@ResponseBody
	private void convertReportToPDF(HttpServletResponse response, @RequestParam(value="rpt_seq_n") int rpt_seq_n, @RequestParam(value="rpt_type") String rpt_type) throws Exception {
		
		ForecastReportDTO report = null;
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("rpt_seq_n", rpt_seq_n);
		
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		
		// DB에 저장된 보고서의 파일 경로 및 파일명을 조회한다.
		report = mapper.selectAdminReportFileInfo(params);
		
		if(report == null) throw new ReportNotFoundException();
		
		InputStream is = null;
		OutputStream os = null;
		File result = null;
		String fileName = null;
		
		try {
			if(rpt_type != null && "DSR".equals(rpt_type)){
				result = new File(DailyReportLocationResource.getPath() + File.separator + report.getRpt_file_path(), report.getRpt_file_org_nm());
				fileName = report.getRpt_file_nm();
			}else{
				if(rpt_seq_n < 10000){ //이전 서버에 데이터는 파일패스에 파일명까지 들어 있다.
					result = new File(ForecastReportLocationResource.getPath() + File.separator + report.getRpt_file_path());
					fileName = result.getName();
				}else{
					result = new File(ForecastReportLocationResource.getPath() + File.separator + report.getRpt_file_path(), report.getRpt_file_nm());
					fileName = report.getRpt_file_nm();
				}
			}
			
			response.setContentType("application/pdf");
			response.setContentLength((int)result.length());
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");
			
			is = new FileInputStream(result);	        
			os = response.getOutputStream();
			
			int readcount = 0;
			byte[] buf = new byte[1024*1024];
			
			while((readcount = is.read(buf)) != -1) {
				os.write(buf, 0, readcount);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(is != null) is.close();
			if(os != null) os.close();
		}
	}
	
	@RequestMapping("daily_situation_rpt_list.do")
	public void daily_situation_rpt_list(ModelMap model,
			@ModelAttribute("pageStatus") PageStatus pageStatus,
			@RequestParam Map<String, Object> requestParams,
			final BindingResult bindingResult) {
		
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		
		Calendar cal = Calendar.getInstance();
		
		if(!requestParams.containsKey("endDate")){
			requestParams.put("endDate", sdf.format(cal.getTime()));
		}
		
		if(!requestParams.containsKey("endHour")){
			String endHour = String.valueOf( cal.get(Calendar.HOUR_OF_DAY) ); 
			if(endHour.length() <= 1) endHour = "0" + endHour;
			
			requestParams.put("endHour", endHour);
		}
		
		cal.add(Calendar.YEAR, -1);
		
		if(!requestParams.containsKey("startDate")){
			requestParams.put("startDate", sdf.format(cal.getTime()));
		}
		
		if(!requestParams.containsKey("startHour")){
			String startHour = String.valueOf( cal.get(Calendar.HOUR_OF_DAY) ); 
			if(startHour.length() <= 1) startHour = "0" + startHour;
			
			requestParams.put("startHour", startHour);
		}
		//requestParams.put("startDate", sd);
		//requestParams.put("endDate", ed);
		
		requestParams.put("rpt_types", Arrays.asList( new String[]{"DSR"} ));
		
		int count = mapper.Count(requestParams);
		
		PageNavigation navigation = new PageNavigation(pageStatus.getPage(), count, 10);
		requestParams.put("startRow", String.valueOf( navigation.getStartRow() ));
		requestParams.put("endRow", String.valueOf( navigation.getEndRow() ));
		
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		model.addAttribute("searchInfo", requestParams);
	}
	
	@RequestMapping("daily_situation_report_download_pdf.do")
	public DownloadModelAndView archives_download(@RequestParam(value="rpt_seq_n", required=true) Integer rpt_seq_n, @RequestParam() Map<String, String> params) throws Exception {
		
		
		Map<String, Object> report = dailySituationReportService.selectDailySituationReport(params);
		
		if(report == null) throw new ArticleFileNotFoundException();
		
		String fileNm = (String)report.get("RPT_FILE_NM");
		String fileOrgNm = (String)report.get("RPT_FILE_ORG_NM");
		File file = new File(DailyReportLocationResource.getPath() + (String)report.get("RPT_FILE_PATH"), fileNm);
		
		if (!file.exists() || !file.isFile())
			throw new ArticleFileNotFoundException();

		return new DownloadModelAndView(file, fileOrgNm);
	}
	
	/**
	 * 미사용
	@RequestMapping(value="forecast_del.do")
	public String forecast_del(@RequestParam(value="rpt_seq_n") int rpt_seq_n, @ModelAttribute("pageStatus") PageStatus pageStatus, RedirectAttributes redirectAttr) throws Exception {
		
		if(logger.isDebugEnabled()) logger.debug("Delete Forecast Report Record...");
		
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		MapperParam params = new MapperParam();
		params.put("rpt_seq_n", rpt_seq_n);
		
		ForecastReportDTO report = mapper.SelectOne(params);

		if(report == null)  throw new ReportNotFoundException();
		
		if(report.getSubmit_dt() != null) {
			throw new Exception("COMIS 전송된 예특보는 삭제할 수 없습니다.");
		}
		
		mapper.Delete(params);
		
		Utils.deleteFile(ForecastReportLocationResource, report.getFile_path1());
		Utils.deleteFile(ForecastReportLocationResource, report.getFile_path2());
		Utils.deleteFile(ForecastReportLocationResource, report.getFile_path3());
		
		redirectAttr.addFlashAttribute("pageStatus", pageStatus);
		return "redirect:forecast_list.do";
	}
	*/
	
	/**
	 * 미사용
	@RequestMapping(value="forecast_form.do", method=RequestMethod.GET)
	public ModelAndView forecast_form(@ModelAttribute("pageStatus") PageStatus pageStatus, @RequestParam(value="rpt_seq_n", required=false) Integer rpt_seq_n, @RequestParam(value="rpt_type", required=true) ForecastReportType rpt_type) throws Exception {
		ForecastReportDTO report = null;
		if(rpt_seq_n == null) {
			report = new ForecastReportDTO();
			report.setRpt_type(rpt_type);
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.HOUR_OF_DAY, 16);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.set(Calendar.MILLISECOND, 0);
			report.setPublish_dt(cal.getTime());
			report.setWrite_dt(new Date());
			
			report.setNot1_desc(new String[]{"영향없음"});
			report.setNot2_desc(new String[]{"영향없음"});
			report.setNot3_desc(new String[]{"영향없음"});

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
			List<ChartSummaryDTO> summaryList = mapper.SelectMaxSummaryForEachDay(startDate, endDate);
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
				switch(index) {
				//startDate값
				case 0:
					if(기상위성운영 != null)
						report.setNot1_max_val1(기상위성운영.getPercentage());
					if(극항로항공기상 != null)
						report.setNot2_max_val1(극항로항공기상.getPercentage());
					if(전리권기상 != null)
						report.setNot3_max_val1(전리권기상.getPercentage());
					break;
				case 1:
					if(기상위성운영 != null)
						report.setNot1_max_val2(기상위성운영.getPercentage());
					if(극항로항공기상 != null)
						report.setNot2_max_val2(극항로항공기상.getPercentage());
					if(전리권기상 != null)
						report.setNot3_max_val2(전리권기상.getPercentage());
					break;
				//endDate값
				case 2:
					if(기상위성운영 != null)
						report.setNot1_max_val3(기상위성운영.getPercentage());
					if(극항로항공기상 != null)
						report.setNot2_max_val3(극항로항공기상.getPercentage());
					if(전리권기상 != null)
						report.setNot3_max_val3(전리권기상.getPercentage());
					break;
				}
			}
			
			UserDetailsWrapper userDetailWrapper = (UserDetailsWrapper)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			WebUser user = (WebUser)userDetailWrapper.getUnwrappedUserDetails();
			String writer = user.getDetail().getName();
			report.setWriter(writer);
		} else {
			ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
			MapperParam params = new MapperParam();
			params.put("rpt_seq_n", rpt_seq_n);
			report = mapper.SelectOne(params);
			if(report == null) {
				throw new Exception("게시물이 존재하지 않습니다.");
			}
			
			if(report.getSubmit_dt() != null) {
				throw new Exception("COMIS 전송된 예특보는 수정할 수 없습니다.");
			}
		}
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("report", report);
		switch (rpt_type) {
		case FCT:
			mav.setViewName("report/forecast_form_fct");
			break;
			
		case WRN:
			mav.setViewName("report/forecast_form_wrn");
			break;
		}
		return mav;
	}
	*/
	
	/**
	 * 미사용
	@ModelAttribute("probabilityRange")
	public Map<Double, Integer> getProbabilityRange() {
		Map<Double, Integer> range = new LinkedHashMap<Double, Integer>();
		for(int i=0; i<=100; ++i) {
			range.put(i/100.0, i);
		}
		return range;
	}
	*/
	
	/**
	 * 미사용
	@RequestMapping(value="forecast_submit.do", method=RequestMethod.POST)
	public String forecast_submit(@ModelAttribute("report") @Valid ForecastReportDTO report,
			@ModelAttribute("pageStatus") PageStatus pageStatus,
			BindingResult bindingResult, 
			@RequestParam(value="file1_data", required=false) MultipartFile file1_data, 
			@RequestParam(value="file2_data", required=false) MultipartFile file2_data, RedirectAttributes redirectAttr) throws IllegalStateException, IOException, ReportNotFoundException {
		
		if(bindingResult.hasErrors()) return "report/forecast_form";
		
		if(file1_data != null || file2_data != null) {
			Date date = new Date();
			SimpleDateFormat dtFormat = new SimpleDateFormat("/yyyy/MM/dd");
			
			String savePath = dtFormat.format(date);

			File path = new File(ForecastReportLocationResource.getPath(), savePath);
			if(!path.exists()) {
				path.mkdirs();
			}
			
			if(file1_data != null && !file1_data.isEmpty()) {
				String saveFilename = UUID.randomUUID().toString();
				String saveFilepath = savePath + "/" + saveFilename;
				
				File fullPath = new File(path, saveFilename);
				file2_data.transferTo(fullPath);
				
				report.setFile_nm1(file1_data.getOriginalFilename());
				report.setFile_path1(saveFilepath);
			}
			
			if(file2_data != null && !file2_data.isEmpty()) {
				String saveFilename = UUID.randomUUID().toString();
				String saveFilepath = savePath + "/" + saveFilename;

				File fullPath = new File(path, saveFilename);
				file2_data.transferTo(fullPath);
				
				report.setFile_nm2(file2_data.getOriginalFilename());
				report.setFile_path2(saveFilepath);
			}
		}
		
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		if(report.getRpt_seq_n() == null) {
			mapper.Insert(report);
		}
		else {
			MapperParam params = new MapperParam();
			params.put("rpt_seq_n", report.getRpt_seq_n());
			ForecastReportDTO oldReport = mapper.SelectOne(params);
			if(oldReport == null) {
				throw new ReportNotFoundException();
			}
			
			if(StringUtils.isEmpty(report.getFile_nm1())) {
				report.setFile_nm1(oldReport.getFile_nm1());
				report.setFile_path1(oldReport.getFile_path1());
			}
			
			if(StringUtils.isEmpty(report.getFile_nm2())) {
				report.setFile_nm2(oldReport.getFile_nm2());
				report.setFile_path2(oldReport.getFile_path2());
			}
			
			mapper.Update(report);
		}
		redirectAttr.addFlashAttribute("pageStatus", pageStatus);
		return "redirect:forecast_list.do";
	}
	*/
	
	/**
	 * 미사용
	@RequestMapping(value="comis_submit.do")
	public String comis_submit(HttpServletRequest request, @RequestParam("rpt_seq_n") int rpt_seq_n, @ModelAttribute("pageStatus") PageStatus pageStatus, RedirectAttributes redirectAttr) throws Exception {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		TransactionStatus txStatus= txManager.getTransaction(def);
		try
		{
			ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);

			MapperParam param = new MapperParam();
			param.put("rpt_seq_n", rpt_seq_n);
			ForecastReportDTO report = mapper.SelectOne(param);
			if(report == null) {
				throw new ReportNotFoundException();
			}
			
			if(report.getSubmit_dt() != null) {
				throw new Exception("이미 전송된 예특보입니다.");
			}
			
			mapper.UpdateSubmit(rpt_seq_n);
			
			report = mapper.SelectOne(param);
			String filename = "swfc";
			switch(report.getType()) {
			case FCT:
				filename += "_fct_";
				break;
			case WRN:
				filename += "_wrn_";	
				break;
			default:
				throw new Exception("Invalid Report Type!");
			}
			
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmm");
			filename += df.format(report.getPublishDate());
			filename += "_" + report.getPublishSeq();
			
			//FTP 전송
			URL pdfUrl = new URL(ServletUriComponentsBuilder.fromCurrentContextPath().path("/report/forecast_export_pdf.do?id={id}").build().expand(id).toString());
			FTPUploader uploader = null;
			InputStream is = null;
			try {
				uploader = new FTPUploader(comisFtpHost, comisFtpPort, comisFtpUser, comisFtpUser);
				is = pdfUrl.openStream();
				if(!uploader.upload(is, filename + ".pdf", comisFtpWorkingDir)) {
					throw new Exception(String.format("FTP file upload error : %s[%d]", uploader.getReplyString(), uploader.getReplyCode()));
				}
			} finally {
				if(uploader != null)
					uploader.disconnect();
				Closeables.close(is, true);
			}
			
		} catch(Exception ex) {
			txManager.rollback(txStatus);
			throw ex;
		}
		txManager.commit(txStatus);
		
		redirectAttr.addFlashAttribute("pageStatus", pageStatus);
		return "redirect:forecast_list.do";
	}
	*/
	
	/**
	 * 미사용
	@RequestMapping(value="forecast_export_pdf.do")
	@ResponseBody
	public void forecast_export_pdf2(@RequestParam(value="rpt_seq_n") Integer rpt_seq_n, HttpServletResponse response) throws Exception {
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		MapperParam param = new MapperParam();
		param.put("rpt_seq_n", rpt_seq_n);
		ForecastReportDTO report = mapper.SelectOne(param);
		
		if(report == null) throw new ReportNotFoundException();
		
		SimpleDateFormat publishDateFormat = new SimpleDateFormat("yyyyMMddHHmm");
		
		String filename;
		switch(report.getRpt_type()) {
		case FCT:
			filename = "swfc_fct_" + publishDateFormat.format(report.getPublish_dt()) + "_" + report.getPublish_seq_n() +  ".pdf"; 
			break;
		case WRN:
			filename = "swfc_wrn_" + publishDateFormat.format(report.getPublish_dt()) + "_" + report.getPublish_seq_n() +  ".pdf";
			break;
		default:
			filename = "swfc_report_" + publishDateFormat.format(report.getPublish_dt()) + "_" + report.getPublish_seq_n() +  ".pdf";
		}
		response.setContentType("application/pdf");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Disposition", String.format("inline;filename=\"%s\";", filename));
		
		String fontPath = String.format("%s,%s", servletContext.getRealPath("/WEB-INF/classes/BATANG.TTC"), 0);
		ExportForecastPdf export = new ExportForecastPdf(ForecastReportLocationResource.getFile(), fontPath);
		ByteArrayOutputStream  os = new ByteArrayOutputStream ();
		try {
		export.createPdf(report, os);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		response.getOutputStream().write(os.toByteArray());
	}
	*/
	
	/**
	 * 미사용
	@RequestMapping(value="forecast_export_pdf2.do")
	public ModelAndView forecast_export_pdf(@RequestParam(value="rpt_seq_n") Integer rpt_seq_n) throws Exception {
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		MapperParam param = new MapperParam();
		param.put("rpt_seq_n", rpt_seq_n);
		ForecastReportDTO report = mapper.SelectOne(param);
		
		if(report == null) 	throw new ReportNotFoundException();
		
		ModelAndView mav = new ModelAndView();
		switch(report.getRpt_type()) {
		case FCT:
			mav.setViewName("report/forecast_export_pdf_fct");
			break;
		case WRN:
			mav.setViewName("report/forecast_export_pdf_wrn");
			break;
			default:
				throw new Exception("Invalid Report Type!");
		}
		
		mav.addObject("report", report);
		mav.addObject("File1Axis", "width");
		mav.addObject("File2Axis", "width");
		
		try {
			File file1 = new File(ForecastReportLocationResource.getFile(), report.getFile_path1());
			if(file1.exists() && file1.isFile()) {
				BufferedImage image = ImageIO.read(file1);
				int width = image.getWidth();
				int height = image.getHeight();
				if(width < height) {
					mav.addObject("File1Axis", "height");
				} 
			}
		}catch(Exception ex) {
			logger.error("forecast_export_pdf - filepath1", ex);
		}
		
		try {
			File file2 = new File(ForecastReportLocationResource.getFile(), report.getFile_path2());
			if(file2.exists() && file2.isFile()) {
				BufferedImage image = ImageIO.read(file2);
				int width = image.getWidth();
				int height = image.getHeight();
				if(width < height) {
					mav.addObject("File2Axis", "height");
				} 
			}
		}catch(Exception ex) {
			logger.error("forecast_export_pdf - filepath2", ex);
		}
		return mav;
	}
	*/
	
	/**
	 * 미사용
	@RequestMapping(value="forecast_export_html.do")
	public ModelAndView forecast_export_html(@RequestParam(value="rpt_seq_n") Integer rpt_seq_n) throws Exception {
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		MapperParam param = new MapperParam();
		param.put("rpt_seq_n", rpt_seq_n);
		ForecastReportDTO report = mapper.SelectOne(param);
		
		if(report == null) 	throw new ReportNotFoundException();
		
		ModelAndView mav = new ModelAndView();
		switch(report.getRpt_type()) {
		case FCT:
			mav.setViewName("report/forecast_export_pdf_fct");
			break;
		case WRN:
			mav.setViewName("report/forecast_export_pdf_wrn");
			break;
			default:
				throw new Exception("Invalid Report Type!");
		}
		
		mav.addObject("report", report);
		return mav;
	}
	*/
	
	/**
	 * 미사용
	@RequestMapping("forecast_report_attachment_download.do")
	public DownloadModelAndView download(@RequestParam("rpt_seq_n") int rpt_seq_n, @RequestParam("fid") int fileId) throws FileNotFoundException, UnsupportedEncodingException{
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		MapperParam params = new MapperParam();
		params.put("rpt_seq_n", rpt_seq_n);
		ForecastReportDTO report = mapper.SelectOne(params);
		if(report == null) {
			throw new ArticleFileNotFoundException();
		}
		
		String filename = null;
		String filepath = null;
		if(fileId == 1) {
			filename = report.getFile_nm1();
			filepath = report.getFile_path1();
		} else if(fileId == 2) {
			filename = report.getFile_nm2();
			filepath = report.getFile_path2();
		} else {
			throw new FileNotFoundException();
		}
		
		if(filepath == null) 
			throw new FileNotFoundException();
		
		File file = new File(ForecastReportLocationResource.getPath(), filepath);
		if(!file.exists() || !file.isFile())
			throw new ArticleFileNotFoundException();
		
	    return new DownloadModelAndView(file, filename);
	}
	 */
	
	
	/**
	 * 미사용
	 * 구통보문 다운로드를 진행한다.
	 * @param model
	 * @param id
	 * @param response
	 * @throws DocumentException
	 * @throws IOException
	 * @throws ReportNotFoundException
	@RequestMapping(value = "/forecast_download_pdf.do", method = RequestMethod.GET)
	public void downloadOldReport(ModelMap model, @RequestParam("rpt_seq_n") int rpt_seq_n, HttpServletResponse response) throws DocumentException, IOException, ReportNotFoundException {
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		MapperParam param = new MapperParam();
		param.put("rpt_seq_n", rpt_seq_n);
		ForecastReportDTO report = mapper.SelectOne(param);
		if(report == null) {
			throw new ReportNotFoundException();
		}
		
		
		String filename = report.getFile_nm1();
		
		response.setContentType("application/pdf");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Disposition", String.format("inline;filename=\"%s\";", filename));
		
		
		File path = new File(ForecastReportLocationResource.getPath(), report.getFile_path1());
		
		FileInputStream fis = null;
		OutputStream os = null;
		try{
			os = response.getOutputStream();
			fis = new FileInputStream(path);
			int readcount = 0;
	        byte[] buf = new byte[1024*1024];
	        while((readcount = fis.read(buf)) != -1){
	        	os.write(buf, 0, readcount);
	        }
		}finally{
			if(fis != null)fis.close();
			if(os != null)os.close();
		}
	}
	 */
}//class end
