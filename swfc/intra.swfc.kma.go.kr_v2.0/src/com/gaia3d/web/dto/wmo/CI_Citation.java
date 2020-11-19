package com.gaia3d.web.dto.wmo;

import java.util.List;

public class CI_Citation {
	private Integer citationseqn          ;    //Citation일련번호
	private Integer dataidentificationseqn;    //DataIdentification일련번호
	private Integer keywordsseqn          ;    //Keywords일련번호
	private Integer conformanceresultseqn ;    //ConformanceResult일련번호
	private String title                 ;    //자료이름
	private String alternativetitle      ;    //요약이름
	private List<CI_Date> dates                 ;    //조회날짜_CI_Date
	private List<MD_Identifier> identifier            ;    //대상식별고유값_MD_Identifier
	private List<CI_ResponsibleParty> citedresponsibleparty ;    //관련그룹_CI_ResponsibleParty
	private String presentationform      ;    //자료형식
	public Integer getCitationseqn() {
		return citationseqn;
	}
	public void setCitationseqn(Integer citationseqn) {
		this.citationseqn = citationseqn;
	}
	public Integer getDataidentificationseqn() {
		return dataidentificationseqn;
	}
	public void setDataidentificationseqn(Integer dataidentificationseqn) {
		this.dataidentificationseqn = dataidentificationseqn;
	}
	public Integer getKeywordsseqn() {
		return keywordsseqn;
	}
	public void setKeywordsseqn(Integer keywordsseqn) {
		this.keywordsseqn = keywordsseqn;
	}
	public Integer getConformanceresultseqn() {
		return conformanceresultseqn;
	}
	public void setConformanceresultseqn(Integer conformanceresultseqn) {
		this.conformanceresultseqn = conformanceresultseqn;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAlternativetitle() {
		return alternativetitle;
	}
	public void setAlternativetitle(String alternativetitle) {
		this.alternativetitle = alternativetitle;
	}
	public List<CI_Date> getDates() {
		return dates;
	}
	public void setDates(List<CI_Date> dates) {
		this.dates = dates;
	}
	public List<MD_Identifier> getIdentifier() {
		return identifier;
	}
	public void setIdentifier(List<MD_Identifier> identifier) {
		this.identifier = identifier;
	}
	public List<CI_ResponsibleParty> getCitedresponsibleparty() {
		return citedresponsibleparty;
	}
	public void setCitedresponsibleparty(
			List<CI_ResponsibleParty> citedresponsibleparty) {
		this.citedresponsibleparty = citedresponsibleparty;
	}
	public String getPresentationform() {
		return presentationform;
	}
	public void setPresentationform(String presentationform) {
		this.presentationform = presentationform;
	}
	
	
}
