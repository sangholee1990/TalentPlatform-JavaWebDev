package com.gaia3d.web.mapper;

import java.util.List;
import java.util.Map;

import com.gaia3d.web.dto.ProgramDTO;
import com.gaia3d.web.mapper.simple.BasicMapper;

public interface ProgramMapper extends BasicMapper<ProgramDTO> {
	ProgramDTO SelectRecentOne(String type);
	
	List<Map<String, String>> listCltData(Object params);
	List<Map<String, String>> listCltProg(Object params);
	List<Map<String, String>> listFrctProg(Object params);
	
	List<Map<String, String>> listCltDataMappingInfo(Object params);
	List<Map<String, String>> listFrctProgMappingInfo(Object params);
	
	Map<String, String> selectCltData(Object params);
	Map<String, String> selectCltProg(Object params);
	Map<String, String> selectFrctProg(Object params);
	
	int hasFrctProgMapping(Object params);
	
	int listCountCltData(Object params);
	int listCountCltProg(Object params);
	int listCountFrctProg(Object params);
	
	int deleteCltData(Object params);
	int deleteCltProg(Object params);
	int deleteFrctProg(Object params);
	int deleteCltProgMapping(Object params);
	int deleteCltProgMappingAll(Object params);
	int deleteFrctProgMapping(Object params);
	
	int updateCltData(Object params);
	int updateCltProg(Object params);
	int updateFrctProg(Object params);
	int updateFrctProgMapping(Object params);
	
	void insertCltData(Object params);
	void insertCltProg(Object params);
	void insertFrctProg(Object params);
	void insertCltProgMapping(Object params);
	void insertFrctProgMapping(Object params);
	
	//datainterface 관련 메서드
	int updateMasterCollectDate(Object params);
}
