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
	$('.listBtn').on('click', function(){
		location.href = "faq_list.do?iPage=${param.iPage}";
	});
});
</script>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->

<div id="contents">
	<h2>FAQ보기</h2>
    <div class="report_form bm2">
        <table>
            <tr>
                <th width="70">제목</th>
                <td><spring:escapeBody htmlEscape="true">${board.title}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th>내용</th>
                <td><custom:EscapeJavaScript>${board.content}</custom:EscapeJavaScript></td>                  
            </tr>
        </table>
    </div>
    <div class="al_c bm2">
        <input type="button" title="목록" value="목록" class="btnsearch gr listBtn" />
    </div>
</div>
<!-- END CONTENTS -->

<jsp:include page="../footer.jsp" />

</body>
</html>
