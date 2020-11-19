/**
 * 
 */
package kr.co.indisystem.swfc.sms;

import java.io.File;

/**
 * 프로그램 변수를 저장하는 클래스
 * @author Administrator
 *
 */
public class GlobalVars {
	
	/**
	 * application 경로 
	 */
	//public static final String APPLICATION_PATH = new File("").getAbsolutePath().replace("bin", "");
	//public static final String APPLICATION_PATH = GlobalVars.class.getClass().getResource("/").getPath().replace("/bin/", "");
	public static final String APPLICATION_PATH = System.getProperty("app.path");
	
	/**
	 * resource 경로
	 */
	public static final String RESOURCE_PATH = APPLICATION_PATH + File.separator + "config";

}
