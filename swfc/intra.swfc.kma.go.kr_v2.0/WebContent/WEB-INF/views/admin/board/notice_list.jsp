<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!doctype html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />
</head>
<body>
<div class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	
	<!--  -->
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">공지사항</h4>
			<!-- content area start -->


			<!-- SEARCH -->
    		<nav class="navbar navbar-default" role="navigation">
				<div class="collapse navbar-collapse navbar-ex1-collapse text-right">
			    	<form class="navbar-form navbar-right" role="search" action="<c:url value="/admin/board/notice_list.do"/>" method="post" name="searchForm" id="searchForm">
			    	<input type="hidden" name="iPage" id="iPage" value="${pageNavigation.nowPage}">
			      	<div class="form-group">
			    		<label for="site_code_cd" class="control-label">사이트 구분</label>
	            		<select class="form-control input-sm"  name="site_code_cd" id="site_code_cd" title="검색">
	            			<option value="">[전체]</option>
			    			<c:forEach var="o" items="${subList}" varStatus="status">            
			            	<option value="${o.code}" <c:if test="${o.code eq param.site_code_cd}">selected="selected"</c:if>>${o.code_nm}</option>
	            			</c:forEach>
			            </select>
			      	</div>
			      	
			      	<div class="form-group">
			    		<label for="use_yn" class="control-label">표출 여부</label>
	            		<select class="form-control input-sm"  name="use_yn" id="use_yn" title="검색">
			    			<option value="" <c:if test="${param.use_yn eq ''}">selected="selected"</c:if>>[전체]</option>
							<option value="Y" <c:if test="${param.use_yn eq 'Y'}">selected="selected"</c:if>>표출</option>
							<option value="N" <c:if test="${param.use_yn eq 'N'}">selected="selected"</c:if>>미표출</option>
			            </select>
			      	</div>

			      	<div class="form-group">
			    		<label for="system_seq" class="control-label">검색 조건</label>
			    		<select class="form-control input-sm"  name="search_target" id="search_target" title="검색">
							<option value="" <c:if test="${param.search_target eq ''}">selected="selected"</c:if>>[전체]</option>
							<option value="title" <c:if test="${param.search_target eq 'title'}">selected="selected"</c:if>>제목</option>
							<option value="content" <c:if test="${param.search_target eq 'content'}">selected="selected"</c:if>>내용</option>
						</select>
						<input class="form-control input-sm" type="text" title="검색어 입력" name="search_text" id="search_text" value="${param.search_text}" />
			      	</div>

			     	<button type="button" id="searchBtn" class="btn btn-primary btn-sm">검색</button>
			    	</form>
			  	</div>
			</nav>
			<!-- SEARCH -->
			
			 <div class="top-button-group">
				<input type="button" class="btn btn-primary btn-sm addBtn" title="등록" value="등록" />
			 </div>
			
    		<table class="table table-striped">
	        	<colgroup>
	        		<col width="50">
	        		<col width="100">
	        		<col width="*">
	        		<col width="80">
	        		<col width="80">
	        		<col width="80">
	        		<col width="70">
	        		<col width="120">
	        	</colgroup>
	        	<thead>
	            	<tr>
	                	<th>No</th>
	                	<th>사이트 구분</th>
	                    <th>제목</th>
	                    <th>조회수</th>
	                    <th>표출여부</th>
	                    <th>팝업여부</th>
	                    <th>등록자</th>
	                    <th>등록일자</th>
	                </tr>
	            </thead>
	            <tbody>
	             <c:choose>
            	<c:when test="${fn:length(list) == 0}">
            		<tr><td colspan="8">등록된 컨텐츠가 없습니다.</td></tr>
            	</c:when>
            	<c:otherwise>
					<c:forEach var="o" items="${list}" varStatus="status">            
		            <tr>
		            	<td class="no">${pageNavigation.startNum - status.index}</td>
		                <td><spring:escapeBody>${o.site_nm}</spring:escapeBody></td>
		                <td class="text-left"><a href="javascript:goView(${o.board_seq});"><spring:escapeBody>${o.title}</spring:escapeBody></a>
		                <c:if test="${ o.is_new  eq 'Y'}"><span class="label label-default">N</span></c:if>
		                </td>
		                <td>${o.hit }</td>
		                <td><spring:escapeBody>${o.use_yn eq 'Y' ? '표출' : '미표출'}</spring:escapeBody></td>
		                <td><spring:escapeBody>${o.popup_yn eq 'Y' ? '표출' : '미표출'}</spring:escapeBody></td>
		                <td><spring:escapeBody>${o.writer}</spring:escapeBody></td>
		                <td><spring:escapeBody>${o.create_date}</spring:escapeBody></td>
		            </tr>
		            </c:forEach>
		         </c:otherwise>
		       </c:choose>
				</tbody>
	        </table>
	        <div class="top-button-group">
				<input type="button" class="btn btn-primary btn-sm addBtn" title="등록" value="등록" />
			</div>
			    
	    	<!-- START PAGER -->  
			<div class="text-center">
			   <ul class="pagination pagination-sm">
			  		<c:if test="${pageNavigation.prevPage}">
				        <li><a href="javascript:goPage(1);" title="처음">&#60;&#60;</a></li>
				        <li><a href="javascript:goPage(${pageNavigation.startPage - 1});" title="이전">&#60;</a></li>
			        </c:if>
			        <c:forEach var="page" begin="${pageNavigation.startPage}" end="${pageNavigation.endPage}">
			        	<li <c:if test="${page eq pageNavigation.nowPage}">class="active"</c:if>><a href="javascript:goPage(${page});">${page}</a></li>
			        </c:forEach>
			        <c:if test="${pageNavigation.nextPage}">
						<li><a href="javascript:goPage(${pageNavigation.endPage + 1});" title="다음">&#62;</a></li>
			        	<li><a href="javascript:goPage(${pageNavigation.totalPage});" title="끝">&#62;&#62;</a></li>        
			        </c:if>
				</ul>
			</div>
	    	<!-- END PAGER --> 
	    	
	    	 <!-- footer start -->
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		    <!-- footer end --> 
	    </div>
	</div>
</div>
<!-- END CONTENTS -->

<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />

<script type="text/javascript">

$(function() { //html 문서가 처음 로딩 되고 난후 실행되는 init 함수
	
	//공지사항 글 등록 페이지로 이동
	$(".addBtn").click(function() {
		location.href="notice_form.do";
	});
});


	// 공지사항 글 상세보기
	function goView(board_seq){
		$(paramForm).addHidden("board_seq", board_seq);
		$(paramForm).attr("action", "notice_view.do");
		$(paramForm).submit();
	}
</script>

</body>
</html>
