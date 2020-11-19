package com.gaia3d.web.dto;

import java.io.Serializable;

import org.hibernate.validator.constraints.NotBlank;

public class BandDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2982854779513698293L;

	private Integer clt_tar_band_seq_n        	   ; // 수집대상밴드일련번호           
	
	private String  clt_tar_sensor_kor_nm 		   ; // 센서 한글명
	private Integer clt_tar_sensor_seq_n      	   ; // 수집대상센서일련번호           
	
	private String clt_tar_band_grp_kor_nm		   ; // 밴드 그룹명
	private String clt_tar_band_grp_eng_nm		   ; // 밴드 그룹명
	private Integer clt_tar_band_grp_seq_n    	   ; // 수집대상밴드그룹일련번호       
	
	@NotBlank
	private String clt_tar_band_kor_nm       	   ; // 수집대상밴드한글명             
	@NotBlank
	private String clt_tar_band_eng_nm       	   ; // 수집대상밴드영문명             

	private String clt_tar_band_desc         	   ; // 수집대상밴드설명               
	private String clt_tar_band_frqc_bandwidth	   ; // 수집대상밴드주파수대역폭       
	private Integer clt_tar_band_width_sz     	   ; // 수집대상밴드가로크기           
	private Integer clt_tar_band_hgt_sz       	   ; // 수집대상밴드세로크기           
	private float clt_tar_band_res          	   ; // 수집대상밴드해상도             
	private String clt_tar_band_cen_frqc     	   ; // 수집대상밴드중심주파수         
	private String use_f_cd                  	   ; // 사용여부코드                   
	private String del_f_cd                  	   ; // 삭제여부코드                   
	private Integer rg_k_seq_n                	   ; // 등록자일련번호                 
	private String rg_d                      	   ; // 등록일자                       
	private String rg_tm                     	   ; // 등록시간                       
	private String rg_ip                     	   ; // 등록자아이피                   
	private Integer mdf_k_seq_n               	   ; // 수정자일련번호                 
	private String mdf_d                     	   ; // 수정일자                       
	private String mdf_tm                    	   ; // 수정시간                       
	private String mdf_ip                    	   ; // 수정자아이피            
	private String clt_tar_band_cd                    	   ; // 코드        
	
	
	public Integer getClt_tar_band_seq_n() {
		return clt_tar_band_seq_n;
	}
	public void setClt_tar_band_seq_n(Integer clt_tar_band_seq_n) {
		this.clt_tar_band_seq_n = clt_tar_band_seq_n;
	}
	public Integer getClt_tar_sensor_seq_n() {
		return clt_tar_sensor_seq_n;
	}
	public void setClt_tar_sensor_seq_n(Integer clt_tar_sensor_seq_n) {
		this.clt_tar_sensor_seq_n = clt_tar_sensor_seq_n;
	}
	public Integer getClt_tar_band_grp_seq_n() {
		return clt_tar_band_grp_seq_n;
	}
	public void setClt_tar_band_grp_seq_n(Integer clt_tar_band_grp_seq_n) {
		this.clt_tar_band_grp_seq_n = clt_tar_band_grp_seq_n;
	}
	public String getClt_tar_band_kor_nm() {
		return clt_tar_band_kor_nm;
	}
	public void setClt_tar_band_kor_nm(String clt_tar_band_kor_nm) {
		this.clt_tar_band_kor_nm = clt_tar_band_kor_nm;
	}
	public String getClt_tar_band_eng_nm() {
		return clt_tar_band_eng_nm;
	}
	public void setClt_tar_band_eng_nm(String clt_tar_band_eng_nm) {
		this.clt_tar_band_eng_nm = clt_tar_band_eng_nm;
	}
	public String getClt_tar_band_desc() {
		return clt_tar_band_desc;
	}
	public void setClt_tar_band_desc(String clt_tar_band_desc) {
		this.clt_tar_band_desc = clt_tar_band_desc;
	}
	public String getClt_tar_band_frqc_bandwidth() {
		return clt_tar_band_frqc_bandwidth;
	}
	public void setClt_tar_band_frqc_bandwidth(String clt_tar_band_frqc_bandwidth) {
		this.clt_tar_band_frqc_bandwidth = clt_tar_band_frqc_bandwidth;
	}
	public Integer getClt_tar_band_width_sz() {
		return clt_tar_band_width_sz;
	}
	public void setClt_tar_band_width_sz(Integer clt_tar_band_width_sz) {
		this.clt_tar_band_width_sz = clt_tar_band_width_sz;
	}
	public Integer getClt_tar_band_hgt_sz() {
		return clt_tar_band_hgt_sz;
	}
	public void setClt_tar_band_hgt_sz(Integer clt_tar_band_hgt_sz) {
		this.clt_tar_band_hgt_sz = clt_tar_band_hgt_sz;
	}
	public float getClt_tar_band_res() {
		return clt_tar_band_res;
	}
	public void setClt_tar_band_res(float clt_tar_band_res) {
		this.clt_tar_band_res = clt_tar_band_res;
	}
	public String getClt_tar_band_cen_frqc() {
		return clt_tar_band_cen_frqc;
	}
	public void setClt_tar_band_cen_frqc(String clt_tar_band_cen_frqc) {
		this.clt_tar_band_cen_frqc = clt_tar_band_cen_frqc;
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
	public String getClt_tar_sensor_kor_nm() {
		return clt_tar_sensor_kor_nm;
	}
	public void setClt_tar_sensor_kor_nm(String clt_tar_sensor_kor_nm) {
		this.clt_tar_sensor_kor_nm = clt_tar_sensor_kor_nm;
	}
	public String getClt_tar_band_grp_kor_nm() {
		return clt_tar_band_grp_kor_nm;
	}
	public void setClt_tar_band_grp_kor_nm(String clt_tar_band_grp_kor_nm) {
		this.clt_tar_band_grp_kor_nm = clt_tar_band_grp_kor_nm;
	}
	public String getClt_tar_band_grp_eng_nm() {
		return clt_tar_band_grp_eng_nm;
	}
	public void setClt_tar_band_grp_eng_nm(String clt_tar_band_grp_eng_nm) {
		this.clt_tar_band_grp_eng_nm = clt_tar_band_grp_eng_nm;
	}
	public String getClt_tar_band_cd() {
		return clt_tar_band_cd;
	}
	public void setClt_tar_band_cd(String clt_tar_band_cd) {
		this.clt_tar_band_cd = clt_tar_band_cd;
	}
	
}
