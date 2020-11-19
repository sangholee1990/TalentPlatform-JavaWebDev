package com.gaia3d.web.dto.wmo;

public class LI_Lineage {
	private Integer lineageseqn      ;         //Lineage일련번호
	private Integer dataqualityseqn  ;         //DataQuality일련번호
	private String statement        ;         //일반적설명
	public Integer getLineageseqn() {
		return lineageseqn;
	}
	public void setLineageseqn(Integer lineageseqn) {
		this.lineageseqn = lineageseqn;
	}
	public Integer getDataqualityseqn() {
		return dataqualityseqn;
	}
	public void setDataqualityseqn(Integer dataqualityseqn) {
		this.dataqualityseqn = dataqualityseqn;
	}
	public String getStatement() {
		return statement;
	}
	public void setStatement(String statement) {
		this.statement = statement;
	}
	
	
}
