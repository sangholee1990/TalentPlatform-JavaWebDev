/*
 * @(#)BaseComponent.java 1.0 2012/08/01
 * 
 * COPYRIGHT (C) 2008 GALLOPSYS CO., LTD.
 * ALL RIGHTS RESERVED.
 */
package egovframework.rte.swfc;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 기본 콤포넌트 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2012/08/01
 */
public class BaseComponent {
    /**
     * 로그
     */
    protected Log log;
    
    /*
     * 멤버 변수를 초기화한다.
     */
    {
        // 로그를 생성한다.
        log = LogFactory.getLog(this.getClass());
    }
    
    /**
     * 로그를 기록한다.
     * 
     * @param message 메시지
     */
    protected void trace(Object message) {
        if (log.isTraceEnabled()) {
            log.trace(message);
        }
    }
    
    /**
     * 로그를 기록한다.
     * 
     * @param message 메시지
     * @param throwable 발생오류
     */
    protected void trace(Object message, Throwable throwable) {
        if (log.isTraceEnabled()) {
            log.trace(message, throwable);
        }
    }
    
    /**
     * 로그를 기록한다.
     * 
     * @param message 메시지
     */
    protected void debug(Object message) {
        if (log.isDebugEnabled()) {
            log.debug(message);
        }
    }
    
    /**
     * 로그를 기록한다.
     * 
     * @param message 메시지
     * @param throwable 발생오류
     */
    protected void debug(Object message, Throwable throwable) {
        if (log.isDebugEnabled()) {
            log.debug(message, throwable);
        }
    }
    
    /**
     * 로그를 기록한다.
     * 
     * @param message 메시지
     */
    protected void info(Object message) {
        if (log.isInfoEnabled()) {
            log.info(message);
        }
    }
    
    /**
     * 로그를 기록한다.
     * 
     * @param message 메시지
     * @param throwable 발생오류
     */
    protected void info(Object message, Throwable throwable) {
        if (log.isInfoEnabled()) {
            log.info(message, throwable);
        }
    }
    
    /**
     * 로그를 기록한다.
     * 
     * @param message 메시지
     */
    protected void warn(Object message) {
        if (log.isWarnEnabled()) {
            log.warn(message);
        }
    }
    
    /**
     * 로그를 기록한다.
     * 
     * @param message 메시지
     * @param throwable 발생오류
     */
    protected void warn(Object message, Throwable throwable) {
        if (log.isWarnEnabled()) {
            log.warn(message, throwable);
        }
    }
    
    /**
     * 로그를 기록한다.
     * 
     * @param message 메시지
     */
    protected void error(Object message) {
        if (log.isErrorEnabled()) {
            log.error(message);
        }
    }
    
    /**
     * 로그를 기록한다.
     * 
     * @param message 메시지
     * @param throwable 발생오류
     */
    protected void error(Object message, Throwable throwable) {
        if (log.isErrorEnabled()) {
            log.error(message, throwable);
        }
    }
    
    /**
     * 로그를 기록한다.
     * 
     * @param message 메시지
     */
    protected void fatal(Object message) {
        if (log.isFatalEnabled()) {
            log.fatal(message);
        }
    }
    
    /**
     * 로그를 기록한다.
     * 
     * @param message 메시지
     * @param throwable 발생오류
     */
    protected void fatal(Object message, Throwable throwable) {
        if (log.isFatalEnabled()) {
            log.fatal(message, throwable);
        }
    }
}