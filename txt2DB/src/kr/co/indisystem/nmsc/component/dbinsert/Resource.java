package kr.co.indisystem.nmsc.component.dbinsert;

import java.io.File;

public class Resource {
	
	/**
	 * 리소스 경로
	 */
	public static String APP_PATH = Resource.class.getResource("Resource.class").getPath();
	/**
	 * 프로그램 경로
	 */
	public static String PROGRAM_PATH = APP_PATH.substring(0, APP_PATH.indexOf("kr/co/indisystem"));
	/**
	 * 리소스 경로
	 */
	public static String RESOURCES_PATH = getPropertiesPath() + File.separator +  "properties";
	
	public static String getPropertiesPath(){
		
		if(PROGRAM_PATH.endsWith("classes/")){
			return PROGRAM_PATH.substring(0, PROGRAM_PATH.lastIndexOf("/classes/"));
		}else if(PROGRAM_PATH.endsWith("bin/")){
			return PROGRAM_PATH.substring(0, PROGRAM_PATH.lastIndexOf("/bin/"));
		}		
		
		return PROGRAM_PATH;
	}
}
