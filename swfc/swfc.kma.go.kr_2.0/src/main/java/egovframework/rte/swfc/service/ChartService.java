package egovframework.rte.swfc.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.rte.swfc.common.Code;
import egovframework.rte.swfc.dto.ChartData;
import egovframework.rte.swfc.dto.ChartSummaryDTO;
import egovframework.rte.swfc.dto.ChartSummaryDTO.Duration;
import egovframework.rte.swfc.mapper.ChartDataMapper;

@Service
public class ChartService extends BaseService {
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	
	@Autowired(required=true)
	private SqlSession sessionTemplate;
	
	public Map<String, Object> selectChartSummary() {
		ChartDataMapper mapper = sessionTemplate.getMapper(ChartDataMapper.class);
		List<ChartSummaryDTO> summaryList = mapper.SelectSummary();
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("notice1", ChartSummaryDTO.MaxCodeFor기상위성운영(summaryList, Duration.H3));
		output.put("notice2", ChartSummaryDTO.MaxCodeFor극항로항공기상(summaryList, Duration.H3));
		output.put("notice3", ChartSummaryDTO.MaxCodeFor전리권기상(summaryList, Duration.H3));
		
		ChartSummaryDTO XRAY_NOW = null;
		ChartSummaryDTO XRAY_H3 = null;
		ChartSummaryDTO PROTON_NOW = null;
		ChartSummaryDTO PROTON_H3 = null;
		ChartSummaryDTO KP_NOW = null;
		ChartSummaryDTO KP_H3 = null;
		ChartSummaryDTO KP_H6 = null;
		ChartSummaryDTO MP_NOW = null;
		ChartSummaryDTO MP_H3 = null;
		for(ChartSummaryDTO chart : summaryList) {
			switch(chart.getDataType()) {
			case XRAY:
				if(chart.getDuration() == Duration.NOW)
					XRAY_NOW = chart;
				else if(chart.getDuration() == Duration.H3)
					XRAY_H3 = chart;
				break;
			case PROTON:
				if(chart.getDuration() == Duration.NOW)
					PROTON_NOW = chart;
				else if(chart.getDuration() == Duration.H3)
					PROTON_H3 = chart;
				break;
			case KP:
				if(chart.getDuration() == Duration.NOW)
					KP_NOW = chart;
				else if(chart.getDuration() == Duration.H3)
					KP_H3 = chart;
				else if(chart.getDuration() == Duration.H6)
					KP_H6 = chart;
				break;
			case MP:
				if(chart.getDuration() == Duration.NOW)
					MP_NOW = chart;
				else if(chart.getDuration() == Duration.H3)
					MP_H3 = chart;
				break;
			}
		}
		
		
		if(KP_H3 == null) KP_H3 = KP_H6;
		
		output.put("XRAY_NOW", XRAY_NOW);
		output.put("XRAY_H3", XRAY_H3);
		
		output.put("PROTON_NOW", PROTON_NOW);
		output.put("PROTON_H3", PROTON_H3);
		
		output.put("KP_NOW", KP_NOW);
		output.put("KP_H3", KP_H3);
		
		output.put("MP_NOW", MP_NOW);
		output.put("MP_H3", MP_H3);		
		
		return output;
	}
	
	public List<? extends ChartData> searchChartDate(Code.CartType chartType, Date startDate, Date endDate) {
		
		ChartDataMapper mapper = sessionTemplate.getMapper(ChartDataMapper.class);
		List<? extends ChartData> list = null;
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("startDate", sdf.format(startDate.getTime()));
		params.put("endDate", sdf.format(endDate.getTime()));
		switch(chartType) {
		case PROTON_FLUX:
			list = mapper.SelectManyGoesProtonFlux(params);
			break;
		case XRAY_FLUX:
			//list = mapper.SelectManyGoesXray5M(params);
			list = mapper.SelectManyGoesXray1M(params);
			break;
		case KP_INDEX_SWPC:
			list = mapper.SelectManyKpIndexSwpc(params);
			break;

		case MAGNETOPAUSE_RADIUS:
			list = mapper.SelectManyMagnetopauseRadius(params);
			break;
			
		case DST_INDEX_KYOTO:
			list = mapper.SelectManyDstIndexKyoto(params);
			break;

		case ACE_MAG:
			list = mapper.SelectManyAceMag(params);
			break;
			
		case ACE_SOLARWIND_DENS:
			list = mapper.SelectManyAceSolarWindDensity(params);
			break;
			
		case ACE_SOLARWIND_SPD:
			list = mapper.SelectManyAceSolarWindSpeed(params);
			break;
			
		case ACE_SOLARWIND_TEMP:
			list = mapper.SelectManyAceSolarWindTemperature(params);
			break;	
			
		case ELECTRON_FLUX:
			list = mapper.SelectManyGoesElectronFlux(params);
			break;
			

		default:
			break;
		}
		return list;		
	}
	
}
