/**
 * 
 */
package xRayReInster;

import java.io.Serializable;

/**
 * @author mjhwang
 *
 */
public class ParticleVo implements Serializable {

	private static final long serialVersionUID = 543420358176270434L;

	private String tm;
	private String mjd;
	private String secofday;
	private String p1;
	private String p5;
	private String p10;
	private String p30;
	private String p50;
	private String p100;
	private String e8;
	private String e20;
	private String e40;

	public ParticleVo(String tm, String mjd, String secofday, String p1, String p5, String p10, String p30, String p50, String p100, String e8, String e20, String e40) {
		this.tm = tm;
		this.mjd = mjd;
		this.secofday = secofday;
		this.p1 = p1;
		this.p5 = p5;
		this.p10 = p10;
		this.p30 = p30;
		this.p50 = p50;
		this.p100 = p100;
		this.e8 = e8;
		this.e20 = e20;
		this.e40 = e40;
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

	public String getSecofday() {
		return secofday;
	}

	public void setSecofday(String secofday) {
		this.secofday = secofday;
	}

	public String getP1() {
		return p1;
	}

	public void setP1(String p1) {
		this.p1 = p1;
	}

	public String getP5() {
		return p5;
	}

	public void setP5(String p5) {
		this.p5 = p5;
	}

	public String getP10() {
		return p10;
	}

	public void setP10(String p10) {
		this.p10 = p10;
	}

	public String getP30() {
		return p30;
	}

	public void setP30(String p30) {
		this.p30 = p30;
	}

	public String getP50() {
		return p50;
	}

	public void setP50(String p50) {
		this.p50 = p50;
	}

	public String getP100() {
		return p100;
	}

	public void setP100(String p100) {
		this.p100 = p100;
	}

	public String getE8() {
		return e8;
	}

	public void setE8(String e8) {
		this.e8 = e8;
	}

	public String getE20() {
		return e20;
	}

	public void setE20(String e20) {
		this.e20 = e20;
	}

	public String getE40() {
		return e40;
	}

	public void setE40(String e40) {
		this.e40 = e40;
	}

	@Override
	public String toString() {
		return "ParticleVo [tm=" + tm + ", mjd=" + mjd + ", secofday=" + secofday + ", p1=" + p1 + ", p5=" + p5
				+ ", p10=" + p10 + ", p30=" + p30 + ", p50=" + p50 + ", p100=" + p100 + ", e8=" + e8 + ", e20=" + e20
				+ ", e40=" + e40 + "]";
	}

}
