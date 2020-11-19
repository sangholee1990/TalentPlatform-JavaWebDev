package com.gaia3d.web.dto.wmo;

import java.util.List;

public class MD_Distributor {
	private Integer distributorseqn           ; //Distributor일련번호
	private Integer distributionseqn          ; //Distribution일련번호
	private Integer formatseqn       ;         //Format일련번호
	private CI_ResponsibleParty distributorcontact        ; //관련그룹_CI_ResponsibleParty
	private List<MD_Format> distributorformat         ; //자료형식_MD_Format
	private List<MD_DigitalTransferOptions> distributortransferoptions; //자료의기술적방법및미디어정보_MD_DigitalTransferOptions
	
	public Integer getDistributorseqn() {
		return distributorseqn;
	}
	public void setDistributorseqn(Integer distributorseqn) {
		this.distributorseqn = distributorseqn;
	}
	public Integer getDistributionseqn() {
		return distributionseqn;
	}
	public void setDistributionseqn(Integer distributionseqn) {
		this.distributionseqn = distributionseqn;
	}
	public CI_ResponsibleParty getDistributorcontact() {
		return distributorcontact;
	}
	public void setDistributorcontact(CI_ResponsibleParty distributorcontact) {
		this.distributorcontact = distributorcontact;
	}
	public List<MD_Format> getDistributorformat() {
		return distributorformat;
	}
	public void setDistributorformat(List<MD_Format> distributorformat) {
		this.distributorformat = distributorformat;
	}
	public List<MD_DigitalTransferOptions> getDistributortransferoptions() {
		return distributortransferoptions;
	}
	public void setDistributortransferoptions(
			List<MD_DigitalTransferOptions> distributortransferoptions) {
		this.distributortransferoptions = distributortransferoptions;
	}
	public Integer getFormatseqn() {
		return formatseqn;
	}
	public void setFormatseqn(Integer formatseqn) {
		this.formatseqn = formatseqn;
	}
	
	
}
