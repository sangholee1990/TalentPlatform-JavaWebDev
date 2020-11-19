<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>우주기상 예특보 서비스 :: 국가기상위성센터</title>
<jsp:include page="/WEB-INF/views/include/jquery.jsp" />
</head>
<body>
<c:set var="returnUrl" value="${header['referer']}"/>
<c:if test="${param.error == null}">
	<c:set var="returnUrl" value="/"/>
</c:if>
<div id="wrap_main">
	<c:if test="${message ne null}">
		<c:choose>
			<c:when test="${message == 1}">
				<p class="message">로그인이 필요합니다.</p>
				<a href="/ko/login.do" title="로그인페이지 이동" class="returnUrl">로그인</a>
			</c:when>
			<c:when test="${message == 2}">
				<p class="message">제한된 접근입니다.</p>
				<a href="<c:out value="${returnUrl}"/>" title="이전 페이지로 돌아가기"  class="returnUrl">돌아가기</a>
			</c:when>
		</c:choose>
	</c:if>
</div>
<script type="text/javascript">
$(function(){
	$("#wrap_main").hide();
	alert($(".message").text());
	location.href=$(".returnUrl").attr("href");	
});
</script>
</body>
</html>