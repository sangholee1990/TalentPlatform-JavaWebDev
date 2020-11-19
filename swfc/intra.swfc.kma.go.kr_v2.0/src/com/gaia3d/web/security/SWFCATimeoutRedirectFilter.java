package com.gaia3d.web.security;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.authentication.AuthenticationTrustResolverImpl;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.util.ThrowableAnalyzer;
import org.springframework.security.web.util.ThrowableCauseExtractor;
import org.springframework.web.filter.GenericFilterBean;

public class SWFCATimeoutRedirectFilter extends GenericFilterBean {

	private static final Logger logger = LoggerFactory.getLogger(SWFCATimeoutRedirectFilter.class);
			
	private ThrowableAnalyzer throwableAnalyzer = new DefaultThrowableAnalyzer();
    private AuthenticationTrustResolver authenticationTrustResolver = new AuthenticationTrustResolverImpl();
 
    private int customSessionExpiredErrorCode = 901;
    private String ajaxHeader = null;
 
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
    {
        try
        {
            chain.doFilter(request, response);
 
            //logger.info("Spring security Chain processed normally");
        }
        catch (IOException ex)
        {
            throw ex;
        }
        catch (Exception ex)
        {
            Throwable[] causeChain = throwableAnalyzer.determineCauseChain(ex);
            RuntimeException ase = (AuthenticationException) throwableAnalyzer.getFirstThrowableOfType(AuthenticationException.class, causeChain);
 
            if (ase == null)
            {
                ase = (AccessDeniedException) throwableAnalyzer.getFirstThrowableOfType(AccessDeniedException.class, causeChain);
            }
 
            if (ase != null)
            {
            	// auth exception
                if (ase instanceof AuthenticationException)
                {
                    throw ase;
                }
                // sessiont timeout
                else if (ase instanceof AccessDeniedException)
                {
                	//access rule check
                    if (authenticationTrustResolver.isAnonymous(SecurityContextHolder.getContext().getAuthentication()))
                    {
                        logger.info("User session expired or not logged in yet");
                        if ( isAjaxRequest((HttpServletRequest)request) )
                        {
                            logger.info("Ajax call detected, send {} error code", this.customSessionExpiredErrorCode);
                            HttpServletResponse resp = (HttpServletResponse) response;
                            resp.sendError(this.customSessionExpiredErrorCode, "Ajax login timeout.");
                        }
                        else
                        {
                            logger.info("Redirect to login page");
                            throw ase;
                        }
                    }
                    else
                    {
                        throw ase;
                    }
                }
            }
        }
    }
 
    private static final class DefaultThrowableAnalyzer extends ThrowableAnalyzer
    {
        /**
         * @see org.springframework.security.web.util.ThrowableAnalyzer#initExtractorMap()
         */
        protected void initExtractorMap()
        {
            super.initExtractorMap();
 
            registerExtractor(ServletException.class, new ThrowableCauseExtractor()
            {
                public Throwable extractCause(Throwable throwable)
                {
                    ThrowableAnalyzer.verifyThrowableHierarchy(throwable, ServletException.class);
                    return ((ServletException) throwable).getRootCause();
                }
            });
        }
 
    }
 
    /**
     * ajax session timeout error code setting
     * @param customSessionExpiredErrorCode
     */
    public void setCustomSessionExpiredErrorCode(int customSessionExpiredErrorCode)
    {
        this.customSessionExpiredErrorCode = customSessionExpiredErrorCode;
    }

    /**
     * ajax request check
     * @param req
     * @return
     */
    private boolean isAjaxRequest(HttpServletRequest req) {
    	if ( ajaxHeader == null ){
    		return req.getHeader("X-Requested-With") != null 
    			&& req.getHeader("X-Requested-With").equals("XMLHttpRequest");
    	}else{
    		return (req.getHeader(ajaxHeader) != null 
        		&& req.getHeader(ajaxHeader).equals(Boolean.TRUE.toString()
        		));
    	}
    }

	/**
	 * ajaxHeader name setting
	 * commonJs.jsp 공통모듈에 아래 ajax beforeSend, error function 정의  
	 * @param ajaxHeader
	 */
	public void setAjaxHeader(String ajaxHeader) {
		this.ajaxHeader = ajaxHeader;
	}
    
}
