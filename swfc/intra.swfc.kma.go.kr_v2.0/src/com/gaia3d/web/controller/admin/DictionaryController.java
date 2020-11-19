package com.gaia3d.web.controller.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import jxl.read.biff.BiffException;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.dto.DictionaryDTO;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.service.DictionaryService;
import com.gaia3d.web.util.Constants;
import com.gaia3d.web.util.PageNavigation;
import com.gaia3d.web.util.WebUtil;

/**
 * 단어사전에 관한 클래스
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/dic/")
public class DictionaryController extends BaseController {
	
	@Resource(name = "sqlSessionTemplate")
	protected SqlSession sessionTemplate;
	
	@Autowired
	private DictionaryService dictionaryService;
	
	@Autowired(required=false)
	@Qualifier("PDSLocationResource")
	private FileSystemResource pdsLocation;

	/**
	 * 단어사전 목록 리스트 페이지를 보여준다.
	 * @return
	 */
	@RequestMapping("dictionary_list.do")
	public void dictionary_list(
			@RequestParam(value="iPage", defaultValue="1") int page
			,@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize
			,@RequestParam Map<String, Object> params
			,Model model){
		
		int count = dictionaryService.SelectCount(params);
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		params.put("startRow", ""+navigation.getStartRow());
		params.put("endRow", ""+navigation.getEndRow());
		
		model.addAttribute("list", dictionaryService.SelectDictionaryList(params));
		model.addAttribute("pageNavigation", navigation);
	}
	
	/**
	 * 
	 * 단어사전을 상세조회한다.
	 * @return
	 * 
	 */
	@RequestMapping("dictionary_view.do")
	public void dictionary_view(
			@RequestParam(value="wrd_dic_seq_n", required=false) Integer wrd_dic_seq_n,
			ModelMap model) throws Exception {
		
		MapperParam param = new MapperParam();
		param.put("wrd_dic_seq_n", wrd_dic_seq_n);
		DictionaryDTO dto = dictionaryService.SelectDictionary(param);
		
		if(dto == null) {
			throw new Exception();
		}
		
		model.addAttribute("dictionary", dto);
	}
	
	/**
	 * 단어사전 등록 또는 수정페이지
	 * 
	 */
	@RequestMapping("dictionary_form.do")
	public void dictionary_form(
			@RequestParam(value="wrd_dic_seq_n", required=false) Integer wrd_dic_seq_n,
			@RequestParam(value="mode", required=false) String mode,
			@RequestParam(value="count", required=false) Integer count,
			ModelMap model) throws Exception  {
		
		DictionaryDTO dto = null;
		
		if(wrd_dic_seq_n == null) {
			dto = new DictionaryDTO();
			model.addAttribute("mode", "new");
			model.addAttribute("count", count);
		} else {
			MapperParam param = new MapperParam();
			param.put("wrd_dic_seq_n", wrd_dic_seq_n);
			dto = dictionaryService.SelectDictionary(param);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("게시물이 없습니다.");
		}
		
		model.addAttribute("dictionary", dto);
		
	}
	
	/**
	 * 단어사전 등록 또는 수정
	 */
	@RequestMapping("dictionary_submit.do")
	public String dictionary_submit(
			@RequestParam Map<String,Object> requestParams,
			@ModelAttribute("dictionary") @Valid DictionaryDTO dictionary,
			BindingResult bindingResult) throws Exception {
	
		if (bindingResult.hasErrors()) {
			return "admin/dic/dictionary_form";
		}
		if(dictionary.getWrd_dic_seq_n() == null) {
			int count = dictionaryService.SelectUniqueExcelDataCount(dictionary);
			if(count == 0) {
				dictionaryService.InsertDictionary(dictionary);
				return "redirect:dictionary_list.do";
			} else if (count != 0) {
				return "redirect:dictionary_form.do?count=" + count;
			}
		} 
		
		if(dictionary.getWrd_dic_seq_n() != null) {
			dictionaryService.UpdateDictionary(dictionary);
		}
		
		return "redirect:dictionary_view.do?wrd_dic_seq_n=" + dictionary.getWrd_dic_seq_n();
	}
	
	/**
	 * 단어사전 내용 삭제
	 */
	@RequestMapping("dictionary_del.do")
	public String dictionary_del(
			@RequestParam(value="wrd_dic_seq_n", required=true) String wrd_dic_seq_n,
			@RequestParam Map<String, String> requestParams) throws Exception {
		
		requestParams.put("wrd_dic_seq_n", wrd_dic_seq_n);
		
		dictionaryService.DeleteDictionary(requestParams);
		
		requestParams.remove(wrd_dic_seq_n);
		
		return "redirect:dictionary_list.do?" + WebUtil.getQueryStringForMap(requestParams);
		
	}
	
	/**
	 * 단어사전 양식 샘플 다운로드한다.
	 */
	@RequestMapping("dictionary_sampleDownload.do")
	public void dictionary_sampleDownload(HttpServletRequest request,
										  HttpServletResponse response,
										  @RequestParam Map<String, Object> params) throws Exception {
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();
		HSSFRow row = sheet.createRow(0);
		
		row.createCell(0).setCellValue("예약어");
		row.createCell(1).setCellValue("국문명");
		row.createCell(2).setCellValue("영문명");
		row.createCell(3).setCellValue("설명");
		
		int idx = 0;
		
		row = sheet.createRow(idx + 1);
		row.createCell(0).setCellValue("SVC");
		row.createCell(1).setCellValue("용역");
		row.createCell(2).setCellValue("SERVICE");
		row.createCell(3).setCellValue("공백이 들어갈 수도 있습니다");
		
		// 타입을 excel로 지정
		response.setContentType("application/ms-excel");
		response.setHeader("Expires:", "0");
		response.setHeader("Content-Disposition", "attachment; filename=dictionary_excelsample.xls");
		
		wb.write(response.getOutputStream());
	}
	
	/**
	 * 단어사전 목록 엑셀 파일 다운로드한다.
	 * @return
	 */
	@RequestMapping("dictionary_excelDownload.do")
	public void dictionary_excelDownload(HttpServletRequest request, 
										HttpServletResponse response, 
										@RequestParam Map<String, Object> params) throws Exception {
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		GregorianCalendar today = new GregorianCalendar();
		List<DictionaryDTO> excelList = dictionaryService.SelectDictionaryExcelList(params);

		// 스프레드시트를 만든다.
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();
		HSSFRow row = sheet.createRow(0);
		row.createCell(0).setCellValue("예약어");
		row.createCell(1).setCellValue("국문명");
		row.createCell(2).setCellValue("영문명");
		row.createCell(3).setCellValue("등록일자");
		
		// 데이터를 셀에 출력한다.
		for(int idx=0; idx<excelList.size(); idx++) {
			row = sheet.createRow(idx + 1);
			row.createCell(0).setCellValue(excelList.get(idx).getSimple_nm());
			row.createCell(1).setCellValue(excelList.get(idx).getKor_nm());
			row.createCell(2).setCellValue(excelList.get(idx).getEng_nm());
			row.createCell(3).setCellValue(formatter.format(excelList.get(idx).getReg_dt()));
		}
		
		// 타입을 excel로 지정
		response.setContentType("application/ms-excel");
		response.setHeader("Expires:", "0");
		response.setHeader("Content-Disposition", "attachment; filename=dictionary_" + today.get(today.YEAR) + (today.get(today.MONTH) + 1) + today.get(today.DATE) + today.get(today.HOUR) + today.get(today.MINUTE) + today.get(today.SECOND) + ".xls");
		
		wb.write(response.getOutputStream());
	}
	
	/**
	 * 단어사전 엑셀파일 업로드 팝업창 페이지로 이동한다.
	 * 
	 */
	@RequestMapping("dictionary_excelUploadPopup.do")
	public ModelAndView dictionary_excelUploadPopup() {
		ModelAndView mv = new ModelAndView("/admin/dic/dictionary_excelFileuploadPopup");
		return mv;
	}
	
	/**
	 * 단어사전 엑셀파일을  업로드한다.
	 * 
	 */
	@RequestMapping("dictionary_excelUpload.do")
	public ModelAndView dictionary_excelUpload(HttpServletRequest request,
										HttpServletResponse response,
										@RequestParam Map<String, Object> params,
										@RequestParam("fileData") MultipartFile[] fileData) throws Exception {
		
		boolean success = false;
		
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
			MultipartFile multipartFile = multipartRequest.getFile("fileData");
			
			String filePath = pdsLocation.getPath();
			
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
						if(tempFile.getName().indexOf(".xlsx") > -1) {
							dictionaryService.InsertDictionaryExcel(readExcel2007(tempFile));
						} else if(tempFile.getName().indexOf(".xls") > -1) {
							dictionaryService.InsertDictionaryExcel(readExcel(tempFile));
						}
					}
					
					
				}
			}
			success = true;
		} catch (Exception ex) {
			error(ex.getMessage());
			success = false;
		}
		
		ModelAndView mv = new ModelAndView("/admin/dic/dictionary_excelFileuploadPopup");
		mv.addObject("success", success);
		return mv;
	}
	
	// Excel 2007(.xlsx) 이상 파일처리
		public List<DictionaryDTO> readExcel2007(File excelFile) throws IOException, BiffException {
			return readExcelData(excelFile);
		}
			
		// Excel 97 ~ 2003(.xls) 파일처리
		public List<DictionaryDTO> readExcel(File excelFile) throws IOException, BiffException {
			return readExcelData(excelFile);
		}
		
		// 엑셀 파일을 읽어들인다.
		public List<DictionaryDTO> readExcelData(File excelFile) throws IOException {
			HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(excelFile));
				
			if(wb == null && wb.getNumberOfSheets() == 0) 
				return null;
				
			HSSFSheet sheet = wb.getSheetAt(0);
			List<DictionaryDTO> list = new ArrayList<DictionaryDTO>();
			DictionaryDTO dto;
			Cell cell;
			String value;
			int i = 0;
			for(Row row : sheet) {
				if(row.getCell(0) != null){
					i++;
				}
				dto = new DictionaryDTO();
				
				//1번째 쉘 키워드
				cell = row.getCell(0);
				if(cell == null || cell.getStringCellValue() == null) break; //첫번째 쉘이 존재하지 않으면 
				value = cell.getStringCellValue();
				dto.setSimple_nm(value);
				
				//2번째 쉘 국문명
				cell = row.getCell(1);
				if(cell != null && cell.getStringCellValue() != null) {
					value = cell.getStringCellValue();
					dto.setKor_nm((value == null ? "" : value));
				}
				else
				{
					dto.setKor_nm("");
				}
				
				//3번째 쉘 영문명
				cell = row.getCell(2);
				if(cell != null && cell.getStringCellValue() != null) {
					value = cell.getStringCellValue();
					dto.setEng_nm((value == null ? "" : value));
				}
				else
				{
					dto.setEng_nm("");
				}
				
				//4번째 쉘 설명 
				//설명 공백이 들어올수도 있다.
				cell = row.getCell(3);
				if(cell != null && cell.getStringCellValue() != null) {
					value = cell.getStringCellValue();
					dto.setWrd_desc((value == null ? "" : value));
				} 
				else
				{
					dto.setWrd_desc("");
				}
				
				int count = dictionaryService.SelectUniqueExcelDataCount(dto);
				if(count == 0) {
					list.add(dto);
				}else{
					
				}
				
			}
				
			if(list != null && list.size() > 0) list.remove(0);
				
			return list;
		}
}
