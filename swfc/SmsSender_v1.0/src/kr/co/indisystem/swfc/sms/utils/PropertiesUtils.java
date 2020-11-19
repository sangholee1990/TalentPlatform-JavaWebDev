package kr.co.indisystem.swfc.sms.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.InvalidPropertiesFormatException;
import java.util.Properties;

import kr.co.indisystem.swfc.sms.GlobalVars;

import org.apache.log4j.Logger;

public class PropertiesUtils {
	
	private static Logger log = Logger.getLogger(PropertiesUtils.class);
	
	private  PropertiesUtils (){}
	
	private static Properties properties = null;
	
	private static final String CONFIG_FILE_NAME =  "config.xml";
	
	static {
		FileInputStream fis = null;
		properties = new Properties();
		try {
			fis = new FileInputStream(new File(GlobalVars.RESOURCE_PATH, CONFIG_FILE_NAME));
			properties.loadFromXML(fis);
		} catch (InvalidPropertiesFormatException e) {
			log.info("InvalidPropertiesFormatException", e);
		} catch (FileNotFoundException e) {
			log.info("FileNotFoundException", e);
		} catch (IOException e) {
			log.info("IOException", e);
		}finally{
			if(fis != null)
				try { fis.close(); } catch (IOException e) {}
		}
	}
	
	public static String getStringValue(String key){
		return properties.getProperty(key, null);
	}
	
	public static String getStringValue(String key, String defaultValue){
		return properties.getProperty(key, defaultValue);
	}
	
	public static int getIntValue(String key){
		return Integer.parseInt( properties.getProperty(key, "-1"));
	}
	
	public static int getIntValue(String key, String defaultValue){
		return Integer.parseInt( properties.getProperty(key, defaultValue));
	}
	

}
