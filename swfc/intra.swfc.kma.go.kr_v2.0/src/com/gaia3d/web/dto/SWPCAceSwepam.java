package com.gaia3d.web.dto;

public class SWPCAceSwepam extends ChartData {

	int s;
	double pro_dens;
	double bulk_spd;
	double ion_temp;
	
	public int getS() {
		return s;
	}
	public void setS(int s) {
		this.s = s;
	}
	public double getPro_dens() {
		return pro_dens;
	}
	public void setPro_dens(double pro_dens) {
		this.pro_dens = pro_dens;
	}
	public double getBulk_spd() {
		return bulk_spd;
	}
	public void setBulk_spd(double bulk_spd) {
		this.bulk_spd = bulk_spd;
	}
	public double getIon_temp() {
		return ion_temp;
	}
	public void setIon_temp(double ion_temp) {
		this.ion_temp = ion_temp;
	}
}
