package com.gaia3d.web.controller;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Calendar;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;

@Controller
@RequestMapping("/monitorSWAA")
public class SWAAMonitorController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(SWAAMonitorController.class);

	// 상황판 1번(극항로 항공기상 감시시스템)
	@RequestMapping("monitor1.do")
	public String monitor1(Locale locale, Model model) {
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
		
		model.addAttribute("year", yearStr);
		model.addAttribute("month", monthStr);
		model.addAttribute("date", dateStr);
		model.addAttribute("hour", hourStr);
		model.addAttribute("minute", minuteStr);

		String calcFilePath = "/swfc/MDL/SWAA/SUNSPOT/HCP_CALC"
				  +	"/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/JFK-ICN-polar.txt";
		File calcFile = new File(calcFilePath);
		while(calcFile.isFile() == false)
		{
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
			
			calcFilePath = "/swfc/MDL/SWAA/SUNSPOT/HCP_CALC"
					  +	"/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/JFK-ICN-polar.txt";
			calcFile = new File(calcFilePath);
		}
		
		String calcFileText = "";
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

		String sing1;
		String sing2;
		String sing3;

		if (cabinValue <= 6.0) {
			sing1 = "sign4";
		} else if (cabinValue <= 12.0) {
			sing1 = "sign2";
		} else {
			sing1 = "sign3";

		}

		if (mSv <= 0.330) {
			sing2 = "sign4";
		} else if (mSv <= 0.670) {
			sing2 = "sign2";
		} else {
			sing2 = "sign3";

		}

		if (mSv <= 0.167) {
			sing3 = "sign4";
		} else if (mSv <= 0.333) {
			sing3 = "sign2";
		} else {
			sing3 = "sign3";

		}
		
		model.addAttribute("sign1", sing1);
		model.addAttribute("sign2", sing2);
		model.addAttribute("sign3", sing3);
		model.addAttribute("hr", hr);
		model.addAttribute("mSvhr", mSvhr);
		model.addAttribute("mSv", mSv);
		model.addAttribute("syear", yearStr);
		model.addAttribute("smonth", monthStr);
		model.addAttribute("sdate", dateStr);
		
		return "/monitorSWAA/monitor1";
	}

	@RequestMapping("monitorA.do")
	@ResponseBody
	public Map<String, Object> a(Locale locale, Model model,
			@RequestParam(value = "value", required = true) String param) {

		String params[] = param.split("/");

		String fileNm = params[0];
		String year = params[1];
		String month = params[2];
		String date = params[3];

		String dPath = "/swfc/MDL/SWAA/SUNSPOT/HCP_CALC/Y" + year + "/M"
				+ month + "/D" + date + "/" + fileNm + ".txt";
		String text = "";
		
		try {
			BufferedReader in = new BufferedReader(new FileReader(dPath));
			String s;
			while ((s = in.readLine()) != null) {
				text += s;
			}
			in.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	
		Map<String, Object> result = Maps.newHashMap();
		result.put("calc", text);

		return result;

	}

	// 상황판 2번(기상위성운영 및 전리권 감시 시스템)
	@RequestMapping("monitor2.do")
	public String monitor2(Locale locale, Model model) {
		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
		Calendar calendar2 = Calendar.getInstance(TimeZone.getTimeZone("GMT+9:00"));

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
		
		int year_kst = calendar2.get(Calendar.YEAR);
		int month_kst = calendar2.get(Calendar.MONTH) + 1;
		int date_kst = calendar2.get(Calendar.DATE);
		int hour_kst = calendar2.get(Calendar.HOUR_OF_DAY);
		int minute_kst = calendar2.get(Calendar.MINUTE);

		String yearStr_kst = String.valueOf(year_kst);
		String monthStr_kst = String.valueOf(month_kst);
		String dateStr_kst = String.valueOf(date_kst);
		String hourStr_kst = String.valueOf(hour_kst);
		String minuteStr_kst = String.valueOf(minute_kst);
				
		if(monthStr_kst.length() < 2) monthStr_kst = "0" + monthStr_kst;
		if(dateStr_kst.length() < 2) dateStr_kst = "0" + dateStr_kst;
		if(hourStr_kst.length() < 2) hourStr_kst = "0" + hourStr_kst;
		if(minuteStr_kst.length() < 2) minuteStr_kst = "0" + minuteStr_kst;

		model.addAttribute("year", yearStr);
		model.addAttribute("month", monthStr);
		model.addAttribute("date", dateStr);
		model.addAttribute("hour", hourStr);
		model.addAttribute("minute", minuteStr);
		
		model.addAttribute("year_kst", yearStr_kst);
		model.addAttribute("month_kst", monthStr_kst);
		model.addAttribute("date_kst", dateStr_kst);
		model.addAttribute("hour_kst", hourStr_kst);
		model.addAttribute("minute_kst", minuteStr_kst);

		return "/monitorSWAA/monitor2";
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
	
	@RequestMapping("loadImageSunspot.do")
	public void loadImageSunspot(String type, String airway, String alt, String num,
			String year, String month, String date,
			HttpServletResponse response) {
		try {
			sendImage( response, readImageSunspot(type, year, month, date, alt, airway, num) );
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("loadImageOvation.do")
	public void loadImageOvation(String year, String month, String date, String hour, String minute,
			HttpServletResponse response) {
		try {
			sendImage( response, readImageOvation(year, month, date, hour, minute) );
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("loadImageDrap.do")
	public void loadImageDrap(String year, String month, String date, String hour, String minute,
			HttpServletResponse response) {
		try {
			sendImage( response, readImageDrap(year, month, date, hour, minute) );
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("loadImageMagnetopause.do")
	public void loadImageMagnetopause(String year, String month, String date, String hour, String minute,
			HttpServletResponse response) {
		try {
			sendImage( response, readImageMagnetopause(year, month, date, hour, minute) );
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("loadImageRBSP.do")
	public void loadImageRBSP(String year, String month, String date,
			HttpServletResponse response) {
		try {
			sendImage( response, readImageRBSP(year, month, date) );
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("loadImageTEC.do")
	public void loadImageTEC(String year, String month, String date, String hour, 
			HttpServletResponse response) {
		try {
			sendImage( response, readImageTEC(year, month, date, hour) );
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	byte[] readImageMagnetopause(String yearStr, String monthStr, String dateStr, String hourStr, String minuteStr) throws Exception {
	
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
			filePath = "/swfc/MDL/KHU/MAGPAUSE_FRCT/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/geomag_A_" + yearStr + monthStr + dateStr + hourStr + minuteStr + "00.png";
			imgFile= new File(filePath);			
			while(imgFile.isFile() == false)
			{
				Calendar calendar = Calendar.getInstance();
				calendar.set(year, month - 1, date, hour, minute);
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
				
				filePath = "/swfc/MDL/KHU/MAGPAUSE_FRCT/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/geomag_A_" + yearStr + monthStr + dateStr + hourStr + minuteStr + "00.png";
				imgFile= new File(filePath);
			}
			logger.info(filePath);
			if(imgFile.isFile() == true)
			{
				BUF_SIZE = (int)imgFile.length() ;    
				buf = new byte[BUF_SIZE] ;   
				in = new DataInputStream(new FileInputStream(imgFile));       
				in.readFully(buf);
			}
			else
			{
				buf = new byte[0];
			}
		} finally { 
			in.close();
		}
		return buf;
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
			while(imgFile.isFile() == false)
			{
				Calendar calendar = Calendar.getInstance();
				calendar.set(year, month - 1, date);
				calendar.add(Calendar.DATE, -1);
				
				year = calendar.get(Calendar.YEAR);
				month = calendar.get(Calendar.MONTH) + 1;
				date = calendar.get(Calendar.DATE);

				yearStr = String.valueOf(year);
				monthStr = String.valueOf(month);
				dateStr = String.valueOf(date);
				
				if(monthStr.length() < 2) monthStr = "0" + monthStr;
				if(dateStr.length() < 2) dateStr = "0" + dateStr;
				
				filePath = "/swfc/MDL/SWAA/RBSP/RBSP/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/rbsp.jpg";
				imgFile= new File(filePath);
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
				buf = new byte[0];
			}
		} finally { 
			in.close();
		}
		return buf;
	}
	byte[] readImageTEC(String yearStr, String monthStr, String dateStr, String hourStr) throws Exception {
	
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
			filePath = "/swfc/MDL/SWAA/TEC_KOREA/TEC/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/tec_korea_" + hourStr + ".jpg";
			imgFile= new File(filePath) ;			
			while(imgFile.isFile() == false)
			{
				Calendar calendar = Calendar.getInstance();
				calendar.set(year, month - 1, date, hour, 00);
				calendar.add(Calendar.HOUR_OF_DAY, -1);
				
				year = calendar.get(Calendar.YEAR);
				month = calendar.get(Calendar.MONTH) + 1;
				date = calendar.get(Calendar.DATE);
				hour = calendar.get(Calendar.HOUR_OF_DAY);

				yearStr = String.valueOf(year);
				monthStr = String.valueOf(month);
				dateStr = String.valueOf(date);
				hourStr = String.valueOf(hour);
				
				if(monthStr.length() < 2) monthStr = "0" + monthStr;
				if(dateStr.length() < 2) dateStr = "0" + dateStr;
				if(hourStr.length() < 2) hourStr = "0" + hourStr;
				
				filePath = "/swfc/MDL/SWAA/TEC_KOREA/TEC/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/tec_korea_" + hourStr + ".jpg";
				imgFile= new File(filePath);
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
				buf = new byte[0];
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
			if(imgFile.isFile() == true)
			{
				BUF_SIZE = (int)imgFile.length() ;    
				buf = new byte[BUF_SIZE] ;   
				in = new DataInputStream(new FileInputStream(imgFile));       
				in.readFully(buf);
			}
			else
			{
				buf = new byte[0];
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
						
			while(imgFile.isFile() == false)
			{
				Calendar calendar = Calendar.getInstance();
				calendar.set(year, month - 1, date, hour, minute5);
				calendar.add(Calendar.MINUTE, -5);
				
				year = calendar.get(Calendar.YEAR);
				month = calendar.get(Calendar.MONTH) + 1;
				date = calendar.get(Calendar.DATE);
				hour = calendar.get(Calendar.HOUR_OF_DAY);
				minute = calendar.get(Calendar.MINUTE);
				minute5 = (int)( (int)(minute / 5) * 5 );

				yearStr = String.valueOf(year);
				monthStr = String.valueOf(month);
				dateStr = String.valueOf(date);
				hourStr = String.valueOf(hour);
				minuteStr = String.valueOf(minute);
				minute5Str = String.valueOf(minute5);
						
				if(monthStr.length() < 2) monthStr = "0" + monthStr;
				if(dateStr.length() < 2) dateStr = "0" + dateStr;
				if(hourStr.length() < 2) hourStr = "0" + hourStr;
				if(minuteStr.length() < 2) minuteStr = "0" + minuteStr;
				if(minute5Str.length() < 2) minute5Str = "0" + minute5Str;
				
				filePath = "/swfc/MDL/SWAA/OVATION/OVATION/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/ovation_world_" + hourStr + minute5Str + ".jpg";
				imgFile= new File(filePath);
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
				buf = new byte[0];
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
			while(imgFile.isFile() == false)
			{
				Calendar calendar = Calendar.getInstance();
				calendar.set(year, month - 1, date, hour, minute);
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
				
				filePath = "/swfc/MDL/SWAA/DRAP/DRAP/Y" + yearStr + "/M" + monthStr + "/D" + dateStr + "/drap_" + hourStr + minuteStr + ".jpg";
				imgFile= new File(filePath);
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
				buf = new byte[0];
			}
		} finally { 
			in.close();
		}
		return buf;
	}

	//방사선 순간 피폭량
	@RequestMapping("hcp_world.do")
	public String hcp_world(Locale locale, Model model) {
		return "/monitorSWAA/question/hcp_world";
	}
	//항공로 순간 피폭량
	@RequestMapping("hcp_airway.do")
	public String hcp_airway(Locale locale, Model model) {
		return "/monitorSWAA/question/hcp_airway";
	}
	//극항로 통신 극관
	@RequestMapping("ovation.do")
	public String ovation(Locale locale, Model model) {
		return "/monitorSWAA/question/ovation";
	}	
	//hf통신 전파 지수
	@RequestMapping("drap.do")
	public String hf(Locale locale, Model model) {
		return "/monitorSWAA/question/drap";
	}
	//테이블 
	@RequestMapping("tableInfo.do")
	public String tableInfo(Locale locale, Model model) {
		return "/monitorSWAA/question/tableInfo";
	}
	//상황판그래프1 x선플럭스
	@RequestMapping("graphInfo1.do")
	public String graphInfo1(Locale locale, Model model) {
		return "/monitorSWAA/question/graphInfo1";
	}
	//상황판그래프2 양성자플럭스
	@RequestMapping("graphInfo2.do")
	public String graphInfo2(Locale locale, Model model) {
		return "/monitorSWAA/question/graphInfo2";
	}
	
	//상황판1 우주기상 특보
	@RequestMapping("info1.do")
	public String info1(Locale locale, Model model) { 
		return "/monitorSWAA/question/info1";
	}
	//상황판1 극항로 방사선
	@RequestMapping("info2.do")
	public String info2(Locale locale, Model model) {
		return "/monitorSWAA/question/info2";
	}
	//상황판1 극항로 통신장애
	@RequestMapping("info3.do")
	public String info3(Locale locale, Model model) {
		return "/monitorSWAA/question/infolast";
	}

	//자기권계면 위치
	@RequestMapping("image1.do")
	public String image1(Locale locale, Model model) {
		return "/monitorSWAA/question/image1";
	}
	//RBSP 위성 데이터 2 차원 그림: 지구 자기권 방사선대
	@RequestMapping("rbspInfo.do")
	public String rbspInfo(Locale locale, Model model) {
		return "/monitorSWAA/question/rbspInfo";
	}
	//tec 총전자밀도
	@RequestMapping("tecInfo.do")
	public String tecInfo(Locale locale, Model model) {
		return "/monitorSWAA/question/tecInfo";
	}
	//40 keV 전자플럭스 차트
	@RequestMapping("infoGraph1.do")
	public String infoGraph1(Locale locale, Model model) {
		return "/monitorSWAA/question/infoGraph1";
	}
	//양성자플럭스
	@RequestMapping("infoGraph2.do")
	public String infoGraph2(Locale locale, Model model) {
		return "/monitorSWAA/question/infoGraph2";
	}
	//2MeV 전자플럭스 차트
	@RequestMapping("infoGraph3.do")
	public String infoGraph3(Locale locale, Model model) {
		return "/monitorSWAA/question/infoGraph3";
	}
	//자기권계면차트
	@RequestMapping("infoGraph4.do")
	public String infoGraph4(Locale locale, Model model) {
		return "/monitorSWAA/question/infoGraph4";
	}
	
	//상황판2 우주기상 특보
	@RequestMapping("info2_1.do")
	public String info2_1(Locale locale, Model model) { 
		return "/monitorSWAA/question/info2_1";
	}
	//상황판2 정지궤도위성 대전 영향
	@RequestMapping("info2_2.do")
	public String info2_2(Locale locale, Model model) {
		return "/monitorSWAA/question/info2_2";
	}
	//상황판2 자기권계면
	@RequestMapping("info2_3.do")
	public String info2_3(Locale locale, Model model) {
		return "/monitorSWAA/question/info2_3";
	}
	
	@RequestMapping("chart_popup.do")
	public void chart_popup(Locale locale, Model model) {
	}

}
