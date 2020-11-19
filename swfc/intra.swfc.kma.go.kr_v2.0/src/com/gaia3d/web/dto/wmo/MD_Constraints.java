package com.gaia3d.web.dto.wmo;

public class MD_Constraints {

	private Integer constraintsseqn         ; 	//Constraints일련번호
	private Integer metadataseqn            ; 	//Metadata일련번호
	private Integer dataidentificationseqn  ; 	//DataIdentification일련번호
	private String uselimitation           ; 	//제한사항
	
	public Integer getConstraintsseqn() {
		return constraintsseqn;
	}
	public void setConstraintsseqn(Integer constraintsseqn) {
		this.constraintsseqn = constraintsseqn;
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
	public String getUselimitation() {
		return uselimitation;
	}
	public void setUselimitation(String uselimitation) {
		this.uselimitation = uselimitation;
	}
	
	
}
