package com.gaia3d.web.dto;

import java.util.Date;

public class DictionaryDTO {
	
	Integer wrd_dic_seq_n;							// 고유번호
	String simple_nm;								// 줄임명
	String kor_nm;									// 국문명
	String eng_nm;									// 영문명
	String wrd_desc;								// 설명
	Date reg_dt;									// 등록일자
	Date up_dt;										// 수정일자
	
	public Integer getWrd_dic_seq_n() {
		return wrd_dic_seq_n;
	}
	public void setWrd_dic_seq_n(Integer wrd_dic_seq_n) {
		this.wrd_dic_seq_n = wrd_dic_seq_n;
	}
	public String getSimple_nm() {
		return simple_nm;
	}
	public void setSimple_nm(String simple_nm) {
		this.simple_nm = simple_nm;
	}
	public String getKor_nm() {
		return kor_nm;
	}
	public void setKor_nm(String kor_nm) {
		this.kor_nm = kor_nm;
	}
	public String getEng_nm() {
		return eng_nm;
	}
	public void setEng_nm(String eng_nm) {
		this.eng_nm = eng_nm;
	}
	public String getWrd_desc() {
		return wrd_desc;
	}
	public void setWrd_desc(String wrd_desc) {
		this.wrd_desc = wrd_desc;
	}
	public Date getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(Date reg_dt) {
		this.reg_dt = reg_dt;
	}
	public Date getUp_dt() {
		return up_dt;
	}
	public void setUp_dt(Date up_dt) {
		this.up_dt = up_dt;
	}
}