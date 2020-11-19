package com.gaia3d.web.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.interceptor.DefaultTransactionAttribute;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.gaia3d.web.mapper.SPCFMapper;
import com.gaia3d.web.util.PageNavigation;
import com.sun.org.apache.bcel.internal.generic.INSTANCEOF;

@Service
public class SPCFService extends BaseService {

	/**
	 * 트랜젝션 처리를 위한 변수
	 */
	@Autowired(required=true)
	private PlatformTransactionManager txManager;
	
	/**
	 * 특정수요자용 컨텐츠 검색
	 * @param params
	 * @return
	 */
	public Map<String, Object> listSPCFContents(Map<String, Object> params) {
		SPCFMapper mapper = sessionTemplate.getMapper(SPCFMapper.class);
		Map<String, Object> paging = new HashMap<String, Object>();
		
		// 특정수요자용 컨텐츠 검색 카운트
		int count = mapper.countSPCFContents(params);
		// 현재 페이지(default: 1)
		int page = Integer.parseInt(String.valueOf(params.get("page")));
		// 페이지 사이즈(default: 10)
		int pageSize = Integer.parseInt(String.valueOf(params.get("pageSize")));
		
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		params.put("navigation", navigation);
		
		// 특정수요자용 컨텐츠를 검색한다.
		List<Map<String, String>> list = mapper.listSPCFContents(params);
		
		paging.put("list", list);
		paging.put("pageNavigation", navigation);
		
		return paging;
	}
	
	/**
	 * 특정수요자용 컨텐츠 조회
	 * @param params
	 * @return
	 */
	public Map<String, String> selectSPCFContents(Map<String, Object> params) {
		SPCFMapper mapper = sessionTemplate.getMapper(SPCFMapper.class);
		// 특정수요자용 컨텐츠를 조회한다.
		return mapper.selectSPCFContents(params);
	}
	
	/**
	 * 특정수요자용 컨텐츠 등록
	 * @param params
	 * @return
	 */
	public int insertSPCFContents(Map<String, Object> params) {
		
		// 처리결과를 확인하기 위한 변수
		int result = -1;
		
		DefaultTransactionDefinition def = new DefaultTransactionAttribute();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus = txManager.getTransaction(def);
		SPCFMapper mapper = sessionTemplate.getMapper(SPCFMapper.class);
		
		try {
			
			// 특정수요자용 컨텐츠를 등록한다.
			result = mapper.insertSPCFContents(params);
			
			txManager.commit(txStatus);
		} catch (Exception e) {
			// TODO: handle exception
			txManager.rollback(txStatus);
		}
		
		return result;
	}
	
	/**
	 * 특정수요자용 컨텐츠 수정
	 * @param params
	 * @return
	 */
	public int updateSPCFContents(Map<String, Object> params) {
		
		// 처리결과를 확인하기 위한 변수
		int result = -1;
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		SPCFMapper mapper = sessionTemplate.getMapper(SPCFMapper.class);
		
		try {
			result = mapper.updateSPCFContents(params); 
			
			txManager.commit(txStatus);
		} catch (Exception e) {
			// TODO: handle exception
			txManager.rollback(txStatus);
		}
		
		// 특정수요자용 컨텐츠를 수정한다.
		return result;
	}
	
	/**
	 * 특정수요자용 컨텐츠 삭제
	 * @param params
	 * @return
	 */
	public int deleteSPCFContents(Map<String, Object> params) {
		
		// 처리결과를 확인하기 위한 변수
		int result = -1;
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		SPCFMapper mapper = sessionTemplate.getMapper(SPCFMapper.class);
		
		try {
			result = mapper.deleteSPCFContents(params);
			
			txManager.commit(txStatus);
		} catch (Exception e) {
			// TODO: handle exception
			txManager.rollback(txStatus);
		}
		// 특정수요자용 컨텐츠를 삭제한다.
		return result;
	}
	
	/**
	 * 특정수요자 회원에게 등록된 특정수요자용 컨텐츠를 검색한다.
	 * 사용자관리 메뉴 특정수요자 상세보기 화면에 표출
	 * @param params
	 * @return
	 */
	public List<Map<String, String>> searchSPCFContents(Map<String, Object> params) {
		SPCFMapper mapper = sessionTemplate.getMapper(SPCFMapper.class);
		
		// 특정수요자 회원에게 등록된 특정수요자용 컨텐츠를 검색한다.
		return mapper.searchSPCFContents(params);
	}
	
	/**
	 * 특정수요자 회원에게 특정수요자용 컨텐츠를 등록한다.
	 * @param params
	 * @return
	 */
	public int insertSPCFContentsUserMapping(Map<String, Object> params) {
		
		// 특정수요자 회원에게 등록된 특정수요자용 컨텐츠를 삭제한다.
		deleteSPCFContentsUserMappingData(params);
		
		// 특정수요자 회원에게 특정수요자용 컨텐츠를 등록한다.
		// result: 처리결과를 확인하기 위한 변수
		int result = insertSPCFContentsUserMappingData(params);
		return result;
	}
	
	/**
	 * 특정수요자 회원에게 특정수요자용 컨텐츠를 등록한다.
	 * @param params
	 * @return
	 */
	public int insertSPCFContentsUserMappingData(Map<String, Object> params) {
		
		// 처리결과를 확인하기 위한 변수
		int result = 0;
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		SPCFMapper mapper = sessionTemplate.getMapper(SPCFMapper.class);
		
		try {
			// 특정수요자 회원에게 등록할 컨텐츠의 고유번호
			String[] spcf_seq_list = (String[]) params.get("spcf_seq_n");
			
			for(int i=0; i < spcf_seq_list.length; i++) {
				params.put("spcf_seq_n", spcf_seq_list[i]);
				
				int cnt = 0;
				
				cnt = mapper.selectSPCFContentsUserMappingDataCnt(params);
				
				if(cnt <= 0) {
					// 특정수요자 회원에게 특정수요자용 컨텐츠를 등록한다.
					result = mapper.insertSPCFContentsUserMappingData(params);
				}
			}
			
			txManager.commit(txStatus);
		} catch (Exception e) {
			// TODO: handle exception
			txManager.rollback(txStatus);
		}
		
		return result;
	}
	
	/**
	 * 특정수요자 회원에게 등록된 특정수요자용 컨텐츠를 삭제한다.
	 * @param params
	 */
	public void deleteSPCFContentsUserMappingData(Map<String, Object> params) {
		
		// 처리결과를 확인하기 위한 변수
		SPCFMapper mapper = sessionTemplate.getMapper(SPCFMapper.class);
		
		// 특정수요자 회원에게 등록된 특정수요자용 컨텐츠를 삭제한다.
		mapper.deleteSPCFContentsUserMappingData(params);
	}
}
