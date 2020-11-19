package com.gaia3d.web.dto.wmo;

public class EX_GeographicDescription extends EX_GeographicExtent {
	private Integer geographicdescriptionseqn ; //GeographicDescription일련번호
//	private Integer extentseqn                ; //Extent일련번호
	private MD_Identifier geographicidentifier      ; //지리적영역식별자_MD_Identifier
	
	public Integer getGeographicdescriptionseqn() {
		return geographicdescriptionseqn;
	}
	public void setGeographicdescriptionseqn(Integer geographicdescriptionseqn) {
		this.geographicdescriptionseqn = geographicdescriptionseqn;
	}
//	public Integer getExtentseqn() {
//		return extentseqn;
//	}
//	public void setExtentseqn(Integer extentseqn) {
//		this.extentseqn = extentseqn;
//	}
	public MD_Identifier getGeographicidentifier() {
		return geographicidentifier;
	}
	public void setGeographicidentifier(MD_Identifier geographicidentifier) {
		this.geographicidentifier = geographicidentifier;
	}
	
	
}
