package com.gaia3d.web.dto;

import org.hibernate.validator.constraints.NotBlank;

public class UserGroup {
	@NotBlank
	String code;
	
	@NotBlank
	String name;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
