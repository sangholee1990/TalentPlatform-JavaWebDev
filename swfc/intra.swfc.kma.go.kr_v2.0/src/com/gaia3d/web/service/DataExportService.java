package com.gaia3d.web.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gaia3d.web.mapper.DataExportMapper;

@Service
public class DataExportService extends BaseService{

	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	/**
	 * 데이타구분별 해당 테이블의 데이타를 모두 검색한다.
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> listExportData(Object params) {
		
		DataExportMapper mapper = sessionTemplate.getMapper(DataExportMapper.class);
		
		return mapper.listExportData(params);
	}
}
