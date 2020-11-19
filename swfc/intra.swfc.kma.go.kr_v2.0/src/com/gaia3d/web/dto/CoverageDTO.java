package com.gaia3d.web.dto;

import java.io.Serializable;

public class CoverageDTO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4040293889518185605L;
	private Integer coverage_seq_n      ; //범위일련번호  
	private String coverage_kor_nm     ; //범위한글명    
	private String coverage_eng_nm     ; //범위영문명    
	private String coverage_desc       ; //범위설명      
	private String use_f_cd            ; //사용여부코드  
	private String del_f_cd            ; //삭제여부코드  
	private Integer rg_k_seq_n          ; //등록자일련번호
	private String rg_d                ; //등록일자      
	private String rg_tm               ; //등록시간      
	private String rg_ip               ; //등록자아이피  
	private Integer mdf_k_seq_n         ; //수정자일련번호
	private String mdf_d               ; //수정일자      
	private String mdf_tm              ; //수정시간      
	private String mdf_ip              ; //수정자아이피  
	private String coverage_cd              ; //코드 
	
	public Integer getCoverage_seq_n() {
		return coverage_seq_n;
	}
	public void setCoverage_seq_n(Integer coverage_seq_n) {
		this.coverage_seq_n = coverage_seq_n;
	}
	public String getCoverage_kor_nm() {
		return coverage_kor_nm;
	}
	public void setCoverage_kor_nm(String coverage_kor_nm) {
		this.coverage_kor_nm = coverage_kor_nm;
	}
	public String getCoverage_eng_nm() {
		return coverage_eng_nm;
	}
	public void setCoverage_eng_nm(String coverage_eng_nm) {
		this.coverage_eng_nm = coverage_eng_nm;
	}
	public String getCoverage_desc() {
		return coverage_desc;
	}
	public void setCoverage_desc(String coverage_desc) {
		this.coverage_desc = coverage_desc;
	}
	public String getUse_f_cd() {
		return use_f_cd;
	}
	public void setUse_f_cd(String use_f_cd) {
		this.use_f_cd = use_f_cd;
	}
	public String getDel_f_cd() {
		return del_f_cd;
	}
	public void setDel_f_cd(String del_f_cd) {
		this.del_f_cd = del_f_cd;
	}
	public Integer getRg_k_seq_n() {
		return rg_k_seq_n;
	}
	public void setRg_k_seq_n(Integer rg_k_seq_n) {
		this.rg_k_seq_n = rg_k_seq_n;
	}
	public String getRg_d() {
		return rg_d;
	}
	public void setRg_d(String rg_d) {
		this.rg_d = rg_d;
	}
	public String getRg_tm() {
		return rg_tm;
	}
	public void setRg_tm(String rg_tm) {
		this.rg_tm = rg_tm;
	}
	public String getRg_ip() {
		return rg_ip;
	}
	public void setRg_ip(String rg_ip) {
		this.rg_ip = rg_ip;
	}
	public Integer getMdf_k_seq_n() {
		return mdf_k_seq_n;
	}
	public void setMdf_k_seq_n(Integer mdf_k_seq_n) {
		this.mdf_k_seq_n = mdf_k_seq_n;
	}
	public String getMdf_d() {
		return mdf_d;
	}
	public void setMdf_d(String mdf_d) {
		this.mdf_d = mdf_d;
	}
	public String getMdf_tm() {
		return mdf_tm;
	}
	public void setMdf_tm(String mdf_tm) {
		this.mdf_tm = mdf_tm;
	}
	public String getMdf_ip() {
		return mdf_ip;
	}
	public void setMdf_ip(String mdf_ip) {
		this.mdf_ip = mdf_ip;
	}
	public String getCoverage_cd() {
		return coverage_cd;
	}
	public void setCoverage_cd(String coverage_cd) {
		this.coverage_cd = coverage_cd;
	}
	
	
}
