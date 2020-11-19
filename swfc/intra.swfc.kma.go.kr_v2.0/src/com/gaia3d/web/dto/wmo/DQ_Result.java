package com.gaia3d.web.dto.wmo;

import org.codehaus.jackson.annotate.JsonSubTypes;
import org.codehaus.jackson.annotate.JsonTypeInfo;

@JsonTypeInfo( use = JsonTypeInfo.Id.NAME, include = JsonTypeInfo.As.PROPERTY, property = "@type")
@JsonSubTypes({
@JsonSubTypes.Type(value = DQ_ConformanceResult.class, name = "DQ_ConformanceResult")
})
public abstract class DQ_Result {

	private Integer domainconsistencyseqn;     //DomainConsistency일련번호

	public Integer getDomainconsistencyseqn() {
		return domainconsistencyseqn;
	}

	public void setDomainconsistencyseqn(Integer domainconsistencyseqn) {
		this.domainconsistencyseqn = domainconsistencyseqn;
	}
	
	
}
