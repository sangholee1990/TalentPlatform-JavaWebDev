package egovframework.rte.swfc.mapper;

import java.util.Map;

import egovframework.rte.swfc.mapper.simple.BasicMapper;

public interface SMSMapper extends BasicMapper{
	
	//SMS 발송결과 저장
	public void insertSendResult(Map<String, Object> params);
	
}//class end
