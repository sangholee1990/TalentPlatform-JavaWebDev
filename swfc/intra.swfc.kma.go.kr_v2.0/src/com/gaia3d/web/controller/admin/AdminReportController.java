package com.gaia3d.web.controller.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import com.gaia3d.web.dto.ChartSummaryDTO;

import org.apache.commons.io.FileUtils;
import org.hibernate.validator.internal.engine.path.MessageAndPath;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.controller.ReportController.ForecastReportType;
import com.gaia3d.web.dto.CodeDTO;
import com.gaia3d.web.dto.ForecastReportDTO;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.exception.ReportNotFoundException;
import com.gaia3d.web.service.AdminReportService;
import com.gaia3d.web.service.CodeService;
import com.gaia3d.web.util.ExportForecastPdf;
import com.gaia3d.web.util.ExportWarningReportPdf;
import com.gaia3d.web.view.DefaultDownloadView.DownloadModelAndView;
import com.gaia3d.web.vo.FontVo;

@Controller
@RequestMapping("/admin/report/")
public class AdminReportController extends BaseController {

	private static final String REPORT_TYPE_CD = "REPORT_TYPE_CD";
	
	@Autowired
	private CodeService codeService;
	
	@Autowired(required=false)
	private MessageSourceAccessor messageSourceAccessor;
	
	/**
	 * 보고서의 코드
	 * 통보문, 특보문, 일일상황보고
	 * @return
	 */
	private List<CodeDTO> listCode(){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("code", REPORT_TYPE_CD);
		params.put("use_yn", "Y");
		return codeService.selectSubCodeList(params);
	}
	
	@Autowired
	private AdminReportService adminReportService;
	
	@ModelAttribute("not1_desc")
	private String[] not1_desc() {
		return adminReportService.not1_desc();
	}
	
	@ModelAttribute("not2_desc")
	private String[] not2_desc() {
		return adminReportService.not2_desc();
	}
	
	@ModelAttribute("not3_desc")
	private String[] not3_desc() {
		return adminReportService.not3_desc();
	}
	
	@ModelAttribute("file_title")
	private String[] file_title() {
		return adminReportService.file_title();
	}
	
	@Autowired
    private ServletContext servletContext;
	
	@Value("${location.ForecastReport.data}")
	private String reportDataLocation;
	
	@Autowired(required=false)
	@Qualifier(value="FigureLocationResource")
	private FileSystemResource FigureLocationResource;
	
	@Autowired(required=false)
	@Qualifier(value="ForecastReportLocationResource")
	private FileSystemResource ForecastReportLocationResource;
	
	@Autowired(required=false)
	@Qualifier(value="DailyReportLocationResource")
	private FileSystemResource DailyReportLocationResource;
	
	@ModelAttribute("probabilityRange")
	public Map<Double, Integer> getProbabilityRange() {
		Map<Double, Integer> range = new LinkedHashMap<Double, Integer>();
		for(int i=0; i<=100; ++i) {
			range.put(i/100.0, i);
		}
		return range;
	}
	
	/**
	 * 보고서를 검색한다.
	 * 
	 * @param page
	 * @param pageSize
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("report_list.do")
	public String listAdminReport(HttpServletRequest request
			,@RequestParam(value="page", defaultValue="1") int page
			,@RequestParam(value="pageSize", defaultValue="10") int pageSize
			,@RequestParam Map<String, Object> params
			,Model model) {
		
		// 관리자페이지인지를 구분하는 파라미터
		// 관리자페이지가 아니라면 -1
		params.put("isAdmin", request.getServletPath().indexOf("admin"));
		
		// 파라메터에 현재 페이지를 추가한다.
		params.put("page", page);
		
		// 파라메터에 페이지당 표출될 게시물의 수를 추가한다.
		params.put("pageSize", pageSize);
		
		// 보고서 구분코드를 모델에 추가한다.
		model.addAttribute("subcodeList", listCode());
		// 검색결과를 모델에 추가한다.
		model.addAttribute("data", adminReportService.listAdminReport(params));
		
		// view의 경로를 반환한다.
		return "/admin/report/report_list";
	}
	
	/**
	 * 보고서의 등록/수정화면으로 이동한다.
	 * 
	 * @param page
	 * @param rpt_seq_n
	 * @param rpt_type
	 * @param rpt_kind
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("report_form.do")
	public String adminReportForm(
			@RequestParam(value="page", defaultValue="1") int page
			,@RequestParam(value="rpt_seq_n", defaultValue="-1") int rpt_seq_n
			,@RequestParam(value="rpt_type", required=true) ForecastReportType rpt_type
			,@RequestParam(value="rpt_kind", defaultValue="N") String rpt_kind
			,@RequestParam Map<String, Object> params
			,Model model) {
		
		ForecastReportDTO report = null;

		// 보고서 수정인 경우
		if(rpt_seq_n != -1) {
			
			if(ForecastReportType.WRN == rpt_type) {
				adminReportService.setForecastReportLocaiontSystem(ForecastReportLocationResource);
			}
			
			report = adminReportService.selectAdminReport(params);
		}
		// 보고서 작성인 경우
		else {
			params.put("rpt_kind", rpt_kind);
			report = adminReportService.getDefaultReportData(rpt_type, params);
		}
		
		model.addAttribute("report", report);
		
		model.addAttribute("page", page);
		
		// 보고서 종류에 따라 이동할 경로를 설정하기위한 변수
		String pageUrl = "/admin/report";
		
		switch(rpt_type) {
		// 통보(예보)인 경우
			case FCT:
				pageUrl += report.getRpt_kind().equals("O") ? "/fct/old/report_form" : "/fct/new/report_form";  
				break;
			// 특보인 경우
			case WRN:
				pageUrl += report.getRpt_kind().equals("O") ? "/wrn/old/report_form" : "/wrn/new/report_form";
				break;
			// 일일상황보고인 경우
			default:
				break;
		}
		
		return pageUrl;
	}

	/**
	 * 보고서를 등록/수정한다.
	 * 
	 * @param report
	 * @param params
	 * @param page
	 * @param rpt_seq_n
	 * @param rpt_type
	 * @param rpt_kind
	 * @param file1_data
	 * @param file2_data
	 * @param model
	 * @return
	 */
	@RequestMapping("report_submit.do")
	public String adminReportSubmit(
			@ModelAttribute("report") @Valid ForecastReportDTO report
			,@RequestParam Map<String, Object> params
			,@RequestParam(value="page", defaultValue="1") int page
			,@RequestParam(value="rpt_seq_n") Integer rpt_seq_n
			,@RequestParam(value="rpt_type", required=true) ForecastReportType rpt_type
			,@RequestParam(value="rpt_kind", defaultValue="N") String rpt_kind
			,@RequestParam(value="file1_data", required=false) MultipartFile file1_data
			,@RequestParam(value="file2_data", required=false) MultipartFile file2_data
			,Model model) {
		
		
		params.put("user_seq_n", getUserSeqN()); //로그인 사용자 고유 번호 등록
		
		if(file1_data != null && !file1_data.isEmpty()) {
			params.put("file1_data", file1_data);
		}
		if(file2_data != null && !file2_data.isEmpty()) {
			params.put("file2_data", file2_data);
		}
		
		if(params.get("file1_data") != null || params.get("file2_data") != null) {
			insertAttachFile(report, params);
		}
		
		
		report.setUser_seq_n(getUserSeqN() + "");
		
		// 보고서 수정인 경우
		if(rpt_seq_n != null) {
			adminReportService.updateAdminReport(report, params);
			report = adminReportService.selectAdminReport(params);
		}
		// 보고서 작성인 경우
		else {
			adminReportService.insertAdminReport(report, params);
		}
		
		FontVo fontVo = getMapVo(FontVo.class, params);
		
		try {
			saveReportAsPdfOnServer(report, fontVo, params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		adminReportService.updateAdminReportFileInfo(report);
		
		model.addAttribute("page", page);
		
		return "redirect:/admin/report/report_list.do";
	}
	

    /**
     * 보고서를 등록한다.
     *
     * @param params
     * @param page
     * @param rpt_seq_n
     * @param rpt_type
     * @param rpt_kind
     * @param model
     * @return
     */
    @RequestMapping("report_auto.do")
    public String adminReportAuto(
            @RequestParam(value="page", defaultValue="1") int page
            ,@RequestParam(value="rpt_seq_n", defaultValue="-1") int rpt_seq_n
            ,@RequestParam(value="rpt_type", required=true) ForecastReportType rpt_type
            ,@RequestParam(value="rpt_kind", defaultValue="N") String rpt_kind
            ,@RequestParam Map<String, Object> params
            ,Model model) {

        ForecastReportDTO report = new ForecastReportDTO();

        params.put("rpt_kind", rpt_kind);

        params.put("user_seq_n", getUserSeqN()); //로그인 사용자 고유 번호 등록

        //기본 정보
        report = adminReportService.getDefaultReportData(rpt_type, params);

        report.setUser_seq_n(getUserSeqN() + "");
        
        switch(rpt_type) {
            // 통보(예보)인 경우
            case FCT:
                report.setTitle("우주기상 예보");
                report.setWriter(null);
                report.setContents("--태양복사, 태양고에너지입자 및 지구자기장 교란이 일반수준을 유지하고 있어 기상위성운영,  극항로 항공기상 및 전리권기상에 영향없음.\n\n--지구 자기권계면이 정상범위이므로 기상위성운영에 영향없음.");
                break;
            // 특보인 경우
            case WRN:
                report.setWriter(null);
                report.setWrn_flag("S");
                report.setTitle("우주기상 특보");
                report.setContents("");

                report.setNot1_tar("기상위성");
                report.setNot2_tar("극항로 항공기 운항");
                report.setNot3_tar("위성항법시스템(GNSS)");

                report.setNot1_type("주의보");
                report.setNot2_type("주의보");
                report.setNot3_type("주의보");

                Date publishDate = report.getPublish_dt();
                SimpleDateFormat df = new SimpleDateFormat("MM.dd HH:mm");
                String noticePublish = df.format(publishDate);
                String noticeFinish = "진행 중";
                if(StringUtils.isEmpty(report.getNot1_publish())) {
                    report.setNot1_publish(noticePublish);
                }
                if(StringUtils.isEmpty(report.getNot2_publish())) {
                    report.setNot2_publish(noticePublish);
                }
                if(StringUtils.isEmpty(report.getNot3_publish())) {
                    report.setNot3_publish(noticePublish);
                }
                if(StringUtils.isEmpty(report.getNot1_finish())) {
                    report.setNot1_finish(noticeFinish);
                }
                if(StringUtils.isEmpty(report.getNot2_finish())) {
                    report.setNot2_finish(noticeFinish);
                }
                if(StringUtils.isEmpty(report.getNot3_finish())) {
                    report.setNot3_finish(noticeFinish);
                }

                break;
            // 일일상황보고인 경우
            default:
                break;
        }



        params.put("footerText1", messageSourceAccessor.getMessage("forecast.report."+rpt_type.toString().toLowerCase()+"."+rpt_kind.toLowerCase()+".footer1"));
        params.put("footerText2", messageSourceAccessor.getMessage("forecast.report."+rpt_type.toString().toLowerCase()+"."+rpt_kind.toLowerCase()+".footer2"));
        params.put("fontName", "BATANG.TTC");
        params.put("fontIndex", "0");

        adminReportService.insertAdminReport(report, params);

        FontVo fontVo = getMapVo(FontVo.class, params);
        System.out.println(report.toString());
        try {
            saveReportAsPdfOnServer(report, fontVo, params);
        } catch (Exception e) {
            e.printStackTrace();
        }

        adminReportService.updateAdminReportFileInfo(report);

        model.addAttribute("page", page);

        return "redirect:/admin/report/report_list.do";
    }



	
	/**
	 * 보고서를 삭제한다.
	 * 
	 * @param page
	 * @param rpt_seq_n
	 * @param model
	 * @return
	 */
	@RequestMapping("report_delete.do")
	public String deleteAdminReport(
			@RequestParam(value="page", defaultValue="1") int page
			,@RequestParam(value="rpt_seq_n", defaultValue="-1") int rpt_seq_n
			,Model model) {
		
		MapperParam params = new MapperParam();
		params.put("rpt_seq_n", rpt_seq_n);
		
		adminReportService.deleteAdminReport(params);
		
		model.addAttribute("page", page);
		
		return "redirect:/admin/report/report_list.do";
	}
	
	/**
	 * 파일을 저장한다.
	 * @param report
	 * @param params
	 * @return
	 */
	private void insertAttachFile(ForecastReportDTO report, Map<String, Object> params) {
		MultipartFile file1_data = null;
		MultipartFile file2_data = null;
		
		Date date = new Date();
		SimpleDateFormat dtFormat = new SimpleDateFormat("/yyyy/MM/dd");
		String savePath = dtFormat.format(date);
		
		try {
			File path = new File(ForecastReportLocationResource.getPath() + File.separator + "data", savePath);
			
			if(!path.exists()) path.mkdirs();
			
			if(params.containsKey("file1_data") && params.get("file1_data") != null) {
				if(params.get("file1_data") instanceof MultipartFile)
					file1_data = (MultipartFile) params.get("file1_data");
				
				String saveFilename = UUID.randomUUID().toString();
//				String saveFilepath = path.getPath().replace('\\', '/') + "/" + saveFilename;
				String saveFilepath = File.separator + "data" + savePath.replace("/", File.separator) + File.separator + saveFilename;
				
				File fullPath = new File(path, saveFilename);
				file1_data.transferTo(fullPath);
				
				report.setFile_nm1(file1_data.getOriginalFilename());
				report.setFile_path1(saveFilepath);
			}
			
			if(params.containsKey("file2_data") && params.get("file2_data") != null) {
				if(params.get("file2_data") instanceof MultipartFile)
					file2_data = (MultipartFile) params.get("file2_data");
				
				String saveFilename = UUID.randomUUID().toString();
				String saveFilepath = File.separator + "data" + savePath.replace("/", File.separator) + File.separator + saveFilename;
				
				File fullPath = new File(path, saveFilename);
				file2_data.transferTo(fullPath);
				
				report.setFile_nm2(file2_data.getOriginalFilename());
				report.setFile_path2(saveFilepath);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 보고서를 PDF 파일로 서버에 저장한다.
	 * 
	 * @param report
	 * @return
	 * @throws Exception
	 */
	private void saveReportAsPdfOnServer(ForecastReportDTO report, FontVo fontVo, Map<String, Object> params) throws Exception {
		
		SimpleDateFormat publishDateFormat = new SimpleDateFormat("yyyyMMddHHmm");
		SimpleDateFormat savePathFormat = new SimpleDateFormat("yyyy/MM/dd");
		String savePath = savePathFormat.format(report.getPublish_dt()); 
		
		String filename = "";
		//String rpt_kind = "";
		//if("N".equals(report.getRpt_kind())) rpt_kind = "_n";
		
		String fontPath = getFontPath(fontVo);
		
		File path;
		FileOutputStream os = null;
		
		try {
			switch(report.getRpt_type()) {
				case FCT:
					filename = "swfc_fct_" + publishDateFormat.format(report.getPublish_dt()) + "_" + report.getPublish_seq_n() + ".pdf"; 
					
					ExportForecastPdf fctExport = new ExportForecastPdf(null, fontPath);
					
					fctExport.setForecastReportLocationResource(ForecastReportLocationResource);
					if("O".equals(report.getRpt_kind())) fctExport.setFigureLocationResource(FigureLocationResource);
					
					path = new File(ForecastReportLocationResource.getPath(), savePath); 
					
					if(!path.exists()) path.mkdirs();
					
					os = new FileOutputStream(path + File.separator + filename);
					
					try {
						fctExport.createPdf(report, os, params);
					}catch(Exception ex) {
						// Nothing to do.
						ex.printStackTrace();
					}
					
					break;
				case WRN:
					filename = "swfc_wrn_" + publishDateFormat.format(report.getPublish_dt()) + "_" + report.getPublish_seq_n() + ".pdf";
					
					ExportWarningReportPdf wrnExport = new ExportWarningReportPdf(null, fontPath);
					
					wrnExport.setForecastReportLocationResource(ForecastReportLocationResource);
					
					path = new File(ForecastReportLocationResource.getPath(), savePath); 
					
					if(!path.exists()) path.mkdirs();
					
					os = new FileOutputStream(path + File.separator + filename);
					
					try {
						wrnExport.createPdf(report, os, params);
					}catch(Exception ex) {
						// Nothing to do.
						ex.printStackTrace();
					}
					
					break;
				default:
					filename = "swfc_report_" + publishDateFormat.format(report.getPublish_dt()) + "_" + report.getPublish_seq_n() +  ".pdf";
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(os != null) os.close();
		}
		
		report.setRpt_file_path(savePath);
		report.setRpt_file_nm(filename);
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
	private void convertReportToPDF(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="rpt_seq_n") int rpt_seq_n, @RequestParam(value="rpt_type") String rpt_type) throws Exception {
		
		ForecastReportDTO report = null;

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("rpt_seq_n", rpt_seq_n);
		
		// DB에 저장된 보고서의 파일 경로 및 파일명을 조회한다.
		report = adminReportService.selectAdminReportFileInfo(params);
		
		if(report == null) throw new ReportNotFoundException();
		
		InputStream is = null;
		OutputStream os = null;
		File result = null;
		String fileName = null;
		
		try {
			if(rpt_type != null && "DSR".equals(rpt_type)){
				result = new File(DailyReportLocationResource.getPath() + File.separator + report.getRpt_file_path(), report.getRpt_file_nm());
				fileName = report.getRpt_file_nm();
			}else{
				//result = new File(ForecastReportLocationResource.getPath() + File.separator + report.getRpt_file_path(), report.getRpt_file_nm());
				//fileName = result.getName();
				
				if(rpt_seq_n < 10000){ //이전 서버에 데이터는 파일패스에 파일명까지 들어 있다.
					result = new File(ForecastReportLocationResource.getPath() + File.separator + report.getRpt_file_path());
					fileName = result.getName();
				}else{
					result = new File(ForecastReportLocationResource.getPath() + File.separator + report.getRpt_file_path(), report.getRpt_file_nm());
					fileName = report.getRpt_file_nm();
				}
			}
			
			String browser = request.getHeader("User-Agent");
			
			if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")){
				fileName = URLEncoder.encode(fileName, "utf-8").replaceAll("\\+", "%20").replace("%28", "(").replace("%29", ")");
				//fileName = URLEncoder.encode(fileName, "utf-8");
			}else{
				fileName = new String(fileName.getBytes("utf-8"), "ISO-8859-1");
			}
			
			response.setContentType("application/pdf");
	        response.setContentLength((int)result.length());
	        response.setHeader("Content-Transfer-Encoding", "binary");
	        response.setHeader("Content-Disposition", "inline; filename=\"" +fileName + "\"");
	        
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
	}
	
	/**
	 * COMIS 전송
	 * 
	 * @param request
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("comis_submit.do")
	@ResponseBody
	public Map<String, Object> submitComis(HttpServletRequest request, @RequestParam Map<String, Object> params, Model model) {
		
		Map<String, Object> result = new HashMap<String, Object>(); 
		adminReportService.setForecastReportLocaiontSystem(ForecastReportLocationResource);
		// COMIS 전송
		adminReportService.submitComis(result, params);
		
		return result;
	}
	
	@RequestMapping("view_browseimage2.do")
	public DownloadModelAndView view_image(@RequestParam(value = "file_path", required = true) String file_path 
			,HttpServletRequest request) throws FileNotFoundException, URISyntaxException {
		
		String filePath = ForecastReportLocationResource.getPath() + File.separator + file_path;
		
		String prefix = request.getSession().getServletContext().getRealPath("/");
		
		String noImage = "/images/report/noimg250.gif";
		
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
	
	@RequestMapping("get_daily_max_val.do")
	@ResponseBody
	public Map<String, Object> getDailyMaxValues(@RequestParam() Map<String, String> params,  Model model){
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("maxValue", adminReportService.getDailyMaxData(params));
		return output;
	}
	
	
	@RequestMapping("get_previous_wrn_issue_rpt.do")
	@ResponseBody
	public Map<String, Object> selectOnePreviousWrnIssueReport(@RequestParam() Map<String, String> params,  Model model){
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("data", adminReportService.selectOnePreviousWrnIssueReport(params));
		return output;
	}
	
	@RequestMapping("get_init_wrn_img.do")
	public DownloadModelAndView view_image(@RequestParam(value = "path", required = true) String path
			,@RequestParam(value = "imageName", required = true) String imageName
			,@RequestParam(value = "isNew", required = true, defaultValue="Y") String isNew
			,@RequestParam(value = "date", required = true) String date
			,HttpServletRequest request) throws FileNotFoundException, URISyntaxException {
		
		String prefix = request.getSession().getServletContext().getRealPath("/");
		String noImage = "/images/report/noimg250.gif";
		
		File file = new File(path, imageName);
		
		//초기 이미지 생성일 경우 이미지 저장소에서 이미지를 옮긴 후 그 이미지를 사용한다. 
		if("Y".equals(isNew)){
			
			
			File dir = new File(ForecastReportLocationResource.getPath() + File.separator + "wrn" + File.separator + "img" + File.separator + date.substring(0, 4));
			
			if(!dir.exists())dir.mkdirs();
			
			File distImage = new File(dir.getPath(), date +"_"+imageName);
			
			try {
				FileUtils.copyFile(new File("/home/gnss/prog/sp_para", imageName), distImage);
			} catch (IOException e) {
				//to do
			}
			
			file = distImage;
		}
		
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
	
	/*
	public static void main(String[] args){
		try {
			FileUtils.copyFile(new File("D:/home/gnss/prog/sp_para/ace_mag.png"), new File("D:/home/gnss/prog/sp_para/ace_mag11.png"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	*/
}
