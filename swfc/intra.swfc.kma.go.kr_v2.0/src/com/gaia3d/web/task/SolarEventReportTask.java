package com.gaia3d.web.task;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.scheduling.support.CronSequenceGenerator;
import org.springframework.stereotype.Component;

import com.gaia3d.web.dto.SolarEventReportDTO;
import com.gaia3d.web.service.SolarEventReportService;

@Component
public class SolarEventReportTask {
	
	
	private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	
	@Autowired
	private SolarEventReportService solarEventService;
	
	@Value("${solar.event.report.path}")
	private String eventPath;
		
	/**
	 * 실제 업데이트 (매일 매시 2분, 32분)
	 * 오늘 파일 DB 저장 (매일 매시 5분, 35분)
	 * @return 
	 * @throws Exception 
	 * */
	public void insertToday() throws Exception{
		TimeZone utc = TimeZone.getTimeZone("UTC");
		Calendar today = Calendar.getInstance(utc);
		checkInsertEvent(today);
	}//insertToday end
	
	/**
	 * 실제 업데이트 (매일 3시간 간격 27분)
	 * 어제 파일 체크 DB 저장	(매일  3시간 간격 32분에)
	 * @return 
	 * @throws Exception 
	 * 
	 * */
	public void insertYesterDay() throws Exception{
		TimeZone utc = TimeZone.getTimeZone("UTC");
		Calendar yesterDay = Calendar.getInstance(utc);
		yesterDay.add(Calendar.DATE, -1);
		checkInsertEvent(yesterDay);
	}
	
	/**
	 * 실제 업데이트(UTC 매일 03시 57분)
	 * 매일 13시 10분에 지난 3일간 파일 체크
	 * @return
	 * @throws
	 * */
	public void insertThreeDay() throws Exception{
		TimeZone utc = TimeZone.getTimeZone("UTC");
		Calendar threeDay = Calendar.getInstance(utc);
		for (int i = 0; i < 3; i++) {
			threeDay.add(Calendar.DATE, -1);
			checkInsertEvent(threeDay);
		}
	}
	
	/**
	 * 파일 체크 후 넣기
	 * @return 
	 * @throws Exception 
	 * */
	public void checkInsertEvent(Calendar cal) throws Exception{
		String fileDate = sdf.format(cal.getTime());
		String year = fileDate.substring(0,4);
		String month = fileDate.substring(4,6);
		String path = eventPath + File.separator + "Y" + year + File.separator + "M" + month;
		try{
			File file = new File(path, fileDate + "events.txt");
			if(file.exists() && file.isFile()){
				insertFile(file);
			}
		}catch(Exception e){
			throw e;
		}
	}//checkInsertEvent end
	
	/**
	 * DB INSERT
	 * @return 
	 * @throws Exception 
	 * */
	public void insertFile(File file) throws Exception{
		BufferedReader in = null;
		
		try{
			in = new BufferedReader(new FileReader(file));
			String str = null;
			String fileDate = file.getName().substring(0,8);
			int maxLine = solarEventService.selectMaxLine(fileDate);
			int line = 1;
			SolarEventReportDTO event = null;
			while ((str = in.readLine()) != null) {
				if(!str.trim().equals("") && str.length() > 17 && line > maxLine){
					if(event == null){
						event = new SolarEventReportDTO();					
					}
					event.setFileDate(fileDate);
					event.setEventTime(str.substring(0, 4).trim());
					event.setEventSign(str.substring(5, 6).trim());
					event.setBeginTime(str.substring(11, 15).trim());
					event.setBeginCode(str.substring(10, 11).trim());
					event.setMaxTime(str.substring(18, 22).trim());
					event.setMaxCode(str.substring(17, 18).trim());
					event.setEndTime(str.substring(28, 32).trim());
					event.setEndCode(str.substring(27, 28).trim());
					event.setObservatory(str.substring(34, 37).trim());
					event.setQuality( str.substring(39, 40).trim());	
					event.setType(str.substring(43, 46).trim());
					event.setLocOrfrq(str.substring(48, 58).trim());
					event.setParticulars(str.substring(58, 66).trim());
					event.setParticularsEtc(str.substring(66, 76).trim());
					event.setRegTime(str.substring(76, 80).trim());
					event.setLine(line); 
					solarEventService.insert(event);
				}//if end
				line++;
			}//while end
			
		}catch(Exception e){
			throw e;
		}finally{
			if(in != null)try{ in.close(); }catch(Exception e){}
		}
	}//insertFile end
	
	
	/**
	 * 매월 1일  이전달 파일 체크  DB저장
	 * @return 
	 * @throws Exception 
	 * */
//	public void insertBeforeMonth() throws Exception{
//		Calendar beforeMonth = Calendar.getInstance();
//		beforeMonth.add(Calendar.MONTH, -1);
//		String beforeDate = sdf.format(beforeMonth.getTime());
//		String year = beforeDate.substring(0,4);
//		String month = beforeDate.substring(4,6);
//		String path = eventPath + File.separator + "Y" + year + File.separator + "M" + month;
//		try{
//			File dir = new File(path);
//			if(dir.exists() && dir.isDirectory()){
//				File[] fileList = dir.listFiles();
//				for (int i = 0; i < fileList.length; i++) {
//					File file = fileList[i];
//					if(file.exists() && file.isFile()){
//						insertFile(file);					
//					}
//				}//for end
//			}//if end
//		}catch(Exception e){
//			throw e;
//		}
//	}//insertBeforeMonth end
	
	/**
	 * 모든 파일 체크 후 DB 저장
	 * @return 
	 * @throws Exception 
	 * */
//	public void insertCheckAll() throws Exception{
//		File dir = new File(eventPath);
//		if(dir.exists()){
//			File[] year = dir.listFiles();
//			for (int i = 0; i < year.length; i++) {
//				if(year[i].isDirectory()){
//					File[] month = year[i].listFiles();
//					for (int j = 0; j < month.length; j++) {
//						if(month[j].isDirectory()){
//							File[] fileList = month[j].listFiles();
//							for (int k = 0; k < fileList.length; k++) {
//								File file = fileList[k];
//								BufferedReader in = new BufferedReader(new FileReader(file));
//								String str = null;
//								String fileDate = file.getName().substring(0,8);
//								int maxLine = solarEventService.selectMaxLine(fileDate);
//								int line = 1;
//								while ((str = in.readLine()) != null) {
//									if(!str.trim().equals("") && str.length() > 17 && line > maxLine){
//										SolarEventReportDTO event = new SolarEventReportDTO();
//										event.setFileDate(fileDate);
//										event.setEventTime(str.substring(0, 4).trim());
//										event.setEventSign(str.substring(5, 6).trim());
//										event.setBeginTime(str.substring(11, 15).trim());
//										event.setBeginCode(str.substring(10, 11).trim());
//										event.setMaxTime(str.substring(18, 22).trim());
//										event.setMaxCode(str.substring(17, 18).trim());
//										event.setEndTime(str.substring(28, 32).trim());
//										event.setEndCode(str.substring(27, 28).trim());
//										event.setObservatory(str.substring(34, 37).trim());
//										event.setQuality( str.substring(39, 40).trim());	
//										event.setType(str.substring(43, 46).trim());
//										event.setLocOrfrq(str.substring(48, 58).trim());
//										event.setParticulars(str.substring(58, 66).trim());
//										event.setParticularsEtc(str.substring(66, 76).trim());
//										event.setRegTime(str.substring(76, 80).trim());
//										event.setLine(line); 
//										solarEventService.insert(event);
//									}//if end
//									line++;
//							    }//while end
//							    in.close();
//							}//for end
//						}//if end
//					}//for end
//				}//if end
//			}//for end
//		}//if end
//	}//insertCheckAll end
	
}//class end 