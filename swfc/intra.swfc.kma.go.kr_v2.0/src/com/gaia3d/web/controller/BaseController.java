package com.gaia3d.web.controller;

import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.apache.commons.lang.SystemUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.hierarchicalroles.UserDetailsWrapper;
import org.springframework.security.core.context.SecurityContextHolder;

import com.gaia3d.web.user.WebUser;
import com.gaia3d.web.vo.FontVo;

public class BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(BaseController.class);
	
	@Resource(name = "sqlSessionTemplate")
	protected SqlSession sessionTemplate;
	
	@Autowired
    private ServletContext servletContext;
	
	protected void debug(String message){
		logger.debug(message);
	}
	protected void info(String message){
		logger.info(message);
	}
	protected void error(String message){
		logger.error(message);
	}
	protected void warn(String message){
		logger.warn(message);
	}
	protected void trace(String message){
		logger.trace(message);
	}
	
	
	
	/**
	 * font 경로를 가져온다.
	 * @param fontName 폰트 파일명
	 * @param index 폰트 인덱스명
	 * @return
	 */
	protected String getFontPath(String fontName, Integer index){
		
		String fontPath = "";
    	if(SystemUtils.IS_OS_LINUX){
    		if(fontName == null) fontName = "gulim.ttf";
    		fontPath = servletContext.getRealPath("/WEB-INF/fonts/linux/" + fontName);
    	}else{
    		if(fontName == null){
    			fontName = "BATANG.TTC";
    			index = 0;
    		}
    		
    		fontPath = servletContext.getRealPath("/WEB-INF/fonts/windows/" + fontName);
    	}
    	
    	if(index != null) fontPath = String.format("%s,%s", fontPath, index);
    	
    	debug("font==>" + fontPath);
    	
    	return fontPath;
    }
	/**
	 * font 경로를 가져온다.
	 * @param fontName 폰트 파일명
	 * @param index 폰트 인덱스명
	 * @return
	 */
	protected String getFontPath(FontVo vo){
		return getFontPath(vo.getFontName(), vo.getFontIndex());
	}
	
	
	/**
	 * map 값을 vo로 매핑한다.
	 * @param clazz
	 * @param map
	 * @return
	 */
	protected <T> T getMapVo(Class<T> clazz, Map<?, ?> map){
		T t = null;
		try {
			t = clazz.newInstance();
			org.apache.commons.beanutils.BeanUtils.populate(t, map);
		} catch (IllegalAccessException e) {
			//debug("IllegalAccessException" + e.getMessage());
		} catch (InvocationTargetException e) {
			//debug("InvocationTargetException" + e.getMessage());
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return (T)t;
	}
	
	
	/**
	 * 로그인 사용자 고유 번호를 가져온다.
	 * @return
	 */
	public Integer getUserSeqN(){
		UserDetailsWrapper userDetailWrapper = (UserDetailsWrapper)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		WebUser user = (WebUser)userDetailWrapper.getUnwrappedUserDetails();
		if(user == null) return null;
		return  user.getDetail().getId();
	}
	
	/**
	 * 로그인 사용자의 사용자 이름을 가져온다.
	 * @return
	 */
	public String getUserName(){
		UserDetailsWrapper userDetailWrapper = (UserDetailsWrapper)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		WebUser user = (WebUser)userDetailWrapper.getUnwrappedUserDetails();
		if(user == null) return null;
		return user.getDetail().getName();
	}
	
	
	public static void mainxxx(String[] args){
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("fontName", 11);
		map.put("fontIndex", 11);
		map.put("test", 11);
		map.put("te333st", 11);
		
		//FontVo vo = getMapVo(FontVo.class, map);
		//
		//BeanUtils.copyProperties(map, vo);
		
		//BeanUtils.(map, vo, FontVo.class);
		
		
		//System.out.println(vo.toString());
	}
	
	
	
	
	
	
}
