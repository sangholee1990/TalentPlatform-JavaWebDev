package com.gaia3d.web.dto;

import java.util.Date;

public class FlarePredicationDetail {

	int id;
	Date create_date;
	String cls;
	Integer ar;
	String phase;
	Double c;
	Double m;
	Double x;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}	
	
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public String getCls() {
		return cls;
	}
	public void setCls(String cls) {
		this.cls = cls;
	}
	public Integer getAr() {
		return ar;
	}
	public void setAr(Integer ar) {
		this.ar = ar;
	}
	public String getPhase() {
		return phase;
	}
	public void setPhase(String phase) {
		this.phase = phase;
	}
	public Double getC() {
		return c;
	}
	public void setC(Double c) {
		this.c = c;
	}
	public Double getM() {
		return m;
	}
	public void setM(Double m) {
		this.m = m;
	}
	public Double getX() {
		return x;
	}
	public void setX(Double x) {
		this.x = x;
	}
}
