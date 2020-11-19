package com.gaia3d.web.util;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class TxUtil {
	
	
	@Resource(name = "txManager")
	private DataSourceTransactionManager txManager;

	private TransactionStatus status;
	
	public void setTxManager(DataSourceTransactionManager txManager){
		this.txManager = txManager;
	}
	
	public void startTransaction(){
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		synchronized (txManager) {
			this.status = this.txManager.getTransaction(def);
		}
	}

	public void commitTransaction(){
		synchronized (txManager) {
			this.txManager.commit(this.status);
		}
	}

        public void rollBackTransaction(){
		synchronized (txManager) {
			this.txManager.rollback(this.status);
		}
	} 
}
