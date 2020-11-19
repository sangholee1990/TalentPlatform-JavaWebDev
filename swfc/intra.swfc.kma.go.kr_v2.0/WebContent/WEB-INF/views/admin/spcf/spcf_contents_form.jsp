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
			<h4 class="page-header">특정수요자용 컨텐츠 등록</h4>
			<!-- content area start -->
			
	        <form name="frm" id="frm" class="form-horizontal" role="form" action="<c:url value="/admin/spcf/spcf_contents_form.do"/>" method="post">
	        	<input type="hidden" name="spcf_seq_n" id="spcf_seq_n" value="${data.spcf_seq_n}" />
	        	<input type="hidden" name="page" id="page" value="${page }" />
			 	
			 	<div class="form-group form-group-sm">
			    	<label for="spcf_nm" class="col-sm-2 control-label">컨텐츠명</label>
			    	<div class="col-sm-5">
			      		<input type="text" class="form-control" id="spcf_nm" name="spcf_nm" placeholder="컨텐츠명을 입력하십시오." value="${data.spcf_nm}" />
			    	</div>
			  	</div>
			 	<div class="form-group form-group-sm">
			    	<label for="spcf_uri" class="col-sm-2 control-label">URL</label>
			    	<div class="col-sm-5">
			      		<input type="text" class="form-control" id="spcf_uri" name="spcf_uri" placeholder="URL을 입력하십시오." value="${data.spcf_uri}" />
			    	</div>
			  	</div>
			  	<div class="form-group form-group-sm">
			    	<label for="use_yn" class="col-sm-2 control-label">사용여부</label>
			    	<div class="col-sm-5">
			    		<select name="use_yn" class="form-control" id="use_yn">
			    			<option value="Y" <c:if test="${data.use_yn eq 'Y'}">selected='selected'</c:if>>사용</option>
			    			<option value="N" <c:if test="${data.use_yn eq 'N'}">selected='selected'</c:if>>미사용</option>
			    		</select>
			    	</div>
			  	</div>
			  	
			  	<!-- button area start -->
			  	<div class="form-group form-group-sm">
				    <div class="col-sm-7 text-right">
				    	<button type="button" class="btn btn-default listBtn">목록</button>
				    	<c:if test="${data.spcf_seq_n eq null }">
				    	<button type="button" class="btn btn-default addBtn">등록</button>
				    	</c:if>
				    	<c:if test="${data.spcf_seq_n != '' && data.spcf_seq_n ne null}">
				    	<button type="button" class="btn btn-default deleteBtn">삭제</button>
				    	<button type="button" class="btn btn-default editBtn">수정</button>
				    	</c:if>
				    </div>
			  	</div>
			  	<!-- button area end -->
			  	
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
		// 등록버튼에 클릭이벤트 바인딩
		$(".addBtn").on("click", insertSPCFContents);
		
		// 수정버튼에 클릭이벤트 바인딩
		$(".editBtn").on("click", modifySPCFContents);
		
		// 목록버튼에 클릭이벤트 바인딩
		$(".listBtn").on("click", function(){
			location.href = "spcf_contents_list.do?page=" + $("#page").val();
		});
		
		// 삭제버튼에 클릭이벤트 바인딩
		$(".deleteBtn").on("click", deleteSPCFContents);
	});
	
	// 유효성 체크	
	function validate() {
		
		if($("#spcf_nm").val() == ""){
			alert("컨텐츠명을 입력하십시오.");
			return false;
		}
		
		var str = $("#spcf_nm").val();
		var strLength = (function(s,b,i,c){
			for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
			return b;
		})(str);
		
		if(strLength > 50){
			alert("컨텐츠명은 최대 한글 16자, 영문 50자 까지 입력가능합니다.");
			return false;
		}
		
		
		if($("#spcf_uri").val() == ""){
			alert("URL을 입력하십시오.");
			return false;
		}
		
		var uri = $("#spcf_uri").val();
		var uriLength = (function(s,b,i,c){
			for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
			return b;
		})(uri);
		
		if(uriLength > 150){
			alert("URL 주소는  최대 한글 50자, 영문 150자 까지 입력가능합니다.");
			return false;
		}
		
		var pattern = new RegExp("^(((http(s?))\:\/\/)?)([0-9a-zA-Z\-]+\.)+[a-zA-Z]{2,6}(\:[0-9]+)?(\/\S*)?$");

		if(!pattern.test(uri)){
			alert("URL 주소를 확인해 주세요.");
			return false;
		}
		
		return true;
	}
	
	// 특정수요자용 컨텐츠 등록
	function insertSPCFContents() {
		// 유효성 체크
		if(!validate()){
			return false;
		}
		
		if(confirm("등록하시겠습니까?")){
			$('#frm').attr("action", "spcf_contents_submit.do");
			frm.submit();
		}
	}
	
	// 특정수요자용 컨텐츠 수정
	function modifySPCFContents() {
		// 유효성 체크
		if(!validate()){
			return false;
		}
		
		if(confirm("수정하시겠습니까?")){
			$('#frm').attr("action", "spcf_contents_modify.do");
			frm.submit();
		}
	}
	
	// 특정수요자용 컨텐츠 삭제
	function deleteSPCFContents() {
		
		if(confirm("삭제하시겠습니까?")) {
			$("#frm").attr("action", "spcf_contents_delete.do");
			frm.submit();
		}
	}
</script>	
</body>
</html>