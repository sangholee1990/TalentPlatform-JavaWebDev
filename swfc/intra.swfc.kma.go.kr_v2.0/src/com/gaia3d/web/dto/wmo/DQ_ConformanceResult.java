package com.gaia3d.web.dto.wmo;

public class DQ_ConformanceResult extends DQ_Result {
	private Integer conformanceresultseqn;     //ConformanceResult일련번호
//	private Integer domainconsistencyseqn;     //DomainConsistency일련번호
	private CI_Citation specification        ;     //공식명칭_CI_Citation
	private String explanation          ;     //적합성결과설명
	private String pass                 ;     //적합성결과표시 1 yes, 0 no
	
	public Integer getConformanceresultseqn() {
		return conformanceresultseqn;
	}
	public void setConformanceresultseqn(Integer conformanceresultseqn) {
		this.conformanceresultseqn = conformanceresultseqn;
	}
//	public Integer getDomainconsistencyseqn() {
//		return domainconsistencyseqn;
//	}
//	public void setDomainconsistencyseqn(Integer domainconsistencyseqn) {
//		this.domainconsistencyseqn = domainconsistencyseqn;
//	}
	public CI_Citation getSpecification() {
		return specification;
	}
	public void setSpecification(CI_Citation specification) {
		this.specification = specification;
	}
	public String getExplanation() {
		return explanation;
	}
	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	
	
}
