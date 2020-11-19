package com.gaia3d.web.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class SWFCAuthenticationFailureHandler implements AuthenticationFailureHandler{
	
	private static final Logger logger = LoggerFactory.getLogger(SWFCAuthenticationFailureHandler.class);
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	
	//에러 확인 페이지
	private String defaultUrl;
	
	/**
	 * 로그인 실패시 
	 * 에러코드 
	 * @return
	 * @exception
	 * */
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request,
			HttpServletResponse response, AuthenticationException exp)
			throws IOException, ServletException {
		
		int error = 0;
		if(exp instanceof AuthenticationServiceException){	//서비스 내부 오류
			error=1;
		}	
		
		if(exp instanceof BadCredentialsException){	//인증 오류
			error=2;
		}
		
		if(exp instanceof LockedException){	//제한 오류
			error=3;
		}

		redirectStrategy.sendRedirect(request, response, defaultUrl + "?error=" + error);
	}

	public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
		this.redirectStrategy = redirectStrategy;
	}

	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}
	
}//class end
