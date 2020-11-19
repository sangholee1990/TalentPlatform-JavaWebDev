package com.gaia3d.web.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;
import org.springframework.web.util.UrlPathHelper;

import com.gaia3d.web.controller.LoginController;
import com.gaia3d.web.util.Constants;

public class SWFCAuthenticationEntryPoint extends LoginUrlAuthenticationEntryPoint {
	
	private static final Logger logger = LoggerFactory.getLogger(SWFCAuthenticationEntryPoint.class);
	
	private String popupLoginUrl = "/login/login_form.do";

	private String popupCheckStr = "_popup";
	
	public SWFCAuthenticationEntryPoint(String loginUrl) {
        super(loginUrl);
    }
	
    @Override
    public void commence(
        HttpServletRequest request, 
        HttpServletResponse response, 
        AuthenticationException authException) 
            throws IOException, ServletException {

    		//request url
        	String reqUrl = new UrlPathHelper().getPathWithinApplication(request);
        
        	logger.debug("request uri = " + reqUrl);
        	//popup window login page redirect
        	if ( reqUrl.indexOf(popupCheckStr) > -1  ) {
        		RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
        		
        		// for SWFCAuthenticationSuccessHandler redirect url
        		request.getSession().setAttribute("url_prior_login", reqUrl);
            	redirectStrategy.sendRedirect(request, response, popupLoginUrl);
            	return;
        	}
        	
        	//main page login page
            super.commence(request, response, authException);
    }

	public void setPopupLoginUrl(String popupLoginUrl) {
		this.popupLoginUrl = popupLoginUrl;
	}

	public void setPopupCheckStr(String popupCheckStr) {
		this.popupCheckStr = popupCheckStr;
	}

	
}
