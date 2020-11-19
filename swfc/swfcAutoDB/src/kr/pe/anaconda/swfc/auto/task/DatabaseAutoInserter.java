package kr.pe.anaconda.swfc.auto.task;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;

import kr.pe.anaconda.swfc.auto.dao.SwfcDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class DatabaseAutoInserter {
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	private static SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	
	
	static {
		sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
		sdf2.setTimeZone(TimeZone.getTimeZone("UTC"));
	}
	
	@Autowired
	private SwfcDao swfcDao;
	
	//@Scheduled(fixedDelay="#{scheduler['scheduled.monitor.http.fixedDelay']}") //몇 초 마다 실행할지 주기 정하기 1/1000 초
	//@Scheduled(cron=@Value("#{scheduler['scheduled.monitor.http.cron']}")) //크론탭과 같은 설정 방법
	//@Scheduled(cron = "#schedulerConfig${scheduled.monitor.http.cron}")
	@Scheduled(cron="0 0/1 * * * *")
	public void xrayTask(){
		String toDate = sdf.format(new Date());
		String fromDate = getTmDate();
		System.out.printf("xray db insert data from date %s to date %s\n", fromDate, toDate);
		Map<String, String> params = new HashMap<String, String>();
		params.put("toDate", toDate);
		params.put("tm", getTmDate());
		swfcDao.insertXray(params);
		//System.out.println( "xray==>" + getTmDate());
	}
	
	@Scheduled(cron="0 0,5,10,15,20,25,30,35,40,45,50,55 * * * *")
	public void protonTask(){
		String toDate = sdf.format(new Date());
		String fromDate = getTmDate();
		System.out.printf("proton db insert data from date %s to date %s\n", fromDate, toDate);
		Map<String, String> params = new HashMap<String, String>();
		params.put("toDate", toDate);
		params.put("tm", getTmDate());
		swfcDao.insertProton(params);
	}
	
	@Scheduled(cron="0 0 0/1 * * *")
	public void kpTask(){
		String toDate = sdf.format(new Date());
		String fromDate = getTmDate();
		System.out.printf("kp db insert data from date %s to date %s\n", fromDate, toDate);
		//String toDate = sdf.format(new Date());
		//System.out.println( "kpTask==>" + getTmDate());
		Map<String, String> params = new HashMap<String, String>();
		params.put("toDate", toDate);
		params.put("tm", getTmDate());
		swfcDao.insertKp(params);
	}
	
	//1분마다.
	@Scheduled(cron="0 0/1 * * * *")
	public void mpTask(){
		String toDate = sdf.format(new Date());
		String fromDate = getTmDate();
		System.out.printf("mp db insert data from date %s to date %s\n", fromDate, toDate);
		Map<String, String> params = new HashMap<String, String>();
		params.put("toDate", toDate);
		params.put("tm", getTmDate());
		swfcDao.insertMp(params);
	}
	
	//1분마다.
	@Scheduled(cron="0 0/1 * * * *")
	public void aceTask(){
		String toDate = sdf.format(new Date());
		String fromDate = getTmDate();
		System.out.printf("TB_ACE_MAG, TB_ACE_SWEPAM db insert data from date %s to date %s\n", fromDate, toDate);
		Map<String, String> params = new HashMap<String, String>();
		params.put("toDate", toDate);
		params.put("tm", getTmDate());
		swfcDao.insertAceMag(params);
		swfcDao.insertAceSwepam(params);
	}
	
	//1시간마다.
	@Scheduled(cron="0 0 0/1 * * *")
	public void distTask(){
		String toDate = sdf.format(new Date());
		String fromDate = getTmDate();
		System.out.printf("TB_DST_INDEX db insert data from date %s to date %s\n", fromDate, toDate);
		Map<String, String> params = new HashMap<String, String>();
		params.put("toDate", toDate);
		params.put("tm", fromDate);
		swfcDao.insertDist(params);
	}
	//1시간마다.
	@Scheduled(cron="0 0 0/1 * * *")
	public void distKhuTask(){
		String toDate = sdf.format(new Date());
		String fromDate = getTmDate();
		System.out.printf("TB_DST_INDEX_KHU db insert data from date %s to date %s\n", fromDate, toDate);
		Map<String, String> params = new HashMap<String, String>();
		params.put("toDate", toDate);
		params.put("tm", fromDate);
		swfcDao.insertDistKHU(params);
	}
	
	//매일 1시에.
	@Scheduled(cron="0 0 1 * * ?")
	//@Scheduled(cron="0 0/1 * * * ?")
	public void flarePredicationTask(){
		String toDate = sdf2.format(new Date());
		String fromDate = getDate();
		System.out.printf("TB_FLARE_PREDICATION db insert data from date %s to date %s\n", fromDate, toDate);
		Map<String, String> params = new HashMap<String, String>();
		params.put("toDate", toDate);
		params.put("tm", fromDate);
		swfcDao.insertFlarePredication(params);
	}
	
	private String getTmDate(){
		Date toDate = new Date();
		toDate.setMonth(4);
		return sdf.format(toDate);
	}
	
	private String getDate(){
		Date toDate = new Date();
		toDate.setMonth(4);
		return sdf2.format(toDate);
	}

}
