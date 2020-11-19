package com.gaia3d.web.dto.wmo;

public class CI_OnlineResource {

	private Integer onlineresourceseqn        ; //OnlineResource일련번호
	private Integer contactseqn               ; //Contact일련번호
	private Integer extensioninformationseqn  ; //ExtensionInformation일련번호
	private Integer digitaltransferoptionsseqn; //DigitalTransferOptions일련번호
	private String linkage                   ; //URL주소
	private String protocol                  ; //연결프로토콜
	private String name                      ; //온라인자료이름
	private String description               ; //온라인자료설명
	
	public Integer getOnlineresourceseqn() {
		return onlineresourceseqn;
	}
	public void setOnlineresourceseqn(Integer onlineresourceseqn) {
		this.onlineresourceseqn = onlineresourceseqn;
	}
	public Integer getContactseqn() {
		return contactseqn;
	}
	public void setContactseqn(Integer contactseqn) {
		this.contactseqn = contactseqn;
	}
	public Integer getExtensioninformationseqn() {
		return extensioninformationseqn;
	}
	public void setExtensioninformationseqn(Integer extensioninformationseqn) {
		this.extensioninformationseqn = extensioninformationseqn;
	}
	public String getLinkage() {
		return linkage;
	}
	public void setLinkage(String linkage) {
		this.linkage = linkage;
	}
	public String getProtocol() {
		return protocol;
	}
	public void setProtocol(String protocol) {
		this.protocol = protocol;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getDigitaltransferoptionsseqn() {
		return digitaltransferoptionsseqn;
	}
	public void setDigitaltransferoptionsseqn(Integer digitaltransferoptionsseqn) {
		this.digitaltransferoptionsseqn = digitaltransferoptionsseqn;
	}
	
}
