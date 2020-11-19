package com.gaia3d.web.dto;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class DataKindInsideDTO implements Serializable {
	private Integer dta_knd_inside_seq_n   ;   //자료종류내부일련번호

	private Integer dta_knd_seq_n   ;          //자료종류일련번호
	private String dta_knd_kor_nm  ;          //자료종류한글명
	private String dta_knd_eng_nm  ;          //자료종류영문명

	private Integer dmn_sub_seq_n   ;          //도메인서브일련번호
	private String dmn_sub_kor_nm   ; 			// 도메인 서브 명
	private String dmn_sub_eng_nm   ; 			// 도메인 서브 영문명

	private Integer dmn_seq_n       ;          //도메인일련번호
	private String dmn_kor_nm   ; 				// 도메인  명
	private String dmn_eng_nm   ; 				// 도메인  영문명

	@NotNull(message="한글명을 입력 하세요.")
	private String dta_knd_inside_kor_nm  ;          //자료종류내부한글명
	
//	@NotNull(message="영문명을 입력 하세요.")
//	@Size(min=1,max=50, message="영문명은 최대 50자까지 입력 가능합니다.")
	private String dta_knd_inside_eng_nm  ;          //자료종류내부영문명
	private String dta_knd_inside_desc    ;          //자료종류내부설명

	private String use_f_cd        ;          //사용여부코드
	private String del_f_cd        ;          //삭제여부코드
	private Integer rg_k_seq_n      ;          //등록자일련번호
	private String rg_d            ;          //등록일자
	private String rg_tm           ;          //등록시간
	private String rg_ip           ;          //등록자아이피
	private Integer mdf_k_seq_n     ;          //수정자일련번호
	private String mdf_d           ;          //수정일자
	private String mdf_tm          ;          //수정시간
	private String mdf_ip          ;          //수정자아이피
	private String dta_knd_cd          ;          //코드
	
	public Integer getDta_knd_inside_seq_n() {
		return dta_knd_inside_seq_n;
	}
	public void setDta_knd_inside_seq_n(Integer dta_knd_inside_seq_n) {
		this.dta_knd_inside_seq_n = dta_knd_inside_seq_n;
	}
	public Integer getDta_knd_seq_n() {
		return dta_knd_seq_n;
	}
	public void setDta_knd_seq_n(Integer dta_knd_seq_n) {
		this.dta_knd_seq_n = dta_knd_seq_n;
	}
	public String getDta_knd_kor_nm() {
		return dta_knd_kor_nm;
	}
	public void setDta_knd_kor_nm(String dta_knd_kor_nm) {
		this.dta_knd_kor_nm = dta_knd_kor_nm;
	}
	public Integer getDmn_sub_seq_n() {
		return dmn_sub_seq_n;
	}
	public void setDmn_sub_seq_n(Integer dmn_sub_seq_n) {
		this.dmn_sub_seq_n = dmn_sub_seq_n;
	}
	public String getDmn_sub_kor_nm() {
		return dmn_sub_kor_nm;
	}
	public void setDmn_sub_kor_nm(String dmn_sub_kor_nm) {
		this.dmn_sub_kor_nm = dmn_sub_kor_nm;
	}
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
	public String getDta_knd_inside_kor_nm() {
		return dta_knd_inside_kor_nm;
	}
	public void setDta_knd_inside_kor_nm(String dta_knd_inside_kor_nm) {
		this.dta_knd_inside_kor_nm = dta_knd_inside_kor_nm;
	}
	public String getDta_knd_inside_eng_nm() {
		return dta_knd_inside_eng_nm;
	}
	public void setDta_knd_inside_eng_nm(String dta_knd_inside_eng_nm) {
		this.dta_knd_inside_eng_nm = dta_knd_inside_eng_nm;
	}
	public String getDta_knd_inside_desc() {
		return dta_knd_inside_desc;
	}
	public void setDta_knd_inside_desc(String dta_knd_inside_desc) {
		this.dta_knd_inside_desc = dta_knd_inside_desc;
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
	public String getDta_knd_eng_nm() {
		return dta_knd_eng_nm;
	}
	public void setDta_knd_eng_nm(String dta_knd_eng_nm) {
		this.dta_knd_eng_nm = dta_knd_eng_nm;
	}
	public String getDmn_sub_eng_nm() {
		return dmn_sub_eng_nm;
	}
	public void setDmn_sub_eng_nm(String dmn_sub_eng_nm) {
		this.dmn_sub_eng_nm = dmn_sub_eng_nm;
	}
	public String getDmn_eng_nm() {
		return dmn_eng_nm;
	}
	public void setDmn_eng_nm(String dmn_eng_nm) {
		this.dmn_eng_nm = dmn_eng_nm;
	}
	public String getDta_knd_cd() {
		return dta_knd_cd;
	}
	public void setDta_knd_cd(String dta_knd_cd) {
		this.dta_knd_cd = dta_knd_cd;
	}
	
}
