package com.gaia3d.web.dto;

import java.io.Serializable;
import java.util.Date;

/**
 * 코더 정보를 관리하는 DTO
 * @author Administrator
 *
 */
public class CodeDTO implements Serializable{
	
	private static final long serialVersionUID = 7412243776266835080L;
	
	private Integer code_seq_n;					// 코드 시퀀스 번호			
	private String code_nm;						// 국문명
	private String code_en_nm;					// 영문명
	private String code_ko_nm;					// 영문명
	private String description;					// 설명
	private String use_yn;						// 표출여부
	private Integer parent_code_seq_n;			// 부모번호
	private  Date rg_date;					    // 등록일자
	private  String code;						// 코드번호
	
	public String getCode_ko_nm() {
		return code_ko_nm;
	}
	public void setCode_ko_nm(String code_ko_nm) {
		this.code_ko_nm = code_ko_nm;
	}
	public Integer getCode_seq_n() {
		return code_seq_n;
	}
	public void setCode_seq_n(Integer code_seq_n) {
		this.code_seq_n = code_seq_n;
	}
	public String getCode_nm() {
		return code_nm;
	}
	public void setCode_nm(String code_nm) {
		this.code_nm = code_nm;
	}
	public String getCode_en_nm() {
		return code_en_nm;
	}
	public void setCode_en_nm(String code_en_nm) {
		this.code_en_nm = code_en_nm;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public Integer getParent_code_seq_n() {
		return parent_code_seq_n;
	}
	public void setParent_code_seq_n(Integer parent_code_seq_n) {
		this.parent_code_seq_n = parent_code_seq_n;
	}
	public Date getRg_date() {
		return rg_date;
	}
	public void setRg_date(Date rg_date) {
		this.rg_date = rg_date;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	
	
	
}
