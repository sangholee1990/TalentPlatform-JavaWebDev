package com.gaia3d.web.dto;

public class BoardsFileDTO {
	Integer board_file_seq;			// 게시판 파일 번호
	Integer board_seq;				// 부모 게시판 번호
	String filepath;				// 파일경로
	String filename;				// 파일명
	String create_date;				// 등록일자
	String create_tm;				// 등록시간
	
	public Integer getBoard_file_seq() {
		return board_file_seq;
	}
	public void setBoard_file_seq(Integer board_file_seq) {
		this.board_file_seq = board_file_seq;
	}
	public Integer getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(Integer board_seq) {
		this.board_seq = board_seq;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getCreate_tm() {
		return create_tm;
	}
	public void setCreate_tm(String create_tm) {
		this.create_tm = create_tm;
	}
}
