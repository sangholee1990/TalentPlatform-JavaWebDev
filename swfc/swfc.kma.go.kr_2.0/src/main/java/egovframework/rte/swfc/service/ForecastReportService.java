package egovframework.rte.swfc.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.rte.swfc.dto.ForecastReportDTO;
import egovframework.rte.swfc.mapper.ForecastReportMapper;

@Service
public class ForecastReportService extends BaseService {

	@Autowired(required=true)
	private SqlSession sessionTemplate;
	
	/**
	 * 다수의 통보문 정보를 가져온다.
	 * @param parameter
	 * @return
	 */
	public List<ForecastReportDTO> listForecastReport(Map<String, Object> parameter){
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		return mapper.SelectMany(parameter);
	}
	
	public ForecastReportDTO selectForecastReport(Map<String, Object> parameter){
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		return mapper.SelectOne(parameter);
	}
	
	/**
	 * 타운트 갯수를 가져온다.
	 * @param parameter
	 * @return
	 */
	public int selectCountForecastReport(Map<String, Object> parameter){
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		return mapper.Count(parameter);
	}
}
