/**
 * 
 */
package com.gaia3d.web.util;


/**
 * @author Administrator
 *
 */
public class StringUtils extends org.apache.commons.lang.StringUtils {
	
	private StringUtils(){}
	
	/**
	 * 문자열을 입력받아 null을 확인 후 값을 반환한다. 값이 null일 경우 지정된 값을 반환한다. 
	 * @param value 문자열
	 * @param defaultValue null일경우 반환될 문자열
	 * @return 결과값
	 */
	public static String getString(String value, String defaultValue){
		return isEmpty(value) ? defaultValue : value;
	}
	
	public static String getString(String value){
		return isEmpty(value) ? null : value;
	}
	

}
