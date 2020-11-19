<%@page import="org.springframework.util.StringUtils"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.gaia3d.web.dto.ForecastReportDTO"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="robots" content="noindex" />
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="include/jquery.jsp" />
<link rel="stylesheet" href="<c:url value="/js/themes/base/jquery-ui.css"/>" />
<style type="text/css">
 .inputArea {}
 .inputArea td {
 	text-align: left;
 }
 .inputArea input {
 	border: 1px solid gray;
 }
 
 .inputArea img {
 	vertical-align: middle;
 }
 
</style>
<script type="text/javascript" src="<c:url value="/js/jquery-ui.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.ui.datepicker-ko.min.js"/>"></script>
<script type="text/javascript">
$(function() {
	$('.iconType').on('click', function(){
		changeData($(this).attr('id'));
	});
});

function changeData(id){
	var userKey = prompt("등록키를 입력해주세요.");
	if(userKey == ''){
		alert('사용자키를 입력해주세요.');
		return false;
	}
	$('#addKey').val(userKey);
	$('#id').val(id);
	if(confirm('통보문 표출을 하시겠습니까?')){
		$('#frm').submit();
	}
	
}

</script>
</head>
<body>
<jsp:include page="header.jsp"/>
<div id="wrap_sub">
	<span style="font-weight: bold; font-size: 14px;">통보문 등록 정보</span>
	<div>
	<div class="result_wrap">
        <table class="list">
            <thead>
                <tr>
                    <th width="20">NO</th>
                    <th>유형</th>
                    <th>제목</th>
                    <th>파일보기</th>
                </tr>
            </thead>
            <tbody>
            	<c:forEach items="${list}" var="item" varStatus="status">
            	<tr>
                    <td>${status.index}</td>
                    <td>
                    	<c:if test="${item.type=='FCT'}"><img class="iconType" id="${item.id}" src="<c:url value="/images/ico_forecast.png"/>" alt="예보" /></c:if>
                    	<c:if test="${item.type=='WRN'}"><img class="iconType" id="${item.id}" src="<c:url value="/images/ico_alert.png"/>" alt="특보" /></c:if>
                    </td>
                    <td><span><fmt:formatDate value="${item.publishDate}" pattern="yyyy.MM.dd HH:mm"/></span>발표</td>
                    <td>
	                   	<c:if test="${item.reportType=='O'}">
		                    <a href="<c:url value="/alerts/downloadOldReport/${item.id}"/>" target="_blank"><img src="<c:url value="/images/ico_pdf.png"/>" alt="Adobe Reader" class="imgbtn" /></a>
	                   	</c:if>
	                   	<c:if test="${item.reportType!='O'}">
		                    <a href="<c:url value="/alerts/download/${item.id}"/>" target="_blank"><img src="<c:url value="/images/ico_pdf.png"/>" alt="Adobe Reader" class="imgbtn" /></a>
	                   	</c:if>
                    </td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    </div> 
</div>
<form id="frm" name="frm" method="post" action="<c:url value="/back/forecastReportComisSubmit.do"/>">
<input type="hidden" name="id" id="id" />
<input type="hidden" name="addKey" id="addKey" />
</form>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
