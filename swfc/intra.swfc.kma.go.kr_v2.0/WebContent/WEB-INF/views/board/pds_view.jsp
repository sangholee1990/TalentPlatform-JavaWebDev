<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.UserDTO, org.springframework.util.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><spring:message code="title"/></title>
<link rel="stylesheet" type="text/css" href="../css/default.css"  />
<jsp:include page="../include/jquery.jsp" />
<script type="text/javascript" src="<c:url value="/js/jquery.validate.min.js"/>"></script>
<script type="text/javascript">
$(function() {
	//updateEmail();
	
	$("#contents :button").click(function() {
		switch($(this).val()) {
		case "수정":
			location.href = "pds_form.do?id=${param.id}&p=${param.p}";
			break;

		case "삭제":
			if(confirm("삭제하시겠습니까?")) {
				location.href = "pds_del.do?id=${param.id}&p=${param.p}";
			}
			break;
		case "목록":
			location.href = "pds_list.do?p=${param.p}";
			break;
		};
	});
});
</script>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->

<div id="contents">
	<h2>자료실보기</h2>
    <div class="report_form bm2">
        <table>
            <tr>
                <th width="70">종류</th>
                <td><spring:escapeBody htmlEscape="true">${article.type}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th width="70">제목</th>
                <td><spring:escapeBody htmlEscape="true">${article.title}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th>내용</th>
                <td><custom:nl2br><spring:escapeBody htmlEscape="false" javaScriptEscape="true">${article.content}</spring:escapeBody></custom:nl2br></td>                  
            </tr>
            <tr>
                <th>첨부파일</th>
                <td><a href="download.do?id=${article.id}"><spring:escapeBody>${article.filename}</spring:escapeBody></a></td>                  
            </tr>
        </table>
    </div>
    <div class="al_c bm2">
		<security:authorize ifAnyGranted="ROLE_USER">    	
    	<input type="button" title="수정" value="수정" class="btnsearch" />
    	<input type="button" title="삭제" value="삭제" class="btnsearch" />
    	</security:authorize>
        <input type="button" title="목록" value="목록" class="btnsearch gr" />
    </div>
</div>
<!-- END CONTENTS -->

<jsp:include page="../footer.jsp" />c

</body>
</html>
