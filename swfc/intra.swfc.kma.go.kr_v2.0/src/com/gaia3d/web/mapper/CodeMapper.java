package com.gaia3d.web.mapper;

import java.util.List;
import java.util.Map;

import com.gaia3d.web.dto.CodeDTO;
import com.gaia3d.web.mapper.simple.BasicMapper;

public interface CodeMapper extends BasicMapper<CodeDTO> {
	
	List<CodeDTO> SelectMany(Object parameter);
	
	/**
	 * 전체 코드정보를 가져온다.
	 * @param parameter
	 * @return
	 */
	List<Map<String, String>> listCodeLevel(Object parameter);
	
	/**
	 * 하나의 코드 정보를 가져온다.
	 * @param parameter
	 * @return
	 */
	Map<String, String> selectCode(Object parameter);
	
	/**
	 * 코드정보 삭제
	 * @param parameter
	 * @return
	 */
	Integer deleteCode(Object parameter);
	
	/**
	 * 코드정조 수정
	 * @param parameter
	 * @return
	 */
	Integer updateCode(Object parameter);
	
	/**
	 * 코드정보 등록
	 * @param parameter
	 * @return
	 */
	Integer insertCode(Object parameter);
	
	/**
	 * 자식을 코드를 가지고 있는지의 여부확인
	 * @param parameter
	 * @return
	 */
	Integer hasChild(Object parameter);
}
