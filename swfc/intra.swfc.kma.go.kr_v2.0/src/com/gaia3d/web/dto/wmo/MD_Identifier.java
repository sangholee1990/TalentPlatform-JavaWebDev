package com.gaia3d.web.dto.wmo;

public class MD_Identifier {
	private Integer identifierseqn           ; //Identifier일련번호
	private Integer citationseqn             ; //Citation일련번호
	private Integer geographicdescriptionseqn; //GeographicDescription일련번호
	private CI_ResponsibleParty authority                ; //관련그룹_CI_ResponsibleParty
	private String code                     ; //명칭종류
	private Integer domainconsistencyseqn    ; //DomainConsistency일련번호
	public Integer getIdentifierseqn() {
		return identifierseqn;
	}
	public void setIdentifierseqn(Integer identifierseqn) {
		this.identifierseqn = identifierseqn;
	}
	public Integer getCitationseqn() {
		return citationseqn;
	}
	public void setCitationseqn(Integer citationseqn) {
		this.citationseqn = citationseqn;
	}
	public Integer getGeographicdescriptionseqn() {
		return geographicdescriptionseqn;
	}
	public void setGeographicdescriptionseqn(Integer geographicdescriptionseqn) {
		this.geographicdescriptionseqn = geographicdescriptionseqn;
	}
	public CI_ResponsibleParty getAuthority() {
		return authority;
	}
	public void setAuthority(CI_ResponsibleParty authority) {
		this.authority = authority;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public Integer getDomainconsistencyseqn() {
		return domainconsistencyseqn;
	}
	public void setDomainconsistencyseqn(Integer domainconsistencyseqn) {
		this.domainconsistencyseqn = domainconsistencyseqn;
	}
	
	
}
