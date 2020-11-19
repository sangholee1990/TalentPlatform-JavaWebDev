/**
 * 
 */
package com.gaia3d.web.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

import com.gaia3d.web.dto.DataMasterDTO;
import com.gaia3d.web.mapper.DataInterfaceMapper;
import com.gaia3d.web.mapper.DataMasterMapper;
import com.gaia3d.web.mapper.ProgramMapper;

/**
 * @author Administrator
 *
 */
@Service
public class DataInterfaceService extends BaseService {
	
	public DataMasterDTO getDirInfo(Object parameter){
		DataMasterMapper mapper = sessionTemplate.getMapper(DataMasterMapper.class);
		DataMasterDTO dto = mapper.SelectOne(parameter);
		return dto;
	}
	
	public int updateMasterCollectDate(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		return mapper.updateMasterCollectDate(params);
	}
	
	
	public int selectSQlFileWithDataFileOut(String inFile, String outFile) throws SQLException, Exception {
		
		Map<String, String> params = new HashMap<String, String>();
		int reultCnt = 0;
		try{
			String selectQuery = getSqlQuery(inFile);
			
			if(selectQuery != null){
				if(selectQuery.toUpperCase().indexOf("DELETE") != -1) throw new SQLException("datainterface not usage delete sql exception");
				if(selectQuery.toUpperCase().indexOf("UPDATE")!= -1) throw new SQLException("datainterface not usage update sql exception");
				if(selectQuery.toUpperCase().indexOf("DROP") != -1) throw new SQLException("datainterface not usage drop sql exception");
				if(selectQuery.toUpperCase().indexOf("CREATE") != -1) throw new SQLException("datainterface not usage create sql exception");
				if(selectQuery.toUpperCase().indexOf("INSERT") != -1) throw new SQLException("datainterface not usage insert sql exception");
					
			}
			
			params.put("selectQuery", selectQuery);
			
			DataInterfaceMapper mapper = sessionTemplate.getMapper(DataInterfaceMapper.class);
			List<Map<String, Object>> result = mapper.selectData(params);
			if(result != null){
				reultCnt = result.size(); 
				saveResult(result, outFile);
			}
		}catch(SQLException e){
			throw e;
		}catch(Exception e){
			error("datainterface file write error "+ e.getMessage());
			throw e;
		}
		
		return reultCnt;
	}
	
	/**
	 * 결과값을 파일로 저장한다.
	 * @param result
	 * @param outFile
	 */
	private void saveResult(List<Map<String, Object>> result, String outFile){
		
		File out = new File(outFile);
		//FileOutputStream fos = new File
		List lines = new ArrayList<String>();
		String header = "";
		if(result != null && result.size() > 0){
			StringBuilder headerLine = null;
			StringBuilder line = null;
			boolean loop = false;
			for(int i = 0; i < result.size(); i++){
				
				LinkedHashMap<String, Object> data = (LinkedHashMap<String, Object>)result.get(i);
				Iterator<String> k = data.keySet().iterator();
				line = new StringBuilder();
				if(i == 0) headerLine = new StringBuilder();
				String key = null;
				loop = k.hasNext();
				while(loop){
					key = k.next();
					if(i == 0) headerLine.append(key.toLowerCase());
					line.append(data.get(key));
					loop = k.hasNext();
					if(loop){
						if(i == 0) headerLine.append("\t");
						line.append("\t");
					}
				}
				
				if(i == 0) lines.add(headerLine.toString());
				lines.add(line.toString());
			}
			try {
				FileUtils.writeLines(out, lines);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	/**
	 * 파일의 내용을 읽어와서 문자열로 반환한다.
	 * @param inFile 읽어들일 전체 경로 + 파일명
	 * @return
	 * @throws Exception
	 */
	private String getSqlQuery(String inFile) throws Exception{
		StringBuilder sb = null;
		Scanner sc = null;
		File sqlFile = new File(inFile);
		
		if(sqlFile.exists() && sqlFile.isFile()){
			try{
				sc = new Scanner(sqlFile);
				sb = new StringBuilder();
				while(sc.hasNextLine()){
					sb.append(sc.nextLine());
				}
			}catch(Exception e){
				throw e;
			}finally{
				if(sc != null) sc.close();
			}
		}else{
			throw new FileNotFoundException("inFile not found Exception");
		}
		return sb.toString();
	}
	
	
}
