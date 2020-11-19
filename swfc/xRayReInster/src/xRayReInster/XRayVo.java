/**
 * 
 */
package xRayReInster;

import java.io.Serializable;

/**
 * @author mjhwang
 *
 */
public class XRayVo implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5970177022059843993L;
	
	private String tm = null;
	private String mjd = null;
	private String secofday = null;
	private String shortFlux = null;
	private String longFlux = null;
	
	public XRayVo(String tm, String mjd, String secofday, String shortFlux, String longFlux){
		this.tm = tm;
		this.mjd = mjd;
		this.secofday = secofday;
		this.shortFlux = shortFlux;
		this.longFlux = longFlux;
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
	public String getShortFlux() {
		return shortFlux;
	}
	public void setShortFlux(String shortFlux) {
		this.shortFlux = shortFlux;
	}
	public String getLongFlux() {
		return longFlux;
	}
	public void setLongFlux(String longFlux) {
		this.longFlux = longFlux;
	}

	@Override
	public String toString() {
		return "XRayVo [tm=" + tm + ", mjd=" + mjd + ", secofday=" + secofday + ", shortFlux=" + shortFlux
				+ ", longFlux=" + longFlux + "]";
	}
	
	
	
}
