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
			<h4 class="page-header">프로그램 관리</h4>
			<!-- content area start -->
				
				<table class="table table-striped">
		        	<thead>
		            	<tr>
		                	<th>no</th>
		                    <th>등록날짜</th>
		                    <th>종류</th>
		                    <th>항목명</th>
		                    <th>다운로드</th>
		                    <th>삭제</th>
		                </tr>
		            </thead>
					<c:forEach var="o" items="${list}" varStatus="status">            
		            <tr>
		            	<td class="no" style="vertical-align: middle">${pageNavigation.startNum - status.index}</td>
		                <td style="vertical-align: middle"><fmt:formatDate value="${o.writeDate}" pattern="yyyy.MM.dd HH:mm"/></td>
		                <td style="vertical-align: middle"><spring:escapeBody>${o.type}</spring:escapeBody></td>
		                <td style="vertical-align: middle"><a href="program_form.do?id=${o.id}"><spring:escapeBody>${o.name}</spring:escapeBody></a></td>
		                <td style="vertical-align: middle"><input type="button" title="다운로드" value="다운로드" class="btn btn-info btn-sm btn-xs downBtn" onclick="location.href='program_download.do?id=${o.id}';"/> </td>
		                <td style="vertical-align: middle"><a href="#"><img src="<c:url value="/images/btn_del.png" />" class="deleteBtn" alt="삭제" id="${o.id}"/></a></td>
		            </tr>
		            </c:forEach>            
		        </table>
		        
		        <!-- paging -->
	    		<jsp:include page="/WEB-INF/views/include/adminPaging.jsp" />
		        <!-- paging -->
		        
		        <div class="top-button-group">
					<input id="addBtn" type="button" class="btn btn-primary btn-sm" title="프로그램 등록" value="프로그램 등록" />
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
$("#addBtn").click(function() {
	location.href="program_form.do";
});

$(".deleteBtn").click(function() {
	if(confirm("삭제하시겠습니까?")) {
		location.href="program_del.do?id=" + $(this).attr("id");
	}
});
</script>	
</body>
</html>