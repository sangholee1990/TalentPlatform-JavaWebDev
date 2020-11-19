package com.gaia3d.web.dto.wmo;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;

public class MD_DataIdentification {

	private Integer dataidentificationseqn    ; //DataIdentification일련번호
	private Integer metadataseqn              ; //Metadata일련번호
	private List<CI_Citation> citation       ; //자료인용정보_CI_Citation
	private String Abstract                  ; //요약설명
	private List<CI_ResponsibleParty> pointofcontact            ; //관련그룹_CI_ResponsibleParty
	private String spatialrepresentationtype ; //사용기법 Code
	private String spatialresolution         ; //일반적이해요소
	private String language                  ; //사용언어
	private String topiccategory             ; //자료제목 Code
	private List<MD_MaintenanceInformation> resourcemaintenance       ; //유지보수정보_MD_MaintenanceInformation
	private List<MD_Keywords> descriptivekeywords       ; //키워드정보_MD_Keywords
	private List<EX_Extent> extent                    ; //범위정보_EX_Extent
	private List<MD_Constraints> resourceconstraints       ; //자료활용정보_MD_Constraints
	
	public Integer getDataidentificationseqn() {
		return dataidentificationseqn;
	}
	public void setDataidentificationseqn(Integer dataidentificationseqn) {
		this.dataidentificationseqn = dataidentificationseqn;
	}
	public Integer getMetadataseqn() {
		return metadataseqn;
	}
	public void setMetadataseqn(Integer metadataseqn) {
		this.metadataseqn = metadataseqn;
	}
	public List<CI_Citation> getCitation() {
		return citation;
	}
	public void setCitation(List<CI_Citation> citation) {
		this.citation = citation;
	}
	public String getAbstract() {
		return Abstract;
	}
	public void setAbstract(String abstract1) {
		Abstract = abstract1;
	}
	public List<CI_ResponsibleParty> getPointofcontact() {
		return pointofcontact;
	}
	public void setPointofcontact(List<CI_ResponsibleParty> pointofcontact) {
		this.pointofcontact = pointofcontact;
	}
	public String getSpatialrepresentationtype() {
		return spatialrepresentationtype;
	}
	public void setSpatialrepresentationtype(String spatialrepresentationtype) {
		this.spatialrepresentationtype = spatialrepresentationtype;
	}
	public String getSpatialresolution() {
		return spatialresolution;
	}
	public void setSpatialresolution(String spatialresolution) {
		this.spatialresolution = spatialresolution;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getTopiccategory() {
		return topiccategory;
	}
	public void setTopiccategory(String topiccategory) {
		this.topiccategory = topiccategory;
	}
	public List<MD_MaintenanceInformation> getResourcemaintenance() {
		return resourcemaintenance;
	}
	public void setResourcemaintenance(
			List<MD_MaintenanceInformation> resourcemaintenance) {
		this.resourcemaintenance = resourcemaintenance;
	}
	public List<MD_Keywords> getDescriptivekeywords() {
		return descriptivekeywords;
	}
	public void setDescriptivekeywords(List<MD_Keywords> descriptivekeywords) {
		this.descriptivekeywords = descriptivekeywords;
	}
	public List<EX_Extent> getExtent() {
		return extent;
	}
	public void setExtent(List<EX_Extent> extent) {
		this.extent = extent;
	}
	public List<MD_Constraints> getResourceconstraints() {
		return resourceconstraints;
	}
	public void setResourceconstraints(List<MD_Constraints> resourceconstraints) {
		this.resourceconstraints = resourceconstraints;
	}
	
}
