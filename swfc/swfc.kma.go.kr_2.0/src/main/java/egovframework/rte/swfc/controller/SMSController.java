package egovframework.rte.swfc.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.swfc.service.SMSService;

/**
 * SMS 로그 관리
 * 
 * */
@Controller
public class SMSController extends BaseController{

	@Autowired
	private SMSService smsService; 
	
	/**
	 * SMS 발송 결과 Log 저장
	 * @return
	 * */
	@RequestMapping(value="/{lang}/sms/send_result.do", method = RequestMethod.POST)
	public void insertSendResult(@PathVariable("lang") String lang, @RequestParam Map<String, Object> params, Model model){
		String etc1 = (String)params.get("etc1");
		int seq = etc1 == null || etc1.trim().equals("") ?  -1 : Integer.parseInt(etc1);
		params.put("seq", seq);
		smsService.insertSendResult(params);
	}//SMSLogInsertSendResult end
	
	
}//class end