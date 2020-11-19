 <%@ tag body-content="scriptless" pageEncoding="utf-8" description="ReportType Converter Tag" trimDirectiveWhitespaces="true"%>
 <%@ attribute name="value" required="true" fragment="false"%><%
 String requestUri = (String)request.getAttribute("javax.servlet.forward.request_uri");
 if(requestUri != null && requestUri.contains(value))
// String lastPart = requestUri.replaceFirst(".*/([^/?]+).*", "$1");
 //if(value.equalsIgnoreCase(lastPart))
 {
 %>
 <jsp:doBody/>
 <%}%>