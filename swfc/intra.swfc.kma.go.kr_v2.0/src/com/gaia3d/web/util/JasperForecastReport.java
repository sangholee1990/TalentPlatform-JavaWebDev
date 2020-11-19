package com.gaia3d.web.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

public class JasperForecastReport {

	private String title;
	private String writer;
	private Date publishDate;

	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getWriter() {
		return writer;
	}


	public void setWriter(String writer) {
		this.writer = writer;
	}


	public Date getPublishDate() {
		return publishDate;
	}


	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	}
	
	public static Collection<JasperForecastReport> getForecastReportList() {
		List<JasperForecastReport> reports = new ArrayList<JasperForecastReport>();
		JasperForecastReport report = new JasperForecastReport();
		report.setTitle("우주기상 통보");
		report.setWriter("김태영");
		report.setPublishDate(new Date());
		reports.add(report);
		return reports;
	}
}
