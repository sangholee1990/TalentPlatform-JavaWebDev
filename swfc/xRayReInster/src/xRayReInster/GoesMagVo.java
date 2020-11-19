package xRayReInster;

import java.io.Serializable;

public class GoesMagVo implements Serializable {

	private static final long serialVersionUID = 9011542425249668721L;
	
	private String tm;
	private String mjd;
	private String secofDay;
	private String hp;
	private String he;
	private String hn;
	private String totalFld;
	
	public GoesMagVo(String tm, String mjd, String secofDay, String hp, String he, String hn, String totalFld){
		this.tm = tm;
		this.mjd = mjd;
		this.secofDay = secofDay;
		this.hp = hp;
		this.he = he;
		this.hn = hn;
		this.totalFld = totalFld;
	}
	
	public String getTm() {
		return tm;
	}
	public void setTm(String tm) {
		this.tm = tm;
	}
	public String getMjd() {
		return mjd;
	}
	public void setMjd(String mjd) {
		this.mjd = mjd;
	}
	public String getSecofDay() {
		return secofDay;
	}
	public void setSecofDay(String secofDay) {
		this.secofDay = secofDay;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getHe() {
		return he;
	}
	public void setHe(String he) {
		this.he = he;
	}
	public String getHn() {
		return hn;
	}
	public void setHn(String hn) {
		this.hn = hn;
	}
	public String getTotalFld() {
		return totalFld;
	}
	public void setTotalFld(String totalFld) {
		this.totalFld = totalFld;
	}
	@Override
	public String toString() {
		return "GoesMagVo [tm=" + tm + ", mjd=" + mjd + ", secofDay=" + secofDay + ", hp=" + hp + ", he=" + he + ", hn="
				+ hn + ", totalFld=" + totalFld + "]";
	}
}
