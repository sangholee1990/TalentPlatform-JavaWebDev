package com.gaia3d.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.gaia3d.web.mapper.GradeChartMapper;

@Service
public class StatisticsService extends BaseService{
	
	/**
	 * 등급별 발현 횟수 카운트를 가져온다.
	 * @param params
	 * @return
	 */
	public List<Map<String, String>> listGrade(Object params){
		GradeChartMapper mapper = sessionTemplate.getMapper(GradeChartMapper.class);
		return mapper.listGrade(params);
	}

}
