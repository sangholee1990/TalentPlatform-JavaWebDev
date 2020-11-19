package egovframework.rte.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtils extends org.apache.commons.lang.time.DateUtils {
	
	
	private static SimpleDateFormat SDF = new SimpleDateFormat("yyyyMMddHH");
	
	private DateUtils(){}
	
	/**
	 * 두 날짜의 간격을 구한다.
	 * @param d1 비교 날짜 
	 * @param d2 비교 날짜
	 * @return d1의 날짜에서 d2 날짜를 뺀 날수
	 */
	public static int daysBetween(Date d1, Date d2){
		return (int)( (d2.getTime() - d1.getTime()) / (1000 * 60 * 60 * 24));
	}
	
	public static void main(String[] args){
		/*
		Calendar cal = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		cal2.set(Calendar.DATE, cal2.get(Calendar.DATE) - 1);
		
		
		System.out.println(daysBetween(cal.getTime(), cal2.getTime()));
		
		
		System.out.println(daysBetween(cal2.getTime(), cal.getTime()));
		2014080408&ed=2014080508
		*/
		
		try {
			Date sDate = SDF.parse("2014080408");
			Date eDate = SDF.parse("2014080508");
			System.out.println(
			daysBetween(sDate, eDate)
					);
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	

}
