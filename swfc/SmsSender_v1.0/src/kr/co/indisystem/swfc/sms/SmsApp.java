package kr.co.indisystem.swfc.sms;

import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import kr.co.indisystem.swfc.sms.http.SmsSender;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.apache.log4j.Logger;

import com.sun.xml.internal.ws.message.ByteArrayAttachment;

/**
 * SMS 발송을 처리하는 메인 클래스
 * @author Administrator
 *
 */
public class SmsApp {
	
	private static Logger log = Logger.getLogger(SmsApp.class);
	
	
	private static boolean isDebug = false;
	private static boolean isEncoding = true;
	private static boolean isSend=true;
	private static String[] ENCODING_KEYS = {"subject", "contents", "toNumber"};

	public static void main(String[] args) {
		
		log.debug("sms start");
		
		//System.out.println(GlobalVars.APPLICATION_PATH);
		//args = new String[4];
		//args[0] = "toNumber:01088303508";
		//args[1] = "subject:test제목입니다.";
		//args[2] = "contents:test 내용입니다.";
		//args[3] = "contents:test 내용입니다.";
		
		/*
		./smsSender.sh: line 36: c3ViamVjdDrF1726xq7A1LTPtNkK: command not found
		./smsSender.sh: line 36: Y29udGVudHM6xde9usauIMDUtM+02S4xMQo=: command not found
		./smsSender.sh: line 36: dG9OdW1iZXI6MDEwODgzMDM1MDgK: command not found
		*/
		
		//System.out.println(new String(Base64.encodeBase64("010-2792-8830".getBytes())));
		//System.out.println(new String(Base64.decodeBase64("7JWI64WV7ZWY7IS47JqUIO2FjOyKpO2KuCDspJHsnoXri4jri6Qu".getBytes())));
		
		//System.out.println(GlobalVars.class.getClass().getResource("/").getPath());
		//System.out.println(GlobalVars.APPLICATION_PATH);
		//System.out.println(args.length);
		//System.out.println(args[0]);
		//System.out.println(new String(Base64.decodeBase64("dG9OdW1iZXI6MDEwODgzMDM1MDgK".getBytes())));
		/*
		System.out.println("기본 인코딩 타입");
		System.out.println("default charset=" + Charset.defaultCharset());
		System.out.println("file.encoding=" +System.getProperty("file.encoding"));
		System.out.println("Default charset in Use=" + getDefaultCharset());
		*/
		
		if(args == null || args.length < 3 ){
			System.out.println("params is null");
			System.exit(1);	
		}
		
		String[] data;
		String key;
		String value;
		for(String param : args){
			data = param.split(":");
			if(data != null && data.length == 2){
				key = data[0];
				value = data[1];
				if(key.equals("debug")){
					isDebug = "Y".equals(value);
				}
				if(key.equals("encoding")){
					isEncoding = !"N".equals(value);
				}
				if(key.equals("send")){
					isSend = !"N".equals(value);
				}
			}
		}
		
		//--------------------------------------------------------------//
		// 넘겨받은 파라메터 값을 셋팅한다.
		//--------------------------------------------------------------//
		List<NameValuePair> paramsList = new ArrayList<NameValuePair>();
		for(String param : args){
			data = param.split(":");
			if(data != null && data.length == 2){
				key = data[0];
				value = data[1];
				if(isEncoding){
					for(String k : ENCODING_KEYS){
						if(k.equals(key)){
							value = new String(Base64.decodeBase64(value.getBytes()));
						}
					}
				}
				paramsList.add(new BasicNameValuePair(key, value));
				
				if(isDebug)System.out.printf("key=%s, value=%s\n",  key, value);
			}
		}
		
		/*
		paramsList.add(new BasicNameValuePair("subject", "1111"));
		paramsList.add(new BasicNameValuePair("contents", "테스트 발송 내용입니다."));
		paramsList.add(new BasicNameValuePair("toNumber", "010-2792-8830"));
		*/
		//Date dt = new Date(System.currentTimeMillis());
		//System.out.println(System.currentTimeMillis());
		
		log.debug("sms send");
		
		if(isSend)new SmsSender().send(paramsList);
	}
	
	private static String getDefaultCharset(){
		OutputStreamWriter wirter = new OutputStreamWriter(new ByteArrayOutputStream());
		String enc = wirter.getEncoding();
		return enc;
	}
}
