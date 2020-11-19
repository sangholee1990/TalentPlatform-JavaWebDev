package egovframework.rte.swfc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.joda.time.LocalDate;

import egovframework.rte.swfc.dto.ChartData;
import egovframework.rte.swfc.dto.ChartSummaryDTO;
import egovframework.rte.swfc.dto.SimpleStringValueChartData;

public interface ChartDataMapper {

	List<ChartData> SelectManyStaHet(Object parameter);
	List<ChartData> SelectManyStaImpact(Object parameter);
	List<ChartData> SelectManyStaMag(Object parameter);
	List<ChartData> SelectManyStaPlastic(Object parameter);
	
	List<ChartData> SelectManyStbHet(Object parameter);
	List<ChartData> SelectManyStbImpact(Object parameter);
	List<ChartData> SelectManyStbMag(Object parameter);
	List<ChartData> SelectManyStbPlastic(Object parameter);
	
	List<ChartData> SelectManyAceEpam(Object parameter);
	
	List<ChartData> SelectManyAceSis(Object parameter);
	List<ChartData> SelectManyAceSwepam(Object parameter);
	
	
	List<ChartData> SelectManyAceMag(Object parameter);
	
	List<ChartData> SelectManyAceSolarWindDensity(Object parameter);
	List<ChartData> SelectManyAceSolarWindSpeed(Object parameter);
	List<ChartData> SelectManyAceSolarWindTemperature(Object parameter);
	
	List<ChartData> SelectManyGoesXray1M(Object parameter);
	List<ChartData> SelectManyGoesXray5M(Object parameter);
	
	List<ChartData> SelectManyGoesProtonFlux(Object parameter);
	List<ChartData> SelectManyGoesElectronFlux(Object parameter);
	List<ChartData> SelectManyGoesParticleS(Object parameter);
	
	List<ChartData> SelectManyDstIndexKyoto(Object parameter);
	List<ChartData> SelectManyDstKhuIndex(Object parameter);
	
	List<ChartData> SelectManyKpIndexSwpc(Object parameter);
	List<ChartData> SelectManyKpIndexKhu(Object parameter);
	
	List<ChartData> SelectManyMagnetopauseRadius(Object parameter);
	
	List<ChartData> SelectManySolarMaximum(Object parameter);
	SimpleStringValueChartData SelectOneSolarMaximum(Object parameter);
	
	
	List<ChartData> SelectManyTEC(Object parameter);
	SimpleStringValueChartData SelectOneTEC(Object parameter);
	
	List<ChartSummaryDTO> SelectSummary();
	List<ChartSummaryDTO> SelectMaxSummaryForEachDay(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);
	List<ChartSummaryDTO> SelectRecentSummary();
}
