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
			<h4 class="page-header">사용자관리</h4>
			<!-- content area start -->
				           
		        <table class="table table-striped">
		        	<thead>
		            	<tr>
		                	<th>no</th>
		                	<th>아이디</th>
		                    <th>담당자</th>
		                    <th>부서</th>
		                    <th>직급</th>
		                    <th>전화번호</th>
		                    <th>이메일</th>
		                    <th>사용자권한</th>
		                </tr>
		            </thead>
					<c:forEach var="o" items="${list}" varStatus="status">            
		            <tr>
		            	<td class="no">${pageNavigation.startNum - status.index}</td>
		            	<td><a href="user_view.do?id=${o.id}&p=${pageNavigation.nowPage}"><spring:escapeBody>${o.userId}</spring:escapeBody></a></td>
		                <td><a href="user_view.do?id=${o.id}&p=${pageNavigation.nowPage}"><spring:escapeBody>${o.name}</spring:escapeBody></a></td>
		                <td><spring:escapeBody>${o.department}</spring:escapeBody></td>
		                <td><spring:escapeBody>${o.position}</spring:escapeBody></td>
		                <td><spring:escapeBody>${o.phone}</spring:escapeBody></td>
		                <td><spring:escapeBody>${o.email}</spring:escapeBody></td>
		                <td><custom:RoleConverter role="${o.role}"/></td>
		            </tr>
		            </c:forEach>
		        </table>
		        
		        <!-- paging -->
	    		<jsp:include page="/WEB-INF/views/include/adminPaging.jsp" />
		        <!-- paging -->
    			
    			
    			<div class="top-button-group">
					<input type="button" class="btn btn-primary btn-sm" title="사용자등록" value="사용자등록" />
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
	$(":button").click(function() {
		location.href="user_form.do";
	});
});
</script>	
</body>
</html>