package com.gaia3d.web.mapper;

import java.util.Map;

import com.gaia3d.web.dto.ForecastReportDTO;
import com.gaia3d.web.mapper.simple.BasicMapper;

public interface ForecastReportMapper extends BasicMapper<ForecastReportDTO> {
	
	void UpdateSubmit(int id);
	
	void updateAdminReportFileInfo(ForecastReportDTO report);
	
	ForecastReportDTO selectAdminReportFileInfo(Map<String, Object> params);
	
	int selectNextPublishSeqN(ForecastReportDTO report);
	
	String selectNextWrnPublishSeqN(ForecastReportDTO report);
	
	int duplCheckPublishSeqN(ForecastReportDTO report);
	
	ForecastReportDTO SelectOnePreviousWrnIssueReport(Object params);
	
}
