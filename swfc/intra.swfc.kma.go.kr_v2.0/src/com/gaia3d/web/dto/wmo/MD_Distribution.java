package com.gaia3d.web.dto.wmo;

import java.util.List;

public class MD_Distribution {
	private Integer distributionseqn     ;     //Distribution일련번호
	private Integer metadataseqn         ;     //Metadata일련번호
	private List<MD_Format> distributionformat   ;     //자료형식_MD_Format
	private List<MD_Distributor> distributor          ;     //배포처정보_MD_Distributor
	private List<MD_DigitalTransferOptions> transferoptions      ;     //자료의기술적방법및미디어정보_MD_DigitalTransferOptions

	public Integer getDistributionseqn() {
		return distributionseqn;
	}
	public void setDistributionseqn(Integer distributionseqn) {
		this.distributionseqn = distributionseqn;
	}
	public Integer getMetadataseqn() {
		return metadataseqn;
	}
	public void setMetadataseqn(Integer metadataseqn) {
		this.metadataseqn = metadataseqn;
	}
	public List<MD_Format> getDistributionformat() {
		return distributionformat;
	}
	public void setDistributionformat(List<MD_Format> distributionformat) {
		this.distributionformat = distributionformat;
	}
	public List<MD_Distributor> getDistributor() {
		return distributor;
	}
	public void setDistributor(List<MD_Distributor> distributor) {
		this.distributor = distributor;
	}
	public List<MD_DigitalTransferOptions> getTransferoptions() {
		return transferoptions;
	}
	public void setTransferoptions(List<MD_DigitalTransferOptions> transferoptions) {
		this.transferoptions = transferoptions;
	}
	
	
}
