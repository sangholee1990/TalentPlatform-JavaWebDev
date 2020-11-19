package com.gaia3d.web.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.gaia3d.web.mapper.ProgramMapper;
import com.gaia3d.web.mapper.SMSMapper;
import com.gaia3d.web.util.PageNavigation;

@Service
public class ProgramService extends BaseService {
	
	@Autowired(required=true)
	private PlatformTransactionManager txManager;
	
	public Map<String, Object> listCltData(Map<String, Object> params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		
		Map<String, Object> paging = new HashMap<String, Object>();
		
		int count = mapper.listCountCltData(params);
		int page = Integer.parseInt( String.valueOf( params.get("page") ));
		int pageSize = Integer.parseInt( String.valueOf( params.get("pageSize") ) );
				
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		params.put("navigation", navigation);
		
		List<Map<String, String>> list = mapper.listCltData(params);
		paging.put("list", list );
		paging.put("pageNavigation", navigation);
		return paging;
		
	}
	
	public Map<String, Object> listCltProg(Map<String, Object> params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		
		Map<String, Object> paging = new HashMap<String, Object>();
		
		int count = mapper.listCountCltProg(params);
		int page = Integer.parseInt( String.valueOf( params.get("page") ));
		int pageSize = Integer.parseInt( String.valueOf( params.get("pageSize") ) );
				
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		params.put("navigation", navigation);
		
		List<Map<String, String>> list = mapper.listCltProg(params);
		paging.put("list", list );
		paging.put("pageNavigation", navigation);
		return paging;
	}
	
	public Map<String, Object> listFrctProg(Map<String, Object> params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		
		Map<String, Object> paging = new HashMap<String, Object>();
		
		int count = mapper.listCountFrctProg(params);
		int page = Integer.parseInt( String.valueOf( params.get("page") ));
		int pageSize = Integer.parseInt( String.valueOf( params.get("pageSize") ) );
				
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		params.put("navigation", navigation);
		
		List<Map<String, String>> list = mapper.listFrctProg(params);
		paging.put("list", list );
		paging.put("pageNavigation", navigation);
		return paging;
	}
	
	public List<Map<String, String>> listFrctProgMappingInfo(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		return mapper.listFrctProgMappingInfo(params);
	}
	
	public List<Map<String, String>> listCltDataMappingInfo(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		return mapper.listCltDataMappingInfo(params);
	}
	
	public Map<String, String> selectCltData(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		return mapper.selectCltData(params);
	}
	
	public Map<String, String> selectCltProg(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		return mapper.selectCltProg(params);
	}
	
	public Map<String, String> selectFrctProg(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		return mapper.selectFrctProg(params);
	}
	
	public int deleteCltData(Object params){
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus txStatus= txManager.getTransaction(def);
		
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		int result = -1;
		try{
			mapper.deleteCltProgMapping(params);
			result = mapper.deleteCltData(params);
			txManager.commit(txStatus);
		} catch(Exception ex) {
			txManager.rollback(txStatus);
		}
		
		return result;
	}
	
	public int deleteCltProg(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		return mapper.deleteCltProg(params);
	}
	
	public int deleteFrctProg(Object params){
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus txStatus= txManager.getTransaction(def);
		
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		int result = -1;
		try{
			mapper.deleteFrctProgMapping(params);
			result = mapper.deleteFrctProg(params);
			txManager.commit(txStatus);
		} catch(Exception ex) {
			txManager.rollback(txStatus);
		}
		
		return result;
	}
	
	public int updateCltData(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		return mapper.updateCltData(params);
	}
	
	public int updateCltProg(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		return mapper.updateCltProg(params);
	}
	
	public int updateFrctProg(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		return mapper.updateFrctProg(params);
	}
	
	public void insertCltData(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		mapper.insertCltData(params);
	}
	
	public void insertCltProg(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		mapper.insertCltProg(params);
	}
	
	public void insertFrctProg(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		mapper.insertFrctProg(params);
	}
	
	public int deleteCltProgMapping(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		return mapper.deleteCltProgMapping(params);
	}
	
	public int deleteFrctProgMapping(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		return mapper.deleteFrctProgMapping(params);
	}
	
	public void insertCltProgMapping(Object params){
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		
		try{
			mapper.deleteCltProgMappingAll(params);
			mapper.insertCltProgMapping(params);
			txManager.commit(txStatus);
		} catch(Exception ex) {
			txManager.rollback(txStatus);
		}
	}
	
	public void insertFrctProgMapping(Object params){
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		if(mapper.hasFrctProgMapping(params) > 0){
			mapper.updateFrctProgMapping(params);
		}else{
			mapper.insertFrctProgMapping(params);
		}
	}
}
