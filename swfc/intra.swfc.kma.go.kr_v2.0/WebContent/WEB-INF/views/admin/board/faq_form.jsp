<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.BoardsDTO,org.springframework.util.*"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!doctype html>
<html lang="ko">
<head>
  <link rel="stylesheet" type="text/css" href="<c:url value='/resources/CLEditor1_4_5/jquery.cleditor.css'/>" />
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />
</head>
<body>
<div id="contents" class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	
	<!--  -->
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">
			<c:choose>
				<c:when test="${faq.board_seq == null}">FAQ 등록</c:when>
				<c:otherwise>FAQ 수정</c:otherwise>
			</c:choose>
			</h4>
			<!-- content area start -->
			
			<form:form commandName="faq" role="form" action="faq_submit.do" method="post" class="form-horizontal">
				<input type="hidden" name="board_seq" value="${faq.board_seq}"/>
				<input type="hidden" name="mode" value="${mode}"/>
				
				<form:errors path="*" cssClass="errorBlock" element="div"/>

				<div class="form-group form-group-sm">
			    	<label for="site_code_cd" class="col-sm-2 control-label">사이트 구분</label>
			    	<div class="col-sm-3">
			      	  <form:select path="site_code_cd" class="form-control">
			    		<c:forEach var="o" items="${subList}" varStatus="status">            
			            	<option value="${o.code}" <c:if test="${faq.site_code_cd == o.code }">selected="selected"</c:if>>${o.code_ko_nm}</option>
	            		</c:forEach>
			           </form:select>
			    	</div>
			  	</div>
	  	
			   <div class="form-group form-group-sm">
			    	<label for="use_yn" class="col-sm-2 control-label">표출여부</label>
			    	<div class="col-sm-3">
			      		<form:select path="use_yn" class="form-control">
	                		<form:option value="Y" label="표출"/>
	                		<form:option value="N" label="미표출"/>
			           </form:select>
			    	</div>
			  	</div>
			  
				<div class="form-group form-group-sm">
			    	<label for="title" class="col-sm-2 control-label">제목</label>
			    	<div class="col-sm-8">
			      		<form:input path="title" class="form-control" maxlength="500"/>
			    	</div>
			  	</div>
			  					    		  	
				<div class="form-group">
			    	<label for="content" class="col-sm-2 control-label">내용</label>
			    	<div class="col-sm-8">
			      		<form:textarea path="content" class="form-control" rows="5"/>
			      	</div>
			  	</div>
			  	
				<div class="form-group form-group-sm">
				    <div class="col-sm-offset-2 col-sm-9 text-right">
				    	<c:choose>
				    	<c:when test="${faq.board_seq == null}">
				    		<input type="button" title="등록" value="등록" class="btn btn-primary btn-sm" />
				    	</c:when>
				    	<c:otherwise>
				    		<input type="button" title="수정" value="수정" class="btn btn-primary btn-sm"/>
				    	</c:otherwise>
				    	</c:choose>
	     					<input type="button" title="취소" value="취소" class="btn btn-primary btn-sm" />
				    </div>
			  	</div>
		    </form:form> 
		    
		     <!-- footer start -->
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		    <!-- footer end -->   
       </div>
    </div>
</div>
<!-- END CONTENTS -->
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript" src="<c:url value="/resources/CLEditor1_4_5/jquery.cleditor.min.js" />"></script>
<script type="text/javascript">
$(function() {
	
	//검색 파라메터 추가
	$(paramForm).find('input[type=hidden]').each(function() {
		$("#faq").addHidden($(this).attr("id"), $(this).val());
	});
	
	//$(document).ready(function () { 
		$("#content").cleditor();
	//});
	
	// 유효성 검사
	$("#faq").validate({
		debug: false,
		rules: {
			sitegubun: "required",
			use_yn: "required",
			title: {
				required : true,
				fieldLength : 300
			   },
			content: "required"
		},
		messages: {
			sitegubun: "사이트를 선택하여 주십시오.",
			use_yn: "표출여부를 선택하여 주십시오.",
			title: {
			    required : "제목을 입력하여 주십시오.",
				fieldLength : "제목은 최대 한글 100자, 영문 300자 까지 입력가능합니다."	
			   },
			content: "내용을 입력하여 주십시오."
		},
		submitHandler: (function(form) {
			//등록
			<c:if test="${mode eq 'new' }">
				var messageStr = "등록하시겠습니까?";
			</c:if>
		
			//수정
			<c:if test="${mode eq 'update' }">
				var messageStr = "수정하시겠습니까?";
			</c:if>
			
			if(confirm(messageStr)) {
				form.submit();
			}
		})
	});

	$("input[type=button]").click(function() {
		switch($(this).val()) {
		case "등록":
			$("#faq").submit();
			break;
		case "수정":
			$("#faq").submit();
			break;
		case "취소":
// 			if(confirm("취소하시겠습니까?")) {
// 				<c:if test="${not empty archives.board_seq}">location.href = "archives_view.do" + getParamURL(); </c:if>
// 				<c:if test="${empty archives.board_seq}">location.href = "archives_list.do" + getParamURL(); </c:if>
// 			}

			//수정
			<c:if test="${mode eq 'update' }">
				$(paramForm).attr("action", "faq_list.do");
			</c:if>

			//등록
			 <c:if test="${mode eq 'new' }">
				$(paramForm).attr("action", "faq_list.do");
			</c:if>

			$(paramForm).submit();
			break;
		};
	});
});
</script>

</body>
</html>