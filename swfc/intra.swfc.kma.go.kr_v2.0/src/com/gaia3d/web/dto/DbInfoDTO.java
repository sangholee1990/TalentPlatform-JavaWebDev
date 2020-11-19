package com.gaia3d.web.dto;

import java.util.Date;

public class DbInfoDTO {
	String tablespace_Name;
	String table_Name;
	String comments;
	long num_Rows;
	Date created;
	Date last_Ddl_Time;
	String file_Name;
	long total;
	long used;
	long free;
	long used_Percent;
	String unit;
	
	public String getTablespace_Name() {
		return tablespace_Name;
	}
	public void setTablespace_Name(String tablespace_Name) {
		this.tablespace_Name = tablespace_Name;
	}
	public String getTable_Name() {
		return table_Name;
	}
	public void setTable_Name(String table_Name) {
		this.table_Name = table_Name;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public long getNum_Rows() {
		return num_Rows;
	}
	public void setNum_Rows(long num_Rows) {
		this.num_Rows = num_Rows;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	public Date getLast_Ddl_Time() {
		return last_Ddl_Time;
	}
	public void setLast_Ddl_Time(Date last_Ddl_Time) {
		this.last_Ddl_Time = last_Ddl_Time;
	}
	public String getFile_Name() {
		return file_Name;
	}
	public void setFile_Name(String file_Name) {
		this.file_Name = file_Name;
	}
	public long getTotal() {
		return total;
	}
	public void setTotal(long total) {
		this.total = total;
	}
	public long getUsed() {
		return used;
	}
	public void setUsed(long used) {
		this.used = used;
	}
	public long getFree() {
		return free;
	}
	public void setFree(long free) {
		this.free = free;
	}
	public long getUsed_Percent() {
		return used_Percent;
	}
	public void setUsed_Percent(long used_Percent) {
		this.used_Percent = used_Percent;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
}
