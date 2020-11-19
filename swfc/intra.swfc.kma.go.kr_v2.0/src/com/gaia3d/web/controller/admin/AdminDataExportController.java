package com.gaia3d.web.controller.admin;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.dto.CodeDTO;
import com.gaia3d.web.service.CodeService;
import com.gaia3d.web.service.DataExportService;

@Controller
@RequestMapping("/admin/export/")
public class AdminDataExportController extends BaseController{

	
	private static final String DATA_EXPORT_TYPE_CD = "DATA_EXPORT_TYPE_CD";
	
	@Autowired
	private CodeService codeService;
	
	/**
	 * 기간별 위성자료의 데이타구분 코드
	 * 
	 * @return
	 */
	private List<CodeDTO> listCode(){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("code", DATA_EXPORT_TYPE_CD);
		params.put("use_yn", "Y");
		return codeService.selectSubCodeList(params);
	}
	
	@Autowired
	private DataExportService dataExportService;
	
	private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	/**
	 * 기간별 위성자료 데이타 다운로드 화면으로 이동한다.
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("data_export_search_form.do")
	public String dataExportSearchForm(@RequestParam Map<String, String> params, Model model) {
		
		Calendar cal = Calendar.getInstance();
		
		// 검색종료 기본값을 오늘로 설정
		if(!params.containsKey("endDate")){
			// 파라메터에 추가
			params.put("endDate", sdf.format(cal.getTime()));
		}
		
		// 검색종료 시간 기본값을 현재 시간으로 설정
		if(!params.containsKey("endHour")){
			String endHour = String.valueOf( cal.get(Calendar.HOUR_OF_DAY) ); 
			// 현재 시간이 한자리인 경우 두자리의 문자열로...
			if(endHour.length() <= 1) endHour = "0" + endHour;
			
			// 파라메터에 추가
			params.put("endHour", endHour);
		}
		
		// 캘린더를 하루 전으로 설정한다.
		cal.add(Calendar.DATE, -1);
		
		// 검색시작 기본값을 하루 전으로 설정
		if(!params.containsKey("startDate")){
			// 파라메터에 추가
			params.put("startDate", sdf.format(cal.getTime()));
		}
		
		// 검색시작 시간 기본값을 현재시간으로 설정
		if(!params.containsKey("startHour")){
			String startHour = String.valueOf( cal.get(Calendar.HOUR_OF_DAY) ); 
			// 현재 시간이 한자리인 경우 두자리의 문자열로...
			if(startHour.length() <= 1) startHour = "0" + startHour;
			
			// 파라메터에 추가
			params.put("startHour", startHour);
		}
		
		// 파라메터를 모델에 추가
		model.addAttribute("params", params);
		
		// 기간별 위성자료 데이타 구분코드를 모델에 추가한다.
		model.addAttribute("subcodeList", listCode());
		
		return "/admin/export/data_export_search_form";
	}
	
	/**
	 * 데이타 구분별 해당 테이블의 데이타를 모두 엑셀파일로 저장한다.
	 * @param request
	 * @param response
	 * @param params
	 * @param model
	 */
	@RequestMapping("export_data_to_excel.do")
	@ResponseBody
	public void exportDataToExcel(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> params, Model model) {

		// 검색기간 일자 yyyy-MM-dd 형식을 yyyyMMdd 형식으로 변경한다.
		String[] st_tmp = params.get("startDate").split("-");
		String[] end_tmp = params.get("endDate").split("-");
		
		String st_dt = st_tmp[0] + st_tmp[1] + st_tmp[2] + params.get("startHour");
		String end_dt = end_tmp[0] + end_tmp[1] + end_tmp[2] + params.get("endHour");
		
		// 검색기간 시간을 0분 0초로 설정한다.
		params.put("startDate", st_dt + "0000");
		params.put("endDate", end_dt + "0000");
		
		// 데이타 구분별 해당 테이블의 데이타를 모두 검색한다.
		List<Map<String, Object>> list = dataExportService.listExportData(params);
		
		try{
			// 엑셀파일 생성
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			HSSFRow header_row = null;
			HSSFRow row = null;
			
			// 최상단 헤더가 될 로우 생성 
			header_row = sheet.createRow(0);
			
			// 검색된 데이타의 key 값 가져온다.
			Iterator<String> k = list.get(0).keySet().iterator();
			
			// 헤더로우의 셀 count가 저장될 변수
			int idx = 0;
			
			// key 값을 헤더로우의 각 셀에 입력한다.
			while(k.hasNext()) {
				String key = (String) k.next();
				header_row.createCell(idx).setCellValue(key);
				
				// 헤더로우의 셀 count 증가.
				idx++;
			}
			
			// 데이터를 입력한다.
			for(int i=0; i<list.size(); i++) {
				// 리스트의 사이즈만큼 로우생성
				row = sheet.createRow(i+1);
				
				// 헤더로우의 셀 count 만큼 로우마다 셀 생성
				for(int j=0; j<idx; j++) {
					
					// 각 셀의 헤더로우의 데이터를 키값으로 value 를 셀에 저장한다. 
					row.createCell(j).setCellValue(String.valueOf(list.get(i).get(header_row.getCell(j).toString())));
				}
			}
			
			// 파일명 형식 : 데이타 구분명_검색시작_검색종료.xls
			String filename = params.get("filename") + "_" + st_dt + "_" + end_dt;
			
			String browser = request.getHeader("User-Agent");
			
			// 한글파일명 처리
			if(browser.contains("MSIE") || browser.contains("Trident")){
				filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
			}else{
				filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			// 타입을 excel로 지정
			response.setContentType("application/ms-excel");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + ".xls\";");
			response.setHeader("Content-Transfer-Encoding", "binary");
			
			wb.write(response.getOutputStream());
		}catch(Exception e) {
//			e.printStackTrace();
		}
	}
}
