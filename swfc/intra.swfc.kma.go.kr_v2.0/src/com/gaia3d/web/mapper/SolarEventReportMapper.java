package com.gaia3d.web.mapper;

import java.util.List;
import java.util.Map;

import com.gaia3d.web.dto.SolarEventReportDTO;
import com.gaia3d.web.mapper.simple.BasicMapper;

public interface SolarEventReportMapper  extends BasicMapper<SolarEventReportDTO>{
	
	
	//등급표
	public List<Map<String, String>> selectGrade(Map<String, Object> params);
	//파일 조회
	public List<SolarEventReportDTO> selectLine(Map<String, Object> params);
	//파일 타입 리스트
	public List<Map<String, String>> selectType(Map<String, Object> params);
	//파일 Insert
	public void insert(SolarEventReportDTO data);
	//파일 별 최대 라인
	public int selectMaxLine(String fileDate);

}
