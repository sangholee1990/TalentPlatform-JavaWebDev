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
<c:set scope="page" var="startDate" value="<%=startDate%>"/>
<c:set scope="page" var="endDate" value="<%=endDate%>"/>

<input type="text" size="12" id="sd" value="<fmt:formatDate type="date" value="${startDate}" pattern="yyyy-MM-dd" timeZone="UTC"/>"/> 
<select id="sh">
	<c:forEach begin="0" end="23" varStatus="loop" var="i">
		<option	value="<fmt:formatNumber minIntegerDigits="2" value="${i}"/>" <c:if test="${hour == i}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${i}" /></option>
	</c:forEach>
</select>시 ~ 
<input type="text" size="12" id="ed" value="<fmt:formatDate type="date" value="${endDate}" pattern="yyyy-MM-dd" timeZone="UTC"/>"/>
<select id="eh">
	<c:forEach begin="0" end="23" varStatus="loop" var="i">
		<option
			value="<fmt:formatNumber minIntegerDigits="2" value="${i}"/>" <c:if test="${hour == i}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${i}" /></option>
	</c:forEach>
</select>시 
 