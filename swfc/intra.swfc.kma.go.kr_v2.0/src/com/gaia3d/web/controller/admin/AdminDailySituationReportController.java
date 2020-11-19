/**
 * 
 */
package com.gaia3d.web.controller.admin;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.SystemUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.dto.ChartSummaryDTO;
import com.gaia3d.web.dto.ForecastReportDTO;
import com.gaia3d.web.dto.ChartSummaryDTO.Duration;
import com.gaia3d.web.exception.ArticleFileNotFoundException;
import com.gaia3d.web.exception.ReportNotFoundException;
import com.gaia3d.web.mapper.ChartDataMapper;
import com.gaia3d.web.service.DailySituationReportService;
import com.gaia3d.web.util.ExportDailySituationReportPdf;
import com.gaia3d.web.view.DefaultDownloadView.DownloadModelAndView;
import com.gaia3d.web.vo.FontVo;
import com.google.common.base.Function;
import com.google.common.collect.ImmutableListMultimap;
import com.google.common.collect.Maps;
import com.google.common.collect.Multimaps;
import com.itextpdf.text.DocumentException;

/**
 * 관리자 영역에 대한 일일상황보고에 대한 요청을 처리하는 클래스
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/report/")
public class AdminDailySituationReportController extends BaseController {

	private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	private static final SimpleDateFormat yearformat = new SimpleDateFormat("yyyy");
	private static final SimpleDateFormat sdf2 = new SimpleDateFormat("HH");
	private static final SimpleDateFormat sdf3 = new SimpleDateFormat("mm");
	private static final SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd(E)");
	
	@Autowired(required=false)
	@Qualifier(value="FigureLocationResource")
	private FileSystemResource FigureLocationResource;
	
	@Autowired(required=false)
	@Qualifier(value="DailyReportLocationResource")
	private FileSystemResource DailyReportLocationResource;
	
	@Autowired
	private DailySituationReportService dailySituationReportService;
	
	@Autowired
    private ServletContext servletContext;
	
	@RequestMapping("daily_situation_report_form.do")
	public String daily_situation_report_form(@RequestParam(value="rpt_seq_n", required=false) Integer rpt_seq_n, @RequestParam() Map<String, Object> params,  Model model){
		
		
		if(rpt_seq_n == null){
			
			java.util.Date toDay = new java.util.Date();
			
			if(!params.containsKey("publish_dt")){
				params.put("publish_dt", sdf.format(toDay));
			}
			
			if(!params.containsKey("publish_hour")){
				params.put("publish_hour", sdf2.format(toDay));
			}
			
			if(!params.containsKey("publish_min")){
				
				String min = sdf3.format(toDay);
				min = min.substring(0, 1) + "0";
				params.put("publish_min", min);
			}
			
			model.addAttribute("prevMaxData", dailySituationReportService.getPrevMaxData(params));
		}else{
			model.addAttribute("report", dailySituationReportService.selectDailySituationReport(params));
		}
		
		model.addAttribute("param", params);
		return "admin/report/daily/daily_situation_report_form";
	}
	
	/*
	public static void main(String[] args){
		java.util.Date toDay = new java.util.Date();
		toDay.setMinutes(1);
		String min = sdf3.format(toDay);
		min = min.substring(0, 1) + "0";
		
		System.out.println(min);
	}
	*/
	
	private void careatePdf(Integer seq, FontVo fontVo) throws Exception{
		
		Map<String, String> params = new HashMap<String, String>();
		params.put("rpt_seq_n", seq + "");
		
		String fileName = null;
		FileOutputStream fos = null;
		ByteArrayOutputStream  os = null;
		
		Map<String, Object> report = dailySituationReportService.selectDailySituationReport(params);
		try {
			
			//Date publishDate = (Date)report.get("PUBLISH_DT"); //보고일
			File saveDir = new File( DailyReportLocationResource.getPath() + (String) report.get("RPT_FILE_PATH"));
			fileName = saveDir + File.separator + (String) report.get("RPT_FILE_NM");
			
			//System.out.println(fileName);
			if(!saveDir.exists()) {
				saveDir.mkdirs();
			}
			
			String fontPath = getFontPath(fontVo);
			
			ExportDailySituationReportPdf export = new ExportDailySituationReportPdf(null, fontPath);
			os = new ByteArrayOutputStream ();
			export.setFigureLocationResource(FigureLocationResource);
			export.createPdf(report, os);
			
			fos = new FileOutputStream(fileName);
			os.writeTo(fos);
			os.flush();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally{
			if(fos != null) fos.close();
			if(os != null) os.close();
		}
	}
	
	
	@RequestMapping("daily_situation_report_download_pdf.do")
	public DownloadModelAndView archives_download(@RequestParam(value="rpt_seq_n", required=true) Integer rpt_seq_n, @RequestParam() Map<String, String> params) throws Exception {
		
		
		Map<String, Object> report = dailySituationReportService.selectDailySituationReport(params);
		
		if(report == null) throw new FileNotFoundException();
		
		String fileNm = (String)report.get("RPT_FILE_NM");
		String fileOriginalNm = (String)report.get("RPT_FILE_ORG_NM");
		
		File file = new File(DailyReportLocationResource.getPath() + (String)report.get("RPT_FILE_PATH"), fileNm);
		if (!file.exists() || !file.isFile())
			throw new FileNotFoundException();

		return new DownloadModelAndView(file, fileOriginalNm);
	}
	
	
	@RequestMapping("daily_situation_max_val.do")
	@ResponseBody
	public Map<String, Object> getDailyMaxValues(@RequestParam() Map<String, String> params,  Model model){
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("maxValue", dailySituationReportService.getPrevMaxData(params));
		return output;
	}
	
	@RequestMapping("daily_situation_wrn_val.do")
	@ResponseBody
	public Map<String, Object> getWrnLastInfo(@RequestParam() Map<String, String> params,  Model model){
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("wrnList", dailySituationReportService.getWrnLastData(params));
		return output;
	}
	
	/**
	 * 하나의 일일 상황 보고문을 등록한다.
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("daily_situation_report_insert.do")
	public String insertDailySituationReport(@RequestParam() Map<String, Object> params, Model model){
		
		params.put("user_seq_n", getUserSeqN()); //로그인 사용자 고유 번호 등록 
		params.put("rpt_file_nm", UUID.randomUUID().toString()); //저장 파일명
		
		dailySituationReportService.insertDailySituationReport(params);
		
		Integer seq = (Integer)params.get("rpt_seq_n");
		if(seq != null){
			//Map<String, Object> data = dailySituationReportService.selectDailySituationReport(seq);
			try{
				FontVo fontVo = getMapVo(FontVo.class, params);
				careatePdf(seq, fontVo);
			}catch(Exception e){}
		}
		
		return "redirect:report_list.do";
	}
	
	/**
	 * 하나의 일일 상황 보고문을 등록한다.
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("daily_situation_report_update.do")
	public String updateDailySituationReport(@RequestParam() Map<String, String> params,  Model model){
		
		params.put("user_seq_n", getUserSeqN() + ""); //로그인 사용자 고유 번호 등록 
		
		if(params.get("rpt_file_nm") == null || "".equals(params.get("rpt_file_nm"))){
			params.put("rpt_file_nm", UUID.randomUUID().toString()); //저장 파일명
		}
		
		dailySituationReportService.updateDailySituationReport(params);
		Integer seq = Integer.parseInt(params.get("rpt_seq_n"));
		if(seq != null){
			try{
				
				FontVo fontVo = getMapVo(FontVo.class, params);
				
				careatePdf(seq, fontVo);
			}catch(Exception e){}
		}
		
		return "redirect:daily_situation_report_form.do?rpt_seq_n=" + params.get("rpt_seq_n");
	}
	
	/**
	 * 하나의 상황보고를 삭제한다.
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("daily_situation_report_delete.do")
	@ResponseBody
	public Map<String, Object> daily_situation_report_delete(@RequestParam() Map<String, String> params,  Model model){
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("result", dailySituationReportService.deleteDailySituationReport(params));
		return output;
	}
	
	@RequestMapping("view_browseimage.do")
	public DownloadModelAndView view_image(@RequestParam(value = "type", required = true) String type
			,@RequestParam(value = "date", required = true) String date
			,@RequestParam(value = "hour", required = true) String hour 
			,HttpServletRequest request) throws FileNotFoundException, URISyntaxException {
		
		
		
		String xfluxImgPattern = FigureLocationResource.getPath() +"/{0}/{1}/{2}/{3}/{4}_xflux_5m.png";
		String kpImgPattern = FigureLocationResource.getPath() +"/{0}/{1}/{2}/{3}/{4}_kp_index.png";
		String protonImgPattern = FigureLocationResource.getPath() +"/{0}/{1}/{2}/{3}/{4}_goes13_proton.png";
		String geomagImgPattern = FigureLocationResource.getPath() +"/{0}/{1}/{2}/{3}/{4}_geomag_B.png";
		
		String[] args = new String[5];
		args[0] = date.split("-")[0];
		args[1] = date.split("-")[1];
		args[2] = date.split("-")[2];
		args[3] = hour;
		args[4] = date.replaceAll("-", "") + hour;
		
		String filePath = null;
		if("xflux".equals(type)){
			filePath = MessageFormat.format(xfluxImgPattern, args);
		}else if("kp".equals(type)){
			filePath = MessageFormat.format(kpImgPattern, args);
		}else if("proton".equals(type)){
			filePath = MessageFormat.format(protonImgPattern, args);
		}else if("geomag".equals(type)){
			filePath = MessageFormat.format(geomagImgPattern, args);
		}
		
		
		/*
		String requestUrl = request.getRequestURL().toString();
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		
		String host = requestUrl.substring(0, requestUrl.indexOf(requestUri));
		
		System.out.println(host + contextPath + "/images/report/noimg250.gif");
		
		URI uri = new URI(host + contextPath + "/images/report/noimg250.gif");
		
		
		
		
		if(uri != null){
			System.out.println(uri.getPath());
			System.out.println(uri.getRawPath());
		}
		 */
		
		String prefix = request.getSession().getServletContext().getRealPath("/");
		String noImage = "/images/report/noimg250.gif";
		
		//System.out.println(prefix);
		
		File file = new File(filePath);
		if(file.exists() && file.isFile()){
			return new DownloadModelAndView(file);
		}else{
			file = new File(prefix + File.separator + noImage);
			if(file.exists() && file.isFile()){
				return new DownloadModelAndView(file);
			};
		}
		
		return null;
	}
		
	
	@RequestMapping("chart_indicator.do")
	@ResponseBody
	public Map<String, Object> chart_indicator(Locale locale, Model model) {
		ChartDataMapper mapper = sessionTemplate.getMapper(ChartDataMapper.class);
		List<ChartSummaryDTO> summaryList = mapper.SelectSummary();
		ImmutableListMultimap<ChartSummaryDTO.DataType, ChartSummaryDTO> result = Multimaps.index(summaryList, new Function<ChartSummaryDTO, ChartSummaryDTO.DataType>() {
			@Override
			public ChartSummaryDTO.DataType apply(ChartSummaryDTO arg0) {
				return arg0.getDataType();
			}
		});
		Map<ChartSummaryDTO.DataType, Map<ChartSummaryDTO.Duration, ChartSummaryDTO>> result2 = Maps.newHashMap();
		for(Map.Entry<ChartSummaryDTO.DataType, ChartSummaryDTO> entry : result.entries()) {
			ChartSummaryDTO.DataType key = entry.getKey();
			result2.put(key, Maps.uniqueIndex(result.get(entry.getKey()), new Function<ChartSummaryDTO, ChartSummaryDTO.Duration>() {
				@Override
				public ChartSummaryDTO.Duration apply(ChartSummaryDTO arg0) {
					return arg0.getDuration();
				}
			}));
		}
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("notice1", ChartSummaryDTO.MaxCodeFor기상위성운영(summaryList, Duration.H3));
		output.put("notice2", ChartSummaryDTO.MaxCodeFor극항로항공기상(summaryList, Duration.H3));
		output.put("notice3", ChartSummaryDTO.MaxCodeFor전리권기상(summaryList, Duration.H3));
		output.put("elements", result2);
		return output;
	}
	
}
