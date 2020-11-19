<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	response.sendRedirect(contextPath + "/ko/index.do");
	return;
%>