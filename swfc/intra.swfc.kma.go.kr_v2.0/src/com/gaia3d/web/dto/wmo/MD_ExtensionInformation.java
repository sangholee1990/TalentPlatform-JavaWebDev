package com.gaia3d.web.dto.wmo;

import java.util.List;

public class MD_ExtensionInformation {

	private Integer extensioninformationseqn  ; //ExtensionInformation일련번호
	private Integer metadataseqn              ; //Metadata일련번호
	private List<CI_OnlineResource> extensiononlineresource   ; //온라인소스정보_CI_OnlineResource
	
	
	public Integer getExtensioninformationseqn() {
		return extensioninformationseqn;
	}
	public void setExtensioninformationseqn(Integer extensioninformationseqn) {
		this.extensioninformationseqn = extensioninformationseqn;
	}
	public Integer getMetadataseqn() {
		return metadataseqn;
	}
	public void setMetadataseqn(Integer metadataseqn) {
		this.metadataseqn = metadataseqn;
	}
	public List<CI_OnlineResource> getExtensiononlineresource() {
		return extensiononlineresource;
	}
	public void setExtensiononlineresource(
			List<CI_OnlineResource> extensiononlineresource) {
		this.extensiononlineresource = extensiononlineresource;
	}

	
}
