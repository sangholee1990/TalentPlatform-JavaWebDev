package com.gaia3d.swfc.batch.util;

import java.util.Calendar;

import org.joda.time.LocalDate;
import org.joda.time.LocalDateTime;

public class DateList {

	private LocalDateTime start;
	private LocalDateTime end;
	
	public DateList(Calendar calendar, int timeOffset) {
		LocalDateTime range1 = LocalDateTime.fromCalendarFields(calendar);
		calendar.add(Calendar.MINUTE, timeOffset);
		LocalDateTime range2 = LocalDateTime.fromCalendarFields(calendar);
		
		if (range1.isBefore(range2)) {
			start = range1;
			end = range2;
		} else {
			start = range2;
			end = range1;
		}
	}
	
	public LocalDateRange getDayIterable() {
		LocalDate range1 = start.toLocalDate();
		LocalDate range2 = end.toLocalDate();
		return new LocalDateRange(range1, range2);
	}
	
	public boolean contains(int year, int monthOfYear, int dayOfMonth) {
		return contains(year, monthOfYear, dayOfMonth, 0, 0, 0, 0);
	}

	public boolean contains(int year, int monthOfYear, int dayOfMonth, int hourOfDay) {
		return contains(year, monthOfYear, dayOfMonth, hourOfDay, 0, 0, 0);
	}

	public boolean contains(int year, int monthOfYear, int dayOfMonth, int hourOfDay, int minuteOfHour) {
		return contains(year, monthOfYear, dayOfMonth, hourOfDay, minuteOfHour, 0, 0);
	}
	
	public boolean contains(int year, int monthOfYear, int dayOfMonth, int hourOfDay, int minuteOfHour, int secondOfMinute) {
		return contains(year, monthOfYear, dayOfMonth, hourOfDay, minuteOfHour, secondOfMinute, 0);
	}
	
	public boolean contains(int year, int monthOfYear, int dayOfMonth, int hourOfDay, int minuteOfHour, int secondOfMinute, int millisOfSecond) {
		LocalDateTime dateTime = new LocalDateTime(year, monthOfYear, dayOfMonth, hourOfDay, minuteOfHour, secondOfMinute, millisOfSecond);
		return start.isBefore(dateTime) && end.isAfter(dateTime);
	}
	
	public boolean contains(String date) {
		int length = date.length();
		
		int year = 0;
		int monthOfYear = 0;
		int dayOfMonth = 0;
		int hourOfDay = 0;
		int minuteOfHour= 0;
		int secondOfMinute = 0;
		int millisOfSecond = 0;
		if(length >= 17) {
			millisOfSecond = Integer.parseInt(date.substring(14, 17));
		}
		
		if(length >= 14) {
			secondOfMinute = Integer.parseInt(date.substring(12, 14));
		}
		
		if(length >= 12) {
			minuteOfHour = Integer.parseInt(date.substring(10, 12));
		}

		if(length >= 10) {
			hourOfDay = Integer.parseInt(date.substring(8, 10));
		}

		if(length >= 8) {
			dayOfMonth = Integer.parseInt(date.substring(6, 8));
		}

		if(length >= 6) {
			monthOfYear = Integer.parseInt(date.substring(4, 6));
		}

		if(length >= 4) {
			year = Integer.parseInt(date.substring(0, 4));
		}
		return contains(year, monthOfYear, dayOfMonth, hourOfDay, minuteOfHour, secondOfMinute, millisOfSecond);
	}
	
	@Override
	public String toString() {
		return "From " + start.toString() + ", To:" + end.toString();
	}
}
