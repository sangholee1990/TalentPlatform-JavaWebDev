package kr.pe.anaconda.swfc.auto.dao;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class SwfcDaoImpl extends SqlMapClientDaoSupport implements SwfcDao{
	
	@Autowired
	public SwfcDaoImpl(SqlMapClientTemplate sqlMapClientTemplate) {
		this.setSqlMapClientTemplate(sqlMapClientTemplate);
	}
	
	public void insertXray(Map<String, String> params){
		getSqlMapClientTemplate().insert("swfcDao.insertXray", params);
	}
	
	public void insertProton(Map<String, String> params){
		getSqlMapClientTemplate().insert("swfcDao.insertProton", params);
	}

	@Override
	public void insertKp(Map<String, String> params) {
		getSqlMapClientTemplate().insert("swfcDao.insertKp", params);
	}

	@Override
	public void insertMp(Map<String, String> params) {
		getSqlMapClientTemplate().insert("swfcDao.insertMp", params);
	}
	
	@Override
	public void insertAceMag(Map<String, String> params) {
		getSqlMapClientTemplate().insert("swfcDao.insertAceMag", params);
	}
	@Override
	public void insertAceSwepam(Map<String, String> params) {
		getSqlMapClientTemplate().insert("swfcDao.insertAceSwepam", params);
	}
	@Override
	public void insertDist(Map<String, String> params) {
		getSqlMapClientTemplate().insert("swfcDao.insertDist", params);
	}
	@Override
	public void insertDistKHU(Map<String, String> params) {
		getSqlMapClientTemplate().insert("swfcDao.insertDistKHU", params);
	}
	@Override
	public void insertFlarePredication(Map<String, String> params) {
		getSqlMapClientTemplate().insert("swfcDao.insertFlarePredication", params);
	}
	
	

}
