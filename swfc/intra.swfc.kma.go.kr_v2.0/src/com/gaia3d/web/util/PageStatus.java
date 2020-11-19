package com.gaia3d.web.util;

public class PageStatus {

	private int page;
	
	public PageStatus() {
		this(1);
	}
	
	public PageStatus(int page) {
		this.page = page;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}
	
	@Override
	public String toString() {
		return "page=" + page;
	}
}
