<%@ tag body-content="scriptless" pageEncoding="utf-8" description="ReportType Converter Tag" trimDirectiveWhitespaces="true"%>
<%@ attribute name="from" required="false" fragment="false" type="java.util.Date"%>
<%@ attribute name="to" required="false" fragment="false" type="java.util.Date"%>
<%@ attribute name="offset" required="false" fragment="false" type="java.lang.Integer"%>
<%@ attribute name="isUTC" required="false" fragment="false" type="java.lang.Boolean"%>
<%@tag import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
if(isUTC == null)
	isUTC = true;
Calendar calendar = null;
Date endDate = null;
Date startDate = null;

if(from != null && to != null) {
	calendar = java.util.Calendar.getInstance();
	if(isUTC) {
		calendar.setTimeZone(TimeZone.getTimeZone("UTC"));	
	}
	calendar.setTime(from);
	
	startDate = from;
	endDate = to;
} else {
	calendar = java.util.Calendar.getInstance();
	if(isUTC) {
		calendar.setTimeZone(TimeZone.getTimeZone("UTC"));	
	} 
	
	endDate = calendar.getTime();
	
	if(offset !=null) {
		calendar.add(Calendar.HOUR_OF_DAY, -offset);
	} else {
		calendar.add(Calendar.DAY_OF_YEAR, -1);
	}
	startDate = calendar.getTime();
}
%>
<c:set scope="page" var="hour" value="<%=calendar.get(Calendar.HOUR_OF_DAY)%>"/>
<c:set scope="page" var="min" value="<%=calendar.get(Calendar.MINUTE)%>"/>
<c:set scope="page" var="startDate" value="<%=startDate%>"/>
<c:set scope="page" var="endDate" value="<%=endDate%>"/>

<input type="text" size="12" id="sd5" value="<fmt:formatDate type="date" value="${startDate}" pattern="yyyy-MM-dd" timeZone="UTC"/>"/> 

 