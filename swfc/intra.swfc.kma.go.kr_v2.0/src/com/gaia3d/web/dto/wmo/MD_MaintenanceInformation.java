package com.gaia3d.web.dto.wmo;

import java.util.List;

import java.math.BigDecimal;

public class MD_MaintenanceInformation {

	private Integer maintenanceinformationseqn		; //MaintenanceInformation일련번호
	private Integer metadataseqn              		; //Metadata일련번호
	private Integer dataidentificationseqn    		; //DataIdentification일련번호
	private String maintenanceandupdatefrequency	; //유지보수주기 Code
	private String userdefinedmaintenancefrequency	; //별도유지보수기간
	private String updatescope               		; //유지보수자료범위 Code
	private List<CI_ResponsibleParty> contact             ; //관련그룹_CI_ResponsibleParty

	public Integer getMaintenanceinformationseqn() {
		return maintenanceinformationseqn;
	}
	public void setMaintenanceinformationseqn(Integer maintenanceinformationseqn) {
		this.maintenanceinformationseqn = maintenanceinformationseqn;
	}
	public Integer getMetadataseqn() {
		return metadataseqn;
	}
	public void setMetadataseqn(Integer metadataseqn) {
		this.metadataseqn = metadataseqn;
	}
	public Integer getDataidentificationseqn() {
		return dataidentificationseqn;
	}
	public void setDataidentificationseqn(Integer dataidentificationseqn) {
		this.dataidentificationseqn = dataidentificationseqn;
	}
	public String getMaintenanceandupdatefrequency() {
		return maintenanceandupdatefrequency;
	}
	public void setMaintenanceandupdatefrequency(
			String maintenanceandupdatefrequency) {
		this.maintenanceandupdatefrequency = maintenanceandupdatefrequency;
	}
	public String getUserdefinedmaintenancefrequency() {
		return userdefinedmaintenancefrequency;
	}
	public void setUserdefinedmaintenancefrequency(
			String userdefinedmaintenancefrequency) {
		this.userdefinedmaintenancefrequency = userdefinedmaintenancefrequency;
	}
	public String getUpdatescope() {
		return updatescope;
	}
	public void setUpdatescope(String updatescope) {
		this.updatescope = updatescope;
	}
	public List<CI_ResponsibleParty> getContact() {
		return contact;
	}
	public void setContact(List<CI_ResponsibleParty> contact) {
		this.contact = contact;
	}

	
}
