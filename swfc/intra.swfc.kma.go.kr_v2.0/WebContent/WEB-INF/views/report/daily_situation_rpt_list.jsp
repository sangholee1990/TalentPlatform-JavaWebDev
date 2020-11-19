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
<title>국가기상위성센터 :: 우주기상인트라넷</title>
<link rel="stylesheet" type="text/css" href="../css/default.css"  />
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<script type="text/javascript">
$(function() {
	var datepickerOption = {
			changeYear:true,
			showOn: "button",
			buttonImage: '../images/btn_calendar.png', 
			buttonImageOnly: true
	};
	
	
	
	$("#startDate").datepicker(datepickerOption);
	$("#endDate").datepicker(datepickerOption);
	
	$("#btnsearch").on('click',function(){
		search(1);
	});
	
	$(".btn_sf").click(function() {
		if(confirm("삭제하시겠습니까?")) {
			location.href=$(this).attr("href");
		} else {
			
		}
		return false;
	});
	
});

function search(page){
	$("#page").val(page);
 	$("#searchForm").submit();
}
</script>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->

<div id="contents">
	<h2>일일상황보고</h2>
	 <div class="search_wrap">    
        <div class="search">
        	<form class="navbar-form navbar-right" action="<c:url value="/report/daily_situation_rpt_list.do"/>" method="post" name="searchForm" id="searchForm">
        	<input type="hidden" name="page" id="page" value="${pageNavigation.nowPage}" />
            <label class="type_tit sun">검색</label>&nbsp;
			<input type="text" size="12" id="startDate" name="startDate" value="${searchInfo.startDate}"/>
			<select id="startHour" name="startHour">
				<c:forEach begin="0" end="23" varStatus="loop" var="i">
					<option	value="<fmt:formatNumber minIntegerDigits="2" value="${i}"/>" <c:if test="${searchInfo.startHour+0 == i}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${i}" /></option>
				</c:forEach>
			</select>시 ~  
			<input type="text" size="12" id="endDate" name="endDate" value="${searchInfo.endDate}"/>
			<select id="endHour" name="endHour">
				<c:forEach begin="0" end="23" varStatus="loop" var="i">
					<option value="<fmt:formatNumber minIntegerDigits="2" value="${i}"/>" <c:if test="${searchInfo.endHour+0 == i}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${i}" /></option>
				</c:forEach>
			</select>시  
            <div class="searchbtns">           
                <input type="button" title="검색" value="검색" class="btnsearch" id="btnsearch"/>
            </div>
           </form>               
        </div>
    </div>
	           
    <div class="report_list">
        <table>
        	<thead>
            	<tr>
                	<th>no</th>
                    <th>제목</th>
                    <th>발표일시</th>
                    <th>작성일</th>
                    <th>PDF</th>
                </tr>
            </thead>
			<c:forEach var="o" items="${list}" varStatus="status">            
            <tr>
            	<td class="no">${pageNavigation.startNum - status.index}</td>
                <td class="title"><fmt:formatDate value="${o.publish_dt}" pattern="yyyy년 MM월 dd일"/>&nbsp;<spring:escapeBody>${o.title}</spring:escapeBody></td>
                <td class="writedate"><fmt:formatDate value="${o.publish_dt}" pattern="yyyy.MM.dd HH:mm"/></td>
                <td class="writedate"><fmt:formatDate value="${o.write_dt}" pattern="yyyy.MM.dd HH:mm"/></td>
                <td>
                <a href="daily_situation_report_download_pdf.do?rpt_seq_n=${ o.rpt_seq_n }" class="downloadDailySituationReportBtn"><img src="<c:url value="/images/report/ico_pdf.png"/>" /></a>
                </td>
            </tr>
            </c:forEach>
        </table>
    </div>
        
     <div class="pager bm4">
  		<c:if test="${pageNavigation.prevPage}">
	        <a href="javascript:search(1);" title="처음" class="move"><img src="../images/pager_ico_first.png" alt="이전" /></a>
	        <a href="#" onclick="search('${pageNavigation.startPage - 1}');" title="이전" class="move"><img src="../images/pager_ico_prev.png" alt="이전" /></a>
        </c:if>
        <c:forEach var="page" begin="${pageNavigation.startPage}" end="${pageNavigation.endPage}">
        	<a href="javascript:search('${page}');" <c:if test="${page == pageNavigation.nowPage}">class="thispage"</c:if>>${page}</a>
        </c:forEach>
        <c:if test="${pageNavigation.nextPage}">
			<a href="#" onclick="search('${pageNavigation.endPage + 1}');" title="다음" class="move"><img src="../images/pager_ico_next.png" alt="이전" /></a>
        	<a href="#" onclick="search('${pageNavigation.totalPage}');" title="끝" class="move"><img src="../images/pager_ico_last.png" alt="이전" /></a>        
        </c:if>
    </div>
    <!-- END PAGER -->  
</div>
<!-- END CONTENTS -->

<jsp:include page="../footer.jsp" />
</body>
</html>
