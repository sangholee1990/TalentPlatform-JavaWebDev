package com.gaia3d.web.exception;

import java.io.FileNotFoundException;

public class ArticleFileNotFoundException extends FileNotFoundException {

	private static final long serialVersionUID = 1L;
	
	public ArticleFileNotFoundException() {
		super("파일이 존재하지 않습니다.");
	}
}
