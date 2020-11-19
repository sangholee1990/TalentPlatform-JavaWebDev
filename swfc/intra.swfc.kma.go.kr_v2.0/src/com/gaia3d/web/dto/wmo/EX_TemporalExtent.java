package com.gaia3d.web.dto.wmo;

public class EX_TemporalExtent {
	private Integer temporalextentseqn;        //TemporalExtent일련번호
	private Integer extentseqn        ;        //Extent일련번호
	private String extent            ;        //자료일시
	
	public Integer getTemporalextentseqn() {
		return temporalextentseqn;
	}
	public void setTemporalextentseqn(Integer temporalextentseqn) {
		this.temporalextentseqn = temporalextentseqn;
	}
	public Integer getExtentseqn() {
		return extentseqn;
	}
	public void setExtentseqn(Integer extentseqn) {
		this.extentseqn = extentseqn;
	}
	public String getExtent() {
		return extent;
	}
	public void setExtent(String extent) {
		this.extent = extent;
	}
}
