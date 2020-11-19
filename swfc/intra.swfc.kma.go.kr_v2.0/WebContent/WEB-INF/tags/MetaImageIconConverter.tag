 <%@ tag body-content="scriptless" pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
 <%@ attribute name="value" required="true" fragment="false"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 <c:choose>
 	<c:when test="${value == 'SDO__01001'}"><c:url value="/images/ico_sdo_aia0131.png"/></c:when>
 	<c:when test="${value == 'SDO__01002'}"><c:url value="/images/ico_sdo_aia0171.png"/></c:when>
 	<c:when test="${value == 'SDO__01003'}"><c:url value="/images/ico_sdo_aia0193.png"/></c:when>
 	<c:when test="${value == 'SDO__01004'}"><c:url value="/images/ico_sdo_aia0211.png"/></c:when>
 	<c:when test="${value == 'SDO__01005'}"><c:url value="/images/ico_sdo_aia0304.png"/></c:when>
 	<c:when test="${value == 'SDO__01006'}"><c:url value="/images/ico_sdo_aia1600.png"/></c:when>
 	<c:when test="${value == 'SOHO_01001'}"><c:url value="/images/ico_sdo_lascoc2.png"/></c:when>
 	<c:when test="${value == 'SOHO_01002'}"><c:url value="/images/ico_sdo_lascoc3.png"/></c:when>
 	<c:when test="${value == 'STA_01001'}"><c:url value="/images/ico_sdo_stereoa.png"/></c:when>
 	<c:when test="${value == 'STA_01002'}"><c:url value="/images/ico_sdo_stereoa.png"/></c:when>
 	<c:when test="${value == 'STB_01001'}"><c:url value="/images/ico_sdo_stereob.png"/></c:when>
 	<c:when test="${value == 'STB_01002'}"><c:url value="/images/ico_sdo_stereob.png"/></c:when>
 </c:choose>