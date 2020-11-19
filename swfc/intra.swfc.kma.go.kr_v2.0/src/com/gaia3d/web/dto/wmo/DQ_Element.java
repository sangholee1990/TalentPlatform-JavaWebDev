package com.gaia3d.web.dto.wmo;

import org.codehaus.jackson.annotate.JsonSubTypes;
import org.codehaus.jackson.annotate.JsonTypeInfo;

@JsonTypeInfo( use = JsonTypeInfo.Id.NAME, include = JsonTypeInfo.As.PROPERTY, property = "@type")
@JsonSubTypes({
@JsonSubTypes.Type(value = DQ_DomainConsistency.class, name = "DQ_DomainConsistency")
})
public abstract class DQ_Element {

	private Integer dataqualityseqn      ;     //DataQuality일련번호

	public Integer getDataqualityseqn() {
		return dataqualityseqn;
	}

	public void setDataqualityseqn(Integer dataqualityseqn) {
		this.dataqualityseqn = dataqualityseqn;
	}
	
	
}
