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
<script type="text/javascript">
   function ExcelUpload() {
		var uploadForm = document.uploadForm;
		if(uploadForm.fileData.value == "") {
			alert("파일을 업로드해주세요");
			return false;
		} else if(!checkFileType(uploadForm.fileData.value)) {
			alert("엑셀 파일만 업로드해주세요");
			return false;
		}
		
		if(confirm("업로드 하시겠습니까?")) {
			uploadForm.action="dictionary_excelUpload.do";
			uploadForm.submit();
		}
   }
   
   <c:if test="${success != null}"> 
   		ExcelUploadCheck();
   </c:if>
   
   function ExcelUploadCheck() {
	 <c:choose>
		 <c:when test="${success == true}">
		   	window.opener.location.reload(true);
			window.close();
		</c:when>
		<c:otherwise>
			alert("업로드를 실패했습니다.");
		</c:otherwise>
	</c:choose>
   }
   
	function checkFileType(filePath) {
		var fileFormat = filePath.toLowerCase();
		if(fileFormat.indexOf(".xls") > -1 || fileFormat.indexOf(".xlsx") > -1) return true;
		else return false;
	}
</script>
<meta charset="UTF-8">
</head>
<body>
<div class="container">

	<div class="row">
		<div class="col-sm-12 col-md-12">
			<h4 class="page-header">단어사전 엑셀파일 업로드</h4>
			<!-- content area start -->
			
			<form class="form-horizontal" name="uploadForm" id="uploadForm" method="post" enctype="multipart/form-data">
			 	<div class="form-group form-group-sm">
					<label for="fileData" class="col-sm-2 control-label">첨부파일</label>
			    	<div class="col-sm-8">
			      		<input type="file" name="fileData" id="fileData" class="form-control"/>
			    	</div>
			    </div>
			    <div align=center><font color="red" size="2">* 첨부파일에 대한 형식이 잘못되었을 경우 등록되지 않을 수도 있습니다.</font></div>
			    <div align=center><font color="red" size="2">* 예약어(25) 국문명(250) 영문명(250) 설명 (1000) byte까지 입력가능합니다.</font></div>
			<input type="button" class="btn btn-primary btn-sm addBtn" title="등록" value="등록" onclick="javascript:ExcelUpload();" style="float:right"/>
			</form>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
</body>
</html>