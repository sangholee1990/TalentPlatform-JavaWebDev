package com.gaia3d.web.util;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.pdf.PdfPCell;

public class PdfStyle {

	/**
	 * cell의 스타일을 설정한다.
	 * 
	 * @param cell
	 * @param border
	 * @param horizontal_aignment
	 * @param vertical_alignment
	 * @param fixed_height
	 * @param base_color
	 * @return
	 */
	public void setCellStyle(PdfPCell cell, int horizontal_aignment, int vertical_alignment, float fixed_height, BaseColor base_color) {
		cell.setHorizontalAlignment(horizontal_aignment);
		cell.setVerticalAlignment(vertical_alignment);
		cell.setFixedHeight(fixed_height);
		cell.setBackgroundColor(base_color);
	}
	
	/**
	 * cell의 스타일을 설정한다.
	 * 
	 * @param cell
	 * @param border
	 * @param horizontal_aignment
	 * @param vertical_alignment
	 * @param base_color
	 * @return
	 */
	public void setCellStyle(PdfPCell cell, int horizontal_aignment, int vertical_alignment, BaseColor base_color) {
		cell.setHorizontalAlignment(horizontal_aignment);
		cell.setVerticalAlignment(vertical_alignment);
		cell.setBackgroundColor(base_color);
	}
	
	/**
	 * cell의 스타일을 설정한다.
	 * 
	 * @param cell
	 * @param border
	 * @param horizontal_aignment
	 * @param vertical_alignment
	 * @param fixed_height
	 * @return
	 */
	public void setCellStyle(PdfPCell cell, int horizontal_aignment, int vertical_alignment, float fixed_height) {
		cell.setHorizontalAlignment(horizontal_aignment);
		cell.setVerticalAlignment(vertical_alignment);
		cell.setFixedHeight(fixed_height);
	}
	
	/**
	 * cell의 스타일을 설정한다.
	 * 
	 * @param cell
	 * @param border
	 * @param horizontal_aignment
	 * @param vertical_alignment
	 * @return
	 */
	public void setCellStyle(PdfPCell cell, int horizontal_aignment, int vertical_alignment) {
		cell.setHorizontalAlignment(horizontal_aignment);
		cell.setVerticalAlignment(vertical_alignment);
	}
	
	/**
	 * cell의 Padding을 설정한다.
	 * 
	 * @param cell
	 * @param left
	 * @param right
	 * @param top
	 * @param bottom
	 * @return
	 */
	public void setCellPaddingStyle(PdfPCell cell, float left, float right, float top, float bottom) {
		cell.setPaddingLeft(left);
		cell.setPaddingRight(right);
		cell.setPaddingTop(top);
		cell.setPaddingBottom(bottom);
	}
	
	/**
	 * cell의 Padding을 설정한다.
	 * 
	 * @param cell
	 * @param left
	 * @param right
	 * @param bottom
	 * @return
	 */
	public void setCellPaddingStyle(PdfPCell cell, float left, float right, float bottom) {
		cell.setPaddingLeft(left);
		cell.setPaddingRight(right);
		cell.setPaddingBottom(bottom);
	}
}
