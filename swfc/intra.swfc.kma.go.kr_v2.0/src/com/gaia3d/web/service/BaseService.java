package com.gaia3d.web.service;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.hierarchicalroles.UserDetailsWrapper;
import org.springframework.security.core.context.SecurityContextHolder;

import com.gaia3d.web.user.WebUser;

public class BaseService {
	
	private static final Logger logger = LoggerFactory.getLogger(BaseService.class);
	
	@Resource(name = "sqlSessionTemplate")
	protected SqlSession sessionTemplate;
	
	
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

}
