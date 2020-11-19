package com.gaia3d.web.dto.wmo;

import java.util.List;

public class CI_ResponsibleParty {

	private Integer responsiblepartyseqn      ; //ResponsibleParty일련번호
	private Integer metadataseqn              ; //Metadata일련번호
	private Integer maintenanceinformationseqn; //MaintenanceInformation일련번호
	private Integer dataidentificationseqn    ; //DataIdentification일련번호
	private Integer citationseqn              ; //Citation일련번호
	private Integer identifierseqn            ; //Identifier일련번호
	private Integer distributorseqn           ; //Distributor일련번호
	private String individualname            ; //책임자이름
	private String organisationname          ; //책임그룹명
	private String positionname              ; //책임자역할
	private List<CI_Contact> contactinfo               ; //책임그룹주소_CI_Contact
	private String role                      ; //책임그룹임무 Code
	
	public Integer getResponsiblepartyseqn() {
		return responsiblepartyseqn;
	}
	public void setResponsiblepartyseqn(Integer responsiblepartyseqn) {
		this.responsiblepartyseqn = responsiblepartyseqn;
	}
	public Integer getMetadataseqn() {
		return metadataseqn;
	}
	public void setMetadataseqn(Integer metadataseqn) {
		this.metadataseqn = metadataseqn;
	}
	public Integer getMaintenanceinformationseqn() {
		return maintenanceinformationseqn;
	}
	public void setMaintenanceinformationseqn(Integer maintenanceinformationseqn) {
		this.maintenanceinformationseqn = maintenanceinformationseqn;
	}
	public Integer getDataidentificationseqn() {
		return dataidentificationseqn;
	}
	public void setDataidentificationseqn(Integer dataidentificationseqn) {
		this.dataidentificationseqn = dataidentificationseqn;
	}
	public Integer getCitationseqn() {
		return citationseqn;
	}
	public void setCitationseqn(Integer citationseqn) {
		this.citationseqn = citationseqn;
	}
	public Integer getIdentifierseqn() {
		return identifierseqn;
	}
	public void setIdentifierseqn(Integer identifierseqn) {
		this.identifierseqn = identifierseqn;
	}
	public Integer getDistributorseqn() {
		return distributorseqn;
	}
	public void setDistributorseqn(Integer distributorseqn) {
		this.distributorseqn = distributorseqn;
	}
	public String getIndividualname() {
		return individualname;
	}
	public void setIndividualname(String individualname) {
		this.individualname = individualname;
	}
	public String getOrganisationname() {
		return organisationname;
	}
	public void setOrganisationname(String organisationname) {
		this.organisationname = organisationname;
	}
	public String getPositionname() {
		return positionname;
	}
	public void setPositionname(String positionname) {
		this.positionname = positionname;
	}
	public List<CI_Contact> getContactinfo() {
		return contactinfo;
	}
	public void setContactinfo(List<CI_Contact> contactinfo) {
		this.contactinfo = contactinfo;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
}
