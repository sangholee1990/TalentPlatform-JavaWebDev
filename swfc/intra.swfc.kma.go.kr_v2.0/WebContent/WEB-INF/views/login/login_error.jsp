<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 우주기상인트라넷</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/default.css"/>"  />
<jsp:include page="../include/jquery.jsp" />
</head>
<body>
	<c:set var="returnUrl" value="${header['referer']}"/>
	<c:if test="${param.error == null}">
		<c:set var="returnUrl" value="/"/>
	</c:if>
	<div class="check">
		<h2>로그인</h2>
		<p class="message"><c:choose>
				<c:when test="${param.error == 1}">시스템 오류입니다.</c:when>
				<c:when test="${param.error == 2}">로그인 정보가 일치하지 않습니다.</c:when>
				<c:when test="${param.error == 3}">로그인이 제한되었습니다.</c:when>
				<c:otherwise>알 수 없는 오류입니다.</c:otherwise>
		</c:choose></p>
		<a href="<c:out value="${returnUrl}"/>" title="이전 페이지" class="back">돌아가기</a>
	</div>
<script type="text/javascript">
	$(function(){
		$(".check").hide();
		alert($(".message").text().trim());
		location.href = $(".back").attr("href");
	});
</script>
</body>
</html>