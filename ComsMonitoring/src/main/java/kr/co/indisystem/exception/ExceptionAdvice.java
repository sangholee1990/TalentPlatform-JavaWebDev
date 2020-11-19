package kr.co.indisystem.exception;

import java.sql.SQLException;

import org.apache.ibatis.exceptions.PersistenceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.transaction.CannotCreateTransactionException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

/**
 * Exception Page Controller
 * 
 * */
@ControllerAdvice
public class ExceptionAdvice extends ResponseEntityExceptionHandler {
	
	private static final Logger logger = LoggerFactory.getLogger(ExceptionAdvice.class);
	
	/**
	 * DB 관련 Exception
	 * */
	@ExceptionHandler({SQLException.class, DataAccessException.class, PersistenceException.class, CannotCreateTransactionException.class})
	public String databaseError(Exception e) {
		//logger.error(e.getMessage());
		logger.debug(e.getMessage());
		return "error/db";
	}
	
	
	@ExceptionHandler(RuntimeException.class) 
    public String handleRuntimeException(RuntimeException e, Model model) {
		logger.debug(e.getMessage());
        return "error/exception";
    }
	
	@ExceptionHandler(Exception.class)
    public String exceptionPage(Exception e, Model model) {
		logger.debug(e.getMessage());
        return "error/exception";
    }
	

}
