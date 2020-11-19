package com.gaia3d.web.mapper;

import java.util.List;



import com.gaia3d.web.dto.ChartData;
import com.gaia3d.web.dto.SWPCAceMag;
import com.gaia3d.web.dto.SWPCGoesProtonFlux;
import com.gaia3d.web.dto.SWPCGoesXray1M;
import com.gaia3d.web.dto.SimpleDoubleValueChartData;
import com.gaia3d.web.dto.SimpleIntegerValueChartData;
import com.gaia3d.web.mapper.simple.BasicMapper;


public interface StatMapper {
	
	List<SWPCGoesXray1M> SelectXrayStat(Object parameter);
	List<SWPCGoesProtonFlux> SelectProtonStat(Object parameter);
	List<SimpleIntegerValueChartData> SelectKpStat(Object parameter);
	List<SimpleDoubleValueChartData> SelectMpStat(Object parameter);
	List<SWPCAceMag> SelectBtStat(Object parameter);
	List<SimpleDoubleValueChartData> SelectBulk_SpdStat(Object parameter);
	List<SimpleDoubleValueChartData> SelectPro_DensStat(Object parameter);
	List<SimpleDoubleValueChartData> SelectIon_TempStat(Object parameter); 
}
