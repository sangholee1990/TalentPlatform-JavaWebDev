/*
 * @(#)BaseController.java 1.0 2012/08/01
 * 
 * COPYRIGHT (C) 2008 GALLOPSYS CO., LTD.
 * ALL RIGHTS RESERVED.
 */
package egovframework.rte.swfc.controller;

import java.util.Enumeration;
import java.util.Iterator;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.swfc.BaseComponent;
import egovframework.rte.swfc.dto.MapperParam;

/**
 * 기본 콘트롤 클래스이다.
 * 콘틀로러의 공통적으로 사용하는 기능을 공유한다.
 * 
 * @author 김은삼
 * @version 1.0 2012/08/01
 */
public class BaseController extends BaseComponent {
	
	@Resource(name = "sqlSessionTemplate")
	protected SqlSession sessionTemplate;
	
    /**
     * 텍스트 파라메터를 반환한다.
     * XSS 방지를 위한 변경도 함께 처리한다.
     * @param request HTTP 요청
     * @param name 파라메터 이름
     * @return 텍스트 파라메터
     */
    private String[] getTextParameter(HttpServletRequest request, String name) {
    	String[] values = request.getParameterValues(name);
    	String[] distValues = null;
    	if(values != null && values.length != 0){
    		distValues = new String[values.length];
    		for(int i = 0; i < values.length; i++){
    			distValues[i] = values[i]; //XSS 처리 - 안함
    		}
    	}
        return distValues;
    }
    
    /**
     * 파일 파라메터를 반환한다.
     * 
     * @param request HTTP 요청
     * @param name 파라메터 이름
     * @return 파일 파라메터
     */
    private MultipartFile[] getFileParameter(MultipartHttpServletRequest request, String name) {
        Object[] source = request.getFiles(name).toArray();
        
        MultipartFile[] destination = new MultipartFile[source.length];
        
        System.arraycopy(source, 0, destination, 0, source.length);
        
        return destination;
    }
    
    protected ServletContext getServletContext(){
    	return getSession().getServletContext();
    }
    
    /**
     * HTTP 요청을 반환한다.
     * 
     * @return HTTP 요청
     */
    protected HttpServletRequest getRequest() {
        return ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
    }
    
    /**
     * HTTP 세션을 반환한다.
     * 
     * @return HTTP 세션
     */
    protected HttpSession getSession() {
        return getSession(getRequest());
    }
    
    /**
     * HTTP 세션을 반환한다.
     * 
     * @param create 생성여부
     * @return HTTP 세션
     */
    protected HttpSession getSession(boolean create) {
        return getSession(getRequest(), create);
    }
    
    /**
     * HTTP 세션을 반환한다.
     * 
     * @param request HTTP 요청
     * @return HTTP 세션
     */
    protected HttpSession getSession(HttpServletRequest request) {
        return request.getSession();
    }
    
    /**
     * HTTP 세션을 반환한다.
     * 
     * @param request HTTP 요청
     * @param create 생성여부
     * @return HTTP 세션
     */
    protected HttpSession getSession(HttpServletRequest request, boolean create) {
        return request.getSession(create);
    }
    
    
    protected MapperParam getParams() {
        return getParams(getRequest(), false);
    }
    
    /**
     * 파라메터를 반환한다.
     * 
     * @param session 세션여부
     * @return 파라메터
     */
    protected MapperParam getParams(boolean session) {
        return getParams(getRequest(), session);
    }
    
    /**
     * 파라메터를 반환한다.
     * 
     * @param request HTTP 요청
     * @return 파라메터
     */
    protected MapperParam getParams(HttpServletRequest request) {
        return getParams(request, false);
    }
    
    /**
     * 파라메터를 반환한다.
     * 
     * @param request HTTP 요청
     * @param session 세션여부
     * @return 파라메터
     */
    protected MapperParam getParams(HttpServletRequest request, boolean session) {
    	MapperParam params = new MapperParam();
        
        // 텍스트 파라메터를 추가한다.
        addTextParameter(params, request);
        
        if (request instanceof MultipartHttpServletRequest) {
            // 파일 파라메터를 추가한다.
            addFileParameter(params, (MultipartHttpServletRequest) request);
        }
        return params;
    }
    
    protected void addTextParameter(MapperParam params, HttpServletRequest request) {
        Enumeration<?> enumeration = request.getParameterNames();
        
        while (enumeration.hasMoreElements()) {
            String name = (String) enumeration.nextElement();
            
            String rename = name;
            
            if (name.endsWith("[]")) {
                rename = name.substring(0, name.lastIndexOf("[]"));
            }
            
            params.add(rename, getTextParameter(request, name));
        }
    }
    
    protected void addFileParameter(MapperParam params, MultipartHttpServletRequest request) {
        Iterator<String> iterator = request.getFileNames();
        
        while (iterator.hasNext()) {
            String name = iterator.next();
            
            String rename = name;
            
            if (name.endsWith("[]")) {
                rename = name.substring(0, name.lastIndexOf("[]"));
            }
            
            params.add(rename, getFileParameter(request, name));
        }
    }
    
    protected String getViewName(String file) {
        return getViewName(Locale.KOREAN.getLanguage(), file);
    }
    
    protected String getViewName(String lang, String file) {
    	return "contents/" + lang + "/" + file;
    }
}