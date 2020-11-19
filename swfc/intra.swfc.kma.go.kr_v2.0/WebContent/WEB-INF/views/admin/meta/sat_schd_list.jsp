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

	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">수집대상 스케줄 정보</h4>
			<!-- content area start -->
				

			<!-- SEARCH -->
    		<nav class="navbar navbar-default" role="navigation">
					<div class="collapse navbar-collapse navbar-ex1-collapse text-right">
				    	<form class="navbar-form navbar-right" role="search" action="/admin/report/dailyReport.do" method="post" name="listForm" id="listForm">
				    	<input type="hidden" name="iPage" id="iPage" value="${pageNavigation.nowPage}">
				    	<input type="hidden" name="search_del" id="search_del" value="N">
				      	
				    	<div class="form-group">
				    		<label for="system_seq" class="control-label">구분</label>
				    		<select class="form-control input-sm"   name="search_target" id="search_target" title="검색">
								<option value="">[전체]</option>
								<option value="clt_tar_kor_nm" <c:if test="${searchInfo.search_target eq 'clt_tar_kor_nm'}">selected="selected"</c:if> >한글명</option>
								<option value="clt_tar_eng_nm" <c:if test="${searchInfo.search_target eq 'clt_tar_eng_nm'}">selected="selected"</c:if> >영문명</option>
							</select>
							<input class="form-control input-sm"   type="text" title="검색어 입력" name="search_text" id="search_text" value="${searchInfo.search_text}" />
				      	</div>
				      	
				      	<div class="form-group">
				      	    <label for="search_use" class="control-label">사용여부</label>
				        	<select class="form-control input-sm"   name="search_use" id="search_use" title="검색">
								<option value="" >[전체]</option>
								<option value="Y" <c:if test="${searchInfo.search_use eq 'Y'}">selected="selected"</c:if> >사용</option>
								<option value="N" <c:if test="${searchInfo.search_use eq 'N'}">selected="selected"</c:if> >미사용</option>
							</select>
				      	</div>
				      	
				     	<button type="button" id="searchBtn" class="btn btn-primary btn-sm">검색</button>
				    	</form>
				  	</div>
			</nav>
    				
   		    <div class="top-button-group">
				<input type="button" class="btn btn-primary btn-sm" title="수집대상 스케줄 " value="수집대상 스케줄 " />
			</div>
          
	        <table id="searchResultList" class="table table-striped">
	        	<thead>
	            	<tr>
	                	<th>no</th>
	                	<th>수집대상 한글명</th>
	                    <th>수집대상 영문명</th>
	                    <th>수신시시작프로그램</th>
	                    <th>사용여부</th>
	                    <th>삭제여부</th>
	                    <th>등록일</th>
	                </tr>
	            </thead>
				<c:forEach var="o" items="${list}" varStatus="status">            
	            <tr>
	            	<td class="no">${pageNavigation.startNum - status.index}</td>
	            	<td><a href="javascript:goView(${o.clt_tar_sch_seq_n});"><spring:escapeBody>${o.clt_tar_kor_nm}</spring:escapeBody></a></td>
	                <td><a href="javascript:goView(${o.clt_tar_sch_seq_n});"><spring:escapeBody>${o.clt_tar_eng_nm}</spring:escapeBody></a></td>
	                <td><spring:escapeBody>${o.rcv_st_pgm}</spring:escapeBody></td>
	                <td><spring:escapeBody>${o.use_f_cd}</spring:escapeBody></td>
	                <td><spring:escapeBody>${o.del_f_cd}</spring:escapeBody></td>
	                <td><spring:escapeBody><custom:DateFormatConvert strDate="${o.rg_d}" strTime="${o.rg_tm}" /></spring:escapeBody></td>
	            </tr>
	            </c:forEach>
	        </table>
	    
	    	<!-- START PAGER -->  
		    <div class="text-center">
			   <ul class="pagination pagination-sm">
			  		<c:if test="${pageNavigation.prevPage}">
				        <li class="active"><a href="javascript:goPage(1);" title="처음"><img src="../images/pager_ico_first.png" alt="이전" /></a></li>
				        <li class="active"><a href="javascript:goPage(${pageNavigation.startPage - 1});" title="이전"><img src="../images/pager_ico_prev.png" alt="이전" /></a></li>
			        </c:if>
			        <c:forEach var="page" begin="${pageNavigation.startPage}" end="${pageNavigation.endPage}">
			        	<li <c:if test="${page eq pageNavigation.nowPage}">class="active"</c:if>><a href="javascript:goPage(${page});">${page}</a></li>
			        </c:forEach>
			        <c:if test="${pageNavigation.nextPage}">
						<li class="active"><a href="javascript:goPage(${pageNavigation.endPage + 1});" title="다음"><img src="../images/pager_ico_next.png" alt="이전" /></a></li>
			        	<li class="active"><a href="javascript:goPage(${pageNavigation.totalPage});" title="끝"><img src="../images/pager_ico_last.png" alt="이전" /></a></li>        
			        </c:if>
				</ul>
			</div>
    		<!-- END PAGER --> 
    		
    		<jsp:include page="/WEB-INF/views/include/commonFooter.jsp" /> 
    		
		</div>
	</div>
</div>
<!-- END CONTENTS -->

<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript" src="<c:url value="/js/metadata/metadata.js"/>"></script>
<script type="text/javascript">

//파라메터 설정
function getParamURL(){

	var search_target = $("#search_target").val();
	var search_text = $("#search_text").val();
	var search_use = $("#search_use").val();
	var search_del = $("#search_del").val();
	var iPage = $("#iPage").val();
	
	return "?search_target=" + search_target 
			+ "&search_text=" + search_text 
			+ "&search_use=" + search_use 
			+ "&search_del="+ search_del 
			+ "&iPage=" + iPage;
}


// 센서 등록
$(function() {
	$(":button").click(function() {
		location.href="sat_schd_form.do";
	});
});


// 검색
$(function() {
	$("#searchBtn").click(function() {
		$("#iPage").val(1);
		location.href= getParamURL();
	});
});

//페이지 이동
function goPage(iPage){
	$("#iPage").val(iPage);
	location.href= getParamURL();
}

//상세보기
function goView(clt_tar_schd_seq_n){
	location.href= "sat_schd_view.do" + getParamURL()
		+ "&clt_tar_schd_seq_n=" + clt_tar_schd_seq_n ;
}
</script>
</body>
</html>
