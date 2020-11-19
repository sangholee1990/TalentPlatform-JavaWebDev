<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.UserDTO, org.springframework.util.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
			<h4 class="page-header">사용자보기</h4>
			<!-- content area start -->
				
				
				<table class="table table-condensed">
					<tr>
		                <th class="active text-center" width="90">아이디</th>
		                <td><spring:escapeBody>${user.userId}</spring:escapeBody></td>                  
		            </tr>
		            <tr>
		                <th class="active text-center">이름</th>
		                <td><spring:escapeBody>${user.name}</spring:escapeBody></td>                  
		            </tr>
		            <tr>
		                <th class="active text-center">부서</th>
		                <td><spring:escapeBody>${user.department}</spring:escapeBody></td>                  
		            </tr>
		            <tr>
		                <th class="active text-center">직급</th>
		                <td><spring:escapeBody>${user.position}</spring:escapeBody></td>                  
		            </tr>
		            <tr>
		                <th class="active text-center">전화번호</th>
		                <td><spring:escapeBody>${user.phone}</spring:escapeBody></td>                  
		            </tr>
		            <tr>
		                <th class="active text-center">이메일</th>
		                <td><spring:escapeBody>${user.email}</spring:escapeBody></td>                  
		            </tr>
		            <tr>
		                <th class="active text-center">사용자권한</th>
		                <td><custom:RoleConverter role="${user.role}"/></td>                  
		            </tr>
		            <tr>
		                <th class="active text-center">사용자그룹</th>
		                <td><custom:RoleConverter role="${user.groupName}"/></td>                  
		            </tr>
				</table>
    		
    		<div class="top-button-group">
				<input type="button" title="수정" value="수정" class="btn btn-primary btn-sm" />
		    	<input type="button" title="삭제" value="삭제" class="btn btn-primary btn-sm" />
		        <input type="button" title="목록" value="목록" class="btn btn-primary btn-sm" />
			</div>
    		
    		<!-- 특정수요자용 컨텐츠 start -->
    		<div id="spcf-area">
	    		<h4 class="page-header">특정수요자용 컨텐츠</h4>
	    		
	    		<table class="table table-spcf-user">
	    			<thead>
		            	<tr>
		                	<th>선택</th>
		                	<th class="contents">컨텐츠명</th>
		                    <th class="contents">URL</th>
		                </tr>
		            </thead>
		            <c:forEach var="o" items="${spcf_list}" varStatus="status">            
			            <tr>
			            	<td class="chkbox">
			            		<input name="spcf_seq_n" type="checkbox" <c:if test="${o.status == 'Y' }">checked="checked"</c:if> value="${o.spcf_seq_n }" />
			            	</td>
			            	<td><spring:escapeBody>${o.spcf_nm}</spring:escapeBody></td>
			                <td><spring:escapeBody>${o.spcf_uri}</spring:escapeBody></td>
			            </tr>
		            </c:forEach>
		            <c:if test="${empty spcf_list }">
		            	<tr>
		            		<td class="chkbox" colspan="3">등록된 컨텐츠가 존재하지 않습니다.</td>
		            	</tr>
		            </c:if>
	    		</table>
	    		
	    		<div class="top-button-group">
					<input id="saveBtn" type="button" title="저장" value="저장" class="btn btn-primary btn-sm" />
				</div>
    		</div>
    		<!-- 특정수요자용 컨텐츠 end -->
			<!-- content area end -->
			
			 <!-- footer start -->
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		    <!-- footer end -->
		</div>		
	</div>
		
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript" src="<c:url value="/js/jquery.validate.min.js"/>"></script>
<script type="text/javascript">
$(function() {
	//updateEmail();
	
	$("input[type=button]").click(function() {
		switch($(this).val()) {
		case "수정":
			location.href = "user_form.do?id=${param.id}&p=${param.p}";
			break;

		case "삭제":
			if(confirm("삭제하시겠습니까?")) {
				location.href = "user_del.do?id=${param.id}&p=${param.p}";
			}
			break;
		case "목록":
			location.href = "user_list.do?p=${param.p}";
			break;
		case "저장":
			if(confirm("저장하시겠습니까?")) {
				var spcf_seq_list = [$(".table-spcf-user").find(":checked").map(function() {return this.value;}).get()];
				
				$.ajax({
					type:"post",
					url: "user_spcf_contents_insert.do",
					data: "id=${param.id}&p=${param.p}&spcf_seq_n=" + spcf_seq_list,
					dataType: "json",
					success: function(e) {
						if(e.result >= 0) alert("저장되었습니다.");
						else alert("Error!!");
					}
				});
			}
			break;
		};
	});
});
</script>
</body>
</html>
