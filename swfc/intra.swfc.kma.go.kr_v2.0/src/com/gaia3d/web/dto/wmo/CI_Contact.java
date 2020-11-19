package com.gaia3d.web.dto.wmo;

import java.util.List;

public class CI_Contact {
	private Integer contactseqn         ;      //Contact일련번호
	private Integer responsiblepartyseqn;      //ResponsibleParty일련번호
	private List<CI_Telephone> phone               ;      //전화번호_CI_Telephone
	private List<CI_Address> address             ;      //주소_CI_Address
	private List<CI_OnlineResource> onlineresource      ;      //온라인정보_CI_OnlineResource
	
	public Integer getContactseqn() {
		return contactseqn;
	}
	public void setContactseqn(Integer contactseqn) {
		this.contactseqn = contactseqn;
	}
	public Integer getResponsiblepartyseqn() {
		return responsiblepartyseqn;
	}
	public void setResponsiblepartyseqn(Integer responsiblepartyseqn) {
		this.responsiblepartyseqn = responsiblepartyseqn;
	}
	public List<CI_Telephone> getPhone() {
		return phone;
	}
	public void setPhone(List<CI_Telephone> phone) {
		this.phone = phone;
	}
	public List<CI_Address> getAddress() {
		return address;
	}
	public void setAddress(List<CI_Address> address) {
		this.address = address;
	}
	public List<CI_OnlineResource> getOnlineresource() {
		return onlineresource;
	}
	public void setOnlineresource(List<CI_OnlineResource> onlineresource) {
		this.onlineresource = onlineresource;
	}
	
}
