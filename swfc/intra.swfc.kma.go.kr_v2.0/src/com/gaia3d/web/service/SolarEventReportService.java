package com.gaia3d.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.interceptor.DefaultTransactionAttribute;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import sun.util.logging.resources.logging;

import com.gaia3d.web.dto.SolarEventReportDTO;
import com.gaia3d.web.mapper.SolarEventReportMapper;
import com.itextpdf.text.log.Logger;

@Service
public class SolarEventReportService extends BaseService{

	@Autowired(required=true)
	private PlatformTransactionManager txManager;
	
	@Value("${solar.event.report.path}")
	private String eventPath;
	
	/**
	 * 등급표
	 * 
	 * */
	public List<Map<String, String>> selectGrade(Map<String, Object> params){
		SolarEventReportMapper mapper = sessionTemplate.getMapper(SolarEventReportMapper.class);
		return mapper.selectGrade(params);
	}
	
	/**
	 * 파일 라인 
	 * */
	public List<SolarEventReportDTO> selectLine(Map<String, Object> params){
		SolarEventReportMapper mapper = sessionTemplate.getMapper(SolarEventReportMapper.class);
		return mapper.selectLine(params);
	}
	
	/**
	 * 파일 별 등록된 타입 리스트
	 * 
	 * */
	public List<Map<String, String>> selectType(Map<String, Object> params){
		SolarEventReportMapper mapper = sessionTemplate.getMapper(SolarEventReportMapper.class);
		return mapper.selectType(params);
	}
	
	/**
	 * 파일 최대 라인
	 * @return
	 * */
	public int selectMaxLine(String fileDate){
		SolarEventReportMapper mapper = sessionTemplate.getMapper(SolarEventReportMapper.class);
		return mapper.selectMaxLine(fileDate);
	}
	
	/**
	 * 파일 DB 저장
	 * @return
	 * 
	 * */
	public void insert(SolarEventReportDTO event){
		SolarEventReportMapper mapper = sessionTemplate.getMapper(SolarEventReportMapper.class);
		DefaultTransactionDefinition def = new DefaultTransactionAttribute();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus = txManager.getTransaction(def);
		try{
			mapper.insert(event);	
			txManager.commit(txStatus);
		}catch(Exception e){	
			txManager.rollback(txStatus);
		}
	}//insert end
	
}//class end