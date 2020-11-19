<%@tag import="org.springframework.web.util.HtmlUtils"
%><%@tag import="org.springframework.util.StringUtils"
%><%@ tag body-content="scriptless" pageEncoding="utf-8"
%><jsp:doBody var="content" scope="page" /><%
String content = (String)jspContext.getAttribute("content");
String[] ontag =  {"javascript","script"};

//태크 관련
for(int i =0; i <ontag.length; i++) {
	content = content.replaceAll("(?i)" + ontag[i] ,"X-" + ontag[i] );
}

//content = HtmlUtils.htmlEscape(content).replaceAll("\n", "<br/>");
out.print(content);
%>