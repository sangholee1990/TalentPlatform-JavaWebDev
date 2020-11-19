package com.gaia3d.web.dto.wmo;

import org.codehaus.jackson.annotate.JsonSubTypes;
import org.codehaus.jackson.annotate.JsonTypeInfo;

/**
 * 
 * Json Polymorphic type handling
 * http://wiki.fasterxml.com/JacksonPolymorphicDeserialization 
 * http://stackoverflow.com/questions/9066288/jersey-serialization-deserialization-issue-abstract-types-can-only-be-instantia
 * 
 * Json schema 
  
  			"@type" : {
				"type":"string",
				"display":false,
				"required":false,
				"default":"EX_GeographicDescription"
			}

 * 
 */
@JsonTypeInfo( use = JsonTypeInfo.Id.NAME, include = JsonTypeInfo.As.PROPERTY, property = "@type")
@JsonSubTypes({
@JsonSubTypes.Type(value = EX_GeographicDescription.class, name = "EX_GeographicDescription"),
@JsonSubTypes.Type(value = EX_GeographicBoundingBox.class, name = "EX_GeographicBoundingBox")
})
public abstract class EX_GeographicExtent {

	
	/**
	 * 그래픽 개체 type query
	 * 1  EX_GEOGRAPHICBOUNDINGBOX
	 * 2  EX_GEOGRAPHICDESCRIPTION
	 */
	private Integer g_type;

	private Integer extentseqn; //Extent일련번호
	
	public Integer getG_type() {
		return g_type;
	}

	public void setG_type(Integer g_type) {
		this.g_type = g_type;
	}

	public Integer getExtentseqn() {
		return extentseqn;
	}

	public void setExtentseqn(Integer extentseqn) {
		this.extentseqn = extentseqn;
	}
	
}
