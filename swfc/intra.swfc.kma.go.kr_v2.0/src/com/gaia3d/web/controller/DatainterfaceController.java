/**
 * 
 */
package com.gaia3d.web.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gaia3d.web.dto.DataMasterDTO;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.service.DataInterfaceService;
import com.gaia3d.web.util.StringUtils;

/**
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/datainterface/")
public class DatainterfaceController extends BaseController{
	
	
	@Autowired
	private DataInterfaceService dataInterfaceService;
	
	
	
	//--------------------------------------------------
	//  9999 : DB_ERROR
	//  0000 : SUCCESS
	//  0001 : DATA_NOTHING
 	//--------------------------------------------------
	
	/**
	 * master 정보의 보관 경로 및 파일명을 반환하는 API 
	 * @param clt_dta_mstr_seq_n
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("getKeepDirectory.do")
	public void getPathFileName(@RequestParam(value="mstr_seq_n", required=true) String clt_dta_mstr_seq_n, HttpServletResponse response) throws IOException{
		MapperParam params = new MapperParam();
		params.put("clt_dta_mstr_seq_n", clt_dta_mstr_seq_n);
		DataMasterDTO dto = null;
		String responseTxt = "";
		String code = "0000";
		try{
			dto = dataInterfaceService.getDirInfo(params);
			if(dto != null){
				responseTxt = StringUtils.getString( dto.getKep_dir(), "");
			}
			
			if("".equals(StringUtils.getString(responseTxt, ""))){
				code = "0001";
				responseTxt = String.format("%s DATA_NOTHING", code);
			}else{
				responseTxt = String.format("%s %s", code, responseTxt);
			}
			
		}catch(Exception e){
			code = "9999";
			responseTxt = String.format("%s DB_ERROR", code);
		}
		response.setContentType("text/plain");
		response.getWriter().write(responseTxt);
	}
	
	
	
	
	/**
	 * master 정보의 보관 파일명을 반환하는 API 
	 * @param clt_dta_mstr_seq_n
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("getFileName.do")
	public void getFileName(@RequestParam(value="mstr_seq_n", required=true) String clt_dta_mstr_seq_n, HttpServletResponse response) throws IOException{
		MapperParam params = new MapperParam();
		params.put("clt_dta_mstr_seq_n", clt_dta_mstr_seq_n);
		DataMasterDTO dto = null;
		String responseTxt = "";
		String code = "0000";
		try{
			
			dataInterfaceService.getDirInfo(params);
			if(dto != null){
				responseTxt = StringUtils.getString( dto.getClt_tar_cd(), "-") + " " + StringUtils.getString(dto.getClt_tar_sensor_cd(), "-") + " " + StringUtils.getString(dto.getDta_knd_cd(), "-")  + " " +StringUtils.getString(dto.getCoverage_cd(), "-");
			}
			
			if(isEmpty(responseTxt)){
				code = "0001";
				responseTxt = String.format("%s DATA_NOTHING", code);
			}else{
				responseTxt = String.format("%s %s", code, responseTxt);
			}
			
		}catch(Exception e){
			code = "9999";
			responseTxt = String.format("%s DB_ERROR", code);
		}
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().write(responseTxt);
	}
	
	/**
	 * master 정보의 보관 파일명을 반환하는 API 
	 * @param clt_dta_mstr_seq_n
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("getProgramPathFileName.do")
	public void getProgramPathFileName(@RequestParam(value="mstr_seq_n", required=true) String clt_dta_mstr_seq_n, HttpServletResponse response) throws IOException{
		MapperParam params = new MapperParam();
		params.put("clt_dta_mstr_seq_n", clt_dta_mstr_seq_n);
		DataMasterDTO dto = null;
		String responseTxt = "";
		String code = "0000";
		try{
			dto = dataInterfaceService.getDirInfo(params);
			if(dto != null){
				responseTxt = StringUtils.getString( dto.getProg_path(), "") + " " + StringUtils.getString(dto.getProg_file_nm(), "");
			}
			
			if(isEmpty(responseTxt)){
				code = "0001";
				responseTxt = String.format("%s DATA_NOTHING", code);
			}else{
				responseTxt = String.format("%s %s", code, responseTxt);
			}
			
		}catch(Exception e){
			code = "9999";
			responseTxt = String.format("%s DB_ERROR", code);
		}
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().write(responseTxt);
	}
	
	
	
	/**
	 * 수집자료 설정 프로그램 경로/파일명 가져오기 
	 * @param clt_dta_mstr_seq_n
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("getCollectionDataSetProgramPathFileName.do")
	public void getCollectionDataSetProgramPathFileName(@RequestParam(value="mstr_seq_n", required=true) String clt_dta_mstr_seq_n, HttpServletResponse response) throws IOException{
		MapperParam params = new MapperParam();
		params.put("clt_dta_mstr_seq_n", clt_dta_mstr_seq_n);
		DataMasterDTO dto = null;
		String responseTxt = "";
		String code = "0000";
		try{
			dto = dataInterfaceService.getDirInfo(params);
			if(dto != null){
				responseTxt = StringUtils.getString( dto.getProg_path(), "") + " " + StringUtils.getString(dto.getProg_file_nm(), "");
			}
			
			if(isEmpty(responseTxt)){
				code = "0001";
				responseTxt = String.format("%s DATA_NOTHING", code);
			}else{
				responseTxt = String.format("%s %s", code, responseTxt);
			}
		}catch(Exception e){
			code = "9999";
			responseTxt = String.format("%s DB_ERROR", code);
		}
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().write(responseTxt);
	}
	
	/**
	 * 수집 자료 DB 등록 프로그램 경로 /파일명 가져오기
	 * @param clt_dta_mstr_seq_n
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("getCollectionDataDbRegisterProgramPathFileName.do")
	public void getCollectionDataDbRegisterProgramPathFileName(@RequestParam(value="mstr_seq_n", required=true) String clt_dta_mstr_seq_n, HttpServletResponse response) throws IOException{
		MapperParam params = new MapperParam();
		params.put("clt_dta_mstr_seq_n", clt_dta_mstr_seq_n);
		params.put("api_type", "db");
		DataMasterDTO dto = null;
		String responseTxt = "";
		String code = "0000";
		try{
			dto = dataInterfaceService.getDirInfo(params);
			if(dto != null){
				responseTxt = StringUtils.getString( dto.getProg_path(), "") + " " + StringUtils.getString(dto.getProg_file_nm(), "");
			}
			
			if(isEmpty(responseTxt)){
				code = "0001";
				responseTxt = String.format("%s DATA_NOTHING", code);
			}else{
				responseTxt = String.format("%s %s", code, responseTxt);
			}
		}catch(Exception e){
			code = "9999";
			responseTxt = String.format("%s DB_ERROR", code);
		}
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().write(responseTxt);
	}
	
	/**
	 * 예측 모델 프로그램 경로/파일명 가져오기
	 * @param clt_dta_mstr_seq_n
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("getForecastModelProgramPathFileName.do")
	public void getForecastModelProgramPathFileName(@RequestParam(value="mstr_seq_n", required=true) String clt_dta_mstr_seq_n, HttpServletResponse response) throws IOException{
		MapperParam params = new MapperParam();
		params.put("clt_dta_mstr_seq_n", clt_dta_mstr_seq_n);
		params.put("api_type", "model");
		DataMasterDTO dto = null;
		String responseTxt = "";
		String code = "0000";
		try{
			dto = dataInterfaceService.getDirInfo(params);
			if(dto != null){
				responseTxt = StringUtils.getString( dto.getFrct_mdl_svr_ip(), "") + " " + StringUtils.getString( dto.getProg_path(), "") + " " + StringUtils.getString(dto.getProg_file_nm(), "");
			}
			
			if(isEmpty(responseTxt)){
				code = "0001";
				responseTxt = String.format("%s DATA_NOTHING", code);
			}else{
				responseTxt = String.format("%s %s", code, responseTxt);
			}
		}catch(Exception e){
			code = "9999";
			responseTxt = String.format("%s DB_ERROR", code);
		}
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().write(responseTxt);
	}
	
	
	/**
	 * master 정보의 최근 업데이트 시간을 업데이트
	 * @param clt_dta_mstr_seq_n
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("prcsCollectionDataDateUpdate.do")
	public void prcsCollectionDataDateUpdate(@RequestParam(value="mstr_seq_n", required=true) Integer mstr_seq_n, @RequestParam(value="tm", required=true) String tm, HttpServletResponse response) throws IOException{
		int result = -1;
		
		
		String code = "0000";
		String responseTxt = "";
		if(mstr_seq_n != null){
			MapperParam params = new MapperParam();
			params.put("clt_dta_mstr_seq_n", mstr_seq_n);
			params.put("tm", tm);
			
		    try{
		    	result = dataInterfaceService.updateMasterCollectDate(params);
		    }catch(Exception e){
		    	code = "9999";
				responseTxt = String.format("%s DB_ERROR", code);
		    }
		}
		
		responseTxt = "N";
		if( result > 0){
			responseTxt = "Y";
			responseTxt = String.format("%s %s", code, responseTxt);
		}else{
			code = "0001";
			responseTxt = String.format("%s %DATA_NOTHING", code);
		}
		
	    response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().write(responseTxt);
	}
	
	private static boolean isEmpty(String value){
		if(value == null) return true;
		
		value = value.replaceAll("-", "");
		value = value.replaceAll(" ", "");
		
		return "".equals(StringUtils.getString(value, ""));
		
		
	}
	
	/**
	 * master 수집자료의 최종 경로 및 파일명 가져오기 API 
	 * @param clt_dta_mstr_seq_n
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("prcsCollectionDataLastPathFileName.do")
	public void prcsCollectionDataLastPathFileName(@RequestParam(value="mstr_seq_n", required=true) String clt_dta_mstr_seq_n, HttpServletResponse response) throws IOException{
		MapperParam params = new MapperParam();
		params.put("clt_dta_mstr_seq_n", clt_dta_mstr_seq_n);
		DataMasterDTO dto = null;
		String responseTxt = "";
		String code = "0000";
		try{
			dto = dataInterfaceService.getDirInfo(params);
			if(dto != null){
				responseTxt = StringUtils.getString( dto.getKep_dir(), "");
				String clt_dta_lst_dtm =  StringUtils.getString( dto.getClt_dta_lst_dtm(), "");
				String lastTime = null;
				String dateTxt = "";
				if(!"".equals(clt_dta_lst_dtm)){
					dateTxt = " %s %s %s %s";
					lastTime = clt_dta_lst_dtm.substring(0, clt_dta_lst_dtm.lastIndexOf("."));
					
					if(lastTime.length() >= 14){
						lastTime = lastTime.substring(lastTime.length() - 14);
						dateTxt = String.format(dateTxt, lastTime.substring(0, 4), lastTime.substring(4, 6), lastTime.substring(6, 8), clt_dta_lst_dtm);
					}else{
						dateTxt = String.format(dateTxt, "-", "-", "-", clt_dta_lst_dtm);
					}
				}
				
				responseTxt = responseTxt + dateTxt;
			}
			
			if("".equals(StringUtils.getString(responseTxt, ""))){
				code = "0001";
				responseTxt = String.format("%s DATA_NOTHING", code);
			}else{
				responseTxt = String.format("%s %s", code, responseTxt);
			}
			
		}catch(Exception e){
			code = "9999";
			responseTxt = String.format("%s DB_ERROR", code);
			error(e.getMessage());
		}
		response.setContentType("text/plain");
		response.getWriter().write(responseTxt);
	}
	
	
	
	/**
	 * master 입력파일의 쿼리를 실행시켜 결과값을 파일로 남김 
	 * @param clt_dta_mstr_seq_n
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("prcsOracleDbGetData.do")
	public void prcsOracleDbGetData(@RequestParam(value="inPath", required=true) String inPath, @RequestParam(value="outPath", required=true) String outPath, HttpServletResponse response) throws IOException{
		int result = -1;
		String responseTxt = "";
		String code = "0000";
		try{
			
			int resultCnt = dataInterfaceService.selectSQlFileWithDataFileOut(inPath, outPath);
			
			if(resultCnt > 0){
				responseTxt = String.format("%s Y", code);
			}else{
				code = "0001";
				responseTxt = String.format("%s N", code);
			}
			
		}catch(SQLException e){
			code = "9999";
			responseTxt = String.format("%s DB_ERROR", code);
			error(e.getMessage());
		}catch(Exception e){
			code = "0001";
			responseTxt = String.format("%s N", code);
			error(e.getMessage());
		}
		
		response.setContentType("text/plain");
		response.getWriter().write(responseTxt);
	}
	
	
	
	
	
	public static void main(String[] args){
		
		String text = "ACE_SOLARWIND_EPAM_1_HOUR_201411010000--,201411200400--.txt";
		
		text = text.substring(0, text.lastIndexOf("."));
		
		if(text.length() >= 14){
			text = text.substring(text.length() - 14);
			text = text + " " + text.substring(0, 4) + " " + text.substring(4, 6) +" "+ text.substring(6, 8); 
		}else{
			text = text + "- - -";
		}
		
		System.out.println(text);
	}
}



