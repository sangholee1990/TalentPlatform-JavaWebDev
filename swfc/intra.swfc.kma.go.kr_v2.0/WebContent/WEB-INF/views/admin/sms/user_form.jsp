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
			<h4 class="page-header">사용자관리</h4>
			<!-- content area start -->
	        <form name="frm" id="frm" class="form-horizontal" role="form" action="<c:url value="/admin/sms/user_submit.do"/>" method="post">
	        	<input type="hidden" name="user_seq_n" id="user_seq_n" value="${userInfo.user_seq_n}" />
			 	<div class="form-group form-group-sm">
			    	<label for="use_yn" class="col-sm-2 control-label">사용여부</label>
			    	<div class="col-sm-5">
			    		<select name="use_yn" class="form-control" id="use_yn">
			    			<option value="Y" <c:if test="${userInfo.use_yn eq 'Y'}">selected='selected'</c:if>>사용</option>
			    			<option value="N" <c:if test="${userInfo.use_yn eq 'N'}">selected='selected'</c:if>>미사용</option>
			    		</select>
			    	</div>
			  	</div>
			 	<div class="form-group form-group-sm">
			    	<label for="user_nm" class="col-sm-2 control-label">이름</label>
			    	<div class="col-sm-5">
			      		<input type="text" class="form-control" id="user_nm" name="user_nm" placeholder="이름" value="${userInfo.user_nm}">
			    	</div>
			  	</div>
			 	<div class="form-group form-group-sm">
			    	<label for="user_hdp" class="col-sm-2 control-label">연락처</label>
			    	<div class="col-sm-5">
			      		<input type="text" class="form-control" id="user_hdp" name="user_hdp" placeholder="핸드폰 연락처를 입력해주세요." value="${userInfo.user_hdp}" maxlength="14">
			    	</div>
			  	</div>
			 	<div class="form-group form-group-sm">
			    	<label for="user_org" class="col-sm-2 control-label">기관</label>
			    	<div class="col-sm-5">
			      		<input type="text" class="form-control" id="user_org" name="user_org" placeholder="기관을 입력해주세요" value="${userInfo.user_org}" maxlength="20">
			    	</div>
			  	</div>
			  	<div class="form-group form-group-sm">
				    <div class="col-sm-7 text-right">
				    	<button type="button" class="btn btn-default listBtn">목록</button>
				    	<c:if test="${userInfo.user_seq_n eq null }">
				    	<button type="button" class="btn btn-default addBtn">등록</button>
				    	</c:if>
				    	<c:if test="${userInfo.user_seq_n != '' && userInfo.user_seq_n ne null}">
				    	<button type="button" class="btn btn-default deleteBtn">삭제</button>
				    	<button type="button" class="btn btn-default editBtn">수정</button>
				    	</c:if>
				    </div>
			  	</div>
			</form>		    
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
	$('.addBtn').on('click', insertSmsUser);
	$('.editBtn').on('click', modifySmsUser);
	$('.listBtn').on('click', function(){
		location.href = "user_list.do";
	});
	
	$('.deleteBtn').on('click', deleteSmsUser);
});


function validate(){
	if($('#user_nm').val() == ''){
		alert('이름을 입력해주세요.');
		$('#user_nm').focus();
		return false;
	}
	if($('#user_hdp').val() == ''){
		alert('연락처를 입력해주세요.');
		$('#user_hdp').focus();
		return false;
	}
	
	return true;
}

function insertSmsUser(){
	if(!validate()){
		return false;
	}
	if(confirm('등록하시겠습니까?')){
		$('#frm').attr("action", "user_submit.do");
		frm.submit();
	}
}

function modifySmsUser(){
	if(!validate()){
		return false;
	}
	if(confirm('수정하시겠습니까?')){
		$('#frm').attr("action", "user_modify.do");
		frm.submit();
	}
}

function deleteSmsUser(){
	if(confirm('삭제하시겠습니까?')){
		$('#frm').attr("action", "user_delete.do");
		frm.submit();
	}
}
</script>	
</body>
</html>