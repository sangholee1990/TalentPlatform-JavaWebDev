<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isErrorPage="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"        prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"   prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml"         prefix="x"%>
<%@ taglib uri="http://www.springframework.org/tags"      prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%
	response.setStatus(HttpServletResponse.SC_OK);
	Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");
	Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
	String servletName = (String) request.getAttribute("javax.servlet.error.servlet_name");
	if (servletName == null) {
		servletName = "Unknown";
	}
	String requestUri = (String) request.getAttribute("javax.servlet.error.request_uri");
	if (requestUri == null) {
		requestUri = "Unknown";
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	 <meta http-equiv="X-UA-Compatible" content="IE=edge">
	 <meta name="viewport" content="width=device-width, initial-scale=1.0">
	 <meta name="description" content="">
	 <meta name="author" content="">
	 <meta http-equiv="Cache-Control" content="no-cache">
	 <meta http-equiv="expires" content="0">
	 <title>seeSystem</title>
	 <!-- Bootstrap core CSS -->
</head>
<body>
<h4>세션 예외가 발생했습니다.</h4>
<table>
	<!-- 
	<tr>
		<th width="120">Error code</th>
		<td><c:out value="${requestScope['javax.servlet.error.status_code']}"/></td>
	</tr>
	<tr>
		<th>Servlet Name</th>
		<td><c:out value="${requestScope['javax.servlet.error.servlet_name']}"/></td>
	</tr>
	<tr>
		<th>Service Uri</th>
		<td><c:out value="${requestScope['javax.servlet.error.request_uri']}"/></td>
	</tr>
	<tr>
	 -->
	<tr>
		<th>Message</th>
		<td><c:out value="${requestScope['javax.servlet.error.message']}"/></td>
	</tr>
</table>
</body>
</html>