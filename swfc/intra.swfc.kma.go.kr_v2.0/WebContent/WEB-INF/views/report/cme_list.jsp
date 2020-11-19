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
<jsp:include page="../include/jquery-ui.jsp" />
<script type="text/javascript">
$(function() {
	var datepickerOption = {
		changeYear : true,
		showOn : "button",
		buttonImage : '../images/btn_calendar.png',
		buttonImageOnly : true
	};
	$("#sd").datepicker(datepickerOption);
	$("#ed").datepicker(datepickerOption);
	
	$("#contents .search_wrap .searchbtns .btnsearch").click(function() {
		var startDate = $("#sd").datepicker('getDate');
		var endDate = $("#ed").datepicker('getDate');
		var sd = $.datepicker.formatDate("yymmdd", startDate) + $("#sh").val() + "0000";
		var ed = $.datepicker.formatDate("yymmdd", endDate) + $("#eh").val() + "0000";
		location.href= "?sd=" + sd + "&ed=" + ed + "&type=" + $("#type").val();
	});
});
</script>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->
<div id="contents">
	<h2>CME 분석 자료</h2>
	
    <!-- SEARCH -->
    <div class="search_wrap">
        <div class="search">
            <label class="type_tit sun">검색</label>
			<custom:DateTimeRangeSelector from="${searchInfo.sd}" to="${searchInfo.ed}" isUTC="false"/>                              
            <span class="mg">
            	<select id="type">
            		<option value="">항목선택 ::::</option>
            		<option value="S" <c:if test="${searchInfo.type == 'S'}">selected="selected"</c:if>>S</option>
            		<option value="C" <c:if test="${searchInfo.type == 'C'}">selected="selected"</c:if>>C</option>
            		<option value="O" <c:if test="${searchInfo.type == 'O'}">selected="selected"</c:if>>O</option>
            		<option value="R" <c:if test="${searchInfo.type == 'R'}">selected="selected"</c:if>>R</option>
            		<option value="ER" <c:if test="${searchInfo.type == 'ER'}">selected="selected"</c:if>>ER</option>
            	</select> 
            </span>
            
            <div class="searchbtns">           
                <input type="button" title="검색" value="검색" class="btnsearch" />
            </div>               
        </div>
    </div>	
	

	<security:authorize ifAnyGranted="ROLE_USER">
    <div class="al_r bm1">
        <a href="cme_download_program.do"><input type="button" title="CME 분석툴 다운로드 " value="CME 분석툴 다운로드 " class="btnsearch gr" /></a>
    </div>
    </security:authorize>           
           
    <div class="report_list">
        <table>
        	<thead>
            	<tr>
                	<th>no</th>
                	<th>제목</th>
                	<th>작성일</th>
                	<th>작성자</th>
                	<th>파일다운</th>
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
		            	<td class="title"><fmt:formatDate value="${o.startObsTime}" pattern="yyyy-MM-dd HH:mm"/> - ${o.speedClass} 형</td>
		            	<td class="writedate">${o.createTime}</td>
		            	<td class="senddate"><spring:escapeBody>${o.analyst}</spring:escapeBody></td>
		                <td class="writedate">
		                	<c:if test="${not empty o.analysisReportPath}">
		                	<a href="cme_download.do?f=${o.analysisReportPath}"><img src="<c:url value="/images/ico_word.png"/>" class="imgbtn"  /></a>
		                	</c:if>
		                </td>
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
        	<a href="?page=${page}&sd=<fmt:formatDate value="${searchInfo.sd}" pattern="yyyyMMddHHmmss"/>&ed=<fmt:formatDate value="${searchInfo.ed}" pattern="yyyyMMddHHmmss"/>&type=${searchInfo.type}" <c:if test="${page == pageNavigation.nowPage}">class="thispage"</c:if>>${page}</a>
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
