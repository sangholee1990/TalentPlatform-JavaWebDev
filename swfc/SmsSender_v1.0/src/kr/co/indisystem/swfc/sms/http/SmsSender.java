package kr.co.indisystem.swfc.sms.http;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.List;

import kr.co.indisystem.swfc.sms.utils.PropertiesUtils;

import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpVersion;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpParams;
import org.apache.http.params.HttpProtocolParams;
import org.apache.http.protocol.HTTP;
import org.apache.log4j.Logger;

public class SmsSender {
	
	private static Logger log = Logger.getLogger(SmsSender.class);

	/**
	 * SMS를 발송한다.
	 * @param nvps
	 */
	public static void send(List<NameValuePair> nvps){
		
		if(nvps == null) return;
		
		//기본 값을 셋팅한다.
		nvps.add(new BasicNameValuePair("m_id", PropertiesUtils.getStringValue("userName")));
		nvps.add(new BasicNameValuePair("m_pw", PropertiesUtils.getStringValue("uesrPw")));
		nvps.add(new BasicNameValuePair("fromNumber", PropertiesUtils.getStringValue("fromNumber")));
		nvps.add(new BasicNameValuePair("m_corpfrcode", "nmsc_sms_" + System.currentTimeMillis()));
		nvps.add(new BasicNameValuePair("returnURL", PropertiesUtils.getStringValue("returnURL")));
		
		/*
		HttpParams params = new BasicHttpParams();
		HttpProtocolParams.setVersion(params, HttpVersion.HTTP_1_1);
		HttpProtocolParams.setContentCharset(params, "utf-8");
		params.setBooleanParameter("http.protocol.expect-continue", false);
		*/
		HttpClient client = new DefaultHttpClient();
		HttpPost httpPost = new HttpPost(PropertiesUtils.getStringValue("url"));
		ResponseHandler<String> handler = new BasicResponseHandler();
		try {
			httpPost.setEntity(new UrlEncodedFormEntity(nvps, "euc-kr"));
			//httpPost.setEntity(new UrlEncodedFormEntity(nvps));
			HttpResponse response = client.execute(httpPost);
			String body = handler.handleResponse(response);
			HttpEntity entity = response.getEntity();
			if(entity != null){
				entity.consumeContent();
				/*
				BufferedReader br = null;
				String line = null;
				
				try{
					br = new BufferedReader(new InputStreamReader(entity.getContent()));
					while((line = br.readLine()) != null){
						System.out.println(line + "\n");
					}
				}finally{
					if(br != null) try{ br.close(); }catch (Exception e) {}
				}
				*/
				System.out.println(body);
				log.debug("status code=>" + response.getStatusLine().getStatusCode());
			}
		} catch (UnsupportedEncodingException e) {
			log.error("UnsupportedEncodingException", e);
		} catch (ClientProtocolException e) {
			log.error("ClientProtocolException", e);
		} catch (IOException e) {
			log.error("IOException", e);
		}finally{
			System.out.println("send ok.");
		}
	}
}
