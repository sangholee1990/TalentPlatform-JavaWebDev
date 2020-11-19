package kr.pe.anaconda.swfc.auto.dao;

import java.util.Map;

public interface SwfcDao {
	
	public void insertXray(Map<String, String> params);
	public void insertProton(Map<String, String> params);
	public void insertKp(Map<String, String> params);
	public void insertMp(Map<String, String> params);
	public void insertAceMag(Map<String, String> params);
	public void insertAceSwepam(Map<String, String> params);
	public void insertDist(Map<String, String> params);
	public void insertDistKHU(Map<String, String> params);
	public void insertFlarePredication(Map<String, String> params);

}
