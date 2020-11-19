package com.gaia3d.web.dto.wmo;

import java.util.List;

public class DQ_DataQuality {

	private Integer dataqualityseqn;           //DataQuality일련번호
	private Integer metadataseqn   ;           //Metadata일련번호
	private DQ_Scope scope          ;           //자료품질의구체적정보_DQ_Scope
	private List<DQ_Element> report         ;           //물리적품질정보_DQ_DomainConsistency extends DQ_Element
	private LI_Lineage lineage        ;           //상대적품질정보_LI_Lineage
	
	public Integer getDataqualityseqn() {
		return dataqualityseqn;
	}
	public void setDataqualityseqn(Integer dataqualityseqn) {
		this.dataqualityseqn = dataqualityseqn;
	}
	public Integer getMetadataseqn() {
		return metadataseqn;
	}
	public void setMetadataseqn(Integer metadataseqn) {
		this.metadataseqn = metadataseqn;
	}
	public DQ_Scope getScope() {
		return scope;
	}
	public void setScope(DQ_Scope scope) {
		this.scope = scope;
	}
	public List<DQ_Element> getReport() {
		return report;
	}
	public void setReport(List<DQ_Element> report) {
		this.report = report;
	}
	public LI_Lineage getLineage() {
		return lineage;
	}
	public void setLineage(LI_Lineage lineage) {
		this.lineage = lineage;
	}
	
}
