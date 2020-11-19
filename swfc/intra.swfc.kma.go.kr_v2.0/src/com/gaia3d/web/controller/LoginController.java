package com.gaia3d.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/login")
public class LoginController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@RequestMapping(value="login_form.do")
	public void login(Model model) {
		
	}
	
	@RequestMapping(value="login_submit.do", method=RequestMethod.GET)
	public void login_submit(Model model) {
		
	}
	@RequestMapping(value="login_error.do", method=RequestMethod.GET)
	public void login_error(Model model, HttpServletRequest request) {
		
	}
	
	public String encryptPassword(String password) throws Exception {
		/*
		String data = "-swfc-" + password + "-swfc-";

		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(data.getBytes("UTF-8"));
		byte[] encrypted = md.digest();
		
		int loop = 0;
		
		for(char c : Base64.encodeBase64String(encrypted).trim().toCharArray()) {
			loop += Integer.valueOf(c);
		}
		loop %= 1000;
		
		for (int i = 0; i < loop; ++i) {
			encrypted = md.digest(encrypted);
		}
		return Base64.encodeBase64String(encrypted).trim();
		*/
		return null;
	}	
	
}
