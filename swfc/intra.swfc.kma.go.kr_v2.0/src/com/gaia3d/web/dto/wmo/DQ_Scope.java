package com.gaia3d.web.dto.wmo;

public class DQ_Scope {
	private Integer scopeseqn       ;          //Scope일련번호
	private Integer dataqualityseqn ;          //DataQuality일련번호
	private String levels          ;          //계층적레벨 Code
	public Integer getScopeseqn() {
		return scopeseqn;
	}
	public void setScopeseqn(Integer scopeseqn) {
		this.scopeseqn = scopeseqn;
	}
	public Integer getDataqualityseqn() {
		return dataqualityseqn;
	}
	public void setDataqualityseqn(Integer dataqualityseqn) {
		this.dataqualityseqn = dataqualityseqn;
	}
	public String getLevels() {
		return levels;
	}
	public void setLevels(String levels) {
		this.levels = levels;
	}
	
	
}
