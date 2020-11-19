package egovframework.rte.swfc.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import egovframework.rte.swfc.dto.SpecificUserContentDTO;
import egovframework.rte.swfc.mapper.SpecificUserContentMapper;

@Service
public class SpecificUserContentService extends BaseService {
	
	@Autowired(required=true)
	private PlatformTransactionManager txManager;
	
//	public int updateResize(Map<String, Object> params){
//		SpecificUserContentMapper mapper = sessionTemplate.getMapper(SpecificUserContentMapper.class);	
//		int count = mapper.updateResize(params);
//		return count;
//	}
	
	
	
	//수요자 순서
//	public int updateSort(Map<String, Object> params){
//		SpecificUserContentMapper mapper = sessionTemplate.getMapper(SpecificUserContentMapper.class);
//		int count = mapper.updateSort(params);
//		return count;
//	}
	
	//수요자 사용 여부
//	public int updateState(Map<String, Object> params){
//		SpecificUserContentMapper mapper = sessionTemplate.getMapper(SpecificUserContentMapper.class);
//		int count = mapper.updateState(params);
//		return count;
//	}
	
	
	public int updateContents(Map<String, Object> params){
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		
		SpecificUserContentMapper mapper = sessionTemplate.getMapper(SpecificUserContentMapper.class);
		int count = 0;
		try{
			count = mapper.updateContents(params);
			txManager.commit(txStatus);
		}catch(Exception e){
			txManager.rollback(txStatus);
		}
		
		return count;
	}
	
	//컨텐츠 추가
	public void insertNewContent(Map<String, Object> params){
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		SpecificUserContentMapper mapper = sessionTemplate.getMapper(SpecificUserContentMapper.class);	
		
		try{
			mapper.insertNewContent(params);
			txManager.commit(txStatus);
		}catch(Exception e){
			txManager.rollback(txStatus);
		}
	}
	
	//수요자 메뉴 가져오기
	public List<SpecificUserContentDTO> selectContent(Map<String, Object> params){
		SpecificUserContentMapper mapper = sessionTemplate.getMapper(SpecificUserContentMapper.class);
		return mapper.SelectContent(params);
	}
	
}
