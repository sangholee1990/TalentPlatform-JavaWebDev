<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.DomainDataMappingDTO,org.springframework.util.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!doctype html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />
</head>
<body>
<div id="contents" class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">WMO Meta 정보</h4>
	
			<div class="top-button-group">
				<input type="button" title="수정" value="수정" id="updateBtn" class="btn btn-primary btn-sm" />
		    	<input type="button" title="삭제" value="삭제" id="deleteBtn" class="btn btn-primary btn-sm" />
		        <input type="button" title="목록" value="목록" id="listBtn" class="btn btn-primary btn-sm" />
			</div>
			<div class="row" id="metaContent"> <span style="text-align : center;">Please wait loading ...</span></div>
			<br /><br />
			<div class="top-button-group">
				<input type="button" title="수정" value="수정" id="updateBtn" class="btn btn-primary btn-sm" />
		    	<input type="button" title="삭제" value="삭제" id="deleteBtn" class="btn btn-primary btn-sm" />
		        <input type="button" title="목록" value="목록" id="listBtn" class="btn btn-primary btn-sm" />
			</div>
			
			<jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />
	</div>
</div>
<!-- END CONTENTS -->
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript" src="<c:url value="/js/metadata/metadata.js"/>"></script>
</div>

<script type="text/javascript">


	
	$(function() {
		$.ajax({
		      type: "GET",
		      url: "<c:url value='/admin/wmo/wmometa_view_innerHtml.do?view_metadataseqn=${param.view_metadataseqn}' />",
		      error: function(data){
		        alert("There was a problem");
		      },
		      success: function(data){
		        $("#metaContent").html(data);
		      }
		});
		
		//$("#metaContent").attr("src", "<c:url value='/admin/wmo/wmometa_view_innerHtml.do?view_metadataseqn=${param.view_metadataseqn}' />");
		
		$("#updateBtn").click(function() {
				$(paramForm).addHidden("mode", "update");
				$(paramForm).attr("action","wmometa_form.do");
				$(paramForm).submit();
		});
		
		$("#deleteBtn").click(function() {
				if(confirm("삭제하시겠습니까?")) {
					$(paramForm).attr("action","wmometa_delete.do");
					$(paramForm).submit();
				}
		});
		
		$("#listBtn").click(function() {	
				$(paramForm).attr("action","wmometa_list.do");
				$(paramForm).submit();
		});
		
	});

	
	function resizeIframe(obj) {
	    obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
	  }
</script>

</body>
</html>
