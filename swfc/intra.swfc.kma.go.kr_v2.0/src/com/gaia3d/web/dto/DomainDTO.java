package com.gaia3d.web.dto;

import java.io.Serializable;

import org.hibernate.validator.constraints.NotBlank;

public class DomainDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -28057818228882686L;
	private Integer dmn_seq_n      ;		//도메인일련번호
	@NotBlank
	private String dmn_kor_nm     ;		//도메인한글명
	private String dmn_eng_nm     ;		//도메인영문명
	private String dmn_desc       ;		//도메인설명
	
	private String use_f_cd       ;		//사용여부코드
	private String del_f_cd       ;		//삭제여부코드
	private Integer rg_k_seq_n     ;		//등록자일련번호
	private String rg_d           ;		//등록일자
	private String rg_tm          ;		//등록시간
	private String rg_ip          ;		//등록자아이피
	private Integer mdf_k_seq_n    ;		//수정자일련번호
	private String mdf_d          ;		//수정일자
	private String mdf_tm         ;		//수정시간
	private String mdf_ip         ;		//수정자아이피
	private String dmn_cd         ;		//코드
	
	public Integer getDmn_seq_n() {
		return dmn_seq_n;
	}
	public void setDmn_seq_n(Integer dmn_seq_n) {
		this.dmn_seq_n = dmn_seq_n;
	}
	public String getDmn_kor_nm() {
		return dmn_kor_nm;
	}
	public void setDmn_kor_nm(String dmn_kor_nm) {
		this.dmn_kor_nm = dmn_kor_nm;
	}
	public String getDmn_eng_nm() {
		return dmn_eng_nm;
	}
	public void setDmn_eng_nm(String dmn_eng_nm) {
		this.dmn_eng_nm = dmn_eng_nm;
	}
	public String getDmn_desc() {
		return dmn_desc;
	}
	public void setDmn_desc(String dmn_desc) {
		this.dmn_desc = dmn_desc;
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
	public String getDmn_cd() {
		return dmn_cd;
	}
	public void setDmn_cd(String dmn_cd) {
		this.dmn_cd = dmn_cd;
	}
	
}
