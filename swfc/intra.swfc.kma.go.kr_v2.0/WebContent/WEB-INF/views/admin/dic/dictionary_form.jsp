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
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/CLEditor1_4_5/jquery.cleditor.css"/>" />
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
				<c:when test="${dictionary.wrd_dic_seq_n == null}">단어사전 등록</c:when>
				<c:otherwise>단어사전 수정</c:otherwise>
			</c:choose>
			</h4>
			
			<form:form commandName="dictionary" role="form" action="dictionary_submit.do" method="post" class="form-horizontal">
				<input type="hidden" name="wrd_dic_seq_n" id="wrd_dic_seq_n" value="${dictionary.wrd_dic_seq_n}">
				<input type="hidden" name="mode" id="mode" value="${mode}">
				<input type="hidden" name="count" id="count" value="${count}">
				<form:errors path="*" cssClass="errorBlock" element="div"/>
				<div class="form-group form-group-sm">
					<label for="simple_nm" class="col-sm-2 control-label">예약어</label>
					<div class="col-sm-8">
						<c:choose>
							<c:when test="${dictionary.wrd_dic_seq_n == null}">
								<form:input path="simple_nm" class="form-control"/>
							</c:when>
							<c:otherwise>
								<form:input path="simple_nm" class="form-control" readonly="true"/>
							</c:otherwise>
						</c:choose>
			    	</div>
			    </div>
			    
			    <div class="form-group form-group-sm">
					<label for="kor_nm" class="col-sm-2 control-label">국문명</label>
			    	<div class="col-sm-8">
			      		<form:input path="kor_nm" class="form-control"/>
			    	</div>
			    </div>
			      <div class="form-group form-group-sm">
					<label for="eng_nm" class="col-sm-2 control-label">영문명</label>
			    	<div class="col-sm-8">
			      		<form:input path="eng_nm" class="form-control"/>
			    	</div>
			    </div>
			    <div class="form-group form-group-sm">
				    	<label for="wrd_desc" class="col-sm-2 control-label">설명</label>
				    	<div class="col-sm-8 text-right">
				    		<textarea class="form-control" rows="3" id="wrd_desc" name="wrd_desc" style="height:100px;">${dictionary.wrd_desc}</textarea>
				    	</div>
				  	</div>
				<div class="form-group form-group-sm">
				    <div class="col-sm-offset-2 col-sm-9 text-right">
				    	<c:choose>
				    	<c:when test="${dictionary.wrd_dic_seq_n == null}">
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

<script type="text/javascript" src="<c:url value="/resources/CLEditor1_4_5/jquery.cleditor.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/CLEditor1_4_5/jquery.cleditor.js"/>"></script>
<script type="text/javascript">
$(function() {
	
	 <c:if test="${count > 0}"> 
	 	alert("이미 등록되어 있는 단어입니다.");
	</c:if>

	//검색 파라메터 추가
	$(paramForm).find('input[type=hidden]').each(function() {
		$("#dictionary").addHidden($(this).attr("wrd_dic_seq_n"), $(this).val());
	});
	
	
	// 유효성 검사
	$("#dictionary").validate({
		debug: false,
		rules: {
			simple_nm: {required:true, fieldLength : 40}, 
			kor_nm:  {required:true, fieldLength : 200}, 
			eng_nm:  {required:true, fieldLength : 250}
		},
		messages: {
			simple_nm: {required: "예약어를 입력하여 주십시오.", fieldLength : "예약어은 최대 한글 10자 영문 40자 까지 입력가능합니다."},
			kor_nm: {required: "국문명을 입력하여 주십시오.", fieldLength : "국문명은 최대 한글 65자 영문 200자 까지 입력가능합니다."},
			eng_nm: {required: "영문명을 입력하여 주십시오.", fieldLength : "영문명은 최대 한글 80자 영문 250자 까지 입력가능합니다."},
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
			$("#dictionary").submit();
			break;
		case "수정":
			$("#dictionary").submit();
			break;
		case "취소":
			//수정
			$(paramForm).addHidden("wrd_dic_seq_n", '${dictionary.wrd_dic_seq_n}');
			<c:if test="${mode eq 'update' }">
				$(paramForm).attr("action", "dictionary_view.do");
			</c:if>

			//등록
			 <c:if test="${mode eq 'new' }">
				$(paramForm).attr("action", "dictionary_list.do");
			</c:if>

			$(paramForm).submit();
			break;
		};
	});
});
</script>
</body>
</html>