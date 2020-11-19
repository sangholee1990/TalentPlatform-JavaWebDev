package egovframework.rte.swfc.mapper;

import egovframework.rte.swfc.dto.ForecastReportDTO;
import egovframework.rte.swfc.mapper.simple.BasicMapper;

public interface ForecastReportMapper extends BasicMapper<ForecastReportDTO> {
	void UpdateSubmit(int id);
}
