package com.gaia3d.web.dto.wmo;

import java.util.List;

public class MD_DigitalTransferOptions {
	private Integer digitaltransferoptionsseqn; //DigitalTransferOptions일련번호
	private Integer distributionseqn          ; //Distribution일련번호
	private Integer distributorseqn           ; //Distributor일련번호
	private List<CI_OnlineResource> onlines                   ; //online_CI_OnlineResource
	
	public Integer getDigitaltransferoptionsseqn() {
		return digitaltransferoptionsseqn;
	}
	public void setDigitaltransferoptionsseqn(Integer digitaltransferoptionsseqn) {
		this.digitaltransferoptionsseqn = digitaltransferoptionsseqn;
	}
	public Integer getDistributionseqn() {
		return distributionseqn;
	}
	public void setDistributionseqn(Integer distributionseqn) {
		this.distributionseqn = distributionseqn;
	}
	public Integer getDistributorseqn() {
		return distributorseqn;
	}
	public void setDistributorseqn(Integer distributorseqn) {
		this.distributorseqn = distributorseqn;
	}
	public List<CI_OnlineResource> getOnlines() {
		return onlines;
	}
	public void setOnlines(List<CI_OnlineResource> onlines) {
		this.onlines = onlines;
	}
	
}
