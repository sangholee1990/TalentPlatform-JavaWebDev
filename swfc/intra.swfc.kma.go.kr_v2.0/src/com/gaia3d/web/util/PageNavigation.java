package com.gaia3d.web.util;

import java.util.HashMap;

public class PageNavigation {
	enum PagingType {
		Google,
		Normal
	};
	
	private boolean isPrevPage; // 이전페이지 존재여부
	private boolean isNextPage; // 다음페이지 존재여부
	protected int nowPage; // 현재페이지
	protected int rowTotal; // 총 게시물수
	protected int blockList; // 한페이지에 표시될 리스트수
	protected int blockPage; // 한 블럭에 표시될 페이지수
	protected int blockSize;
	private int totalPage; // 전체페이지수
	private int startPage; // 시작페이지
	private int endPage; // 마지막 페이지
	private int startRow; // 데이타베이스의 쿼리에서 사용할 시작값
	private int endRow; // 데이타베이스의 쿼리에서 사용할 종료값
	private int startNum; // 리스트 표기시 처음 시작 숫자

	/*
	 * 페이지를 계산하는 생성자 nowPage:현재페이지 rowTotal : 총게시물수 blockList : 한페이지에 디스플레이될
	 * 게시물수 blockPage: 한 블럭에 표시될 페이지수
	 */
	public PageNavigation(int nowPage, int rowTotal, int blockList) {
		this(nowPage, rowTotal, blockList, 9);
	}

	public PageNavigation(int nowPage, int rowTotal, int blockList, int blockPage) {
		this(nowPage, rowTotal, blockList, blockPage, PagingType.Google);
	}
	
	public PageNavigation(int nowPage, int rowTotal, int blockList, int blockPage, PagingType pagingType) {
		super();

		this.nowPage = nowPage;
		this.rowTotal = rowTotal;
		this.blockList = blockList;
		this.blockPage = blockPage;

		// 각종 플래그를 초기화
		isPrevPage = false;
		isNextPage = false;

		// 입력된 전체 열의 수를 통해 전체 페이지 수를 계산한다
		this.totalPage = (int) Math.ceil((double) rowTotal / (double) blockList);

		// 현재 페이지가 전체 페이지수보다 클경우 전체 페이지수로 강제로 조정한다
		if (nowPage > this.totalPage)
			nowPage = this.totalPage;

		// 상기와 같을경우 totalPage가 0이고 nowPage가 1일경우 에러발생
		if (nowPage < 1)
			nowPage = 1;
		
		// DB입력을 위한 시작과 종료값을 구한다
		this.startRow = (nowPage - 1) * blockList + 1;
		this.endRow = this.startRow + blockList - 1;
		

		// 시작페이지와 종료페이지의 값을 구한다
		switch (pagingType) {
		case Google:
			this.startPage = Math.max(nowPage - blockPage / 2, 1);
			break;
			
		case Normal:
			this.startPage = ((nowPage - 1) / blockPage) * blockPage + 1;
			break;
		}
		this.endPage = this.startPage + blockPage - 1;

		// 리스트의 최상의 숫자를 구한다.
		this.startNum = rowTotal - (blockList * (nowPage - 1));// 리스트될 경우 최상위 숫자

		// 마지막 페이지값이 전체 페이지값보다 클 경우 강제 조정
		if (this.endPage >= this.totalPage) {
			this.endPage = totalPage;
			this.startPage = Math.max(this.endPage - blockPage, 1);
		}

		// 시작 페이지가 1보다 클 경우 이전 페이징이 가능한것으로 간주한다
		if (this.startPage > 1) {
			this.isPrevPage = true;
		}

		// 종료페이지가 전체페이지보다 작을경우 다음 페이징이 가능한것으로 간주한다
		if (this.endPage < this.totalPage) {
			this.isNextPage = true;
		}

		// 기타 값을 저장한다
		this.nowPage = nowPage;
		this.rowTotal = rowTotal;
		this.blockList = blockList;
		this.blockPage = blockPage;
	}

	public void Debug() {
		System.out.println("input : nowPage :" + this.nowPage
				+ " / rowTotal : " + this.rowTotal + " / blockList : "
				+ this.blockList + " / blockPage : " + this.blockPage
				+ " / totalPage : " + this.totalPage);
		System.out.println("Total Page : " + this.totalPage
				+ " / Start Page : " + this.startPage + " / End Page : "
				+ this.endPage);
		System.out.println("Total Row : " + this.rowTotal + " / Start Row : "
				+ this.startRow + " / End Row : " + this.endRow);
	}

	// 전체 페이지 수를 알아온다
	public int getTotalPage() {
		return totalPage;
	}

	// 시작 Row값을 가져온다
	public int getStartRow() {
		return startRow;
	}

	// 마지막 Row값을 가져온다
	public int getEndRow() {
		return endRow;
	}

	// Block Row 크기를 가져온다
	public int getBlockSize() {
		return blockSize;
	}

	// 시작페이지값을 가져온다
	public int getStartPage() {
		return startPage;
	}
	
	// 현재 페이지값을 가져온다
	public int getNowPage() {
		return nowPage;
	}

	// 마지막 페이지값을 가져온다
	public int getEndPage() {
		return endPage;
	}

	// 이전페이지의 존재유무를 가져온다
	public boolean isPrevPage() {
		return isPrevPage;
	}

	// 다음페이지의 존재유무를 가져온다
	public boolean isNextPage() {
		return isNextPage;
	}

	// 리스트 표기시 처음 시작 숫자를 가져온다.
	public int getStartNum() {
		return startNum;
	}

	public HashMap<String, String> getParams() {

		HashMap<String, String> params = new HashMap<String, String>();
		params.put("isPrevPage", new Boolean(isPrevPage).toString());
		params.put("isNextPage", new Boolean(isNextPage).toString());

		params.put("nowPage", Integer.toString(nowPage));
		params.put("rowTotal", Integer.toString(rowTotal));
		params.put("blockList", Integer.toString(blockList));
		params.put("blockPage", Integer.toString(blockPage));
		params.put("blockSize", Integer.toString(blockSize));
		params.put("totalPage", Integer.toString(totalPage));
		params.put("startPage", Integer.toString(startPage));
		params.put("endPage", Integer.toString(endPage));
		params.put("startRow", Integer.toString(startRow));
		params.put("endRow", Integer.toString(endRow));
		params.put("startNum", Integer.toString(startNum));
		return params;
	}

}
