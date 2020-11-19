package com.gaia3d.web.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.gaia3d.web.dto.SWPCAceMag;
import com.gaia3d.web.dto.SWPCGoesProtonFlux;
import com.gaia3d.web.dto.SWPCGoesXray1M;
import com.gaia3d.web.dto.SimpleDoubleValueChartData;
import com.gaia3d.web.dto.SimpleIntegerValueChartData;
import com.gaia3d.web.mapper.StatMapper;

@Service
public class StatsService extends BaseService {
	
	public List<SWPCGoesXray1M> SelectXrayStat(Object params) {
		StatMapper mapper = sessionTemplate.getMapper(StatMapper.class);
		return mapper.SelectXrayStat(params);
	}
	
	public List<SWPCGoesProtonFlux> SelectProtonStat(Object params) {
		StatMapper mapper = sessionTemplate.getMapper(StatMapper.class);
		return mapper.SelectProtonStat(params);
	}
	
	public List<SimpleIntegerValueChartData> SelectKpStat(Object params) {
		StatMapper mapper = sessionTemplate.getMapper(StatMapper.class);
		return mapper.SelectKpStat(params);
	}
	
	public List<SimpleDoubleValueChartData> SelectMpStat(Object params) {
		StatMapper mapper = sessionTemplate.getMapper(StatMapper.class);
		return mapper.SelectMpStat(params);
	}
	
	public List<SWPCAceMag> SelectBtStat(Object params) {
		StatMapper mapper = sessionTemplate.getMapper(StatMapper.class);
		return mapper.SelectBtStat(params);
	}
	
	public List<SimpleDoubleValueChartData> SelectBulk_SpdStat(Object params) {
		StatMapper mapper = sessionTemplate.getMapper(StatMapper.class);
		return mapper.SelectBulk_SpdStat(params);
	}
	
	public List<SimpleDoubleValueChartData> SelectPro_DensStat(Object params) {
		StatMapper mapper = sessionTemplate.getMapper(StatMapper.class);
		return mapper.SelectPro_DensStat(params);
	}
	
	public List<SimpleDoubleValueChartData> SelectIon_TempStat(Object params) {
		StatMapper mapper = sessionTemplate.getMapper(StatMapper.class);
		return mapper.SelectIon_TempStat(params);
	}
}
