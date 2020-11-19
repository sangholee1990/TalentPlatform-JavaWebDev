package com.gaia3d.web.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.dto.CodeDTO;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.mapper.CodeMapper;

@Service
public class CodeService extends BaseService {
	private static final Logger logger = LoggerFactory.getLogger(CodeService.class);
	
	public List<CodeDTO> selectSubCodeList(Object parameter) {
		CodeMapper mapper = sessionTemplate.getMapper(CodeMapper.class); 
		return mapper.SelectMany(parameter);
	}

	/**
	 * Wmo code list
	 * @return
	 */
	public Map<String, List<Map<String, String>>> getWmoCodeList() {
	
		Map<String, List<Map<String, String>>> result = new HashMap<String, List<Map<String, String>>>();
		List<Map<String, String>> child = null;
		
		CodeMapper mapper = sessionTemplate.getMapper(CodeMapper.class); 
		
		HashMap<String, String> parameter = new HashMap<String, String>();
		parameter.put("code", "WMO");
		List<CodeDTO> pList = mapper.SelectMany(parameter);
	
		for(CodeDTO pcode : pList ){
			
			HashMap<String, String> param = new HashMap<String, String>();
			param.put("code", pcode.getCode());
			List<CodeDTO> cList = mapper.SelectMany(param);
			
			child = new ArrayList();
			for(CodeDTO ccode : cList ){
				HashMap tmpMap = new HashMap();
				tmpMap.put(ccode.getCode_nm(), ccode.getCode());
				child.add(tmpMap);
			}
			result.put(pcode.getCode_nm(), child);
		}
		return result;
	}
	
	/**
	 * 리스트 전체 코드를 가져온다.
	 * @return
	 */
	public List<Map<String, String>> listAllCode(){
		CodeMapper mapper = sessionTemplate.getMapper(CodeMapper.class); 
		return mapper.listCodeLevel(null);
	}
	
	/**
	 * 신규 코드를 추가한다.
	 * @param param
	 * @return
	 */
	public Integer insertCode(Map<String, String> param){
		CodeMapper mapper = sessionTemplate.getMapper(CodeMapper.class); 
		return mapper.insertCode(param);
		
	}
	
	public Integer deleteCode(Map<String, String> param){
		CodeMapper mapper = sessionTemplate.getMapper(CodeMapper.class); 
		return mapper.deleteCode(param);
	}
	
	public Integer updateCode(Map<String, String> param){
		CodeMapper mapper = sessionTemplate.getMapper(CodeMapper.class); 
		return mapper.updateCode(param);
	}
}
