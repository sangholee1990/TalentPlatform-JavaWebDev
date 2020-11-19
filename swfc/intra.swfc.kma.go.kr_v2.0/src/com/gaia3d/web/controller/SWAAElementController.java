package com.gaia3d.web.controller;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.web.view.DefaultDownloadView.DownloadModelAndView;
import com.google.common.collect.Maps;
/**
 * @author 태영
 * 
 */
@Controller
@RequestMapping("/elementSWAA")
public class SWAAElementController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(SWAAElementController.class);

	@RequestMapping("north_route.do")
	public void swaaNorthRoute(Model model) throws IOException {  
		
		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
		/*
		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("KST"));
		
		calendar.add(Calendar.DATE, -1);
		*/
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
		
		model.addAttribute("year", yearStr);
		model.addAttribute("month", monthStr);
		model.addAttribute("date", dateStr);
		model.addAttribute("hour", hourStr);
		model.addAttribute("minute", minuteStr);
		
		String calcFileName = "";
		String calcFilePath = "";
		File calcFile = null;
		for(int i = 1; i < 10 ; i ++ ) {
			switch (i){
			case 1:
				calcFileName = "LAX-ICN";
				break;
			case 2:
				calcFileName = "JFK-ICN";
				break;
			case 3:
				calcFileName = "JFK-ICN-polar";
				break;
			case 4:
				calcFileName = "DEL-ICN";
				break;
			case 5:
				calcFileName = "MSC-ICN";
				break;
			case 6:
				calcFileName = "SAT-ICN";
				break;
			case 7:
				calcFileName = "IST-ICN";
				break;
			case 8:
				calcFileName = "ICN-LHR";
				break;
			case 9:
				calcFileName = "PAR-ICN";
				break;			
			}
		
			calcFilePath = "/swfc/MDL/SWAA/SUNSPOT/HCP_CALC"
					+	"/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/" + calcFileName + ".txt";
			calcFile = new File(calcFilePath);
			
			String calcFileText = "";
			if(calcFile.isFile() == true) 
			{
				try {
					BufferedReader in = new BufferedReader(new FileReader(calcFile));
					String s;
					while ((s = in.readLine()) != null) {
						calcFileText += s;
					}
					in.close();
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(calcFileText != "") {
				String[] txt = calcFileText.split(" ");
	
				String hr1 = txt[0];
				String mSvh1r = txt[1];
				String mSv1 = txt[2];
				
				double hr2 = Double.valueOf(hr1);
				double mSvhr2 = Double.valueOf(mSvh1r);
				double mSv2 = Double.valueOf(mSv1);
	
				double hr3 = hr2 / 60;
				double mSvhr3 = mSvhr2 / 1000;
				double mSv3 = mSv2 / 1000;
	
				double hr = Math.round(hr3 * 100d) / 100d;
				double mSvhr = Math.round(mSvhr3 * 10000d) / 10000d;
				double mSv = Math.round(mSv3 * 10000d) / 10000d;
	
				double cabinValue = mSvhr * 800;
				
				String sign;
				String text;
				if (cabinValue <= 6.0) {
					sign = "sign4";
					text = "일반";
				} else if (cabinValue <= 12.0) {
					sign = "sign2";
					text = "주의보";
				} else {
					sign = "sign3";
					text = "경보";
				}
				
				
				model.addAttribute("airway_" + i + "_sign", sign);
				model.addAttribute("airway_" + i + "_hr", hr);
				model.addAttribute("airway_" + i + "_mSvhr", mSvhr);
				model.addAttribute("airway_" + i + "_mSv", mSv);
				model.addAttribute("airway_" + i + "_text", text);
			}
		}

	}

	@RequestMapping("weather_satellite.do")
	public void swaaWeatherSatellite(Model model) throws IOException {  
	}
	
	//===========================================================================//
	
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
	
	//===========================================================================//
	
	@RequestMapping("intraSunspot.do")
	public void loadImageSunspot(String type, String airway, String alt, String num,
			String year, String month, String date,
			HttpServletResponse response) {
		
		if(year == null || month == null || date == null)
		{
			Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			/*
			 * 2015-06-29 황명진 주석
			Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("KST"));
			calendar.add(Calendar.DATE, -1);
			*/
			int year_int = calendar.get(Calendar.YEAR);
			int month_int = calendar.get(Calendar.MONTH) + 1;
			int date_int = calendar.get(Calendar.DATE);
			
			year = String.valueOf(year_int);
			month = String.valueOf(month_int);
			date = String.valueOf(date_int);
					
			if(month.length() < 2) month = "0" + month;
			if(date.length() < 2) date = "0" + date;
		}
		
		try {
			sendImage( response, readImageSunspot(type, year, month, date, alt, airway, num) );
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("intraOvation.do")
	public void loadImageOvation(String year, String month, String date, String hour, String minute,
			HttpServletResponse response) {
		try {
			sendImage( response, readImageOvation(year, month, date, hour, minute) );
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("intraDrap.do")
	public void loadImageDrap(String year, String month, String date, String hour, String minute,
			HttpServletResponse response) {
		try {
			sendImage( response, readImageDrap(year, month, date, hour, minute) );
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("intraRBSP.do")
	public void loadImageRBSP(String year, String month, String date, String index,
			HttpServletResponse response) {
		
		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
		int year_int = 0;
		int month_int = 0;
		int date_int = 0;
		int index_int = Integer.parseInt(index);		
		if(year == null || month == null || date == null)
		{
		} else {
			
			year_int = Integer.parseInt(year);
			month_int = Integer.parseInt(month);
			date_int = Integer.parseInt(date);
			calendar.set(year_int, month_int - 1, date_int);
		}
		calendar.add(Calendar.DATE, index_int);
		
		year_int = calendar.get(Calendar.YEAR);
		month_int = calendar.get(Calendar.MONTH) + 1;
		date_int = calendar.get(Calendar.DATE);
		
		year = String.valueOf(year_int);
		month = String.valueOf(month_int);
		date = String.valueOf(date_int);
				
		if(month.length() < 2) month = "0" + month;
		if(date.length() < 2) date = "0" + date;

		try {
			sendImage( response, readImageRBSP(year, month, date) );
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("intraTEC.do")
	public void loadImageTEC(String area, String type, String year, String month, String date, String hour, 
			HttpServletResponse response) {
		if(year == null || month == null || date == null)
		{
			Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			
			int year_int = calendar.get(Calendar.YEAR);
			int month_int = calendar.get(Calendar.MONTH) + 1;
			int date_int = calendar.get(Calendar.DATE);
			
			//===========================================================
			if(area.intern() == "WORLD") {
				calendar.set(year_int, month_int - 1, date_int);
				//calendar.add(Calendar.DATE, -3);
				
				year_int = calendar.get(Calendar.YEAR);
				month_int = calendar.get(Calendar.MONTH) + 1;
				date_int = calendar.get(Calendar.DATE);
			} else {
				calendar.set(year_int, month_int - 1, date_int);
				//calendar.add(Calendar.DATE, -1);
				
				year_int = calendar.get(Calendar.YEAR);
				month_int = calendar.get(Calendar.MONTH) + 1;
				date_int = calendar.get(Calendar.DATE);
			}
			//===========================================================
			
			year = String.valueOf(year_int);
			month = String.valueOf(month_int);
			date = String.valueOf(date_int);
					
			if(month.length() < 2) month = "0" + month;
			if(date.length() < 2) date = "0" + date;
		}
		try {
			sendImage( response, readImageTEC(area, type, year, month, date, hour) );
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("intraTECSkyway.do")
	public void loadImageTECSkyway(HttpServletResponse response, String skyway) throws Exception {
		
		int BUF_SIZE;
		byte[] buf = null;
		DataInputStream in =  null ;
		
		String filePath = "/swfc/MDL/SWAA/COMMON_DATA/AIRWAY/ROUTE_IMAGE/out_" + skyway + "_image.png";
		File imgFile= new File(filePath) ;
		
		if(imgFile.isFile() == true)
		{
			BUF_SIZE = (int)imgFile.length() ;    
			buf = new byte[BUF_SIZE] ;   
			in = new DataInputStream(new FileInputStream(imgFile));       
			in.readFully(buf);
		}
		
		sendImage( response, buf );
	}
	
	byte[] readImageRBSP(String yearStr, String monthStr, String dateStr) throws Exception {
	
		int year = Integer.parseInt(yearStr);
		int month = Integer.parseInt(monthStr);
		int date = Integer.parseInt(dateStr);
		
		int BUF_SIZE;
		byte[] buf = null;    
		DataInputStream in =  null ;
		try {
			String filePath = null;
			File imgFile = null;
			filePath = "/swfc/MDL/SWAA/RBSP/RBSP/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/rbsp.jpg";
			imgFile= new File(filePath) ;			
			if(imgFile.isFile() == true)
			{
				BUF_SIZE = (int)imgFile.length() ;    
				buf = new byte[BUF_SIZE] ;   
				in = new DataInputStream(new FileInputStream(imgFile));       
				in.readFully(buf);
			}
			else
			{
				filePath = "/swfc/MDL/SWAA/COMMON_DATA/PLOT_COMMON/noimage.png";
				imgFile = new File(filePath);
				if(imgFile.isFile() == true)
				{
					BUF_SIZE = (int)imgFile.length() ;    
					buf = new byte[BUF_SIZE] ;   
					in = new DataInputStream(new FileInputStream(imgFile));       
					in.readFully(buf);
				} else
				{
					buf = new byte[0];
				}
			}
		} finally { 
			in.close();
		}
		return buf;
	}
	
	byte[] readImageTEC(String area, String type, String yearStr, String monthStr, String dateStr, String hourStr) throws Exception {
	
		int year = Integer.parseInt(yearStr);
		int month = Integer.parseInt(monthStr);
		int date = Integer.parseInt(dateStr);
		int hour = Integer.parseInt(hourStr);
		
		int BUF_SIZE;
		byte[] buf = null;    
		DataInputStream in =  null ;
		try {
			String filePath = null;
			File imgFile = null;
			String fileHeader = "";
			if(area.intern() != "KOREA" && area.intern() != "WORLD") return null;
			if(type.intern() == "TEC")
			{
				fileHeader = area.intern()=="WORLD" ? "tec_world_" : "tec_korea_";
			} else if (type.intern() == "GPS_L1")
			{
				fileHeader = area.intern()=="WORLD" ? "gps_l1_world_" : "gps_l1_korea_";
			} else if (type.intern() == "GPS_L2")
			{
				fileHeader = area.intern()=="WORLD" ? "gps_l2_world_" : "gps_l2_korea_";
			} else
			{
				return null;
			}
			
			filePath = "/swfc/MDL/SWAA/TEC_" + area + "/" + type + "/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/" + fileHeader + hourStr + ".jpg";
			imgFile= new File(filePath) ;
			if(imgFile.isFile() == true)
			{
				BUF_SIZE = (int)imgFile.length() ;    
				buf = new byte[BUF_SIZE] ;   
				in = new DataInputStream(new FileInputStream(imgFile));       
				in.readFully(buf);
			}
			else
			{
				filePath = "/swfc/MDL/SWAA/COMMON_DATA/PLOT_COMMON/noimage.png";
				imgFile = new File(filePath);
				if(imgFile.isFile() == true)
				{
					BUF_SIZE = (int)imgFile.length() ;    
					buf = new byte[BUF_SIZE] ;   
					in = new DataInputStream(new FileInputStream(imgFile));       
					in.readFully(buf);
				} else
				{
					buf = new byte[0];
				}
			}
		} finally { 
			in.close();
		}
		return buf;
	}

	byte[] readImageSunspot(String type, String yearStr, String monthStr, String dateStr, String alt, String airway, String num) throws Exception { 		
		
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
			}
			else if(type.equals("HCP_AIRWAY"))
			{
				filePath = "/swfc/MDL/SWAA/SUNSPOT/HCP_AIRWAY/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/" + airway + ".jpg";
				imgFile= new File(filePath) ;
			}
			else if(type.equals("HCP_ROTATE"))
			{
				filePath = "/swfc/MDL/SWAA/SUNSPOT/HCP_ROTATE/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/" + alt + "/hcp_rotate_" + num + ".jpg";
				imgFile= new File(filePath) ;
			}
			else if(type.equals("HCP_KOREA"))
			{
				filePath = "/swfc/MDL/SWAA/SUNSPOT/HCP_KOREA/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/" + airway + ".jpg";
				imgFile= new File(filePath) ;
			}
			if(imgFile.isFile() == true)
			{
				BUF_SIZE = (int)imgFile.length() ;    
				buf = new byte[BUF_SIZE] ;   
				in = new DataInputStream(new FileInputStream(imgFile));       
				in.readFully(buf);
			}
			else
			{
				filePath = "/swfc/MDL/SWAA/COMMON_DATA/PLOT_COMMON/noimage.png";
				imgFile = new File(filePath);
				if(imgFile.isFile() == true)
				{
					BUF_SIZE = (int)imgFile.length() ;    
					buf = new byte[BUF_SIZE] ;   
					in = new DataInputStream(new FileInputStream(imgFile));       
					in.readFully(buf);
				} else
				{
					buf = new byte[0];
				}
			}
		} finally { 
			in.close();
		}
		return buf;
	}
	
	byte[] readImageOvation(String yearStr, String monthStr, String dateStr, String hourStr, String minuteStr) throws Exception { 		
		
		int year = Integer.parseInt(yearStr);
		int month = Integer.parseInt(monthStr);
		int date = Integer.parseInt(dateStr);
		int hour = Integer.parseInt(hourStr);
		int minute = Integer.parseInt(minuteStr);
		
		int minute5 = (int)( (int)(minute / 5) * 5 );
		String minute5Str = String.valueOf(minute5);
		if(minute5Str.length() < 2) minute5Str = "0" + minute5Str;
		
		int BUF_SIZE;
		byte[] buf = null;    
		DataInputStream in =  null ;
		try {
			String filePath = null;
			File imgFile = null;
			filePath = "/swfc/MDL/SWAA/OVATION/OVATION/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/ovation_world_" + hourStr + minute5Str + ".jpg";
			imgFile= new File(filePath) ;
			if(imgFile.isFile() == true)
			{
				BUF_SIZE = (int)imgFile.length() ;    
				buf = new byte[BUF_SIZE] ;   
				in = new DataInputStream(new FileInputStream(imgFile));       
				in.readFully(buf);
			}
			else
			{
				filePath = "/swfc/MDL/SWAA/COMMON_DATA/PLOT_COMMON/noimage.png";
				imgFile = new File(filePath);
				if(imgFile.isFile() == true)
				{
					BUF_SIZE = (int)imgFile.length() ;    
					buf = new byte[BUF_SIZE] ;   
					in = new DataInputStream(new FileInputStream(imgFile));       
					in.readFully(buf);
				} else
				{
					buf = new byte[0];
				}
			}
		} finally { 
			in.close();
		}
		return buf;
	}
	
	byte[] readImageDrap(String yearStr, String monthStr, String dateStr, String hourStr, String minuteStr) throws Exception { 		
		
		int year = Integer.parseInt(yearStr);
		int month = Integer.parseInt(monthStr);
		int date = Integer.parseInt(dateStr);
		int hour = Integer.parseInt(hourStr);
		int minute = Integer.parseInt(minuteStr);
		
		int BUF_SIZE;
		byte[] buf = null;    
		DataInputStream in =  null ;
		try {
			String filePath = null;
			File imgFile = null;
			filePath = "/swfc/MDL/SWAA/DRAP/DRAP/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/drap_" + hourStr + minuteStr + ".jpg";
			imgFile= new File(filePath) ;			
			if(imgFile.isFile() == true)
			{
				BUF_SIZE = (int)imgFile.length() ;    
				buf = new byte[BUF_SIZE] ;   
				in = new DataInputStream(new FileInputStream(imgFile));       
				in.readFully(buf);
			}
			else
			{
				filePath = "/swfc/MDL/SWAA/COMMON_DATA/PLOT_COMMON/noimage.png";
				imgFile = new File(filePath);
				if(imgFile.isFile() == true)
				{
					BUF_SIZE = (int)imgFile.length() ;    
					buf = new byte[BUF_SIZE] ;   
					in = new DataInputStream(new FileInputStream(imgFile));       
					in.readFully(buf);
				} else
				{
					buf = new byte[0];
				}
			}
		} finally { 
			in.close();
		}
		return buf;
	}
	
	@RequestMapping("element_image_click.do")
	public String element_image_click(Model model, String imagesrc) throws IOException {
		int k = imagesrc.indexOf("/elementSWAA");
		if(k == -1) {
			imagesrc = "/elementSWAA/" + imagesrc;
		} else {
			imagesrc = imagesrc.substring(k);
		}
		//int i = imagesrc.indexOf("/SWFCWeb");
		//int j = imagesrc.indexOf("/intra");
		//if(i != -1) {
		//	imagesrc = imagesrc.replaceAll("/SWFCWeb", "");
		//}
		//if(j != -1) {
		//	imagesrc = imagesrc.replaceAll("/intra", "");
		//}
		String imagesrc2 = imagesrc.replace('*', '&');
		model.addAttribute("imagesrc", imagesrc2);
		return "/elementSWAA/element_image_click";
	}
	
	@RequestMapping("intraSunspotAirway.do")
	@ResponseBody
	public Map<String, Object> intraSunspotAirway(Locale locale, Model model,
			@RequestParam(value = "value", required = true) String param) {
		String params[] = param.split("/");

		String year = params[0];
		String month = params[1];
		String date = params[2];
		
		String calcFileName = "";
		String calcFilePath = "";
		File calcFile = null;
		Map<String, Object> result = Maps.newHashMap();
		
		for(int i = 1; i < 10 ; i ++ ) {
			switch (i){
			case 1:
				calcFileName = "LAX-ICN";
				break;
			case 2:
				calcFileName = "JFK-ICN";
				break;
			case 3:
				calcFileName = "JFK-ICN-polar";
				break;
			case 4:
				calcFileName = "DEL-ICN";
				break;
			case 5:
				calcFileName = "MSC-ICN";
				break;
			case 6:
				calcFileName = "SAT-ICN";
				break;
			case 7:
				calcFileName = "IST-ICN";
				break;
			case 8:
				calcFileName = "ICN-LHR";
				break;
			case 9:
				calcFileName = "PAR-ICN";
				break;			
			}
		
			calcFilePath = "/swfc/MDL/SWAA/SUNSPOT/HCP_CALC"
					+	"/Y" + year + "/M" + month + "/D" + date + "/" + calcFileName + ".txt";
			calcFile = new File(calcFilePath);
			
			String calcFileText = "";
			if(calcFile.isFile() == true) 
			{
				try {
					BufferedReader in = new BufferedReader(new FileReader(calcFile));
					String s;
					while ((s = in.readLine()) != null) {
						calcFileText += s;
					}
					in.close();
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(calcFileText != "") {
				result.put("airway"+i, calcFileText);
			}
		}
		return result;
	}
	
	
	List<String> returnVal = new ArrayList<String>(); 
	
	@RequestMapping("searchNorthRoute.do")
	@ResponseBody
	public List<String> searchNorthRoute(@RequestParam(value="sd", required=true) String startDate,
			@RequestParam(value="ed", required=true) String endDate,
			@RequestParam(value="type", required=true) String type
			) throws Exception { 
		
		returnVal.clear();
		
		List<String> lstFiles = new ArrayList<String>();
		
		String[] sdate = startDate.split("-");
		String[] edate = endDate.split("-");
		
		String sYear = sdate[0];
		String sMonth = sdate[1];
		String sDay = sdate[2];
		String sHour = sdate[3];
		String sMin = sdate[4];
		
		String eYear = edate[0];
		String eMonth = edate[1];
		String eDay = edate[2];
		String eHour = edate[3];
		String eMin = edate[4];
		
		String ovationPath="";
		if(type.equals("ovation")){
			 ovationPath = "/swfc/MDL/SWAA/OVATION/OVATION/";
		}else if(type.equals("drap")){
			 ovationPath = "/swfc/MDL/SWAA/DRAP/DRAP/";
		}
			
		
		
		 
		String startVal = sYear+sMonth+sDay+sHour+sMin;
		String endVal = eYear+eMonth+eDay+eHour+eMin; 
		
		subDirList(ovationPath, startVal,endVal);	 
		
		int string = returnVal.size();
		
		lstFiles = returnVal;  
		
		/*lstFiles.add( "ovation_world_0005.jpg" );*/
		return lstFiles;
	}
	 
	public void subDirList(String source,String startVal, String endVal){
		  
		File dir = new File(source);
		File[] listFiles = dir.listFiles(); 

		try { 
			
			for(int i = 0; i <listFiles.length; i++){
				File file = listFiles[i];
				String filePath = "";
				
				if(file.isDirectory()){ 
					 
					subDirList(file.getCanonicalPath().toString(),startVal,endVal);
					
				}else if(file.isFile()){  
					
					String pathNm =file.getCanonicalPath();  
					String pattern = "\\d"; 
					Pattern compile = Pattern.compile(pattern); 
					Matcher matcher = compile.matcher(pathNm);
					
					String fileMake = "";
					
					while(matcher.find()){
						fileMake += matcher.group(0);						
					} 
					double fileNumber = Double.valueOf(fileMake).doubleValue();
					double startNumber = Double.valueOf(startVal).doubleValue();
					double endNumber = Double.valueOf(endVal).doubleValue();  
					if(fileNumber>=startNumber&&fileNumber<=endNumber){
						int k = file.getCanonicalPath().indexOf(":");
						String fullPath = "";
						if(k != -1) {
							fullPath = file.getCanonicalPath().toString().substring(k+1);
						}
						else {
							fullPath = file.getCanonicalPath().toString();
						}
						
						fullPath = fullPath.replaceAll("\\\\", "/");
						
						returnVal.add(fullPath);
					} 
				}  
			} 
		} catch (Exception e) {  
			
		} 		 
	}

	@RequestMapping("view_imageNorthRoute.do")
	public DownloadModelAndView view_imageNorthRoute(
			@RequestParam(value = "f", required = true) String filePathString) throws FileNotFoundException { 
		File fileFullPath = new File( filePathString );
		
		return new DownloadModelAndView(fileFullPath);
	}
	
} 

