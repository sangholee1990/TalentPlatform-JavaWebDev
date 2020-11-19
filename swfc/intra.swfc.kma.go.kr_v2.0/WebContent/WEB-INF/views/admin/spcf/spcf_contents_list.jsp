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
			<h4 class="page-header">특정수요자용 컨텐츠 목록</h4>
			<!-- content area start -->

			<nav class="navbar navbar-default" role="navigation">
				<div class="collapse navbar-collapse navbar-ex1-collapse text-right">
			    	<form class="navbar-form navbar-right" role="search" action="<c:url value="/admin/spcf/spcf_contents_list.do"/>" method="post" name="listForm" id="listForm">
				    	<input type="hidden" name="page" id="page" value="${param.page}">
				    	
				    	<div class="form-group">
				    		<label for="use_yn" class="control-label">사용여부</label>
				    		
					    	<select class="form-control input-sm" name="use_yn" id="use_yn">
					    			<option value="">전체</option>
					    			<option value="Y" <c:if test="${param.use_yn eq 'Y'}">selected='selected'</c:if>>사용</option>
					    			<option value="N" <c:if test="${param.use_yn eq 'N'}">selected='selected'</c:if>>미사용</option>
				    		</select>
				    	</div>
				    	<div class="form-group">
				    		<label for="search_type" class="control-label">구분</label>
				    		
				    		<select class="form-control input-sm" name="search_type" id="search_type">
				    			<option>전체</option>
				    			<option value="spcf_nm" <c:if test="${param.search_type eq 'spcf_nm'}">selected='selected'</c:if>>컨텐츠명</option>
				    			<option value="spcf_uri" <c:if test="${param.search_type eq 'spcf_uri'}">selected='selected'</c:if>>URL</option>
				    		</select>
				      	</div>
				      	
				      	<div class="form-group">
				        	<input type="text" name="search_value" class="form-control input-sm" placeholder="검색어" value="${ param.search_value }">
				      	</div>
				      	
				     	<button type="button" id="searchBtn" class="btn btn-primary btn-sm">검색</button>
			    	</form>
			  	</div>
			</nav>

	        <table class="table table-striped">
	        	<thead>
	            	<tr>
	                	<th width="10%">no</th>
	                	<th width="65%">컨텐츠명</th>
	                    <th width="15%">등록일자</th>
	                    <th width="10%">사용여부</th>
	                </tr>
	            </thead>
				<c:forEach var="o" items="${data.list}" varStatus="status">            
	            <tr>
	            	<td class="no">${data.pageNavigation.startNum - status.index}</td>
	            	<td><a href="<c:url value="/admin/spcf/spcf_contents_form.do?page=${param.page}&spcf_seq_n=${o.spcf_seq_n }"/>"><spring:escapeBody>${o.spcf_nm}</spring:escapeBody></a></td>
	                <td><fmt:formatDate value="${o.rg_date}" pattern="yyyy.MM.dd"/></td>
	                <td>
	                	<c:if test="${o.use_yn eq 'Y' }">사용</c:if>
	                	<c:if test="${o.use_yn eq 'N' }">미사용</c:if>
	                </td>
	            </tr>
	            </c:forEach>
	            <c:if test="${empty data.list }">
	            <tr>
	            	<td colspan="4">등록된 컨텐츠가 존재하지 않습니다.</td>
	            </tr>
	            </c:if>
	        </table>
		        
	        <!-- paging -->
    		<jsp:include page="/WEB-INF/views/include/commonPaging.jsp" />
	        <!-- paging -->
   			
   			
   			<div class="top-button-group">
				<input type="button" class="btn btn-primary btn-sm addBtn" title="컨텐츠등록" value="컨텐츠등록" />
			</div>
    			
			<!-- content area end -->
			
			 <!-- footer start -->
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		    <!-- footer end -->
		</div>		
	</div>
		
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript">
$(function() {
	$("#searchBtn").on("click", function() {
		paging(1);
	});
	
	$(".addBtn").on("click", function() {
		location.href = "spcf_contents_form.do";
	});
});
</script>	
</body>
</html>