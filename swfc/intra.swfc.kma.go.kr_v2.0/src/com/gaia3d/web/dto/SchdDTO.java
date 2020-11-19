package com.gaia3d.web.dto;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

public class SchdDTO {

	private Integer clt_tar_sch_seq_n   ;   //수집대상스케줄일련번호 
	@NotNull
	private Integer clt_tar_seq_n       ;   //수집대상일련번호           

	private Integer clt_tar_grp_seq_n   ;   //수집대상그룹일련번호       
	private String rcv_d               ;   //수신일자                   
	private String rcv_tm              ;   //수신시간                   
	private String rcv_nd_tm           ;   //수신소요시간               
	private Integer rcv_line            ;   //수신라인                   
	private String rcv_fmt             ;   //수신포맷                   
	private String rcv_st_pgm          ;   //수신시시작프로그램         
	private String rcv_cncl_f_cd       ;   //수신취소여부코드           
	private Integer max_hi              ;   //최대고도                   
	private Integer prty_rnk            ;   //우선순위                   
	private String use_f_cd            ;   //사용여부코드               
	private String del_f_cd            ;   //삭제여부코드               
	private Integer rg_k_seq_n          ;   //등록자일련번호             
	private String rg_d                ;   //등록일자                   
	private String rg_tm               ;   //등록시간                   
	private String rg_ip               ;   //등록자아이피               
	private Integer mdf_k_seq_n         ;   //수정자일련번호             
	private String mdf_d               ;   //수정일자                   
	private String mdf_tm              ;   //수정시간                   
	private String mdf_ip              ;   //수정자아이피        
	
	public Integer getClt_tar_sch_seq_n() {
		return clt_tar_sch_seq_n;
	}
	public void setClt_tar_sch_seq_n(Integer clt_tar_sch_seq_n) {
		this.clt_tar_sch_seq_n = clt_tar_sch_seq_n;
	}
	public Integer getClt_tar_seq_n() {
		return clt_tar_seq_n;
	}
	public void setClt_tar_seq_n(Integer clt_tar_seq_n) {
		this.clt_tar_seq_n = clt_tar_seq_n;
	}
	public Integer getClt_tar_grp_seq_n() {
		return clt_tar_grp_seq_n;
	}
	public void setClt_tar_grp_seq_n(Integer clt_tar_grp_seq_n) {
		this.clt_tar_grp_seq_n = clt_tar_grp_seq_n;
	}
	public String getRcv_d() {
		return rcv_d;
	}
	public void setRcv_d(String rcv_d) {
		this.rcv_d = rcv_d;
	}
	public String getRcv_tm() {
		return rcv_tm;
	}
	public void setRcv_tm(String rcv_tm) {
		this.rcv_tm = rcv_tm;
	}
	public String getRcv_nd_tm() {
		return rcv_nd_tm;
	}
	public void setRcv_nd_tm(String rcv_nd_tm) {
		this.rcv_nd_tm = rcv_nd_tm;
	}
	public Integer getRcv_line() {
		return rcv_line;
	}
	public void setRcv_line(Integer rcv_line) {
		this.rcv_line = rcv_line;
	}
	public String getRcv_fmt() {
		return rcv_fmt;
	}
	public void setRcv_fmt(String rcv_fmt) {
		this.rcv_fmt = rcv_fmt;
	}
	public String getRcv_st_pgm() {
		return rcv_st_pgm;
	}
	public void setRcv_st_pgm(String rcv_st_pgm) {
		this.rcv_st_pgm = rcv_st_pgm;
	}
	public String getRcv_cncl_f_cd() {
		return rcv_cncl_f_cd;
	}
	public void setRcv_cncl_f_cd(String rcv_cncl_f_cd) {
		this.rcv_cncl_f_cd = rcv_cncl_f_cd;
	}
	public Integer getMax_hi() {
		return max_hi;
	}
	public void setMax_hi(Integer max_hi) {
		this.max_hi = max_hi;
	}
	public Integer getPrty_rnk() {
		return prty_rnk;
	}
	public void setPrty_rnk(Integer prty_rnk) {
		this.prty_rnk = prty_rnk;
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

	
}
