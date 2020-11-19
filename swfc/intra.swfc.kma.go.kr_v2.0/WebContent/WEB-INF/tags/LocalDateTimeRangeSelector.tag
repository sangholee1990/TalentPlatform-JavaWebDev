<%@tag import="org.joda.time.LocalDateTime"%>
<%@ tag body-content="scriptless" pageEncoding="utf-8" description="ReportType Converter Tag" trimDirectiveWhitespaces="true"%>
<%@ attribute name="startDate" required="false" fragment="false" type="org.joda.time.LocalDateTime"%>
<%@ attribute name="endDate" required="false" fragment="false" type="org.joda.time.LocalDateTime"%>
<%@tag import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<%
if(startDate == null || endDate == null) {
	Calendar calendar = java.util.Calendar.getInstance(TimeZone.getTimeZone("UTC"));
	endDate = LocalDateTime.fromCalendarFields(calendar);
	calendar.add(Calendar.DAY_OF_YEAR, -1);
	startDate = LocalDateTime.fromCalendarFields(calendar);
}
%>
<c:set scope="page" var="startHour" value="<%=startDate.getHourOfDay()%>"/>
<c:set scope="page" var="endHour" value="<%=endDate.getHourOfDay()%>"/>
<input type="text" size="12" id="sd" value="<joda:format value="${startDate}" pattern="yyyy-MM-dd"/>"/> 
<select id="sh">
	<c:forEach begin="0" end="23" varStatus="loop" var="i">
		<option	value="<fmt:formatNumber minIntegerDigits="2" value="${i}"/>" <c:if test="${startHour == i}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${i}" /></option>
	</c:forEach>
</select>시 ~ 
<input type="text" size="12" id="ed" value="<joda:format value="${endDate}" pattern="yyyy-MM-dd"/>"/>
<select id="eh">
	<c:forEach begin="0" end="23" varStatus="loop" var="i">
		<option
			value="<fmt:formatNumber minIntegerDigits="2" value="${i}"/>" <c:if test="${endHour == i}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${i}" /></option>
	</c:forEach>
</select>시 