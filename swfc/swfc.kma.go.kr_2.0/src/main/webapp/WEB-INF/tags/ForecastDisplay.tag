<%@ tag body-content="scriptless" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%@ attribute name="now" required="true" fragment="false" type="egovframework.rte.swfc.dto.ChartSummaryDTO"%>
<%@ attribute name="h3" required="true" fragment="false" type="egovframework.rte.swfc.dto.ChartSummaryDTO"%>
<div class="info">
	<div class="sign <custom:CodeSign notice="${h3}"/>">
		<p>${h3.grade}</p>
	</div>
	<fmt:parseDate value="${h3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
	<p class="infotext">
		<span class="message fw">${h3.gradeText}</span> 
		<span>현재 : ${now.val}</span>
		<span>
		<c:choose>
			<c:when test="${h3.dataType=='MP'}">최소값</c:when>
			<c:otherwise>최대값</c:otherwise>
		</c:choose> : ${h3.val}</span>
		<span><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></span>
	</p>
</div>
