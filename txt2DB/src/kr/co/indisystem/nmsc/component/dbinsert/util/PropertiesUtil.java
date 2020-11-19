/**
 * 
 */
package kr.co.indisystem.nmsc.component.dbinsert.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

import kr.co.indisystem.nmsc.component.dbinsert.Resource;



/**
 * @author mjhwang
 *
 */
public class PropertiesUtil {
	
	private PropertiesUtil(){}
	
	private static Properties props = new Properties();
	
	static {
	    InputStream is = null;
	    try {
			is = new FileInputStream(new File(Resource.RESOURCES_PATH, "common-properties.xml"));
			props.loadFromXML(is);
			//props.load(new InputStreamReader(is, "UTF-8"));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(is != null) try {is.close(); } catch (IOException e) {}
		}
	}
	
	public static String getString(String key, String defaultValue){
		if(props.getProperty(key) == null){
			return defaultValue;
		}
		return props.getProperty(key);
	}
	
	public static String getString(String key){
		return getString(key, null);
	}
	
	public static Object getValue(String key){
		return props.get(key);
	}
}
