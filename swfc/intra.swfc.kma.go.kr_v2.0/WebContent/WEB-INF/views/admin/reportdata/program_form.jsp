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
			<h4 class="page-header">프로그램 등록</h4>
			<!-- content area start -->
				           
	        <form:form commandName="program" action="program_submit.do" method="post" enctype="multipart/form-data" class="form-horizontal">
			<input type="hidden" name="p" value="${param.p}"/>
			<form:hidden path="id"/>
			<form:errors path="*" cssClass="errorBlock" element="div"/>
            <div class="form-group form-group-sm">
		    	<label for="type" class="col-sm-2 control-label">종류</label>
		    	<div class="col-sm-5">
		      		<form:select path="type" class="form-control">
	               		<form:option value="CME" label="CME"/>
	               		<form:option value="STOA" label="STOA"/>
	               	</form:select>
		    	</div>
		  	</div>
		  	
		  	<div class="form-group form-group-sm">
              	<label for="name" class="col-sm-2 control-label">항목명</label>
		    	<div class="col-sm-5">
		    		<form:input path="name" class="form-control" />
		    	</div>
		  	</div>
		  	
		  	<div class="form-group form-group-sm">
              	<label for="file1Data" class="col-sm-2 control-label">파일</label>
		    	<div class="col-sm-5">
		    		<input type="file" name="file1Data" class="form-control"/>
		    	</div>
		  	</div>
		  	
		  	<div class="form-group ">
			    <div class="col-sm-offset-2 col-sm-9 text-right">
			    	<input type="button" title="등록" value="등록" class="btn btn-primary btn-sm" />
      				<input type="button" title="취소" value="취소" class="btn btn-primary btn-sm" />
			    </div>
		  	</div>
			</form:form>		
    
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
	$("#program").validate({
		debug: false,
		rules: {
			name: {
				required : true,
				fieldLength : 255
			   },
		},
		messages: {
			name:{
				required:"항목명을 입력하세요.",
				fieldLength : "항목명은 최대 한글 85자, 영문 255자 까지 입력가능합니다."
				}
		},
		submitHandler: (function(form) {
			if(confirm("등록하시겠습니까?")) {
				form.submit();
			}
		})
	});
	
	$("input[type=button]").click(function() {
		switch($(this).val()) {
		case "등록":
			$("#program").submit();
			break;
			
		case "취소":
			if(confirm("취소하시겠습니까?")) {
				location.href = "program_list.do?p=${param.p}";
			}
			break;
		};
	});
	
});
</script>	
</body>
</html>