<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%><%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/js/plugin/lightbox/css/lightbox.css"/>" />
<style type="text/css">
	.searchBox {
		width:100%; 
		vertical-align: middle;
	}
	
	.searchBox select {
		float: left;
	}
	.searchBox a {
		float: right;
	}
</style>
<jsp:include page="/WEB-INF/views/include/jquery.jsp" />
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript" src="<c:url value="/resources/common/js/plugin/lightbox/js/lightbox.js"/>"></script>
<script type="text/javascript">
//검색
$(function() {
	$("#searchBtn").click(function() {
		goSearch(1);
	});
	
	$('.pager a').on('click', function(e){
		e.preventDefault();
		goSearch($(this).attr('page'));
	});
});

function goSearch(page){
	$("#iPage").val(page);
	$("#searchForm").submit();
}

// 상세보기
function goView(board_seq){
	$(paramForm).addHidden("board_seq", board_seq);
	$(paramForm).attr("action", "notice_view.do");
	$(paramForm).submit();
}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/topMenu.jsp"/>
<div id="wrap_sub">
	<h2 class="community">
    	<span>정보마당</span>
    </h2>
    <div id="tab" class="tab2">
    	<a href="<c:url value="/ko/board/notice_list.do"/>" class="notice on"><span>공지사항</span></a>
        <a href="<c:url value="/ko/board/faq_list.do"/>" class="faq"><span>FAQ</span></a>
        <a href="<c:url value="/ko/board/archives_list.do"/>" class="data"><span>자료실</span></a>
    </div>
    <!-- 공지사항 -->
    <div id="notice">
        <h3 class="noticet">
            <span>공지사항</span>
        </h3>
        <form name="searchForm" id="searchForm" action="notice_list.do"  method="post">
        <input type="hidden" name="iPage" id="iPage" value="${pageNavigation.nowPage}" />
		<div class='searchbox'>
			<select class='sel_sort' name="search_target">
				<option value="" <c:if test="${param.search_target eq ''}">selected="selected"</c:if>>[전체]</option>
				<option value="title" <c:if test="${param.search_target eq 'title'}">selected="selected"</c:if>>제목</option>
				<option value="content" <c:if test="${param.search_target eq 'content'}">selected="selected"</c:if>>내용</option>
			</select>
			<input class='inp_search' type="text" title="검색어 입력" name="search_text" id="search_text" value="${param.search_text}" />
			<a href='#' id="searchBtn" class='bt_search'><img src='<c:url value="/resources/ko/images/bt_search.png"/>' alt='검색'/></a>
		</div>
		</form>
		<!-- bbs : list-->
		<table summary='News & Notice' class="list">
			<caption class='txt_hidden'>News & Notice</caption>
			<colgroup>
				<col width='10%'/>
				<col width='60%'/>
				<col width='10%'/>
				<col width='10%'/>
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>날짜</th>
					<th class='th_date'>조회수</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="item" items="${list}" varStatus="status">
           	<tr>
                <td>${pageNavigation.startNum - status.index}</td>
                <td style="text-align:left"><a href="javascript:goView(${item.board_seq});"><spring:escapeBody javaScriptEscape="true" htmlEscape="true">${item.title}</spring:escapeBody></a></td>
                <td>${item.create_date}</td>
                <td>${item.hit}</td>
            </tr>
            </c:forEach>
            <c:if test="${empty list}"> 
				<tr>
					<td colspan="4">컨텐츠가 존재하지 않습니다.</td>
				</tr> 
			</c:if>
			</tbody>
		</table><!-- //bbs -->
		
		<div class="pager">
	  		<c:if test="${pageNavigation.prevPage}">
	  			<a href="#" class="fir" page="1"><span>처음</span></a>
	  			<a href="#" page="${pageNavigation.startPage - 1}" class="pre"><span>이전</span></a>
	        </c:if>
	        <c:forEach var="page" begin="${pageNavigation.startPage}" end="${pageNavigation.endPage}">
	        	<a href="#" <c:if test="${page == pageNavigation.nowPage}">class="tsp"</c:if> page="${page}">${page}</a>
	        </c:forEach>
	        <c:if test="${pageNavigation.nextPage}">
		        <a href="#" class="nex" page="${pageNavigation.endPage + 1}"><span>다음</span></a>
		        <a href="#" class="las" page="${pageNavigation.totalPage}"><span>마지막</span></a>
	        </c:if>
	    </div>
    <!-- END 공지사항 -->
	
    </div>
    <!-- END PAGER -->
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>