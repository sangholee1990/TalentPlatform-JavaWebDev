package egovframework.rte.swfc.dto;

public class SpecificUserContentDTO {
	private int orderNum;	//순서
	private int spcfSeq;	//메뉴 번호
	private String uri;		//컨텐츠 경로
	private String title;	//컨텐츠 명
	private char userUse;	//사용자 사용 여부
	private char adminUse;	//관리자 허용 여부
	private String cssInfo;	//스타일 저장
	
	
	
	
	public String getCssInfo() {
		return cssInfo;
	}
	public void setCssInfo(String cssInfo) {
		this.cssInfo = cssInfo;
	}
	public int getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}
	public int getSpcfSeq() {
		return spcfSeq;
	}
	public void setSpcfSeq(int spcfSeq) {
		this.spcfSeq = spcfSeq;
	}
	public String getUri() {
		return uri;
	}
	public void setUri(String uri) {
		this.uri = uri;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public char getUserUse() {
		return userUse;
	}
	public void setUserUse(char userUse) {
		this.userUse = userUse;
	}
	public char getAdminUse() {
		return adminUse;
	}
	public void setAdminUse(char adminUse) {
		this.adminUse = adminUse;
	}

	
	
}//class end
