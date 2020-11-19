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

	<div class="row">
		<div class="col-sm-12 col-md-12">
			<h4 class="page-header">범위 정보</h4>
			<!-- content area start -->
				

			<!-- SEARCH -->
    		<nav class="navbar navbar-default" role="navigation">
					<div class="collapse navbar-collapse navbar-ex1-collapse text-right">
				    	<form class="navbar-form navbar-right" role="search" action="coverage_list_popup.do" method="post" name="listForm" id="listForm">
				    	<input type="hidden" name="iPage" id="iPage" value="${pageNavigation.nowPage}">
				      	<input type="hidden" name="search_del" id="search_del" value="N"/>	
				      	<input type="hidden" name="search_use" id="search_use" value="Y"/>	
				      	
				    	<div class="form-group">
				    		<label for="system_seq" class="control-label">검색조건</label>
				    		<select class="form-control input-sm"   name="search_target" id="search_target" title="검색">
								<option value="">[전체]</option>
								<option value="coverage_kor_nm" <c:if test="${param.search_target eq 'coverage_kor_nm'}">selected="selected"</c:if> >한글명</option>
								<option value="coverage_eng_nm" <c:if test="${param.search_target eq 'coverage_eng_nm'}">selected="selected"</c:if> >영문명</option>
							</select>
							<input class="form-control input-sm"   type="text" title="검색어 입력" name="search_text" id="search_text" value="${param.search_text}" />
				      	</div>
				     	<button type="button" id="searchBtn" class="btn btn-primary btn-sm">검색</button>
				    	</form>
				  	</div>
			</nav>
    				
	        <table id="searchResultList" class="table table-striped">
	        	<thead>
	            	<tr>
	                	<th>No</th>
	                	<th>한글명</th>
	                    <th>영문명</th>
	                    <th>사용여부</th>
	                    <th>등록일</th>
	                </tr>
	            </thead>
				<c:forEach var="o" items="${list}" varStatus="status">            
	            <tr>
	            	<td class="col-sm-1">${pageNavigation.startNum - status.index}</td>
	            	<td class="col-sm-4 text-left"><a href="javascript:goSelect(${o.coverage_seq_n},'${o.coverage_kor_nm}');"><spring:escapeBody>${o.coverage_kor_nm}</spring:escapeBody></a></td>
	                <td class="col-sm-4 text-left"><spring:escapeBody>${o.coverage_eng_nm}</spring:escapeBody></td>
	                <td class="col-sm-1"><spring:escapeBody><custom:UseYNConvert useYN="${o.use_f_cd}" /></spring:escapeBody></td>
	                <td class="col-sm-2"><spring:escapeBody><custom:DateFormatConvert strDate="${o.rg_d}" strTime="${o.rg_tm}" /></spring:escapeBody></td>
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
    		
		</div>
	</div>
</div>
<!-- END CONTENTS -->

<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript" src="<c:url value="/js/metadata/metadata.js"/>"></script>
<script type="text/javascript">

// 검색
// $(function() {
// 	$("#searchBtn").click(function() {
// 		goPage(1);
// 	});
// });

//페이지 이동
// function goPage(iPage){
// 	$("#iPage").val(iPage);
// 	$("#searchForm").attr("action","coverage_list_popup.do");
// 	$("#searchForm").submit();
// }

//상세보기
function goSelect(seq, nm){
	window.opener.setCoverage(seq, nm);
	window.close();
}
</script>
</body>
</html>
