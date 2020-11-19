package com.gaia3d.web.exception;

public class ArticleNotFoundException extends Exception {

	private static final long serialVersionUID = 1L;
	
	public ArticleNotFoundException() {
		super("게시물이 존재하지 않습니다.");
	}

}
