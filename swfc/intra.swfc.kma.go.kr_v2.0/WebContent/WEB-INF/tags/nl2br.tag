<%@tag import="org.springframework.web.util.HtmlUtils"
%><%@tag import="org.springframework.util.StringUtils"
%><%@ tag body-content="scriptless" pageEncoding="utf-8"
%><jsp:doBody var="content" scope="page" /><%
String content = (String)jspContext.getAttribute("content");
content = HtmlUtils.htmlEscape(content).replaceAll("\n", "<br/>");
content = content.replaceAll("<script", "<Xscript");
content = content.replaceAll("<SCRIPT", "<XSCRIPT");
out.print(content);
%>