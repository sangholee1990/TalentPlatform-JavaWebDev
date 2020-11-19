 <%@ tag body-content="scriptless" pageEncoding="utf-8" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ attribute name="notice" required="true" fragment="false" type="egovframework.rte.swfc.dto.ChartSummaryDTO"%>
 <c:if test="${notice != null}">
 <c:choose>
 	<c:when test="${notice.code == 0}">w</c:when>
 	<c:when test="${notice.code == 1}">g</c:when>
 	<c:when test="${notice.code == 2}">b</c:when>
 	<c:when test="${notice.code == 3}">y</c:when>
 	<c:when test="${notice.code == 4}">o</c:when>
 	<c:when test="${notice.code == 5}">r</c:when>
 </c:choose>
</c:if> 
