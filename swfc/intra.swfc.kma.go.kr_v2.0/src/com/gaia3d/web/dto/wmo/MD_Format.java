package com.gaia3d.web.dto.wmo;

import java.util.List;

public class MD_Format {
	private Integer formatseqn       ;         //Format일련번호
	private Integer distributionseqn ;         //Distribution일련번호
	private Integer distributorseqn  ;         //Distributor일련번호
	private String name             ;         //전송포맷이름
	private String version          ;         //전송포맷버전
	private String specification    ;         //산출물설명
	private List<MD_Distributor> formatdistributor;         //배포처정보_MD_Distributor
	
	public Integer getFormatseqn() {
		return formatseqn;
	}
	public void setFormatseqn(Integer formatseqn) {
		this.formatseqn = formatseqn;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getSpecification() {
		return specification;
	}
	public void setSpecification(String specification) {
		this.specification = specification;
	}
	public List<MD_Distributor> getFormatdistributor() {
		return formatdistributor;
	}
	public void setFormatdistributor(List<MD_Distributor> formatdistributor) {
		this.formatdistributor = formatdistributor;
	}
	
	
}
