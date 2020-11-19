package com.gaia3d.web.mapper;

import java.util.List;
import java.util.Map;

import com.gaia3d.web.mapper.simple.BasicMapper;

/**
 * 특정수요자용 컨텐츠를 처리하기 위한 인터페이스
 * @author 김현철
 *
 */
public interface SPCFMapper extends BasicMapper<Map<String, Object>> {
	
	/**
	 * 특정수요자용 컨텐츠 검색
	 * @param parameter
	 * @return
	 */
	List<Map<String, String>> listSPCFContents(Object parameter);

	/**
	 * 특정수요자용 컨텐츠 검색 카운트
	 * @param parameter
	 * @return
	 */
	int countSPCFContents(Object parameter);
	
	/**
	 * 특정수요자용 컨텐츠 조회
	 * @param parameter
	 * @return
	 */
	Map<String, String> selectSPCFContents(Object parameter);
	
	/**
	 * 특정수요자용 컨텐츠 등록
	 * @param parameter
	 * @return
	 */
	int insertSPCFContents(Object parameter);
	
	/**
	 * 특정수요자용 컨텐츠 수정
	 * @param parameter
	 * @return
	 */
	int updateSPCFContents(Object parameter);
	
	/**
	 * 특정수요자용 컨텐츠 삭제
	 * @param parameter
	 * @return
	 */
	int deleteSPCFContents(Object parameter);
	
	/**
	 * 특정수요자에게 등록된 컨텐츠를 검색한다.
	 * @param parameter
	 * @return
	 */
	List<Map<String, String>> searchSPCFContents(Object parameter);
	
	int selectSPCFContentsUserMappingDataCnt(Object parameter);
	
	/**
	 * 특정수요자에게 컨텐츠를 등록한다.
	 * @param parameter
	 * @return
	 */
	int insertSPCFContentsUserMappingData(Object parameter);
	
	/**
	 * 특정수요자에게 등록된 컨텐츠를 삭제한다.
	 * @param parameter
	 * @return
	 */
	int deleteSPCFContentsUserMappingData(Object parameter);
}
