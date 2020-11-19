<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 우주기상인트라넷</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/default.css"/>" />
</head>
<body>
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

	//out.print(statusCode);
	//out.print(servletName);
	//out.print(requestUri);
	//out.print(throwable.getMessage());
%>
<jsp:include page="../header.jsp" />
<div id="contents">
<div class="errorblock">
<%--
<ul>
<li><%=exception.getClass().getSimpleName() %></li>
<li><%=exception.getMessage() %></li>
</ul>
 --%>
<dl>
  <dt>Error code</dt>
  <dd><c:out value="${requestScope['javax.servlet.error.status_code']}"/></dd>
  <dt>Servlet Name</dt>
  <dd><c:out value="${requestScope['javax.servlet.error.servlet_name']}"/></dd>
  <dt>Service Uri</dt>
  <dd><c:out value="${requestScope['javax.servlet.error.request_uri']}"/></dd>
  <dt>message</dt>
  <dd><c:out value="${requestScope['javax.servlet.error.message']}"/></dd>
</dl>


</div>
</div>
<jsp:include page="../footer.jsp" />
</body>
</html>
