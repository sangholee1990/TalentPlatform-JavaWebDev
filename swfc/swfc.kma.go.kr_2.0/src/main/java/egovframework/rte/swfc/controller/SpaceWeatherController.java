package egovframework.rte.swfc.controller;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Calendar;
import java.util.Locale;
import java.util.TimeZone;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SpaceWeatherController extends BaseController {
	private static final Logger logger = LoggerFactory
			.getLogger(SpaceWeatherController.class);
	
	@RequestMapping("ko/specificContent/iframe.do")
	public String iframe(Locale locale, Model model) {
		return "/contents/ko/specificContent/contents/swaa_sunspot_iframe";
	}
		
	@RequestMapping("ko/specificContent/hcp_airway.do")
	public String main(Locale locale, Model model,String number) {
		if(number==null){
			number="";
		}
		return "/contents/ko/specificContent/contents/swaa_sunspot_hcp_airway"+number;
	}
	
	@RequestMapping("ko/specificContent/hcp_korea.do")
	public String main00(Locale locale, Model model,String number) {
		if(number==null){
			number="";
		}
		return "/contents/ko/specificContent/contents/swaa_sunspot_hcp_korea"+number;
	}
	  
	@RequestMapping("ko/specificContent/hcp_world.do")
	public String mai(Locale locale, Model model,String number) {
		if(number==null){
			number="";
		}
		return "/contents/ko/specificContent/contents/swaa_sunspot_hcp_world"+number;
	}
	
	@RequestMapping("ko/specificContent/ovation.do")
	public String main1(Locale locale, Model model) { 
		return "/contents/ko/specificContent/contents/swaa_ovation";
	} 
	@RequestMapping("ko/specificContent/tec_world.do")
	public String main2(Locale locale, Model model) { 
		return "/contents/ko/specificContent/contents/swaa_tec_world";
	}
	@RequestMapping("ko/specificContent/tec_korea.do")
	public String main3(Locale locale, Model model) { 
		return "/contents/ko/specificContent/contents/swaa_tec_korea";
	} 
	@RequestMapping("ko/specificContent/rbsp.do")
	public String main4(Locale locale, Model model) { 
		return "/contents/ko/specificContent/contents/swaa_rbsp";
	} 
	@RequestMapping("ko/specificContent/drap.do")
	public String main5(Locale locale, Model model) { 
		return "/contents/ko/specificContent/contents/swaa_drap";
	} 
	@RequestMapping("ko/specificContent/mag.do")
	public String main6(Locale locale, Model model) { 
		return "/contents/ko/specificContent/contents/swaa_mag";
	} 
	@RequestMapping("/ko/specificContent/swaa_image.do")
	public void swaaSunspotImage(String type, String airway, String alt, HttpServletResponse response) { 
		try {
			sendImage(response, readImage(type, alt, airway) );
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	void sendImage( HttpServletResponse response, byte[] imgContentsArray) {
		
		ServletOutputStream servletOut = null;
		BufferedOutputStream outStream = null;
		try {                  
			servletOut = response.getOutputStream();  
			outStream =  new BufferedOutputStream( servletOut );                    
			outStream.write(  imgContentsArray, 0, imgContentsArray.length );      
			outStream.flush();
		} catch( Exception writeException ) { 
			writeException.printStackTrace();
		} finally { 
			try {             
				if ( outStream != null ) outStream.close(); 
				if ( servletOut != null ) servletOut.close();
			} catch( Exception closeException ) { 
				closeException.printStackTrace();
			}    
		}
	}

	byte[] readImage(String type, String alt, String airway) throws Exception { 		
		
		//외부망 파일패스
		//String linkPath = "/data/apphome/swfc/swfc_resource/SWAA/";
		
		//내부망 링크파일패스
		//String linkPath = "/data/home/gnss/swfc_resource/SWAA/";
		
		//내부망 원본파일패스
		String linkPath = "/swfc/MDL/SWAA/";
		String linkPath2 = "/swfc/MDL/KHU";
		
		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		int date = calendar.get(Calendar.DATE);
		int hour = calendar.get(Calendar.HOUR_OF_DAY);
		int minute = calendar.get(Calendar.MINUTE);
		
		String yearStr = String.valueOf(year);
		String monthStr = String.valueOf(month);
		String dateStr = String.valueOf(date);
		String hourStr = String.valueOf(hour);
		String minuteStr = String.valueOf(minute);
		
		if(monthStr.length() < 2) monthStr = "0" + monthStr;
		if(dateStr.length() < 2) dateStr = "0" + dateStr;
		if(hourStr.length() < 2) hourStr = "0" + hourStr;
		if(minuteStr.length() < 2) minuteStr = "0" + minuteStr;
		
		int BUF_SIZE;
		byte[] buf = null;    
		DataInputStream in =  null ;
		try {
			String filePath = null;
			File imgFile = null;
			if(type.equals("HCP_WORLD"))
			{
				filePath = linkPath + "SUNSPOT/HCP_WORLD/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/hcp_world_" + alt + ".jpg";
				imgFile= new File(filePath) ;
				while(imgFile.isFile() == false) {
					calendar.add(Calendar.DATE, -1);
					year = calendar.get(Calendar.YEAR);
					month = calendar.get(Calendar.MONTH) + 1;
					date = calendar.get(Calendar.DATE);
					hour = calendar.get(Calendar.HOUR_OF_DAY);
					minute = calendar.get(Calendar.MINUTE);
					yearStr = String.valueOf(year);
					monthStr = String.valueOf(month);
					dateStr = String.valueOf(date);
					hourStr = String.valueOf(hour);
					minuteStr = String.valueOf(minute);
					if(monthStr.length() < 2) monthStr = "0" + monthStr;
					if(dateStr.length() < 2) dateStr = "0" + dateStr;
					if(hourStr.length() < 2) hourStr = "0" + hourStr;
					if(minuteStr.length() < 2) minuteStr = "0" + minuteStr;
					
					filePath = linkPath + "SUNSPOT/HCP_WORLD/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/hcp_world_" + alt + ".jpg";
					imgFile= new File(filePath);
				}
				
			}
			else if(type.equals("HCP_AIRWAY"))
			{
				filePath = linkPath + "SUNSPOT/HCP_AIRWAY/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/" + airway + ".jpg";
				imgFile= new File(filePath) ;
				while(imgFile.isFile() == false) {
					calendar.add(Calendar.DATE, -1);
					year = calendar.get(Calendar.YEAR);
					month = calendar.get(Calendar.MONTH) + 1;
					date = calendar.get(Calendar.DATE);
					hour = calendar.get(Calendar.HOUR_OF_DAY);
					minute = calendar.get(Calendar.MINUTE);
					yearStr = String.valueOf(year);
					monthStr = String.valueOf(month);
					dateStr = String.valueOf(date);
					hourStr = String.valueOf(hour);
					minuteStr = String.valueOf(minute);
					if(monthStr.length() < 2) monthStr = "0" + monthStr;
					if(dateStr.length() < 2) dateStr = "0" + dateStr;
					if(hourStr.length() < 2) hourStr = "0" + hourStr;
					if(minuteStr.length() < 2) minuteStr = "0" + minuteStr;
					
					filePath = linkPath + "SUNSPOT/HCP_AIRWAY/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/" + airway + ".jpg";
					imgFile= new File(filePath);
				}
			}
			else if(type.equals("HCP_KOREA"))
			{
				filePath = linkPath + "SUNSPOT/HCP_KOREA/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/" + airway + ".jpg";
				imgFile= new File(filePath) ;
				while(imgFile.isFile() == false) {
					calendar.add(Calendar.DATE, -1);
					year = calendar.get(Calendar.YEAR);
					month = calendar.get(Calendar.MONTH) + 1;
					date = calendar.get(Calendar.DATE);
					hour = calendar.get(Calendar.HOUR_OF_DAY);
					minute = calendar.get(Calendar.MINUTE);
					yearStr = String.valueOf(year);
					monthStr = String.valueOf(month);
					dateStr = String.valueOf(date);
					hourStr = String.valueOf(hour);
					minuteStr = String.valueOf(minute);
					if(monthStr.length() < 2) monthStr = "0" + monthStr;
					if(dateStr.length() < 2) dateStr = "0" + dateStr;
					if(hourStr.length() < 2) hourStr = "0" + hourStr;
					if(minuteStr.length() < 2) minuteStr = "0" + minuteStr;
					
					filePath = linkPath + "SUNSPOT/HCP_KOREA/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/" + airway + ".jpg";
					imgFile= new File(filePath);
				}
			}
			else if(type.equals("ovation"))
			{ 
				filePath = linkPath + "OVATION/OVATION/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/ovation_world_" + hourStr + minuteStr + ".jpg";
				imgFile = new File(filePath);
				while(imgFile.isFile() == false) {
					calendar.add(Calendar.MINUTE, -1);
					year = calendar.get(Calendar.YEAR);
					month = calendar.get(Calendar.MONTH) + 1;
					date = calendar.get(Calendar.DATE);
					hour = calendar.get(Calendar.HOUR_OF_DAY);
					minute = calendar.get(Calendar.MINUTE);
					yearStr = String.valueOf(year);
					monthStr = String.valueOf(month);
					dateStr = String.valueOf(date);
					hourStr = String.valueOf(hour);
					minuteStr = String.valueOf(minute);
					if(monthStr.length() < 2) monthStr = "0" + monthStr;
					if(dateStr.length() < 2) dateStr = "0" + dateStr;
					if(hourStr.length() < 2) hourStr = "0" + hourStr;
					if(minuteStr.length() < 2) minuteStr = "0" + minuteStr;
					
					filePath = linkPath + "OVATION/OVATION/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/ovation_world_" + hourStr + minuteStr + ".jpg";
				 	imgFile= new File(filePath); 
				}
			}
			else if(type.equals("tec_world"))
			{
				if(alt == null) alt = "00";
			 	filePath = linkPath + "TEC_WORLD/TEC/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/tec_world_" + alt + ".jpg"; 
				imgFile = new File(filePath);
			 	while(imgFile.isFile() == false) {
			 		calendar.add(Calendar.DATE, -1);
					year = calendar.get(Calendar.YEAR);
					month = calendar.get(Calendar.MONTH) + 1;
					date = calendar.get(Calendar.DATE);
					hour = calendar.get(Calendar.HOUR_OF_DAY);
					minute = calendar.get(Calendar.MINUTE);
					yearStr = String.valueOf(year);
					monthStr = String.valueOf(month);
					dateStr = String.valueOf(date);
					hourStr = String.valueOf(hour);
					minuteStr = String.valueOf(minute);
					if(monthStr.length() < 2) monthStr = "0" + monthStr;
					if(dateStr.length() < 2) dateStr = "0" + dateStr;
					if(hourStr.length() < 2) hourStr = "0" + hourStr;
					if(minuteStr.length() < 2) minuteStr = "0" + minuteStr;
			 					 		
					filePath = linkPath + "TEC_WORLD/TEC/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/tec_world_" + alt + ".jpg"; 
					imgFile = new File(filePath);
				}  
			}
			else if(type.equals("tec_korea"))
			{  
				if(alt == null) alt = "00";
				filePath = linkPath + "TEC_KOREA/TEC/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/tec_korea_" + alt + ".jpg"; 
				imgFile = new File(filePath);
			 	while(imgFile.isFile() == false) {
			 		calendar.add(Calendar.DATE, -1);
					year = calendar.get(Calendar.YEAR);
					month = calendar.get(Calendar.MONTH) + 1;
					date = calendar.get(Calendar.DATE);
					hour = calendar.get(Calendar.HOUR_OF_DAY);
					minute = calendar.get(Calendar.MINUTE);
					yearStr = String.valueOf(year);
					monthStr = String.valueOf(month);
					dateStr = String.valueOf(date);
					hourStr = String.valueOf(hour);
					minuteStr = String.valueOf(minute);
					if(monthStr.length() < 2) monthStr = "0" + monthStr;
					if(dateStr.length() < 2) dateStr = "0" + dateStr;
					if(hourStr.length() < 2) hourStr = "0" + hourStr;
					if(minuteStr.length() < 2) minuteStr = "0" + minuteStr;			 		
			 		
					filePath = linkPath + "TEC_KOREA/TEC/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/tec_korea_" + alt + ".jpg"; 
					imgFile = new File(filePath);
				}  
			}
			else if(type.equals("rbsp"))
			{ 
				filePath = linkPath + "RBSP/RBSP/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/rbsp.jpg";
				imgFile= new File(filePath) ;
				while(imgFile.isFile() == false) {
					calendar.add(Calendar.DATE, -1);
					year = calendar.get(Calendar.YEAR);
					month = calendar.get(Calendar.MONTH) + 1;
					date = calendar.get(Calendar.DATE);
					hour = calendar.get(Calendar.HOUR_OF_DAY);
					minute = calendar.get(Calendar.MINUTE);
					yearStr = String.valueOf(year);
					monthStr = String.valueOf(month);
					dateStr = String.valueOf(date);
					hourStr = String.valueOf(hour);
					minuteStr = String.valueOf(minute);
					if(monthStr.length() < 2) monthStr = "0" + monthStr;
					if(dateStr.length() < 2) dateStr = "0" + dateStr;
					if(hourStr.length() < 2) hourStr = "0" + hourStr;
					if(minuteStr.length() < 2) minuteStr = "0" + minuteStr;					
					
					filePath = linkPath + "RBSP/RBSP/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/rbsp.jpg";
					imgFile= new File(filePath);
					}
			}
			else if(type.equals("drap"))
			{  
				filePath = linkPath + "DRAP/DRAP/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/drap_" + hourStr + minuteStr + ".jpg";
				imgFile = new File(filePath);
			 	while(imgFile.isFile() == false) {
			 		calendar.add(Calendar.MINUTE, -1);
					year = calendar.get(Calendar.YEAR);
					month = calendar.get(Calendar.MONTH) + 1;
					date = calendar.get(Calendar.DATE);
					hour = calendar.get(Calendar.HOUR_OF_DAY);
					minute = calendar.get(Calendar.MINUTE);
					yearStr = String.valueOf(year);
					monthStr = String.valueOf(month);
					dateStr = String.valueOf(date);
					hourStr = String.valueOf(hour);
					minuteStr = String.valueOf(minute);
					if(monthStr.length() < 2) monthStr = "0" + monthStr;
					if(dateStr.length() < 2) dateStr = "0" + dateStr;
					if(hourStr.length() < 2) hourStr = "0" + hourStr;
					if(minuteStr.length() < 2) minuteStr = "0" + minuteStr;		
					
					filePath = linkPath + "DRAP/DRAP/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/drap_" + hourStr + minuteStr + ".jpg";
					imgFile = new File(filePath);
				}  
			}
			else if(type.equals("mag"))
			{   
				filePath = linkPath + "MAGNETOPAUSE/" + yearStr + "/" + monthStr + "/" + dateStr + "/geomag_A_" + yearStr + monthStr + dateStr + hourStr + minuteStr + "UT.png";
				imgFile = new File(filePath);
				 
			 	while(imgFile.isFile() == false) {
			 		calendar.add(Calendar.MINUTE, -1);
					year = calendar.get(Calendar.YEAR);
					month = calendar.get(Calendar.MONTH) + 1;
					date = calendar.get(Calendar.DATE);
					hour = calendar.get(Calendar.HOUR_OF_DAY);
					minute = calendar.get(Calendar.MINUTE);
					yearStr = String.valueOf(year);
					monthStr = String.valueOf(month);
					dateStr = String.valueOf(date);
					hourStr = String.valueOf(hour);
					minuteStr = String.valueOf(minute);
					if(monthStr.length() < 2) monthStr = "0" + monthStr;
					if(dateStr.length() < 2) dateStr = "0" + dateStr;
					if(hourStr.length() < 2) hourStr = "0" + hourStr;
					if(minuteStr.length() < 2) minuteStr = "0" + minuteStr;	
					
					filePath = linkPath2 + "MAGPAUSE_FRCT/" + yearStr + "/" + monthStr + "/" + dateStr + "/geomag_A_" + yearStr + monthStr + dateStr + hourStr + minuteStr + "UT.png";
					imgFile = new File(filePath);
				}  
			}
			
			System.out.println(filePath);
			
			BUF_SIZE = (int)imgFile.length();    
			buf = new byte[BUF_SIZE];   
			in = new DataInputStream(new FileInputStream(imgFile));       
			in.readFully(buf);        
		} finally { 
			in.close();
		}
		return   buf;
	}
}
