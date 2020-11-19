package com.gaia3d.web.vo;

import java.io.Serializable;

public class FontVo implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String fontName;
	private Integer fontIndex;
	
	public String getFontName() {
		return fontName;
	}
	public void setFontName(String fontName) {
		this.fontName = fontName;
	}
	public Integer getFontIndex() {
		return fontIndex;
	}
	public void setFontIndex(Integer fontIndex) {
		this.fontIndex = fontIndex;
	}
	@Override
	public String toString() {
		return "FontVo [fontName=" + fontName + ", fontIndex=" + fontIndex
				+ "]";
	}
	
	

}
