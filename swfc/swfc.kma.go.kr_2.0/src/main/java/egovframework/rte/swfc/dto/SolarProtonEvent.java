package egovframework.rte.swfc.dto;

import java.util.Date;

public class SolarProtonEvent {

	Date start_date;
	Date stop_date;
	Date peak_date;
	Date arr_date;
	
	String gcls;
	String position;
	Double probab;
	Double pkflux;
	Double arr_tm;
	Integer spot;
	
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getStop_date() {
		return stop_date;
	}
	public void setStop_date(Date stop_date) {
		this.stop_date = stop_date;
	}
	public Date getPeak_date() {
		return peak_date;
	}
	public void setPeak_date(Date peak_date) {
		this.peak_date = peak_date;
	}
	public Date getArr_date() {
		return arr_date;
	}
	public void setArr_date(Date arr_date) {
		this.arr_date = arr_date;
	}
	public String getGcls() {
		return gcls;
	}
	public void setGcls(String gcls) {
		this.gcls = gcls;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public Double getProbab() {
		return probab;
	}
	public void setProbab(Double probab) {
		this.probab = probab;
	}
	public Double getPkflux() {
		return pkflux;
	}
	public void setPkflux(Double pkflux) {
		this.pkflux = pkflux;
	}
	public Double getArr_tm() {
		return arr_tm;
	}
	public void setArr_tm(Double arr_tm) {
		this.arr_tm = arr_tm;
	}
	public Integer getSpot() {
		return spot;
	}
	public void setSpot(Integer spot) {
		this.spot = spot;
	}
}
