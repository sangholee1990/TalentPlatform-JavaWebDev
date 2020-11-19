<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><spring:message code="title"/></title>
<link rel="stylesheet" type="text/css" href="../css/default.css"  />
<jsp:include page="../include/jquery.jsp" />
<script type="text/javascript">
$(function() {
	$(":button").click(function() {
		location.href="pds_form.do";
	});
});
</script>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->
<div id="contents">
	<h2>자료실</h2>

	<security:authorize ifAnyGranted="ROLE_USER">
    <div class="al_r bm1">
        <input type="button" title="자료 등록" value="자료 등록" class="btnsearch gr" />       
    </div>
    </security:authorize>           
           
    <div class="report_list">
        <table>
        	<thead>
            	<tr>
                	<th>no</th>
                	<th>종류</th>
                	<th>제목</th>
                	<th>첨부파일</th>
                    <th>작성일</th>
                    <th>조회</th>
                </tr>
            </thead>
            <c:choose>
            	<c:when test="${fn:length(list) == 0}">
            		<tr><td colspan="5">등록된 자료가 없습니다.</td></tr>
            	</c:when>
            	<c:otherwise>
					<c:forEach var="o" items="${list}" varStatus="status">            
		            <tr>
		            	<td class="no">${pageNavigation.startNum - status.index}</td>
		            	<td><spring:escapeBody>${o.type}</spring:escapeBody></td>
		            	<td><a href="pds_view.do?id=${o.id}&p=${pageNavigation.nowPage}"><spring:escapeBody>${o.title}</spring:escapeBody></a></td>
		                <td><a href="download.do?id=${o.id}"><spring:escapeBody>${o.filename}</spring:escapeBody></a></td>
		                <td><fmt:formatDate value="${o.create_date}" pattern="yyyy.MM.dd HH:mm"/></td>
		                <td><spring:escapeBody>${o.hit}</spring:escapeBody></td>
		            </tr>
		            </c:forEach>
            	</c:otherwise>
            </c:choose>
        </table>
    </div>
    
    <div class="pager bm4">
  		<c:if test="${pageNavigation.prevPage}">
	        <a href="?p=1" title="처음" class="move"><img src="../images/pager_ico_first.png" alt="이전" /></a>
	        <a href="?p=${pageNavigation.startPage - 1}" title="이전" class="move"><img src="../images/pager_ico_prev.png" alt="이전" /></a>
        </c:if>
        <c:forEach var="page" begin="${pageNavigation.startPage}" end="${pageNavigation.endPage}">
        	<a href="?p=${page}" <c:if test="${page == pageNavigation.nowPage}">class="thispage"</c:if>>${page}</a>
        </c:forEach>
        <c:if test="${pageNavigation.nextPage}">
			<a href="?p=${pageNavigation.endPage + 1}" title="다음" class="move"><img src="../images/pager_ico_next.png" alt="이전" /></a>
        	<a href="?p=${pageNavigation.totalPage}" title="끝" class="move"><img src="../images/pager_ico_last.png" alt="이전" /></a>        
        </c:if>
    </div>
    <!-- END PAGER -->  
</div>
<!-- END CONTENTS -->

<jsp:include page="../footer.jsp" />

</body>
</html>
