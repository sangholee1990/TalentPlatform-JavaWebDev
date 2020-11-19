package com.gaia3d.web.mapper;

import java.util.List;
import java.util.Map;


public interface DailySituationReportMapper{
	
	/**
	 * 이전 날짜의 특보요소의 최대 값을 가져온다.
	 * @param parasm
	 * @return
	 */
	List<Map<String, String>> selectRSGPreDay(Object params);
	List<Map<String, String>> selectWrnLastData(Object params);
	
	/**
	 * 하나의 상황보고를 등록한다.
	 * @param params
	 */
	void insertDailySituationReport(Object params);
	
	int deleteDailySituationReport(Object params);
	
	int updateDailySituationReport(Object params);
	
	/**
	 * 하나의 일일 상황보고 문서를 가져온다.
	 * @param params
	 * @return
	 */
	Map<String, Object> selectDailySituationReport(Object params);

}
