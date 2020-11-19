package egovframework.rte.swfc.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import egovframework.rte.swfc.mapper.SMSMapper;


@Service
public class SMSService extends BaseService{
	
	@Autowired(required=true)
	private PlatformTransactionManager txManager;
	
	/**
	 * SMS 발송 결과 Log 저장
	 * 
	 * */
	public void insertSendResult(Map<String, Object> params){
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		
		try{
			mapper.insertSendResult(params);
			txManager.commit(txStatus);
		}catch(Exception e){
			txManager.rollback(txStatus);
		}
		
	}//insertSendResult end
	
}//class end
