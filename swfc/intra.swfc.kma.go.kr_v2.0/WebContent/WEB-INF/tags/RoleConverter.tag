 <%@ tag body-content="scriptless" pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ attribute name="role" required="true" fragment="false"%>
 <c:choose>
 	<c:when test="${role=='ROLE_ADMIN'}">관리자</c:when>
 	<c:when test="${role=='ROLE_USER'}">코로나분석</c:when>
 	<c:when test="${role=='ROLE_SPECIFIC_USER'}">특정수요자</c:when>
 	<c:otherwise>${role}</c:otherwise>
 </c:choose>
