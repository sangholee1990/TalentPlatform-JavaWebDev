package com.gaia3d.web.controller;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Calendar;
import java.util.Locale;
import java.util.TimeZone;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class SpaceWeatherController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(SpaceWeatherController.class);
	
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
		
		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		int date = calendar.get(Calendar.DATE);
		int hour = calendar.get(Calendar.HOUR);
		int minute = calendar.get(Calendar.MINUTE);
		
		String yearStr = String.valueOf(year);
		String monthStr = String.valueOf(month);
		if(monthStr.length() < 2) monthStr = "0" + monthStr;
		String dateStr = String.valueOf(date);
		if(dateStr.length() < 2) dateStr = "0" + dateStr;		
		
		int BUF_SIZE;
		byte[] buf = null;    
		DataInputStream in =  null ;
		try {
			String filePath = null;
			File imgFile = null;
			if(type.equals("HCP_WORLD"))
			{
				filePath = "/swfc/MDL/SWAA/SUNSPOT/HCP_WORLD/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/hcp_world_" + alt + ".jpg";
				imgFile= new File(filePath) ;
				if(imgFile.isFile() == false) {
					dateStr = String.valueOf(date-1);
					dateStr = dateStr.length() < 2 ? "0" + dateStr : dateStr;
					filePath = "/swfc/MDL/SWAA/SUNSPOT/HCP_WORLD/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/hcp_world_" + alt + ".jpg";
					imgFile= new File(filePath);
				}
				
			}
			else if(type.equals("HCP_AIRWAY"))
			{
				filePath = "/swfc/MDL/SWAA/SUNSPOT/HCP_AIRWAY/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/" + airway + ".jpg";
				imgFile= new File(filePath) ;
				if(imgFile.isFile() == false) {
					dateStr = String.valueOf(date-1);
					dateStr = dateStr.length() < 2 ? "0" + dateStr : dateStr;
					filePath = "/swfc/MDL/SWAA/SUNSPOT/HCP_AIRWAY/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/" + airway + ".jpg";
					imgFile= new File(filePath);
				}
			}else if(type.equals("ovation"))
			{ 
				 	File newFile = new File("/swfc/MDL/SWAA/OVATION/OVATION/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/");
				 	if(newFile.isFile() == false) {
						dateStr = String.valueOf(date-1);
						dateStr = dateStr.length() < 2 ? "0" + dateStr : dateStr;
						newFile = new File("/swfc/MDL/SWAA/OVATION/OVATION/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/");
					}  
				 	File[] fileList = newFile.listFiles();
				 	int fileCount = fileList.length;
				 	String ovationName = fileList[fileCount-1].getName(); 
				 	filePath = "/swfc/MDL/SWAA/OVATION/OVATION/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/" + ovationName;
				 	imgFile= new File(filePath); 
			}else if(type.equals("tec_world"))
			{  
			 	File newFile = new File("/swfc/MDL/SWAA/TEC_WORLD/TEC/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/");
			 	if(newFile.isFile() == false) {
					dateStr = String.valueOf(date-1);
					dateStr = dateStr.length() < 2 ? "0" + dateStr : dateStr;
					newFile = new File("/swfc/MDL/SWAA/TEC_WORLD/TEC/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/");
				}  
			 	
			 	File[] fileList = newFile.listFiles();
			 	int fileCount = fileList.length;			 	
			 	String tecName = fileList[fileCount-1].getName();
			 	
			 	if(alt!=null){ 
			 		String[] split = tecName.split("_");
			 		split[2] = alt+".jpg";
			 		tecName = split[0]+"_"+split[1]+"_"+split[2];  
			 	} 
			 	filePath = "/swfc/MDL/SWAA/TEC_WORLD/TEC/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/" + tecName;
			 	imgFile= new File(filePath);
			}
			else if(type.equals("tec_korea"))
			{  
			 	File newFile = new File("/swfc/MDL/SWAA/TEC_KOREA/TEC/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/");
			 	if(newFile.isFile() == false) {
					dateStr = String.valueOf(date-1);
					dateStr = dateStr.length() < 2 ? "0" + dateStr : dateStr;
					newFile = new File("/swfc/MDL/SWAA/TEC_KOREA/TEC/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/");
				}  
			 	
			 	File[] fileList = newFile.listFiles();
			 	int fileCount = fileList.length;			 	
			 	String tecName = fileList[fileCount-1].getName();
			 	
			 	if(alt!=null){ 
			 		String[] split = tecName.split("_");
			 		split[2] = alt+".jpg";
			 		tecName = split[0]+"_"+split[1]+"_"+split[2];  
			 	} 
			 	filePath = "/swfc/MDL/SWAA/TEC_KOREA/TEC/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/" + tecName;
			 	imgFile= new File(filePath);
			}else if(type.equals("rbsp"))
			{ 
				filePath = "/swfc/MDL/SWAA/RBSP/RBSP/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/rbsp.jpg";
				imgFile= new File(filePath) ;
				if(imgFile.isFile() == false) {
					dateStr = String.valueOf(date-1);
					dateStr = dateStr.length() < 2 ? "0" + dateStr : dateStr;
					filePath = "/swfc/MDL/SWAA/RBSP/RBSP/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/rbsp.jpg";
					imgFile= new File(filePath);
					}
			}else if(type.equals("drap"))
			{  
				File newFile = new File("/swfc/MDL/SWAA/DRAP/DRAP/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/");
			 	if(newFile.isFile() == false) {
					dateStr = String.valueOf(date-1);
					dateStr = dateStr.length() < 2 ? "0" + dateStr : dateStr;
					newFile = new File("/swfc/MDL/SWAA/DRAP/DRAP/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/");
				}  
			 	File[] fileList = newFile.listFiles();
			 	int fileCount = fileList.length;
			 	String Name = fileList[fileCount-1].getName(); 
			 	filePath = "/swfc/MDL/SWAA/DRAP/DRAP/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/" + Name;
			 	imgFile= new File(filePath);  
			}else if(type.equals("mag"))
			{   
				File newFile = new File("/data/home/gnss/geomag_new/figure/" + yearStr + "/" + monthStr + "/" + dateStr + "/");
				System.out.println(newFile);
			 	if(newFile.isFile() == false) {
					dateStr = String.valueOf(date-1);
					dateStr = dateStr.length() < 2 ? "0" + dateStr : dateStr;
					newFile = new File("/data/home/gnss/geomag_new/figure/" + yearStr + "/" + monthStr + "/" + dateStr + "/");
				}  
			 	File[] fileList = newFile.listFiles(); 
			 	int fileCount = fileList.length; 
			 	String Name = fileList[fileCount-1].getName(); 
			 	 	for(int i = 0 ; i <fileCount; i++){
			 		String fileABC = fileList[i].getName(); 
				 		boolean contains = StringUtils.contains(fileABC, "A");
				 		if(contains){	
				 			Name = fileABC; ; 
				 		} 
			 	 	} 
			 	filePath = "/data/home/gnss/geomag_new/figure/" + yearStr + "/" + monthStr + "/" + dateStr + "/"+ Name;
			 	imgFile= new File(filePath);  
			}
			  
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
