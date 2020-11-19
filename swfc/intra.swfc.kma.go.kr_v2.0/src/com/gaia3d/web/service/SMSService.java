package com.gaia3d.web.service;

import java.io.IOException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.jsoup.helper.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.gaia3d.web.mapper.SMSMapper;
import com.gaia3d.web.util.PageNavigation;
import com.gaia3d.web.util.SSHUtils;
import com.gaia3d.web.util.StringUtils;
import com.google.common.base.Joiner;

@Service
public class SMSService extends BaseService {
	
	@Autowired(required=true)
	private PlatformTransactionManager txManager;
	
	@Value("${sms.send.min}")
	private double smsSendMin = 180;
	
	@Value("${sms.send.shell.location}")
	private String smsShellLocation;
	
	@Value("${sms.server.ip}")
	private String smsServerIp;
	
	@Value("${sms.server.id}")
	private String smsServerUser;
	
	@Value("${sms.server.pw}")
	private String smsServerPw;
	
	@Value("${sms.server.shell}")
	private String smsServerShell;
	
	/*
	@Autowired
	@Qualifier("${sms.send.min}")
	public void setSmsSendMin(int smsSendMin) {
		this.smsSendMin = smsSendMin;
	} 
  */
	/**
	 * SMS 사용자를 등록한다.
	 * @param params
	 * @return
	 */
	public int insertSmsUser(Map<String, Object> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		return mapper.insertSmsUser(params);
	}
	
	/**
	 * SMS 사용자를 등록한다.
	 * @param params
	 * @return
	 */
	public int insertSmsUser(List<Map<String, String>> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		
		if(params == null || params.size() == 0) return 1;
		for(Map<String, String> user : params){
			mapper.insertSmsUser(user);
		}
		
		return 1;
	}
	
	/**
	 * 사용자 정보를 삭제한다.
	 * @param params
	 * @return
	 */
	public int deleteSmsUser(Map<String, Object> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		return mapper.deleteSmsUser(params);
	}
	/**
	 * 사용자 정보를 수정한다.
	 * @param params
	 * @return
	 */
	public int updateSmsUser(Map<String, Object> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		return mapper.updateSmsUser(params);
	}
	
	/**
	 * 하나의 SMS 사용자 정보를 가져온다.
	 * @param params
	 * @return
	 */
	public Map<String, String> selectSmsUser(Map<String, Object> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		return mapper.selectSmsUser(params);
	}
	
	public Map<String, String> selectUniqueSmsUser(Map<String, String> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		return mapper.selectUniqueSmsUser(params);
	}
	
	/**
	 * 하나의 SMS 사용자 정보를 가져온다.
	 * @param params
	 * @return
	 */
	public Map<String, String> selectSms(Map<String, Object> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		return mapper.selectSms(params);
	}
	
	/**
	 * 사용자 리스트 목록을 가져온다.
	 * @param params
	 * @return
	 */
	public List<Map<String, String>> listSmsUser(Map<String, Object> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		return mapper.listSmsUser(params);
	}
	
	/**
	 * 사용자 리스트 목록을 가져온다.
	 * @param params
	 * @return
	 */
	public List<Map<String, String>> listSmsAllUser(Map<String, Object> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		return mapper.listSmsAllUser(params);
	}
	
	/**
	 * 사용자 리스트 목록을 가져온다.
	 * @param params
	 * @return
	 */
	public Map<String, Object> listSmsUserWithPaging(Map<String, Object> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		Map<String, Object> paging = new HashMap<String, Object>();
		
		int count = mapper.countSmsUser(params);
		int page = Integer.parseInt( String.valueOf( params.get("page") ));
		int pageSize = Integer.parseInt( String.valueOf( params.get("pageSize") ) );
				
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		params.put("navigation", navigation);
		
		List<Map<String, String>> list = mapper.listSmsUser(params);
		paging.put("list", list );
		paging.put("pageNavigation", navigation);
		return paging;
	}
	
	/**
	 * 사용자 리스트 목록을 가져온다.
	 * @param params
	 * @return
	 */
	public Map<String, Object> listSmsLogWithPaging(Map<String, Object> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		Map<String, Object> paging = new HashMap<String, Object>();
		
		int count = mapper.countSmsLog(params);
		int page = Integer.parseInt( String.valueOf( params.get("page") ));
		int pageSize = Integer.parseInt( String.valueOf( params.get("pageSize") ) );
		
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		params.put("navigation", navigation);
		
		List<Map<String, String>> list = mapper.listSmsLog(params);
		paging.put("list", list );
		paging.put("pageNavigation", navigation);
		return paging;
	}
	
	/**
	 * SMS 리스트 목록을 가져온다.
	 * @param params
	 * @return
	 */
	public Map<String, Object> listSmsWithPaging(Map<String, Object> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		Map<String, Object> paging = new HashMap<String, Object>();
		
		int count = mapper.countSms(params);
		int page = Integer.parseInt( String.valueOf( params.get("page") ));
		int pageSize = Integer.parseInt( String.valueOf( params.get("pageSize") ) );
		
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		params.put("navigation", navigation);
		
		List<Map<String, String>> list = mapper.listSms(params);
		paging.put("list", list );
		paging.put("pageNavigation", navigation);
		return paging;
	}
	
	/**
	 * 사용자 리스트 목록을 가져온다.
	 * @param params
	 * @return
	 */
	public Map<String, Object> listSmsUserMappingList(Map<String, Object> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		Map<String, Object> paging = new HashMap<String, Object>();
		List<Map<String, String>> list = mapper.listSmsUserMappingList(params);
		paging.put("list", list );
		return paging;
	}
	
	/**
	 * 하나의 SMS를 등록한다.
	 * @param params
	 * @return
	 */
	public int insertSms(Map<String, Object> params){
		int result = -1;
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		
		result = mapper.insertSms(params);
		try{
			
			String[] user_seq_n = (String[])params.get("user_seq_n");
			if(user_seq_n != null && user_seq_n.length > 0){
				for(String seq : user_seq_n){
					params.put("user_seq_n", seq);
					mapper.insertSmsUserMapping(params);
				}
			}
			txManager.commit(txStatus);
		} catch(Exception ex) {
			txManager.rollback(txStatus);
		}
		
		return result;
	}
	
	/**
	 * 사용자 정보를 삭제한다.
	 * @param params
	 * @return
	 */
	public int deleteSms(Map<String, Object> params){
		int result = -1;
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		try{
			result = mapper.deleteSms(params);
			mapper.deleteSmsUserMapping(params);
			txManager.commit(txStatus);
		} catch(Exception ex) {
			txManager.rollback(txStatus);
		}
		return result;
	}
	
	/**
	 * SMS 정보를 수정한다.
	 * @param params
	 * @return
	 */
	public int updateSms(Map<String, Object> params) {
		
		int result = -1;
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		
		try{
			result = mapper.updateSms(params);
			mapper.deleteSmsUserMapping(params);
			
			String[] user_seq_n = (String[])params.get("user_seq_n");
			if(user_seq_n != null && user_seq_n.length > 0){
				for(String seq : user_seq_n){
					params.put("user_seq_n", seq);
					mapper.insertSmsUserMapping(params);
				}
			}
		
			txManager.commit(txStatus);
		} catch(Exception ex) {
			txManager.rollback(txStatus);
		}
		
		return result;
	}
	
	
	/**
	 * SMS 임계치 목록 정보를 가져온다.
	 * @param params
	 * @return
	 */
	public List<Map<String, String>> listSmsThreshold(Map<String, Object> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		return mapper.listSmsThreshold(params);
	}
	
	/**
	 * 하나의 SMS를 등록한다.
	 * @param params
	 * @return
	 */
	public int insertSmsThreshold(Map<String, Object> params){
		int result = -1;
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		
		result = mapper.insertSmsThreshold(params);
		try{
			
			String[] user_seq_n = (String[])params.get("user_seq_n");
			if(user_seq_n != null && user_seq_n.length > 0){
				for(String seq : user_seq_n){
					params.put("user_seq_n", seq);
					mapper.insertSmsThresholdUserMapping(params);
				}
			}
			txManager.commit(txStatus);
		} catch(Exception ex) {
			txManager.rollback(txStatus);
		}
		
		return result;
	}
	
	/**
	 * SMS 정보를 수정한다.
	 * @param params
	 * @return
	 */
	public int updateSmsThreshold(Map<String, Object> params) {
		
		int result = -1;
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		
		try{
			result = mapper.updateSmsThreshold(params);
			
			//리스트 페이지 목록에서 특정 컬럼만 수정하게 될경우 사용자 매핑 테이블은 수정이 되면 안되므로
			boolean isUserUpdate = true;
			String userUpdate = StringUtil.isBlank((String)params.get("userUpdate")) ? "" : (String)params.get("userUpdate");
			isUserUpdate = !"N".equals(userUpdate);
			if(isUserUpdate) {
			
				mapper.deleteSmsThresholdUserMapping(params);
				String[] user_seq_n = (String[])params.get("user_seq_n");
				if(user_seq_n != null && user_seq_n.length > 0){
					for(String seq : user_seq_n){
						params.put("user_seq_n", seq);
						mapper.insertSmsThresholdUserMapping(params);
					}
				}
			}
		
			txManager.commit(txStatus);
		} catch(Exception ex) {
			txManager.rollback(txStatus);
		}
		
		return result;
	}
	
	public int deleteSmsThreshol(Map<String, Object> params) {
		
		
		int result = -1;
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		
		try{
			mapper.deleteSmsThresholdUserMapping(params);
			mapper.deleteSmsThresholdGrade(params);
			result = mapper.deleteSmsThreshold(params);
		
			txManager.commit(txStatus);
		} catch(Exception ex) {
			txManager.rollback(txStatus);
		}
		
		return result;
	}
	
	/**
	 * 하나의 SMS 임계값 정보를 가져온다.
	 * @param params
	 * @return
	 */
	public Map<String, Object> selectSmsThreshold(Map<String, Object> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		return mapper.selectSmsThreshold(params);
	}
	
	/**
	 * SMS 임계값의 등급 정보를 수정 및 등록한다.
	 * @param params
	 * @return
	 */
	public int updateSmsThresholdGrade(Map<String, Object> params){
		
		int result = -1;
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus txStatus= txManager.getTransaction(def);
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		
		try{
			String[] grade_no = (String[])params.get("grade_no");
			String[] pre_val = (String[])params.get("pre_val");
			String[] pre_flag = (String[])params.get("pre_flag");
			String[] next_val = (String[])params.get("next_val");
			String[] next_flag = (String[])params.get("next_flag");
			if(grade_no != null && grade_no.length > 0){
				Map<String, String> param = new HashMap<String, String>();
				for(int i = 0; i < grade_no.length; i++){
					param.put("sms_threshold_seq_n", String.valueOf( params.get("sms_threshold_seq_n") ));
					param.put("grade_no", grade_no[i]);
					param.put("pre_val", pre_val[i]);
					param.put("pre_flag", pre_flag[i]);
					param.put("next_val", next_val[i]);
					param.put("next_flag", next_flag[i]);
					mapper.updateSmsThresholdGrade(param);
				}
			}
			txManager.commit(txStatus);
		} catch(Exception ex) {
			txManager.rollback(txStatus);
		}
		return result;
	}
	
	
	/**
	 * SMS 임계치 목록 정보를 가져온다.
	 * @param params
	 * @return
	 */
	public List<Map<String, String>> listSmsThresholdGrade(Map<String, Object> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		return mapper.listSmsThresholdGrade(params);
	}
	
	
	/**
	 * sms 발송 여부 태그 정보를 업데이트 한다.
	 * @return
	 */
	public int updateSmsThresholdChangeSendTag(Object params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		return mapper.updateSmsThresholdSendSatusChange(params);
	}
	
	/**
	 * sms 발송 여부 태그 정보를 업데이트 한다.
	 * @return
	 */
	public int updateSmsThresholdLog(Object params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		return mapper.updateSmsThresholdLog(params);
	}
	
	
	/**
	 * 시간이 지난 SMS 발송 플래그가 Y인 값들을 모두 N으로 리셋한다.
	 * @return
	 */
	public int updateSmsSendFlagAllReset(Object params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		return mapper.updateSmsSendFlagAllReset(params);
	}
	
	/**
	 * SMS 임계치 값에 해당하는 실제 데이터 정보를 가져온다.
	 * @param params
	 * @return
	 */
	public double selectSmsThresholdData(Map<String, String> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		return mapper.selectSmsThresholdData(params);
	}
	
	
	/**
	 * SMS 인계치 정보를 발송한다.
	 * @param params
	 */
	public void sendThresHoldSMS(Map<String, Object> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		Map<String, Object> log = mapper.selectSmsThresholdLog(params);
		if(log == null){
			params.put("send_yn", "Y");	
			mapper.updateSmsThresholdLog(params); //신규 로그 등록
			
			sendSms(params, 1);
		}else{
			int min = (Integer)log.get("diff_min");
			String sendFlag = (String)log.get("SEND_YN");
			
			if(sendFlag == null ) sendFlag = "N";
			 
			if("N".equals(sendFlag)){ //SMS가 미발송 상태이면....
				//미발송 상태이면 
				//보낸 상태를 Y 발송일을 현재로 셋팅한 후 sms을 발송한다.
				try{
				params.put("send_yn", "Y");
				params.put("send_dt", "Y");
				updateSmsThresholdLog(params);
				}catch(Exception e){
					info("sms send status update error ==> " + e.getMessage());
				}finally{
					sendSms(params, 1);
				}
			}
		}
	}
	
	
	/**
	 * 3시간이 지난 SMS 임계치 로그 목록 정보를 가져온다.
	 * @param params
	 * @return
	 */
	public void sendingSmsThresholdAfterMessage(){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		List<Map<String, Object>> logList = mapper.selectSendingSmsThresholdLog();
		if(logList != null && logList.size() > 0){
			for(Map<String, Object> params : logList){
				
				//기존 키값이 소문자로 되어 있어 소문자로 파라메터를 재셋팅해서 로직을 태운다.ㅜㅜ
				Iterator<String> iter = null;
				String key;
				if(iter != null){
					iter = params.keySet().iterator();
					while(iter.hasNext()){
						key = iter.next();
						params.put(key.toLowerCase(), params.get(key));
					}
				}
				
				//상태값 변경
				try{
					params.put("send_yn", "N");	
					updateSmsThresholdLog(params);
				}catch(Exception e){}
				
				//SMS 발송
				sendSms(params, 2);
				//로그정보 업데이트
				
			}
		}
	}
	
	/**
	 * 임계치 SMS를 발송한다. 
	 * @param params
	 * @param flag 1: 발송 알람 2: 발송 경과 알람
	 */
	public void sendSms(Map<String, Object> param, int flag){
		
		info("sms 발송..." + param.get("sms_threshold_seq_n"));
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sms_threshold_seq_n", param.get("sms_threshold_seq_n"));
		params.put("sms_seq_n", param.get("sms_threshold_seq_n"));
		
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		Map<String, Object> thresholdSms = mapper.selectSmsThreshold(params);
		List<Map<String, String>> userList = mapper.listSmsUserMappingList(params);
		
		if(thresholdSms == null) return;
		
		if(userList == null || userList.size() == 0) return;
			
		List<String> tmpUserList  = new ArrayList<String>();	
		for(Map<String, String> user : userList){
			if(user.get("sms_seq_n") != null){
				tmpUserList.add(user.get("user_hdp"));
			}
		}
		
		String users = Joiner.on(",").join(tmpUserList);
		String message = (String)thresholdSms.get("msg1");
		String title = (String)thresholdSms.get("threshold_nm");
		int smsSeq = (Integer)thresholdSms.get("sms_threshold_seq_n");
		if(flag == 2){
			message = (String)thresholdSms.get("msg2");
			
			if(message == null || "".equals(message.trim())){
				info("sms after msg empty");
				return;
			}
		}
		
		
		//SMS 발송
		String subject = new String( Base64.encodeBase64(title.getBytes() ));
		String contents = new String( Base64.encodeBase64(message.getBytes() ));
		String toNumber = new String( Base64.encodeBase64(users.getBytes() ));
		String smsParams = "subject:{0} contents:{1} toNumber:{2} etc1:{3}";
		
		smsParams = MessageFormat.format(smsParams, subject, contents, toNumber, smsSeq);
		
		String shell = smsServerShell + " " +smsParams;
		try{
			SSHUtils ssh = new SSHUtils();
			ssh.setHost(smsServerIp);
			ssh.setUserId(smsServerUser);
			ssh.setUserPassword(smsServerPw);
			ssh.setCommand(shell);
			//ssh.setSaveFileName("d:\\test1111.txt");
			//shell.setDaemon(true);
			ssh.start();
		}catch(Exception e){
			info(e.getMessage());
		}
		
		/*
		info(users + "=" + users);
		info(subject + "=" + subject);
		info(message + "=" + message);
		info(smsSeq + "=" + smsSeq);
		
		//user = "toNumber:" + 
		 */
		
		
		/*
		List<String> commandList = new ArrayList<String>();
		commandList.add(smsShellLocation);
		commandList.add(MessageFormat.format("\"subject:{0}\"", new String( Base64.encodeBase64(subject.getBytes()))));
		commandList.add(MessageFormat.format("\"contents:{0}\"", new String( Base64.encodeBase64(message.getBytes()))));
		commandList.add(MessageFormat.format("\"toNumber:{0}\"", new String( Base64.encodeBase64(users.getBytes()))));
		commandList.add(MessageFormat.format("etc1:{0}", smsSeq));
		
		
		for(String line : commandList){
			System.out.println(line);
		}
		callSmsShell(commandList);
		*/
	}
	
	
	public void callSmsShell(List<String> commandList){
		Process process = null; 
		//String logShellPath = smsShellLocation;
		
		try {
			ProcessBuilder pb = new ProcessBuilder();
			pb.redirectErrorStream(true);
			process = pb.command(commandList).start();
			/*
			process.getInputStream();
			
			is = process.getInputStream();
			isr = new InputStreamReader(is);
			br = new BufferedReader(isr);
			
			
			StringBuffer response = new StringBuffer();
			//process = Runtime.getRuntime().exec(command);
			//ProcessBuilder b = new ProcessBuilder();
			//b.redirectErrorStream(false);
			//Process process = b.command(command).start();
			
			br = new BufferedReader(new InputStreamReader(process.getInputStream()));
			String line = null;
			while((line = br.readLine() ) != null){
				response.append(line);
			}
			
			System.out.println(response.toString());
			*/
			process.waitFor();
		} catch (IOException e) {
			System.out.println(e.getMessage());
		} catch (InterruptedException e) {
		}finally{
			if(process != null) process.destroy();
		}
	}
	
	
	/**
	 * 수동 SMS 발송을 요청한다.
	 * @param params
	 */
	public void requestSendSMS(Map<String, String> params){
		SMSMapper mapper = sessionTemplate.getMapper(SMSMapper.class);
		List<Map<String, String>> userList = mapper.listSmsUserMappingList(params);
		Map<String, String> sms = mapper.selectSms(params);
		
		if(userList == null || userList.size() == 0) return;
		if(sms == null) return;
		
		
		List<String> tmpUserList  = new ArrayList<String>();	
		for(Map<String, String> user : userList){
			if(user.get("sms_seq_n") != null){
				tmpUserList.add(user.get("user_hdp"));
			}
		}
		
		String users = Joiner.on(",").join(tmpUserList);
		String message = (String)sms.get("message");
		String title = (String)sms.get("subject");
		int smsSeq = Integer.parseInt(params.get("sms_seq_n"));
		
		/*
		List<String> commandList = new ArrayList<String>();
		commandList.add(smsShellLocation);
		commandList.add(MessageFormat.format("\"subject:{0}\"", new String( Base64.encodeBase64(subject.getBytes()))));
		commandList.add(MessageFormat.format("\"contents:{0}\"", new String( Base64.encodeBase64(message.getBytes()))));
		commandList.add(MessageFormat.format("\"toNumber:{0}\"", new String( Base64.encodeBase64(users.getBytes()))));
		commandList.add(MessageFormat.format("etc1:{0}", smsSeq));
		
		
		for(String line : commandList){
			System.out.println(line);
		}
		
		//callSmsShell(commandList);
		*/
		
		String subject = new String( Base64.encodeBase64(title.getBytes() ));
		String contents = new String( Base64.encodeBase64(message.getBytes() ));
		String toNumber = new String( Base64.encodeBase64(users.getBytes() ));
		String smsParams = "subject:{0} contents:{1} toNumber:{2} etc1:{3}";
		
		smsParams = MessageFormat.format(smsParams, subject, contents, toNumber, smsSeq);
		
		String shell = smsServerShell + " " +smsParams;
		try{
			SSHUtils ssh = new SSHUtils();
			ssh.setHost(smsServerIp);
			ssh.setUserId(smsServerUser);
			ssh.setUserPassword(smsServerPw);
			ssh.setCommand(shell);
			//ssh.setSaveFileName("d:\\test1111.txt");
			//shell.setDaemon(true);
			ssh.start();
		}catch(Exception e){
			info(e.getMessage());
		}
	}
	
	public static void main(String[] args){
		String[] arr = {"1", "2", "3"};
		System.out.println(Arrays.toString(arr));
		
		System.out.println(Joiner.on(",").join(arr));
		
	}
	
}
