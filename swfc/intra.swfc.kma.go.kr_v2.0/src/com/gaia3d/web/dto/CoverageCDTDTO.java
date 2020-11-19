package com.gaia3d.web.dto;

import java.math.BigDecimal;

public class CoverageCDTDTO {
	private Integer  coverage_cdt_seq_n        ; //범위좌표일련번호
	private Integer coverage_seq_n            ; //범위일련번호    
	private BigDecimal lft_top_cdt_x             ; //좌측상단좌표X   
	private BigDecimal lft_top_cdt_y             ; //좌측상단좌표Y   
	private BigDecimal righ_top_cdt_x            ; //우측상단좌표X   
	private BigDecimal righ_top_cdt_y            ; //우측상단좌표Y   
	private BigDecimal lft_btm_cdt_x             ; //좌측하단좌표X   
	private BigDecimal lft_btm_cdt_y             ; //좌측하단좌표Y   
	private BigDecimal righ_btm_cdt_x            ; //우측하단좌표X   
	private BigDecimal righ_btm_cdt_y            ; //우측하단좌표Y   
	private BigDecimal pixel_per_dstc_x          ; //픽셀당실거리X   
	private BigDecimal pixel_per_dstc_y          ; //픽셀당실거리Y   
	private String use_f_cd                  ; //사용여부코드    
	private String del_f_cd                  ; //삭제여부코드    
	private Integer rg_k_seq_n                ; //등록자일련번호  
	private String rg_d                      ; //등록일자        
	private String rg_tm                     ; //등록시간        
	private String rg_ip                     ; //등록자아이피    
	private Integer mdf_k_seq_n               ; //수정자일련번호  
	private String mdf_d                     ; //수정일자        
	private String mdf_tm                    ; //수정시간        
	private String mdf_ip                    ; //수정자아이피   
	
	public Integer getCoverage_cdt_seq_n() {
		return coverage_cdt_seq_n;
	}
	public void setCoverage_cdt_seq_n(Integer coverage_cdt_seq_n) {
		this.coverage_cdt_seq_n = coverage_cdt_seq_n;
	}
	public Integer getCoverage_seq_n() {
		return coverage_seq_n;
	}
	public void setCoverage_seq_n(Integer coverage_seq_n) {
		this.coverage_seq_n = coverage_seq_n;
	}
	public BigDecimal getLft_top_cdt_x() {
		return lft_top_cdt_x;
	}
	public void setLft_top_cdt_x(BigDecimal lft_top_cdt_x) {
		this.lft_top_cdt_x = lft_top_cdt_x;
	}
	public BigDecimal getLft_top_cdt_y() {
		return lft_top_cdt_y;
	}
	public void setLft_top_cdt_y(BigDecimal lft_top_cdt_y) {
		this.lft_top_cdt_y = lft_top_cdt_y;
	}
	public BigDecimal getRigh_top_cdt_x() {
		return righ_top_cdt_x;
	}
	public void setRigh_top_cdt_x(BigDecimal righ_top_cdt_x) {
		this.righ_top_cdt_x = righ_top_cdt_x;
	}
	public BigDecimal getRigh_top_cdt_y() {
		return righ_top_cdt_y;
	}
	public void setRigh_top_cdt_y(BigDecimal righ_top_cdt_y) {
		this.righ_top_cdt_y = righ_top_cdt_y;
	}
	public BigDecimal getLft_btm_cdt_x() {
		return lft_btm_cdt_x;
	}
	public void setLft_btm_cdt_x(BigDecimal lft_btm_cdt_x) {
		this.lft_btm_cdt_x = lft_btm_cdt_x;
	}
	public BigDecimal getLft_btm_cdt_y() {
		return lft_btm_cdt_y;
	}
	public void setLft_btm_cdt_y(BigDecimal lft_btm_cdt_y) {
		this.lft_btm_cdt_y = lft_btm_cdt_y;
	}
	public BigDecimal getRigh_btm_cdt_x() {
		return righ_btm_cdt_x;
	}
	public void setRigh_btm_cdt_x(BigDecimal righ_btm_cdt_x) {
		this.righ_btm_cdt_x = righ_btm_cdt_x;
	}
	public BigDecimal getRigh_btm_cdt_y() {
		return righ_btm_cdt_y;
	}
	public void setRigh_btm_cdt_y(BigDecimal righ_btm_cdt_y) {
		this.righ_btm_cdt_y = righ_btm_cdt_y;
	}
	public BigDecimal getPixel_per_dstc_x() {
		return pixel_per_dstc_x;
	}
	public void setPixel_per_dstc_x(BigDecimal pixel_per_dstc_x) {
		this.pixel_per_dstc_x = pixel_per_dstc_x;
	}
	public BigDecimal getPixel_per_dstc_y() {
		return pixel_per_dstc_y;
	}
	public void setPixel_per_dstc_y(BigDecimal pixel_per_dstc_y) {
		this.pixel_per_dstc_y = pixel_per_dstc_y;
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
