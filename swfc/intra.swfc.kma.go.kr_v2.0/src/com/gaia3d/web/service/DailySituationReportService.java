/**
 * 
 */
package com.gaia3d.web.service;

import java.io.File;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Service;

import com.gaia3d.web.mapper.DailySituationReportMapper;
import com.gaia3d.web.util.ExportDailySituationReportPdf;
import com.gaia3d.web.util.ExportForecastPdf;
import com.itextpdf.text.BaseColor;

/**
 * @author Administrator
 *
 */
@Service
public class DailySituationReportService extends BaseService{
	
	
	
	@Autowired(required=false)
	@Qualifier(value="FigureLocationResource")
	private FileSystemResource FigureLocationResource;
	
	@Autowired(required=false)
	@Qualifier(value="ForecastReportLocationResource")
	private FileSystemResource ForecastReportLocationResource;
	
	final BaseColor data1Color = BaseColor.YELLOW;
	final BaseColor data2Color = BaseColor.RED;
	final BaseColor data3Color = new BaseColor(0, 176, 80);
	
	/**
	 * 이전날의 최대 값 요소 정보를 가져온다.
	 * @param params
	 * @return
	 */
	public List<Map<String, String>> getPrevMaxData(Object params){
		DailySituationReportMapper mapper = sessionTemplate.getMapper(DailySituationReportMapper.class); 
		return mapper.selectRSGPreDay(params);
	}
	
	public List<Map<String, String>> getWrnLastData(Object params){
		DailySituationReportMapper mapper = sessionTemplate.getMapper(DailySituationReportMapper.class); 
		return mapper.selectWrnLastData(params);
	}
	
	/**
	 * 하나의 일일 상황보고를 등록한다.
	 * @param params
	 */
	public void insertDailySituationReport(Object params){
		DailySituationReportMapper mapper = sessionTemplate.getMapper(DailySituationReportMapper.class); 
		mapper.insertDailySituationReport(params);
		
		/*
		Map<String, Object> param = (Map<String, Object>)params;
		Integer seq = (Integer)param.get("rpt_seq_n");
		
		if(seq != null){
			Map<String, Object> data = selectDailySituationReport(seq);
		}
		*/
		
	}
	
	public Map<String, Object> selectDailySituationReport(Object params){
		DailySituationReportMapper mapper = sessionTemplate.getMapper(DailySituationReportMapper.class); 
		return mapper.selectDailySituationReport(params);
	}
	
	/**
	 * 하나의 일일 상황보고를 삭제한다.
	 * @param params
	 */
	public int deleteDailySituationReport(Object params){
		DailySituationReportMapper mapper = sessionTemplate.getMapper(DailySituationReportMapper.class); 
		return mapper.deleteDailySituationReport(params);
	}
	/**
	 * 하나의 일일 상황보고를 수정한다.
	 * @param params
	 */
	public int updateDailySituationReport(Object params){
		DailySituationReportMapper mapper = sessionTemplate.getMapper(DailySituationReportMapper.class); 
		return mapper.updateDailySituationReport(params);
	}
	
	
	public void createPdf(Object params){
		DailySituationReportMapper mapper = sessionTemplate.getMapper(DailySituationReportMapper.class); 
		Map<String, Object> report = mapper.selectDailySituationReport(params);
		if(report != null){
			
			//String fontPath = String.format("%s,%s", servletContext.getRealPath("/WEB-INF/classes/BATANG.TTC"), 0);
			//ExportForecastPdf export = new ExportForecastPdf(ForecastReportLocationResource.getFile(), fontPath);
			//FileOutputStream os = new FileOutputStream(new File(ForecastReportLocationResource.getPath(), filename));
			
			//new ExportDailySituationReportPdf(basePath, font);
		}
		
	}
	
	public static void main(String[] args){
		
	
	}

}
