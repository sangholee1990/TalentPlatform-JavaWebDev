<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.DomainLayerDTO, org.springframework.util.*"
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
<div id="contents" class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">도메인 레이어 정보</h4>
	
	        <table class="table table-condensed">
	            <tr>
	                <th class="active text-center" width="90">도메인(영문)</th>
	                <td><spring:escapeBody>${domainLayerDTO.dmn_kor_nm} (${domainLayerDTO.dmn_eng_nm} )</spring:escapeBody></td>                  
	            </tr>	            
	            <tr>
	                <th class="active text-center">코드</th>
	                <td><spring:escapeBody>${domainLayerDTO.dmn_layer_cd}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">한글명</th>
	                <td><spring:escapeBody>${domainLayerDTO.dmn_layer_kor_nm}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">영문명</th>
	                <td><spring:escapeBody>${domainLayerDTO.dmn_layer_eng_nm}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">사용여부</th>
	                <td><spring:escapeBody><custom:UseYNConvert useYN="${domainLayerDTO.use_f_cd}"/></spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">설명</th>
	                <td><div class="custom-overflow"><spring:escapeBody>${domainLayerDTO.dmn_layer_desc}</spring:escapeBody></div></td>                  
	            </tr>
	        </table>
    	
    		<div class="top-button-group">
						<input type="button" title="수정" value="수정" class="btn btn-primary btn-sm" />
				    	<input type="button" title="삭제" value="삭제" class="btn btn-primary btn-sm" />
				        <input type="button" title="목록" value="목록" class="btn btn-primary btn-sm" />
			</div>
			<!-- content area end -->
			
			<jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />
    	</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript" src="<c:url value="/js/metadata/metadata.js"/>"></script>

<script type="text/javascript">

$(function() {
	
	$("#contents :button").click(function() {
		switch($(this).val()) {
		case "수정":
			
			$(paramForm).addHidden("mode", "update");
			$(paramForm).attr("action", "domainlayer_form.do");
			$(paramForm).submit();
			
			break;

		case "삭제":
			if(confirm("삭제하시겠습니까?")) {
				$(paramForm).attr("action", "domainlayer_del.do");
				$(paramForm).submit();
			}
			break;
		case "목록":
			$(paramForm).attr("action", "domainlayer_list.do");
			$(paramForm).submit();
			break;
		}
	});
});

</script>
</body>
</html>
