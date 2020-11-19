package com.gaia3d.web.security;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class SWFCAuthenticationSuccessHandler implements
		AuthenticationSuccessHandler {

	private static final Logger logger = LoggerFactory.getLogger(SWFCAuthenticationSuccessHandler.class);
			
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	/**
	 * 권한별 home url 
	 */
	private Map<String, String> roleHomeUrl = new HashMap<String, String>() {{
	    put("ROLE_USER", "/");
	    put("ROLE_SPECIFIC_USER", "/");
	    put("ROLE_ADMIN", "/admin/user_list.do");
	}};
	 
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, 
      HttpServletResponse response, Authentication authentication) throws IOException {
        handle(request, response, authentication);
        clearAuthenticationAttributes(request);
    }
 
    /**
     * 로그인 상황별 페이지 분기 
     * 1. Session timeout 시 이전 작업 url 로이동 
     * 2. 정상 로그인 시 권한별 default page 로 이동 
     * @param request
     * @param response
     * @param authentication
     * @throws IOException
     */
    protected void handle(HttpServletRequest request, 
      HttpServletResponse response, Authentication authentication) throws IOException {

    	//get redirect url from SWFCAuthenticationEntryPoint Session timeout previous url
        String targetUrl = (String) request.getSession().getAttribute("url_prior_login");
        if ( targetUrl == null ){
        	targetUrl = determineTargetUrl(authentication);
        }
        
        if (response.isCommitted()) {
            logger.debug("Response has already been committed. Unable to redirect to " + targetUrl);
            return;
        }
 
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }
 
    /**
     * 권한별 초기 페이지 설정
     * @param authentication
     * @return
     */
    protected String determineTargetUrl(Authentication authentication) {
        
        String homeUrl = null;
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        for (GrantedAuthority grantedAuthority : authorities) {
       
        	if ( roleHomeUrl.containsKey(grantedAuthority.getAuthority()) ) {
        		homeUrl = roleHomeUrl.get(grantedAuthority.getAuthority());
        		break;
        	}
        }
        
        logger.debug("home url = " + homeUrl );
        if (homeUrl != null ){
            return homeUrl; 
        } else {
            throw new IllegalStateException();
        }
    }
 
    protected void clearAuthenticationAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }
 
    public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
        this.redirectStrategy = redirectStrategy;
    }
    protected RedirectStrategy getRedirectStrategy() {
        return redirectStrategy;
    }

	public void setRoleHomeUrl(Map<String, String> roleHomeUrl) {
		this.roleHomeUrl = roleHomeUrl;
	}


	

}
