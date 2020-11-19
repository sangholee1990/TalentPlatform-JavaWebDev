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
			<h4 class="page-header">수집자료관리</h4>
			<!-- content area start -->
	        <form name="frm" id="frm" class="form-horizontal" role="form" action="ctl_data_submit.do" method="post">
	        	<input type="hidden" name="clt_dta_seq_n" value="${info.CLT_DTA_SEQ_N}" >
	        	<c:if test="${info.CLT_DTA_SEQ_N != '' && info.CLT_DTA_SEQ_N ne null}">
	        	<div class="form-group form-group-sm">
			    	<label for="clt_dta_seq_n" class="col-sm-2 control-label">자료코드 번호</label>
			    	<div class="col-sm-5">
			      		<input type="text" class="form-control" placeholder="자료코드" value="${info.CLT_DTA_SEQ_N}" disabled="disabled">
			    	</div>
			  	</div>
			  	</c:if>
			 	<div class="form-group form-group-sm">
			    	<label for="dta_nm" class="col-sm-2 control-label">자료명</label>
			    	<div class="col-sm-5">
			      		<input type="text" class="form-control" id="dta_nm" name="dta_nm" placeholder="자료명" value="${info.DTA_NM}">
			    	</div>
			  	</div>
			 	<div class="form-group form-group-sm">
			    	<label for="dta_path" class="col-sm-2 control-label">자료경로</label>
			    	<div class="col-sm-5">
			      		<input type="text" class="form-control" id="dta_path" name="dta_path" placeholder="자료경로" value="${info.DTA_PATH}">
			    	</div>
			  	</div>
			  	<div class="form-group form-group-sm">
				    <div class="col-sm-7 text-right">
				    	<button type="button" class="btn btn-default listBtn">목록</button>
				    	<c:if test="${info.CLT_DTA_SEQ_N eq null }">
				    	<button type="button" class="btn btn-default addBtn">등록</button>
				    	</c:if>
				    	<c:if test="${info.CLT_DTA_SEQ_N != '' && info.CLT_DTA_SEQ_N ne null}">
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
		location.href = "ctl_data_list.do";
	});
	
	$('.deleteBtn').on('click', deleteSmsUser);
});


function validate(){
	if($('#dta_nm').val() == ''){
		alert('자료명을 입력해주세요.');
		$('#dta_nm').focus();
		return false;
	}
	if($('#dta_path').val() == ''){
		alert('자료경로를 입력해주세요.');
		$('#dta_path').focus();
		return false;
	}
	
	return true;
}

function insertSmsUser(){
	if(!validate()){
		return false;
	}
	if(confirm('등록하시겠습니까?')){
		$('#frm').attr("action", "ctl_data_submit.do");
		frm.submit();
	}
}

function modifySmsUser(){
	if(!validate()){
		return false;
	}
	if(confirm('수정하시겠습니까?')){
		$('#frm').attr("action", "ctl_data_modify.do");
		frm.submit();
	}
}

function deleteSmsUser(){
	if(confirm('삭제하시겠습니까?')){
		$('#frm').attr("action", "ctl_data_delete.do");
		frm.submit();
	}
}
</script>	
</body>
</html>