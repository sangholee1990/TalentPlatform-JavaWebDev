package com.gaia3d.web.dto.wmo;

public class CI_Telephone {

	private Integer telephoneseqn;             //Telephone일련번호
	private Integer contactseqn  ;             //Contact일련번호
	private String voice        ;             //전화번호
	
	public Integer getTelephoneseqn() {
		return telephoneseqn;
	}
	public void setTelephoneseqn(Integer telephoneseqn) {
		this.telephoneseqn = telephoneseqn;
	}
	public Integer getContactseqn() {
		return contactseqn;
	}
	public void setContactseqn(Integer contactseqn) {
		this.contactseqn = contactseqn;
	}
	public String getVoice() {
		return voice;
	}
	public void setVoice(String voice) {
		this.voice = voice;
	}

}
