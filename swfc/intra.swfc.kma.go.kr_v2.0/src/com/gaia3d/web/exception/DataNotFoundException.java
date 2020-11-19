package com.gaia3d.web.exception;

public class DataNotFoundException extends RuntimeException {

	private static final long serialVersionUID = 1L;
	
	public DataNotFoundException() {
		super("데이터가 존재하지 않습니다.");
	}
}
