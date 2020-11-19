/**
 * 
 */
package com.gaia3d.web.mapper;

import java.util.List;
import java.util.Map;

import com.gaia3d.web.mapper.simple.BasicMapper;

/**
 * SMS 발송에 관련된 DAO 클래스
 * @author Administrator
 *
 */
public interface SMSMapper extends BasicMapper<Map<String, Object>>  {

	/**
	 * SMS 사용자 목록을 가져온다.
	 * @param parameter
	 * @return
	 */
	List<Map<String, String>> listSmsUser(Object parameter);
	List<Map<String, String>> listSmsLog(Object parameter);
	
	
	/**
	 * SMS 사용자에 해당하는 사용자 리스트를 매팡하여 가져온다.
	 * @param parameter
	 * @return
	 */
	List<Map<String, String>> listSmsUserMappingList(Object parameter);
	
	/**
	 * 발송상태인 SMS 발송 목록에서 3시간이 지난 SMS 임계 정보를 가져온다.
	 * @param parameter
	 * @return
	 */
	List<Map<String, Object>> selectSendingSmsThresholdLog();
	
	/**
	 * 하나의 사용자 정보을 가져온다.
	 * @param parameter
	 * @return
	 */
	Map<String, String> selectSmsUser(Object parameter);
	Map<String, String> selectUniqueSmsUser(Object parameter);
	
	/**
	 * SMS 사용자 전체 목록을 가져온다.
	 * @param parameter
	 * @return
	 */
	List<Map<String, String>> listSmsAllUser(Object parameter);
	
	/**
	 * 하나의 SMS 정보을 가져온다.
	 * @param parameter
	 * @return
	 */
	Map<String, String> selectSms(Object parameter);
	
	/**
	 * 사용자를 삭제한다.
	 * @param parameter
	 * @return
	 */
	int deleteSmsUser(Object parameter);
	
	/**
	 * 사용자를 수정한다.
	 * @param parameter
	 * @return
	 */
	int updateSmsUser(Object parameter);
	
	/**
	 * 시간이 지난 SMS 임계치 로그 발송 정보를 모두 리셋한다. 
	 * @param parameter
	 * @return
	 */
	int updateSmsSendFlagAllReset(Object parameter);
	
	/**
	 * 사용자를 등록한다.
	 * @param parameter
	 * @return
	 */
	int insertSmsUser(Object parameter);
	
	
	/**
	 * 카웅트 정보를 가져온다.
	 * @param parameter
	 * @return
	 */
	int countSmsUser(Object parameter);
	
	/**
	 * 하나의 SMS를 등록한다.
	 * @param parameter
	 * @return
	 */
	int insertSms(Object parameter);
	
	/**
	 * SMS에 해당하는 USER 매핑 정보를 등록한다.
	 * @param parameter
	 * @return
	 */
	int insertSmsUserMapping(Object parameter);
	
	/**
	 * SMS 목록을 가져온다.
	 * @param parameter
	 * @return
	 */
	List<Map<String, String>> listSms(Object parameter);
	
	/**
	 * SMS 테이블의 카웅트 정보를 가져온다.
	 * @param parameter
	 * @return
	 */
	int countSms(Object parameter);
	int countSmsLog(Object parameter);
	
	/**
	 * SMS 정보를 삭제한다.
	 * @param parameter
	 * @return
	 */
	int deleteSms(Object parameter);
	
	/**
	 * SMS와 사용자와의 매핑 정보를 삭제한다.
	 * @param parameter
	 * @return
	 */
	int deleteSmsUserMapping(Object parameter);
	
	/**
	 * SMS 정보를 수정한다.
	 * @param parameter
	 * @return
	 */
	int updateSms(Object parameter);
	
	/**
	 * SMS 임계치 정보 값을 수정한다.
	 * @param parameter
	 * @return
	 */
	int updateSmsThresholdLog(Object parameter);
	
	/**
	 * sms 임계값 정보를 등록한다.
	 * @param parameter
	 * @return
	 */
	int insertSmsThreshold(Object parameter);
	
	/**
	 * SMS 임계값 정보를 수정한다.
	 * @param parameter
	 * @return
	 */
	int updateSmsThreshold(Object parameter);
	
	int deleteSmsThresholdGrade(Object parameter);
	
	/**
	 * SMS임계갓 정보를 삭제한다.
	 * @param parameter
	 * @return
	 */
	int deleteSmsThreshold(Object parameter);
	
	/**
	 * 하나의 SMS 임계값 정보를 가져온다.
	 * @param parameter
	 * @return
	 */
	Map<String, Object> selectSmsThreshold(Object parameter);
	
	/**
	 * 다수의 SMS 임계값 정보를 가져온다.
	 * @param parameter
	 * @return
	 */
	List<Map<String, String>> listSmsThreshold(Object parameter);
	
	/**
	 * sms 임계치 수신자 정보를 삭제한다.
	 * @param parameter
	 * @return
	 */
	int deleteSmsThresholdUserMapping(Object parameter);
	
	/**
	 * SMS임계치와 사용자와의 매핑 정보를 삭제한다.
	 * @param parameter
	 * @return
	 */
	int insertSmsThresholdUserMapping(Object parameter);
	
	/**
	 * 하나의 sms 임계값의 등급 정보 목록을 가져온다.
	 * @param parameter
	 * @return
	 */
	List<Map<String, String>> listSmsThresholdGrade(Object parameter);
	
	
	/**
	 * sms 임계값 등급 정보를 수정한다.
	 * @param parameter
	 * @return
	 */
	int updateSmsThresholdGrade(Object parameter);
	
	/**
	 * sms 발송 관련 태그 정보를 업데이트 한다.
	 * @param parameter
	 * @return
	 */
	int updateSmsThresholdSendSatusChange(Object parameter);
	
	/**
	 * 데이터 값을 가져온다.
	 * @param parameter
	 * @return
	 */
	double selectSmsThresholdData(Object parameter);
	
	/**
	 * 임계치 SMS 발송 로그 값이을 조회한다.
	 * @param parameter
	 * @return
	 */
	Map<String, Object> selectSmsThresholdLog(Object parameter);
}
