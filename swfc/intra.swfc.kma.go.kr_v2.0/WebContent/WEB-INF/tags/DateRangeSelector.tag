<%@ tag body-content="scriptless" pageEncoding="utf-8" description="ReportType Converter Tag" trimDirectiveWhitespaces="true"%>
<%@tag import="java.util.*"%>
<%@ attribute name="offset" required="false" fragment="false" type="java.lang.Integer"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
Calendar calendar = java.util.Calendar.getInstance(TimeZone.getTimeZone("UTC"));
Date now = calendar.getTime();

if(offset == null)
	calendar.add(Calendar.DAY_OF_YEAR, -1);
else
	calendar.add(Calendar.DAY_OF_YEAR, -Math.abs(offset));
Date yesterday = calendar.getTime();
%>
<c:set scope="page" var="endDate" value="<%=now%>"/>
<c:set scope="page" var="startDate" value="<%=yesterday%>"/>

<input type="text" size="12" id="sd" value="<fmt:formatDate type="date" value="${startDate}" pattern="yyyy-MM-dd" timeZone="UTC"/>"/> 
<input type="text" size="12" id="ed" value="<fmt:formatDate type="date" value="${endDate}" pattern="yyyy-MM-dd" timeZone="UTC"/>"/>