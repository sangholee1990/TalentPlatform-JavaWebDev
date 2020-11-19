package com.gaia3d.web.dto.wmo;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.codehaus.jackson.map.annotate.JsonSerialize;

public class CI_Date {

	private Integer dateseqn     ;           //Date일련번호
	private Integer citationseqn ;           //Citation일련번호
	private Date dates        ;           //조회날짜
	private String datetype     ;           //조회날짜형식

	
	@JsonDeserialize(using=CustomJsonDateDeSerializer.class, as = Date.class)
	public Date getDates() {
		return dates;
	}
	@JsonSerialize(using=CustomJsonDateSerializer.class, as = Date.class)
	public void setDates(Date dates) {
		this.dates = dates;
	}
	
	public Integer getDateseqn() {
		return dateseqn;
	}
	public void setDateseqn(Integer dateseqn) {
		this.dateseqn = dateseqn;
	}
	public Integer getCitationseqn() {
		return citationseqn;
	}
	public void setCitationseqn(Integer citationseqn) {
		this.citationseqn = citationseqn;
	}
	public String getDatetype() {
		return datetype;
	}
	public void setDatetype(String datetype) {
		this.datetype = datetype;
	}
	
	
}
