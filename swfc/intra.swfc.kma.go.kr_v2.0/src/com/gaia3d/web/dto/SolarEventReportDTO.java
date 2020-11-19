package com.gaia3d.web.dto;

public class SolarEventReportDTO {
	private String fileDate;
	private String eventTime;
	private String eventSign;
	private String beginTime;
	private String beginCode;
	private String maxTime;
	private String maxCode;
	private String endTime;
	private String endCode;
	private String observatory;
	private String quality;
	private String type;
	private String locOrfrq;
	private String particulars;
	private String particularsEtc;
	private String regTime;
	private int line;
	
	public String getFileDate() {
		return fileDate;
	}
	public void setFileDate(String fileDate) {
		this.fileDate = fileDate;
	}
	public String getEventTime() {
		return eventTime == null? "":eventTime;
	}
	public void setEventTime(String eventTime) {
		this.eventTime = eventTime;
	}
	public String getEventSign() {
		return eventSign == null? "":eventSign;
	}
	public void setEventSign(String eventSign) {
		this.eventSign = eventSign;
	}
	public String getBeginTime() {
		return beginTime == null? "":beginTime;
	}
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}
	public String getBeginCode() {
		return beginCode == null? "":beginCode;
	}
	public void setBeginCode(String beginCode) {
		this.beginCode = beginCode;
	}
	public String getMaxTime() {
		return maxTime == null? "":maxTime;
	}
	public void setMaxTime(String maxTime) {
		this.maxTime = maxTime;
	}
	public String getMaxCode() {
		return maxCode == null? "":maxCode;
	}
	public void setMaxCode(String maxCode) {
		this.maxCode = maxCode;
	}
	public String getEndTime() {
		return endTime == null? "":endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getEndCode() {
		return endCode == null? "":endCode;
	}
	public void setEndCode(String endCode) {
		this.endCode = endCode;
	}
	public String getObservatory() {
		return observatory == null? "":observatory;
	}
	public void setObservatory(String observatory) {
		this.observatory = observatory;
	}
	public String getQuality() {
		return  quality == null? "":quality;
	}
	public void setQuality(String quality) {
		this.quality = quality;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getLocOrfrq() {
		return locOrfrq == null? "":locOrfrq;
	}
	public void setLocOrfrq(String locOrfrq) {
		this.locOrfrq = locOrfrq;
	}
	public String getParticulars() {
		return particulars == null? "":particulars;
	}
	public void setParticulars(String particulars) {
		this.particulars = particulars;
	}
	public String getParticularsEtc() {
		return particularsEtc == null? "":particularsEtc;
	}
	public void setParticularsEtc(String particularsEtc) {
		this.particularsEtc = particularsEtc;
	}
	public String getRegTime() {
		return regTime == null? "":regTime;
	}
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}
	public int getLine() {
		return line;
	}
	public void setLine(int line) {
		this.line = line;
	}
	
	
	
}//class end
