package egovframework.rte.swfc.controller;

import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;

import net.coobird.thumbnailator.Thumbnails;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.swfc.common.Code;
import egovframework.rte.swfc.common.Code.IMAGE_CODE;
import egovframework.rte.swfc.dto.ChartSummaryDTO;
import egovframework.rte.swfc.dto.ChartSummaryDTO.Duration;
import egovframework.rte.swfc.dto.ForecastReportDTO;
import egovframework.rte.swfc.dto.MapperParam;
import egovframework.rte.swfc.dto.SWFCImageMetaDTO;
import egovframework.rte.swfc.exception.ReportNotFoundException;
import egovframework.rte.swfc.mapper.ChartDataMapper;
import egovframework.rte.swfc.mapper.SWFCImageMetaMapper;
import egovframework.rte.swfc.service.BoardService;
import egovframework.rte.swfc.service.ChartService;
import egovframework.rte.swfc.service.ForecastReportService;
import egovframework.rte.swfc.service.ImageService;
import egovframework.rte.swfc.util.ImageLocationResource;
import egovframework.rte.swfc.view.DefaultDownloadView.DownloadModelAndView;
import egovframework.rte.utils.AnimatedGifEncoder;
import egovframework.rte.utils.DateUtils;
import egovframework.rte.utils.PageNavigation;

@Controller
@RequestMapping("/")
public class MainController extends BaseController {
	private static final String BOARD_NOTICE_CODE = "3";
	private static final String SITE_CODE_CD = "1";
	private static final String KOR_SITE_CODE = "1";
	
	@Autowired
	private ForecastReportService forecastReportService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ImageService imageService;
	
	@Autowired
	private ChartService chartService;
	
	@Autowired(required=true)
	@Qualifier(value="ForecastReportLocationResource")
	private FileSystemResource ForecastReportLocationResource;
	
	@Autowired(required=true)
	@Qualifier(value="ForecastReportLocationImageResource")
	private FileSystemResource ForecastReportLocationImageResource;
	
	@Autowired(required = true)
	private ImageLocationResource imageLocationResource;
	
	@RequestMapping(value = "/{lang}/index.do", method = RequestMethod.GET)
	public String index(@PathVariable("lang") String lang, Locale locale, Model model) {
		Map<String, Object> requestParams = new HashMap<String, Object>();
		requestParams.put("startRow", 1);
		requestParams.put("endRow", 3);
		model.addAttribute("forecastList", forecastReportService.listForecastReport(requestParams));
		model.addAttribute("summary", chartService.selectChartSummary());
		
		requestParams.put("site_code_cd", KOR_SITE_CODE);
		requestParams.put("board_code_cd", BOARD_NOTICE_CODE);
		requestParams.put("use_yn", "Y");
//		requestParams.put("popup_yn", "Y");
		
		model.addAttribute("noticeList", boardService.listBoard(requestParams));
		
		//팝업 여부가 Y인 값들을 최근 등록된 20건 가져온다.
		requestParams.put("popup_yn", "Y");
		int count = boardService.selectCountBoard(requestParams);
		PageNavigation navigation = new PageNavigation(1, count, 20);
		requestParams.put("startRow", navigation.getStartRow());
		requestParams.put("endRow", navigation.getEndRow());
		model.addAttribute("noticePopupList", boardService.listBoard(requestParams));
		
		return getViewName(lang, "index");
	}
	
	@RequestMapping(value = "/{lang}/alerts.do")
	public String alerts(@PathVariable("lang") String lang, Model model, @RequestParam(required=false, value="p", defaultValue="1") int page, @RequestParam Map<String, Object> params) {
		
		//Map<String, Object> params = new HashMap<String, Object>();
		int count = forecastReportService.selectCountForecastReport(params);
		PageNavigation navigation = new PageNavigation(page, count, 10, 10);
		
		params.put("startRow", navigation.getStartRow());
		params.put("endRow", navigation.getBlockPage());
		
		model.addAttribute("list", forecastReportService.listForecastReport(params));
		model.addAttribute("pageNavigation", navigation);
		
		return getViewName(lang, "alerts");
	}
	
	
	//@RequestMapping(value = "/{lang}/alerts/img/{type}.do", method = RequestMethod.GET)
	//@ResponseBody
	public FileSystemResource alertsImgxxxx(@PathVariable("lang") String lang, @PathVariable("type") Code.AlertStaticImage imageType) {
		File imageFile = new File(ForecastReportLocationImageResource.getFile(), imageType + ".png");
		return new FileSystemResource(imageFile);
	}	
	
	@RequestMapping(value = "/{lang}/alerts/img/{type}.do", method = RequestMethod.GET)
	@ResponseBody
	public void alertsImg(@PathVariable("lang") String lang, @PathVariable("type") Code.AlertStaticImage imageType, HttpServletResponse response) {
		
		OutputStream os = null;
		File imageFile = null;
		try{
			response.setContentType("image/png");
			os = response.getOutputStream();
			imageFile =new File(ForecastReportLocationImageResource.getFile(), imageType + ".png");
			BufferedImage bi = ImageIO.read(imageFile);
			ImageIO.write(bi, "png", os);
		
		} catch (Exception e) {
//			e.printStackTrace();
		} finally {
			try { if(os != null) os.close();	} catch (IOException e) {}
		}
	}	
	
	@RequestMapping(value = "/{lang}/currentxxx.do", method = RequestMethod.GET)
	public String current(@PathVariable("lang") String lang, ModelMap model) {
		model.addAttribute("summary", chartService.selectChartSummary());
		model.addAttribute("imageList", imageService.selectRecentOneForEach());
		return getViewName(lang, "current");
	}
	
	@RequestMapping(value = "/{lang}/current.do", method = RequestMethod.GET)
	public String current2(@PathVariable("lang") String lang, ModelMap model) {
		model.addAttribute("summary", chartSummary());
		
		SWFCImageMetaMapper mapper = sessionTemplate.getMapper(SWFCImageMetaMapper.class);
		Map<String, Map<String, String>> imageUrlSet = new HashMap<String, Map<String, String>>();
		for(SWFCImageMetaDTO meta : mapper.SelectRecentOneForEach()) {
			IMAGE_CODE code = IMAGE_CODE.valueOf(meta.getCode());
			String url = String.format("/%s/current/image/%s/%s", lang, meta.getCode(), meta.getFilePath());
			Map<String, String> data = new HashMap<String, String>();
			data.put("codeText", code.getText());
			data.put("imageUrl", url);
			imageUrlSet.put(code.toString(), data);
		}
		model.addAttribute("imageList", imageUrlSet);
		return getViewName(lang, "current");
	}
	
	@RequestMapping(value = "/{lang}/currentPop.do", method = RequestMethod.GET)
	public String currentPop(@PathVariable("lang") String lang, ModelMap model) {
		return getViewName(lang, "currentPop");
	}
	
	@RequestMapping("/{lang}/monitor/search_by_code.do")
	public String search_by_code(@PathVariable("lang") String lang, @RequestParam(value = "code", required = true) IMAGE_CODE code, 
			@RequestParam(value="createDate", required=false)String date, ModelMap model) {
		
		Date createDate = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");
		if(date != null){
			try {
				createDate = sdf.parse(date);
			} catch (ParseException e) {
				createDate = null;
			}
		}
		
		SWFCImageMetaMapper mapper = sessionTemplate.getMapper(SWFCImageMetaMapper.class);
		MapperParam param = new MapperParam();
		param.put("code", code);
		param.put("createDate", createDate);
		//Collection<SWFCImageMetaDTO> list = ;
		model.addAttribute("data", mapper.SelectManyIntertemporalByCode(param));
		return "jsonView";
	}
	
	@RequestMapping("/{lang}/current/query.do")
	public String chartData(@PathVariable("lang") String lang, Model model, 
			@RequestParam(value="type") Code.CartType chartType, 
			@RequestParam(value="sd", required=true) String startDate,
			@RequestParam(value="ed", required=true) String endDate	
			
			) throws Exception {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");
		
		Date sDate = sdf.parse(startDate);
		Date eDate = sdf.parse(endDate);
		
		if(Math.abs(DateUtils.daysBetween(sDate, eDate)) > 7) {
			throw new Exception("Days out of range! " + Math.abs(DateUtils.daysBetween(sDate, eDate)));
		}
		
		//List<? extends ChartData> list =
		model.addAttribute("data", chartService.searchChartDate(chartType, sDate.before(eDate) ?sDate:eDate, sDate.before(eDate)?eDate:sDate));
		//return ;
		return "jsonView";
	}
	
	@RequestMapping("/{lang}/download_report/{rpt_seq_n}.do")
	public void downloadReport(@PathVariable("lang") String lang,ModelMap model, @PathVariable("rpt_seq_n") int rpt_seq_n, HttpServletResponse response) throws IOException, ReportNotFoundException {
		ForecastReportDTO report = null;

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("rpt_seq_n", rpt_seq_n);
		
		// DB에 저장된 보고서의 파일 경로 및 파일명을 조회한다.
		report = forecastReportService.selectForecastReport(params);
		
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
		
		InputStream is = null;
		OutputStream os = null;
		File result = null;
		
		try {
			if(rpt_seq_n < 10000){
				result = new File(ForecastReportLocationResource.getPath() + File.separator + report.getRpt_file_path());
			}else{
				result = new File(ForecastReportLocationResource.getPath() + File.separator + report.getRpt_file_path(), report.getRpt_file_nm());
			}
			
			if(report.getRpt_file_path() == null || "".equals(report.getRpt_file_path()) || report.getRpt_file_nm() == null || "".equals(report.getRpt_file_nm())) throw new ReportNotFoundException();
			
			response.setContentType("application/pdf");
	        response.setContentLength((int)result.length());
	        response.setHeader("Content-Transfer-Encoding", "binary");
	        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
	        
	        is = new FileInputStream(result);	        
	        os = response.getOutputStream();
	        
	        int readcount = 0;
	        byte[] buf = new byte[1024*1024];
	        
	        while((readcount = is.read(buf)) != -1) {
	        	os.write(buf, 0, readcount);
	        }
		} catch (Exception e) {
			// TODO: handle exception
//			e.printStackTrace();
		} finally {
			if(is != null) is.close();
			if(os != null) os.close();
		}
	}
	
	@RequestMapping(value = "/{lang}/alerts/covert_report_to_pdf/{rpt_seq_n}.do", method = RequestMethod.GET)
	@ResponseBody
	public void convertReportToPDF(@PathVariable("lang") String lang,ModelMap model, @PathVariable("rpt_seq_n") int rpt_seq_n, HttpServletResponse response) throws IOException, ReportNotFoundException {
		ForecastReportDTO report = null;

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("rpt_seq_n", rpt_seq_n);
		
		// DB에 저장된 보고서의 파일 경로 및 파일명을 조회한다.
		report = forecastReportService.selectForecastReport(params);
		
		if(report == null) throw new ReportNotFoundException();
		
		InputStream is = null;
		OutputStream os = null;
		File result = null;
		
		try {
			
			if(rpt_seq_n < 10000){
				result = new File(ForecastReportLocationResource.getPath() + File.separator + report.getRpt_file_path());
			}else{
				result = new File(ForecastReportLocationResource.getPath() + File.separator + report.getRpt_file_path(), report.getRpt_file_nm());
			}
			
			if(report.getRpt_file_path() == null || "".equals(report.getRpt_file_path()) || report.getRpt_file_nm() == null || "".equals(report.getRpt_file_nm())) throw new ReportNotFoundException();
			
			response.setContentType("application/pdf");
	        response.setContentLength((int)result.length());
	        response.setHeader("Content-Transfer-Encoding", "binary");
	        response.setHeader("Content-Disposition", "inline; filename=\"" + result.getName() + "\"");
	        
	        is = new FileInputStream(result);	        
	        os = response.getOutputStream();
	        
	        int readcount = 0;
	        byte[] buf = new byte[1024*1024];
	        
	        while((readcount = is.read(buf)) != -1) {
	        	os.write(buf, 0, readcount);
	        }
		} catch (Exception e) {
//			e.printStackTrace();
		} finally {
			if(is != null) is.close();
			if(os != null) os.close();
		}
		/**
		MapperParam param = new MapperParam();
		param.put("id", id);
		ForecastReportDTO report = forecastReportService.selectForecastReport(param);
		if(report == null) {
			throw new ReportNotFoundException();
		}
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
		
		File classesPath = new File(getServletContext().getRealPath("/WEB-INF/classes"));
		String[] fontFiles = classesPath.list(new FilenameFilter() {
			public boolean accept(File dir, String name) {
				return "ttc".equalsIgnoreCase(FilenameUtils.getExtension(name));
			}
		});
		
		if(fontFiles.length == 0)
			throw new IOException("No available fonts.");
		
		String fontPath = String.format("%s,%s", new File(classesPath, fontFiles[0]).getAbsolutePath(), 0);
		ExportForecastPdf export = new ExportForecastPdf(ForecastReportLocationResource.getFile(), fontPath);
		ByteArrayOutputStream  os = new ByteArrayOutputStream ();
		try {
		export.createPdf(report, os);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		response.getOutputStream().write(os.toByteArray());
		*/
	}
	
	@RequestMapping(value = "/{lang}/current/image/{imageCode}/{filePathString}", method = RequestMethod.GET)
	public DownloadModelAndView downloadImage(@PathVariable("lang") String lang, ModelMap model, @PathVariable Code.IMAGE_CODE imageCode, @PathVariable String filePathString) throws FileNotFoundException {
		String filePath = new String(org.springframework.security.crypto.codec.Base64.decode(filePathString.getBytes()));
		return imageLocationResource.DownloadBrowse(imageCode, filePath);
	}
	
	@RequestMapping("/{lang}/monitor/view_movie.do")
	public void view_movie(@RequestParam(value = "id", required = true) Integer id, 
			@RequestParam(value = "delay", required = false, defaultValue = "200") int delay,
			@RequestParam(value = "frames", required = true, defaultValue = "20") int frames, 
			@RequestParam(value = "size", required = true, defaultValue = "512") int size,
			HttpServletResponse response) throws IOException {
		response.setContentType("image/gif");
		SWFCImageMetaMapper mapper = sessionTemplate.getMapper(SWFCImageMetaMapper.class);
		MapperParam params = new MapperParam();
		params.put("id", id);
		params.put("cnt", frames);
		List<SWFCImageMetaDTO> list = mapper.SelectManyMovie(params);
		if (list.size() > 0) {
			AnimatedGifEncoder encoder = new AnimatedGifEncoder();
			encoder.setDelay(delay);
			encoder.setRepeat(0);
			encoder.setQuality(15);
			BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
			encoder.start(bos);
			for (SWFCImageMetaDTO dao : list) {
				try {
					File file = imageLocationResource.getBrowseFile(dao);
					BufferedImage bi = Thumbnails.of(file).outputQuality(0.0f).size(size, size).asBufferedImage();
					encoder.addFrame(bi);
					bos.flush();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
			encoder.finish();
			bos.flush();
			bos.close();
		}
	}
	
	@RequestMapping("/{lang}/monitor/view_browseimage.do")
	public DownloadModelAndView view_image(@RequestParam(value = "id", required = true) int id) throws FileNotFoundException {
		SWFCImageMetaMapper mapper = sessionTemplate.getMapper(SWFCImageMetaMapper.class);
		MapperParam param = new MapperParam();
		param.put("id", id);
		SWFCImageMetaDTO dao = mapper.SelectOne(param);

		String filePath = new String(org.springframework.security.crypto.codec.Base64.decode(dao.getFilePath().getBytes()));
		return imageLocationResource.DownloadBrowse(dao.getCode(), filePath);
	}
	
	@RequestMapping("/{lang}/monitor/summary.do")
	private String updateSummary(Model model){
		model.addAttribute("summary", chartSummary());
		return "jsonView";
	}
	
	private Map<String, Object> chartSummary() {
		ChartDataMapper mapper = sessionTemplate.getMapper(ChartDataMapper.class);
		List<ChartSummaryDTO> summaryList = mapper.SelectSummary();
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("notice1", ChartSummaryDTO.MaxCodeFor기상위성운영(summaryList, Duration.H3));
		output.put("notice2", ChartSummaryDTO.MaxCodeFor극항로항공기상(summaryList, Duration.H3));
		output.put("notice3", ChartSummaryDTO.MaxCodeFor전리권기상(summaryList, Duration.H3));
		
		ChartSummaryDTO XRAY_NOW = null;
		ChartSummaryDTO XRAY_H3 = null;
		ChartSummaryDTO PROTON_NOW = null;
		ChartSummaryDTO PROTON_H3 = null;
		ChartSummaryDTO KP_NOW = null;
		ChartSummaryDTO KP_H3 = null;
		ChartSummaryDTO KP_H6 = null;
		ChartSummaryDTO MP_NOW = null;
		ChartSummaryDTO MP_H3 = null;
		for(ChartSummaryDTO chart : summaryList) {
			switch(chart.getDataType()) {
			case XRAY:
				if(chart.getDuration() == Duration.NOW)
					XRAY_NOW = chart;
				else if(chart.getDuration() == Duration.H3)
					XRAY_H3 = chart;
				break;
			case PROTON:
				if(chart.getDuration() == Duration.NOW)
					PROTON_NOW = chart;
				else if(chart.getDuration() == Duration.H3)
					PROTON_H3 = chart;
				break;
			case KP:
				if(chart.getDuration() == Duration.NOW)
					KP_NOW = chart;
				else if(chart.getDuration() == Duration.H3)
					KP_H3 = chart;
				else if(chart.getDuration() == Duration.H6)
					KP_H6 = chart;
				break;
			case MP:
				if(chart.getDuration() == Duration.NOW)
					MP_NOW = chart;
				else if(chart.getDuration() == Duration.H3)
					MP_H3 = chart;
				break;
			}
		}
		
		if(KP_H3 == null) KP_H3 = KP_H6;
		
		output.put("XRAY_NOW", XRAY_NOW);
		output.put("XRAY_H3", XRAY_H3);
		
		output.put("PROTON_NOW", PROTON_NOW);
		output.put("PROTON_H3", PROTON_H3);
		
		output.put("KP_NOW", KP_NOW);
		output.put("KP_H3", KP_H3);
		
		output.put("MP_NOW", MP_NOW);
		output.put("MP_H3", MP_H3);		
		
		return output;
	}
}
