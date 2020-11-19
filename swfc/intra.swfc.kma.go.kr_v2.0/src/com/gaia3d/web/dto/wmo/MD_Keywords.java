package com.gaia3d.web.dto.wmo;

import javax.xml.bind.annotation.XmlElement;

public class MD_Keywords {

	private Integer keywordsseqn           ;   //Keywords일련번호
	private Integer dataidentificationseqn ;   //DataIdentification일련번호
	private String keyword                ;   //키워드
	private String type                   ;   //그룹형식
	private CI_Citation thesaurusname          ;   //공식명칭_CI_Citation
	
	
	public Integer getKeywordsseqn() {
		return keywordsseqn;
	}
	public void setKeywordsseqn(Integer keywordsseqn) {
		this.keywordsseqn = keywordsseqn;
	}
	public Integer getDataidentificationseqn() {
		return dataidentificationseqn;
	}
	public void setDataidentificationseqn(Integer dataidentificationseqn) {
		this.dataidentificationseqn = dataidentificationseqn;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public CI_Citation getThesaurusname() {
		return thesaurusname;
	}
	public void setThesaurusname(CI_Citation thesaurusname) {
		this.thesaurusname = thesaurusname;
	}
	
	
}
