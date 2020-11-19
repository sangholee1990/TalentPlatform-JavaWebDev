/**
 * 
 */
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

import com.gaia3d.web.mapper.GnssMapper;
import com.gaia3d.web.mapper.SMSMapper;
import com.gaia3d.web.util.PageNavigation;

/**
 * @author Administrator
 *
 */
@Service
public class GnssService extends BaseService {
	
	@Autowired(required=true)
	private PlatformTransactionManager txManager;
	
	/**
	 * gnss 리스트 목록을 가져온다.
	 * @param params
	 * @return
	 */
	public Map<String, Object> listGnssStationWithPaging(Map<String, Object> params){
		GnssMapper mapper = sessionTemplate.getMapper(GnssMapper.class);
		Map<String, Object> paging = new HashMap<String, Object>();
		
		int count = mapper.countGnssStation(params);
		int page = Integer.parseInt( String.valueOf( params.get("page") ));
		int pageSize = Integer.parseInt( String.valueOf( params.get("pageSize") ) );
		
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		params.put("navigation", navigation);
		
		List<Map<String, String>> list = mapper.listGnssStation(params);
		paging.put("list", list );
		paging.put("pageNavigation", navigation);
		return paging;
	}
	
	public List<Map<String,String>> listGnssStationMappingInfo(Map<String, Object> params){
		GnssMapper mapper = sessionTemplate.getMapper(GnssMapper.class);
		return mapper.listGnssStationMappingInfo(params);
	}
	
	/**
	 * 하나의 지점 정보를 가져온다.
	 * @param params
	 * @return
	 */
	public Map<String, String> selectGnssStation(Map<String, Object> params){
		GnssMapper mapper = sessionTemplate.getMapper(GnssMapper.class);
		return mapper.selectGnssStation(params);
	}
	/**
	 * 하나의 지점 정보를 가져온다.
	 * @param params
	 * @return
	 */
	public int insertGnssStation(Map<String, Object> params){
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		
		GnssMapper mapper = sessionTemplate.getMapper(GnssMapper.class);
		int lastId = mapper.selectMaxSeqNo();
		params.put("id", lastId);
		try{
			
			mapper.insertGnssStation(params);
			
			String[] codes = (String[])params.get("code");
				
			if(codes != null && codes.length > 0){
				for(int i = 0; i < codes.length; i++){
					
					params.put("code", codes[i]);
					mapper.insertGnssStationMappingInfo(params);
				}
			}
			txManager.commit(txStatus);
		} catch(Exception ex) {
			error(ex.getMessage());
			txManager.rollback(txStatus);
		}
		
		return lastId;
	}
	
	/**
	 * 지점 정보를 삭제한다.
	 * @param params
	 * @return
	 */
	public int deleteGnssStation(Map<String, Object> params){
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		int result = -1;
		GnssMapper mapper = sessionTemplate.getMapper(GnssMapper.class);
		try{
			mapper.deleteGnssStationMappingInfo(params);
			result = mapper.deleteGnssStation(params);
			txManager.commit(txStatus);
		} catch(Exception ex) {
			error(ex.getMessage());
			txManager.rollback(txStatus);
		}
		return result;
	}
	
	/**
	 * 지점 정보를 수정한다.
	 * @param params
	 * @return
	 */
	public int updateGnssStation(Map<String, Object> params){
		
		int result = -1;
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		
		GnssMapper mapper = sessionTemplate.getMapper(GnssMapper.class);
		try{
			
			result = mapper.updateGnssStation(params);
			
			mapper.deleteGnssStationMappingInfo(params);
			
			String[] codes = (String[])params.get("code");
			if(codes != null && codes.length > 0){
				for(int i = 0; i < codes.length; i++){
					params.put("code", codes[i]);
					mapper.insertGnssStationMappingInfo(params);
				}
			}
			txManager.commit(txStatus);
		} catch(Exception ex) {
			System.out.println(ex.getMessage());
			txManager.rollback(txStatus);
		}
		
		return result;
		
	}

}
