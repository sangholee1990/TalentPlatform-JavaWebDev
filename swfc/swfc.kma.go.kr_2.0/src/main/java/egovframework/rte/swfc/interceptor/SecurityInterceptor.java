package egovframework.rte.swfc.interceptor;

import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.rte.swfc.common.Code.Role;
import egovframework.rte.swfc.common.Key;
import egovframework.rte.swfc.exception.AuthorityException;
import egovframework.rte.swfc.exception.UserNotFoundException;

public class SecurityInterceptor extends HandlerInterceptorAdapter {
	
	/**
     * 프로그램을 확인한다.
     * 
     * @param request HTTP 요청
     */
    private void checkAccess(HttpServletRequest request) {
        String context = request.getContextPath();
        String uri     = request.getRequestURI();
        String ip	   = request.getRemoteAddr();
        String reqQueryStr = StringUtils.isEmpty(request.getQueryString()) ? "" : request.getQueryString();
    	
        try {
    		reqQueryStr = URLDecoder.decode(reqQueryStr , "utf-8");
		} catch (Exception e) {}
        
        // 컨텍스트 경로가 루트가 아닌 경우
        if (!"/".equals(context)) {
            uri = uri.substring(context.length());
        }
        
        //특정 수요자용 컨텐츠  URL에 접근을 할경우 권한 체크를 한다.
        if(uri.indexOf("/specificContent/") > 0){
         	HttpSession session = request.getSession(false);
         	
         	if(session == null || session.getAttribute(Key.User.USER_ID) == null){
         		request.setAttribute("message", 1);
         		return;
         		//throw new UserNotFoundException();
         	}
         	
         	String userRole = (String)session.getAttribute(Key.User.USER_ROLE);
         	Role userRoleCode =  Role.valueOf(userRole);
         	
         	if(userRoleCode.getLevel() < Role.ROLE_SPECIFIC_USER.getLevel()){
         		request.setAttribute("message", 2);
         		//throw new AuthorityException("해당 메뉴의 접근 권한이 없습니다.");
         	}
        }        
    }
    
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		//메뉴 접근 권한을 체크한다.
		checkAccess(request);
		
		return true;
	}
}
