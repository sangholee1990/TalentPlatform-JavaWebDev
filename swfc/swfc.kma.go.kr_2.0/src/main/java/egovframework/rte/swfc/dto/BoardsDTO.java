package egovframework.rte.swfc.dto;

import java.io.Serializable;


public class BoardsDTO implements Serializable {
	private static final long serialVersionUID = -6340295323750948712L;
	
	Integer board_seq;				// 게시판 번호
	String title;					// 제목
	String content;					// 내용
	int boardgubun;					// 게시판 구분
	String board_code_cd;			// 게시판 코드
	String create_date;				// 등록일자
	String create_tm;				// 등록시간
	int hit;						// 조회수
	String writer;					// 등록자
	String writer_ip;				// 등록자 아이피
	String pw;						// 비밀번호
	String email;					// 이메일
	String update_date;				// 수정일자
	String update_tm;				// 수정시간
	String use_yn;					// 표출여부
	int sitegubun;					// 사이트 구분
	String site_code_cd;				// 사이트 코드
	String site_nm;					// 사이트 구분 국문명
	String site_eng;				// 사이트 구분 영문명
	String board_section_nm;				// 사이트 구분 영문명
	String board_section_cd;				// 사이트 구분 영문명
	String is_new;
	String popup_yn;						// 팝업 여부
	
	public String getIs_new() {
		return is_new;
	}
	public void setIs_new(String is_new) {
		this.is_new = is_new;
	}
	public Integer getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(Integer board_seq) {
		this.board_seq = board_seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getBoardgubun() {
		return boardgubun;
	}
	public void setBoardgubun(int boardgubun) {
		this.boardgubun = boardgubun;
	}
	public int getSitegubun() {
		return sitegubun;
	}
	public void setSitegubun(int sitegubun) {
		this.sitegubun = sitegubun;
	}
	
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	public String getWriter_ip() {
		return writer_ip;
	}
	public void setWriter_ip(String writer_ip) {
		this.writer_ip = writer_ip;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	
	public String getUpdate_tm() {
		return update_tm;
	}
	public void setUpdate_tm(String update_tm) {
		this.update_tm = update_tm;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	
	public String getBoard_code_cd() {
		return board_code_cd;
	}
	public void setBoard_code_cd(String board_code_cd) {
		this.board_code_cd = board_code_cd;
	}
	public String getSite_nm() {
		return site_nm;
	}
	public void setSite_nm(String site_nm) {
		this.site_nm = site_nm;
	}
	public String getSite_eng() {
		return site_eng;
	}
	public void setSite_eng(String site_eng) {
		this.site_eng = site_eng;
	}
	public String getSite_code_cd() {
		return site_code_cd;
	}
	public void setSite_code_cd(String site_code_cd) {
		this.site_code_cd = site_code_cd;
	}
	public String getBoard_section_nm() {
		return board_section_nm;
	}
	public void setBoard_section_nm(String board_section_nm) {
		this.board_section_nm = board_section_nm;
	}
	public String getBoard_section_cd() {
		return board_section_cd;
	}
	public void setBoard_section_cd(String board_section_cd) {
		this.board_section_cd = board_section_cd;
	}
	public String getPopup_yn() {
		return popup_yn;
	}
	public void setPopup_yn(String popup_yn) {
		this.popup_yn = popup_yn;
	}	
	
	
}
