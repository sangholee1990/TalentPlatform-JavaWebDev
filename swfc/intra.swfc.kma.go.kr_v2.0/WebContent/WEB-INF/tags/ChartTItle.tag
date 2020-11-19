 <%@ tag body-content="scriptless" pageEncoding="utf-8" description="ReportType Converter Tag" trimDirectiveWhitespaces="true"%>
 <%@ attribute name="type" required="true" fragment="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <c:choose>
	<c:when test="${type == 'XRAY_FLUX'}">
		<c:set var="title" value="X-선 플럭스(GOES-15)"/> 
	</c:when>
	<c:when test="${type == 'PROTON_FLUX'}">
		<c:set var="title" value="양성자 플럭스(GOES-13)"/>
	</c:when>
	<c:when test="${type == 'ELECTRON_FLUX'}">
		<c:set var="title" value="전자 플럭스(GOES-13)"/>
	</c:when>
	<c:when test="${type == 'ELECTRON_FLUX_ALL'}">
		<c:set var="title" value="전자 플럭스(GOES-13, GOES-15)"/>
	</c:when>
	<c:when test="${type == 'KP_INDEX_SWPC' || type == 'KP_INDEX_KHU'}">
	   <c:set var="title" value="Kp 지수"/>
	</c:when>
	<c:when test="${type == 'MAGNETOPAUSE_RADIUS'}">
	   <c:set var="title" value="자기권계면"/>
	</c:when>	
	<c:when test="${type == 'DST_INDEX_KYOTO' || type == 'DST_INDEX_KHU'}">
	   <c:set var="title" value="Dst 지수"/>
	</c:when>
	<c:when test="${type == 'POES_NOAA'}">
	   <c:set var="title" value="POES위성자료(NOAA)"/>
	</c:when>
	<c:when test="${type == 'TEC'}">
	   <c:set var="title" value="총전자밀도"/>
	</c:when>	
	<c:when test="${type == 'ACE_MAG'}">
	   <c:set var="title" value="ACE IMF 자기장"/>
	</c:when>
	<c:when test="${type == 'ACE_SOLARWIND_SPD'}">
	   <c:set var="title" value="ACE 태양풍 속도"/>
	</c:when>
	<c:when test="${type == 'ACE_SOLARWIND_DENS'}">
	   <c:set var="title" value="ACE 태양풍 밀도"/>
	</c:when>
	<c:when test="${type == 'ACE_SOLARWIND_TEMP'}">
	   <c:set var="title" value="ACE 태양풍 온도"/>
	</c:when>
	<c:when test="${type == 'SOLAR_MAXIMUM'}">
	   <c:set var="title" value="Solar Maximum"/>
	</c:when>				
	<c:otherwise>
	   <c:set var="title" value="그래프"/>
	</c:otherwise>
 </c:choose>
 <c:out value="${title}"/>