package com.gaia3d.web.dto.wmo;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlSchema;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.codehaus.jackson.map.annotate.JsonSerialize;


@XmlRootElement(name="MD_Metadata")
public class MD_Metadata {

	private Integer metadataseqn              ; // Metadata일련번호               
	
	private String fileidentifier            ; // 고유식별자                               
	private String language                  ; // 사용언어                                 
	private String characterset              ; // 표준문자전체이름                         
	private String hierarchylevel            ; // 계층레벨                                 
	private String hierarchylevelname        ; // 계층레벨이름     
	
	private List<CI_ResponsibleParty> contact		; // 관련그룹_CI_ResponsibleParty

	private Date 	datestamp                 ; // 생산일시      
	
	private String metadatastandardname      ; // 표준이름                                 
	private String metadatastandardversion   ; // 표준버전                                 
	private String locale                    ; // 대체지역                                 

	private List<MD_ExtensionInformation> metadataextensioninfo     ; // 확장설명정보_MD_ExtensionInformation     
	private MD_MaintenanceInformation metadatamaintenance       ; // 유지보수정보_MD_MaintenanceInformation   
	
	private List<MD_DataIdentification> identificationinfo        ; // 자료기본정보_MD_DataIdentification       
	
	private List<MD_Constraints>  metadataconstraints       ; // 자료활용정보_MD_Constraints              
	private MD_Distribution  distributioninfo          ; // 자료분배및옵션정보_MD_Distribution       
	private List<DQ_DataQuality>  dataqualityinfo           ; // 자료품질평가_DQ_DataQuality   
	
	@JsonDeserialize(using=CustomJsonDateDeSerializer.class, as = Date.class)
	public Date getDatestamp() {
		return datestamp;
	}
	@JsonSerialize(using=CustomJsonDateSerializer.class, as = Date.class)
	public void setDatestamp(Date datestamp) {
		this.datestamp = datestamp;
	}
	
	
	public Integer getMetadataseqn() {
		return metadataseqn;
	}
	public void setMetadataseqn(Integer metadataseqn) {
		this.metadataseqn = metadataseqn;
	}
	public String getFileidentifier() {
		return fileidentifier;
	}
	public void setFileidentifier(String fileidentifier) {
		this.fileidentifier = fileidentifier;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getCharacterset() {
		return characterset;
	}
	public void setCharacterset(String characterset) {
		this.characterset = characterset;
	}
	public String getHierarchylevel() {
		return hierarchylevel;
	}
	public void setHierarchylevel(String hierarchylevel) {
		this.hierarchylevel = hierarchylevel;
	}
	public String getHierarchylevelname() {
		return hierarchylevelname;
	}
	public void setHierarchylevelname(String hierarchylevelname) {
		this.hierarchylevelname = hierarchylevelname;
	}
	public List<CI_ResponsibleParty> getContact() {
		return contact;
	}
	public void setContact(List<CI_ResponsibleParty> contact) {
		this.contact = contact;
	}
	

	public String getMetadatastandardname() {
		return metadatastandardname;
	}
	public void setMetadatastandardname(String metadatastandardname) {
		this.metadatastandardname = metadatastandardname;
	}
	public String getMetadatastandardversion() {
		return metadatastandardversion;
	}
	public void setMetadatastandardversion(String metadatastandardversion) {
		this.metadatastandardversion = metadatastandardversion;
	}
	public String getLocale() {
		return locale;
	}
	public void setLocale(String locale) {
		this.locale = locale;
	}
	public List<MD_ExtensionInformation> getMetadataextensioninfo() {
		return metadataextensioninfo;
	}
	public void setMetadataextensioninfo(
			List<MD_ExtensionInformation> metadataextensioninfo) {
		this.metadataextensioninfo = metadataextensioninfo;
	}
	public MD_MaintenanceInformation getMetadatamaintenance() {
		return metadatamaintenance;
	}
	public void setMetadatamaintenance(MD_MaintenanceInformation metadatamaintenance) {
		this.metadatamaintenance = metadatamaintenance;
	}
	public List<MD_DataIdentification> getIdentificationinfo() {
		return identificationinfo;
	}
	public void setIdentificationinfo(List<MD_DataIdentification> identificationinfo) {
		this.identificationinfo = identificationinfo;
	}
	public List<MD_Constraints> getMetadataconstraints() {
		return metadataconstraints;
	}
	public void setMetadataconstraints(List<MD_Constraints> metadataconstraints) {
		this.metadataconstraints = metadataconstraints;
	}
	public MD_Distribution getDistributioninfo() {
		return distributioninfo;
	}
	public void setDistributioninfo(MD_Distribution distributioninfo) {
		this.distributioninfo = distributioninfo;
	}
	public List<DQ_DataQuality> getDataqualityinfo() {
		return dataqualityinfo;
	}
	public void setDataqualityinfo(List<DQ_DataQuality> dataqualityinfo) {
		this.dataqualityinfo = dataqualityinfo;
	}
	
}
