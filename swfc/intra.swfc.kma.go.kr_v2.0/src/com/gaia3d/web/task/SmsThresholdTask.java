package com.gaia3d.web.task;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.gaia3d.web.service.BaseService;
import com.gaia3d.web.service.SMSService;

/**
 * SMS 임계치 요소의 등급에 따른 실황 메세지 발송 스케줄러
 * @author Administrator
 *
 */
public class SmsThresholdTask extends BaseService{
	
	private static final Logger logger = LoggerFactory.getLogger(SmsThresholdTask.class);
	
	private static final int LIMITED_MIN = 180;
	
	@Autowired
	SMSService smsService;
	
	public void smsThresholdMonitoring(){
		logger.info("smsThreshold task run--------------------- start");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("use_yn", "Y");
		List<Map<String, String>> smsThresholdList = smsService.listSmsThreshold(params);
		
		if(smsThresholdList != null && smsThresholdList.size() > 0){
			for(Map<String, String> data : smsThresholdList){
				gradeCheck(data);
			}
		}
		
		/*
		if(smsThresholdList != null && smsThresholdList.size() > 0){
			for(Map<String, String> data : smsThresholdList){
				System.out.println("smsThresholdList run");
				try{
					String runFlag = org.springframework.util.StringUtils.trimWhitespace( data.get("send_yn") );
					if("Y".equals(runFlag)){ //SMS 발송중인 상태이면
						System.out.println("runFlag==>Y" );
						//SMS 발송 상태이면 3시간이 지난 시간 체크를 하여 전송 테그를 발송한다.
						int diffMin = Integer.parseInt(String.valueOf(data.get("send_date_min")));
						if(diffMin > LIMITED_MIN){
							data.put("send_yn", "N");
							smsService.updateSmsThresholdChangeSendTag(data);
							//TODO 3시간 경과 sms 발송
						}
					}else{//현재 SMS 발송 상태가 아니면....
						System.out.println("runFlag==>N" );
						//등급 정보를 가져온다.
						gradeCheck(data);
					}
				}catch(Exception e){
					System.out.println(e.getMessage());
				}
			}
		}*/
		
		logger.info("smsThreshold task run--------------------- end");
	}
	
	
	public void smsThresholdSendAfterMessageTask(){
		logger.info("smsThresholdSendAfterMessageTask task run--------------------- start");
				
		//3시간이 지난 임계치 정보가 있는경우 경과 SMS를 발송한다.
		try{
			smsService.sendingSmsThresholdAfterMessage();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		
		/*
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sms_threshold_seq_n", 103);
		params.put("grade_no", 3);
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		Map<String, Object> log = mapper.selectSmsThresholdLog(params);
		
		logger.info("SEND_YN ==>" + (String)log.get("SEND_YN"));
		logger.info("send_yn ==>" + (String)log.get("send_yn"));
		*/
		/*
		try{
			smsService.sendingSmsThresholdAfterMessage();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		*/
		
		//전송 플래그가 Y인 시간이 지난 로그를 모두 N으로 변경한다.
		//위에 로직에서 혹은 시스템 장애로 인해 Y 플래그가 변경되지 않은 경우를 위함..
		smsService.updateSmsSendFlagAllReset(null);
		
		logger.info("smsThresholdSendAfterMessageTask task run--------------------- end");
	}
	
	
	/**
	 * 등급 체크
	 * @param data
	 */
	private void gradeCheck(Map<String, String> data){
		
		
		logger.info("grade check ------------------ start");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("sms_threshold_seq_n", data.get("sms_threshold_seq_n"));
		param.put("grade_no", data.get("grade_no"));
		param.put("orderBy", "ASC");
		param.put("orderKey", "grade_no");
		
		//등급 정보를 가져온다.
		List<Map<String, String>> gradeList = smsService.listSmsThresholdGrade(param);
		
		//등급이 등록되어 있으면 실행
		if(gradeList != null && gradeList.size() > 0){
			
			try{
				//가장 마지막에 등록된 데이터를 조회한다.
				double currentThresholdData = smsService.selectSmsThresholdData(data);
				
				for(Map<String, String> grade :  gradeList){
					double preVal;
					double nextVal;
					String preFlag;
					String nextFlag;
					if(!StringUtils.isEmpty( grade.get("pre_val") )  && !StringUtils.isEmpty( grade.get("next_val") )){ //두개의 판별식이 존재하면
						
						preVal = Double.parseDouble(String.valueOf(grade.get("pre_val")));
						nextVal = Double.parseDouble(String.valueOf(grade.get("next_val")));
						preFlag = grade.get("pre_flag");
						nextFlag = grade.get("next_flag");
						
						boolean result1 = gradeComparison(preVal, currentThresholdData, preFlag);
						boolean result2 = gradeComparison(currentThresholdData, nextVal, nextFlag);
						
						if(result1 && result2){
							//SMS 발송하고 발송여부 상태 업데이트
							param.put("send_yn", "Y");
							param.put("send_dt", "Y");
							param.put("grade_no", grade.get("grade_no"));
							smsService.sendThresHoldSMS(param);
							//break;
						}
						
					}else if(!StringUtils.isEmpty( grade.get("pre_val") ) && StringUtils.isEmpty( grade.get("next_val") )){ //하나의 판별식만 존재하면
						
						//System.out.println("bbbbb");
						
						preVal = Double.parseDouble(String.valueOf(grade.get("pre_val")));
						preFlag = grade.get("pre_flag");
						
						boolean result1 = gradeComparison(preVal, currentThresholdData, preFlag);
						if(result1){
							//SMS 발송하고 발송여부 상태 업데이트
							param.put("send_yn", "Y");
							param.put("send_dt", "Y");
							param.put("grade_no", grade.get("grade_no"));
							smsService.sendThresHoldSMS(param);
							//break;
						}
					}
				}
			}catch(Exception e){
				//System.out.println(e.getMessage());
				logger.error("sms threshold grade check exception", e);
			}finally{
				//to do
			}
		}else{
			logger.info("empty grade info");
		}
		
		logger.info("grade check ------------------ end");
	}
	
	
	
	
	public static void main(String[] args){
		
		double a  = 1;
		double b = 1;
		
		System.out.println(gradeComparison(a, b, "eq"));
	}
	
	/**
	 * 두 값 입력받은 논리식으로 비교하 참, 거짓을 반환한다. 
	 * @param sourceVal 실제 데이터값
	 * @param compareVal 비교 값
	 * @param expression 논리식
	 * @return 참,거짓 여부
	 */
	public static boolean gradeComparison(double val1, double val2, String expression){
		boolean result = false;
		
		expression = expression.toLowerCase();
		
		if("lt".equals(expression)){
			result = (val1 < val2);
		}else if("le".equals(expression)){
			result = (val1 <= val2);
		}else if("gt".equals(expression)){
			result = (val1 > val2);
		}else if("ge".equals(expression)){
			result = (val1 >= val2);
		}else if("eq".equals(expression)){
			result = (val1 == val2);
		}else if("ne".equals(expression)){
			result = (val1 != val2);
		}else{
			result = false;
		}
		
		//logger.debug("%s %s %s = %s\n",val1, expression, val2, result);
		
		return result;
	}
}
