package com.gaia3d.web.mapper;

import java.util.List;
import java.util.Map;

public interface DataExportMapper {
	
	/**
	 * 데이타구분별 해당 테이블의 데이타를 모두 검색한다.
	 * @param parameter
	 * @return
	 */
	List<Map<String, Object>> listExportData(Object parameter);
}
