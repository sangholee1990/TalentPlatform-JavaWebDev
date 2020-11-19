package com.gaia3d.web.service;


import java.io.InputStream;
import java.util.Iterator;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.support.SpringFactoriesLoader;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.gaia3d.web.dto.DictionaryDTO;
import com.gaia3d.web.mapper.DictionaryMapper;
import com.gaia3d.web.mapper.SMSMapper;

@Service
public class DictionaryService extends BaseService {
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@Autowired(required=true)
	private PlatformTransactionManager txManager;
		
	public List<DictionaryDTO> SelectDictionaryList(Object params) {
		DictionaryMapper mapper = sessionTemplate.getMapper(DictionaryMapper.class);
		return mapper.SelectMany(params);
	}
	
	public List<DictionaryDTO> SelectDictionaryExcelList(Object params) {
		DictionaryMapper mapper = sessionTemplate.getMapper(DictionaryMapper.class);
		return mapper.selectDictionaryExcelList(params);
	}
	
	public DictionaryDTO SelectDictionary(Object params) {
		DictionaryMapper mapper = sessionTemplate.getMapper(DictionaryMapper.class);
		return mapper.SelectOne(params);
	}
	
	public int SelectCount(Object params) {
		DictionaryMapper mapper = sessionTemplate.getMapper(DictionaryMapper.class);
		return mapper.Count(params);
	}
	
	public int SelectUniqueExcelDataCount(Object params) {
		DictionaryMapper mapper = sessionTemplate.getMapper(DictionaryMapper.class);
		return mapper.SelectUniqueExcelDataCount(params);
	}
	
	public void InsertDictionary(Object params) {
		DictionaryMapper mapper = sessionTemplate.getMapper(DictionaryMapper.class);
		mapper.insertDictionary(params);
	}
	
	public void InsertDictionaryExcel(List<DictionaryDTO> list) throws Exception {
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		DictionaryMapper mapper = sessionTemplate.getMapper(DictionaryMapper.class);
		
		Iterator<DictionaryDTO> it = list.iterator();
		
		try{
			while(it.hasNext()) {
				mapper.insertDictionary(it.next());
			}
			txManager.commit(txStatus);
		}catch(Exception e){
			txManager.rollback(txStatus);
			throw e;
		}finally{
		}
	}
	
	public void UpdateDictionary(Object params) {
		DictionaryMapper mapper = sessionTemplate.getMapper(DictionaryMapper.class);
		mapper.updateDictionary(params);
	}
	
	public void DeleteDictionary(Object params) {
		DictionaryMapper mapper = sessionTemplate.getMapper(DictionaryMapper.class);
		mapper.deleteDictionary(params);
	}
}
