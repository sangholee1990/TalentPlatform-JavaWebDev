package com.gaia3d.web.controller.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.read.biff.BiffException;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.dto.DictionaryDTO;
import com.gaia3d.web.service.SMSService;

@Controller
@RequestMapping("/admin/sms/")
public class SMSController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(SMSController.class);
	
	@Autowired
	private SMSService smsService;
	
	@Autowired(required=false)
	@Qualifier("PDSLocationResource")
	private FileSystemResource pdsLocation;
	
	/**
	 * 글 등록 및 수정 요청을 처리한다.
	 * @param user_seq_n
	 * @param params
	 * @return
	 */
	@RequestMapping("user_form.do")
	public String userForm(@RequestParam(value="user_seq_n", defaultValue = "-1") int user_seq_n, @RequestParam Map<String, Object> params, Model model){
		if(user_seq_n == -1){
		}else{
			model.addAttribute("userInfo", smsService.selectSmsUser(params));
		}
		return "/admin/sms/user_form";
	}
	
	/**
	 * SMS 사용자를 등록한다.
	 * @return
	 */
	@RequestMapping("user_submit.do")
	public String smsUserAdd(@RequestParam Map<String, Object> params){
		smsService.insertSmsUser(params);
		return "redirect:user_list.do";
	}
	
	/**
	 * SMS 사용자를 등록한다.
	 * @return
	 */
	@RequestMapping("user_modify.do")
	public String smsUserModify(@RequestParam(value="user_seq_n", required=true) int user_seq_n, @RequestParam Map<String, Object> params){
		smsService.updateSmsUser(params);
		return "redirect:user_form.do?user_seq_n=" + user_seq_n;
	}
	

	/**
	 * SMS 사용자를 등록한다.
	 * @return
	 */
	@RequestMapping(value="user_delete.do", method=RequestMethod.POST)
	public String deleteSmsUser(@RequestParam(value="user_seq_n", defaultValue = "-1", required=true) int user_seq_n, @RequestParam Map<String, Object> params){
		int result = smsService.deleteSmsUser(params);
		return "redirect:user_list.do";
	}
	
	/**
	 * SMS 사용자를 등록한다.
	 * @return
	 */
	@RequestMapping(value="user_display_update.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSmsUser(@RequestParam(value="user_seq_n", defaultValue = "-1", required=true) int user_seq_n, @RequestParam Map<String, Object> params){
		int result = smsService.updateSmsUser(params);
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("result", result);
		return output;
	}
	
	
	/**
	 * SMS 사용자정보 페이지를 보여준다.
	 * @return
	 */
	@RequestMapping("user_list.do")
	public String smsUserList(
			@RequestParam(value="page", defaultValue="1") int page
			,@RequestParam(value="pageSize", defaultValue="10") int pageSize
			,@RequestParam Map<String, Object> params
			,Model model){
		
		params.put("page", page);
		params.put("pageSize", pageSize);
		
		model.addAttribute("data", smsService.listSmsUserWithPaging(params));
		return "/admin/sms/user_list";
	}
	
	
	
	/**
	 * SMS 리스트 정보를 요청한다.
	 * @return
	 */
	@RequestMapping("sms_list.do")
	public String smsList(
			@RequestParam(value="page", defaultValue="1") int page
			,@RequestParam(value="pageSize", defaultValue="10") int pageSize
			,@RequestParam Map<String, Object> params
			,Model model){
		
		params.put("page", page);
		params.put("pageSize", pageSize);
		
		model.addAttribute("data", smsService.listSmsWithPaging(params));
		return "/admin/sms/sms_list";
	}
	/**
	 * SMS 로그 리스트 정보를 요청한다.
	 * @return
	 */
	@RequestMapping("smsLog_list.do")
	public String smsLogList(
			@RequestParam(value="page", defaultValue="1") int page
			,@RequestParam(value="pageSize", defaultValue="10") int pageSize
			,@RequestParam Map<String, Object> params
			,Model model){
		
		params.put("page", page);
		params.put("pageSize", pageSize);
		
		model.addAttribute("data", smsService.listSmsLogWithPaging(params));
		return "/admin/sms/sms_log_list";
	}
	
	/**
	 * 글 등록 및 수정 요청을 처리한다.
	 * @param user_seq_n
	 * @param params
	 * @return
	 */
	@RequestMapping("sms_form.do")
	public String smsForm(@RequestParam(value="sms_seq_n", defaultValue = "-1") int sms_seq_n, @RequestParam Map<String, Object> params, Model model){
		if(sms_seq_n == -1){
			params.put("page", 1);
			params.put("pageSize", 1000);
			model.addAttribute("data", smsService.listSmsUserWithPaging(params));
		}else{
			model.addAttribute("data", smsService.listSmsUserMappingList(params));
			model.addAttribute("sms", smsService.selectSms(params));
		}
		
		return "/admin/sms/sms_form";
	}
	
	/**
	 * SMS 사용자를 등록한다.
	 * @return
	 */
	@RequestMapping("sms_submit.do")
	public String smsAdd(@RequestParam Map<String, Object> params, @RequestParam(value="user_seq_n", required=false) String[] user_seq_n){
		params.put("user_seq_n", user_seq_n);
		smsService.insertSms(params);
		return "redirect:sms_list.do";
	}
	
	/**
	 * SMS 사용자를 등록한다.
	 * @return
	 */
	@RequestMapping(value="sms_delete.do", method=RequestMethod.POST)
	public String deleteSms(@RequestParam(value="sms_seq_n", defaultValue = "-1", required=true) int sms_seq_n, @RequestParam Map<String, Object> params){
		int result = smsService.deleteSms(params);
		return "redirect:sms_list.do";
	}
	
	/**
	 * SMS 정보를 수정한다.
	 * @return
	 */
	@RequestMapping("sms_modify.do")
	public String smsModify(@RequestParam Map<String, Object> params, @RequestParam(value="user_seq_n", required=false) String[] user_seq_n,
			@RequestParam(value="sms_seq_n", required=true) int sms_seq_n){
		params.put("user_seq_n", user_seq_n);
		smsService.updateSms(params);
		return "redirect:sms_form.do?sms_seq_n=" + sms_seq_n;
	}
	
	
	
	/**
	 * 글 등록 및 수정 요청을 처리한다.
	 * @param user_seq_n
	 * @param params
	 * @return
	 */
	@RequestMapping("sms_threshold_form.do")
	public String smsCriticalForm(@RequestParam(value="sms_threshold_seq_n", defaultValue = "-1") int sms_threshold_seq_n, @RequestParam Map<String, Object> params, Model model){
		if(sms_threshold_seq_n == -1){
			params.put("page", 1);
			params.put("pageSize", 1000);
			model.addAttribute("data", smsService.listSmsUserWithPaging(params));
		}else{
			
			params.put("sms_seq_n", sms_threshold_seq_n); //동일한 쿼리를 사용하기 위해 키값 변경
			
			model.addAttribute("data", smsService.listSmsUserMappingList(params));
			model.addAttribute("sms", smsService.selectSmsThreshold(params));
		}
		
		return "/admin/sms/sms_threshold_form";
	}
	
	/**
	 * SMS 리스트 정보를 요청한다.
	 * @return
	 */
	@RequestMapping("sms_threshold_list.do")
	public String smsThresholdList(@RequestParam Map<String, Object> params, Model model){
		model.addAttribute("list", smsService.listSmsThreshold(params));
		return "/admin/sms/sms_threshold_list";
	}
	
	/**
	 * SMS 사용자를 등록한다.
	 * @return
	 */
	@RequestMapping("sms_threshold_submit.do")
	public String smsThresholdAdd(@RequestParam Map<String, Object> params, @RequestParam(value="user_seq_n", required=false) String[] user_seq_n){
		params.put("user_seq_n", user_seq_n);
		smsService.insertSmsThreshold(params);
		return "redirect:sms_threshold_list.do";
	}
	
	/**
	 * SMS 정보를 수정한다.
	 * @return
	 */
	@RequestMapping("sms_threshold_modify.do")
	public String smsThresholdModify(@RequestParam Map<String, Object> params, @RequestParam(value="user_seq_n", required=false) String[] user_seq_n
			,@RequestParam(value="sms_threshold_seq_n", required=true) int sms_threshold_seq_n){
		params.put("user_seq_n", user_seq_n);
		smsService.updateSmsThreshold(params);
		return "redirect:sms_threshold_form.do?sms_threshold_seq_n=" + sms_threshold_seq_n;
	}
	
	/**
	 * SMS 정보를 삭제한다.
	 * @return
	 */
	@RequestMapping("sms_threshold_delete.do")
	public String sms_threshold_delete(@RequestParam Map<String, Object> params, @RequestParam(value="user_seq_n", required=false) String[] user_seq_n
			,@RequestParam(value="sms_threshold_seq_n", required=true) int sms_threshold_seq_n){
		params.put("user_seq_n", user_seq_n);
		smsService.deleteSmsThreshol(params);
		return "redirect:sms_threshold_list.do";
	}
	
	/**
	 * SMS 정보를 수정한다.
	 * @return
	 */
	@RequestMapping("sms_threshold_grade_form.do")
	public String smsThresholdGradeForm(@RequestParam Map<String, Object> params, @RequestParam(value="user_seq_n", required=false) String[] user_seq_n, Model model){
		//params.put("user_seq_n", user_seq_n);
		model.addAttribute("sms", smsService.selectSmsThreshold(params));
		model.addAttribute("list", smsService.listSmsThresholdGrade(params));
		return "/admin/sms/sms_threshold_grade_form";
	}
	
	/**
	 * SMS 사용자를 등록한다.
	 * @return
	 */
	@RequestMapping("sms_threshold_grade_submit.do")
	public String smsThresholdGradeAdd(
			@RequestParam(value="sms_threshold_seq_n", required=true) int sms_threshold_seq_n
			,@RequestParam Map<String, Object> params
			,@RequestParam(value="grade_no", required=false) String[] grade_no
			,@RequestParam(value="pre_val", required=false) String[] pre_val
			,@RequestParam(value="pre_flag", required=false) String[] pre_flag
			,@RequestParam(value="next_flag", required=false) String[] next_flag
			,@RequestParam(value="next_val", required=false) String[] next_val
			){
		params.put("grade_no", grade_no);
		params.put("pre_val", pre_val);
		params.put("pre_flag", pre_flag);
		params.put("next_flag", next_flag);
		params.put("next_val", next_val);
		smsService.updateSmsThresholdGrade(params);
		return "redirect:sms_threshold_grade_form.do?sms_threshold_seq_n=" + sms_threshold_seq_n;
	}
	
	/**
	 * SMS 사용자를 등록한다.
	 * @return
	 */
	@RequestMapping(value="sms_threshold_status_update.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSmsThresholdStatusUpdate(@RequestParam(value="sms_threshold_seq_n", defaultValue = "-1", required=true) int sms_threshold_seq_n, @RequestParam Map<String, Object> params){
		int result = smsService.updateSmsThreshold(params);
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("result", result);
		return output;
	}
	
	/**
	 * SMS 사용자를 등록한다.
	 * @return
	 */
	@RequestMapping(value="sms_send_ajax.do")
	@ResponseBody
	public Map<String, Object> sms_send_ajax(@RequestParam(value="sms_seq_n", required=true) Integer sms_seq_n, @RequestParam Map<String, String> params){
		smsService.requestSendSMS(params);
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("result", "1");
		return output;
	}
	
	/**
	 * SMS 사용자 엑셀 샘플을 다운로드 한다.
	 * @return
	 */
	@RequestMapping("user_excel_download.do")
	public void dictionary_excelDownload(HttpServletRequest request, 
										HttpServletResponse response, 
										@RequestParam Map<String, Object> params) throws Exception {
		
		GregorianCalendar today = new GregorianCalendar();
		
		List<Map<String, String>> userList = smsService.listSmsAllUser(params);
		// 스프레드시트를 만든다.
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();
		HSSFRow row = sheet.createRow(0);
		row.createCell(0).setCellValue("이름");
		row.createCell(1).setCellValue("핸드폰번호");
		row.createCell(2).setCellValue("기관");
		row.createCell(3).setCellValue("사용여부");
		
		
		Map<String, String> user = null;
		// 데이터를 셀에 출력한다.
		for(int idx=0; idx<userList.size(); idx++) {
			user = userList.get(idx);
			row = sheet.createRow(idx + 1);
			row.createCell(0).setCellValue(user.get("user_nm"));
			row.createCell(1).setCellValue(user.get("user_hdp"));
			row.createCell(2).setCellValue(user.get("user_org"));
			row.createCell(3).setCellValue(user.get("use_yn"));
		}
		
		// 타입을 excel로 지정
		response.setContentType("application/ms-excel");
		response.setHeader("Expires:", "0");
		response.setHeader("Content-Disposition", "attachment; filename=sms_user_" + today.get(today.YEAR) + (today.get(today.MONTH) + 1) + today.get(today.DATE) + today.get(today.HOUR) + today.get(today.MINUTE) + today.get(today.SECOND) + ".xls");
		
		wb.write(response.getOutputStream());
	}
	
	/**
	 * 단어사전 양식 샘플 다운로드한다.
	 */
	@RequestMapping("user_excel_sample_download.do")
	public void user_excel_sample_download(HttpServletRequest request,
										  HttpServletResponse response,
										  @RequestParam Map<String, Object> params) throws Exception {
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();
		HSSFRow row = sheet.createRow(0);
		
		row.createCell(0).setCellValue("이름");
		row.createCell(1).setCellValue("핸드폰번호");
		row.createCell(2).setCellValue("기관");
		row.createCell(3).setCellValue("사용여부");
		
		int idx = 1;
		
		row = sheet.createRow(idx++);
		row.createCell(0).setCellValue("홍길동");
		row.createCell(1).setCellValue("010-1234-5678");
		row.createCell(2).setCellValue("인디시스템");
		row.createCell(3).setCellValue("Y");
		
		row = sheet.createRow(idx++);
		row.createCell(0).setCellValue("이순신");
		row.createCell(1).setCellValue("01045671234");
		row.createCell(2).setCellValue("인디시스템");
		row.createCell(3).setCellValue("N");
		
		// 타입을 excel로 지정
		response.setContentType("application/ms-excel");
		response.setHeader("Expires:", "0");
		response.setHeader("Content-Disposition", "attachment; filename=sms_user_excel_sample.xls");
		
		wb.write(response.getOutputStream());
	}
	
	/**
	 * 사용자 엑셀 업로드 팝업창 페이지로 이동한다.
	 * 
	 */
	@RequestMapping("user_excel_upload_popup.do")
	public String user_excel_upload_popup() {
		return "/admin/sms/excelFileuploadPopup";
	}
	
	/**
	 * 단어사전 엑셀파일을  업로드한다.
	 * 
	 */
	@RequestMapping("user_sms_excel_upload.do")
	public ModelAndView dictionary_excelUpload(HttpServletRequest request,
										HttpServletResponse response,
										@RequestParam Map<String, Object> params,
										@RequestParam("fileData") MultipartFile[] fileData) throws Exception {
		
		boolean success = false;
		
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
			MultipartFile multipartFile = multipartRequest.getFile("fileData");
			
			String filePath = pdsLocation.getPath();
			
			System.out.println(filePath);
			
			// 파일이 저장된 실제 경로 + 파일명 찾기
			
			if(multipartFile != null && multipartFile.getSize() > 0) {
				String saveFileName = multipartFile.getOriginalFilename();
				long fileSize = multipartFile.getSize();
					
				
				OutputStream outputStream = null;
				File tempFile = null;
 						
				if(fileSize > 0 && !saveFileName.equals("")) {
					try{
						tempFile = new File(filePath,saveFileName);
						outputStream = new FileOutputStream(tempFile);
						FileCopyUtils.copy(multipartFile.getInputStream(), outputStream);
					}catch(Exception e){
						throw e;
					}finally{
						if(outputStream != null) try{ outputStream.close(); }catch (IOException e2) {}
					}
					
					if(tempFile.exists() && tempFile.isFile()){
					// Excel 처리
						if(tempFile.getName().indexOf(".xlsx") > -1 || tempFile.getName().indexOf(".xls") > -1) {
							smsService.insertSmsUser(readExcelData(tempFile));
							//dictionaryService.InsertDictionaryExcel(readExcel(tempFile));
						}
					}
				}
			}
			success = true;
		} catch (Exception ex) {
			error(ex.getMessage());
			success = false;
		}
		
		ModelAndView mv = new ModelAndView("/admin/sms/excelFileuploadPopup");
		mv.addObject("success", success);
		return mv;
	}
	
		
	// 엑셀 파일을 읽어들인다.
	//#{user_nm}, #{user_hdp}, SYSDATE, #{use_yn}, #{user_org})
	private List<Map<String, String>> readExcelData(File excelFile) throws IOException {
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(excelFile));
			
		if(wb == null && wb.getNumberOfSheets() == 0) 
			return null;
			
		HSSFSheet sheet = wb.getSheetAt(0);
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Map<String, String> user;
		Cell cell;
		String value;
		int i = 0;
		for(Row row : sheet) {
			if(row.getCell(0) != null){
				i++;
			}
			user = new HashMap<String, String>();
			
			//1번째 쉘 키워드
			cell = row.getCell(0);
			if(cell == null || cell.getStringCellValue() == null) break; //첫번째 쉘이 존재하지 않으면 
			value = cell.getStringCellValue();
			user.put("user_nm", value);
			
			//1번째 쉘 키워드
			cell = row.getCell(1);
			if(cell == null || cell.getStringCellValue() == null) break; //첫번째 쉘이 존재하지 않으면 
			value = cell.getStringCellValue();
			user.put("user_hdp", value);
			
			
			
			
			//3번째 쉘 영문명
			cell = row.getCell(2);
			if(cell != null && cell.getStringCellValue() != null) {
				value = cell.getStringCellValue();
				user.put("user_org", (value == null ? "" : value));
			}else{
				user.put("user_org", "");
			}
			
			//4번째 쉘 설명 
			//설명 공백이 들어올수도 있다.
			cell = row.getCell(3);
			if(cell != null && cell.getStringCellValue() != null) {
				value = cell.getStringCellValue();
				user.put("use_yn", (value == null ? "Y" : value));
			}else{
				user.put("use_yn", "Y");
			}
			
			Map<String, String> userData = smsService.selectUniqueSmsUser(user);
			if(userData == null) {
				list.add(user);
			}
		}
			
		if(list != null && list.size() > 0) list.remove(0);
			
		return list;
	}
	
}
