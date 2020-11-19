package com.gaia3d.web.dto.wmo;

import java.util.List;

public class EX_Extent {
	private Integer extentseqn             ;  //Extent일련번호
	private Integer dataidentificationseqn ;  //DataIdentification일련번호
	
	//EX_GeographicExtent
	//extends EX_GeographicBoundingBox 	
	//extends EX_GeographicDescription 
	private List<EX_GeographicExtent> geographicelement      ;  //지리적검색요소_EX_GeographicExtent
	private List<EX_TemporalExtent> temporalelement        ;  //시간적검색요소_EX_TemporalExtent
	
	public Integer getExtentseqn() {
		return extentseqn;
	}
	public void setExtentseqn(Integer extentseqn) {
		this.extentseqn = extentseqn;
	}
	public Integer getDataidentificationseqn() {
		return dataidentificationseqn;
	}
	public void setDataidentificationseqn(Integer dataidentificationseqn) {
		this.dataidentificationseqn = dataidentificationseqn;
	}
	public List<EX_TemporalExtent> getTemporalelement() {
		return temporalelement;
	}
	public void setTemporalelement(List<EX_TemporalExtent> temporalelement) {
		this.temporalelement = temporalelement;
	}
	public List<EX_GeographicExtent> getGeographicelement() {
		return geographicelement;
	}
	public void setGeographicelement(List<EX_GeographicExtent> geographicelement) {
		this.geographicelement = geographicelement;
	}
}
