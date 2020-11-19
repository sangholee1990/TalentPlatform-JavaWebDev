package com.gaia3d.web.dto;

import java.util.Date;

public class SWFCImageMetaDTO implements Comparable<SWFCImageMetaDTO> {

	int id;
	String code;
	Date createDate;
	String filePath;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	@Override
	public int compareTo(SWFCImageMetaDTO o) {
		return getCreateDate().compareTo(o.getCreateDate());
	}
}
