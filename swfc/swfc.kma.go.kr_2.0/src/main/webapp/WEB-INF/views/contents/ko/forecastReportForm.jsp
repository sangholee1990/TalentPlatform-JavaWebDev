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
<%
	ForecastReportDTO report = (ForecastReportDTO)request.getAttribute("report");

	Date publishDate = report.getPublishDate();
	Calendar cal = Calendar.getInstance();
	cal.setTime(publishDate);
	
	if(StringUtils.isEmpty(report.getTitle())) {
		report.setTitle("우주기상 통보");		
	}
	
	pageContext.setAttribute("publishHour", cal.get(Calendar.HOUR_OF_DAY));
	pageContext.setAttribute("publishMinute", cal.get(Calendar.MINUTE));

%>
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
	var datepickerOption = {
			changeYear:true,
			showOn: "button",
			buttonImage: '<c:url value="/images/btn_calendar.png"/>', 
			buttonImageOnly: true
	};
	$("#publishDay").datepicker(datepickerOption);
	
	$('.addBtn').on('click', function(){
		addReport();
	});
	
});

function addReport(){
	if($("input[name='title']").val() == ''){
		alert('제목을 입력해주세요.');
		return false;
	}
	if($("input[name='addKey']").val() == ''){
		alert('등록키를 입력해주세요.');
		return false;
	}
	
	
	var publishDay = $("#publishDay").val();
	var publishDate = publishDay + " " + $("#publishHour").val() + ":" + $("#publishMinute").val() + ":00";
	$("#publishDate").val(publishDate);
	
	if(confirm('등록하시겠습니까?')){
		$('#frm').submit();
	}
}


</script>
</head>
<body>
<jsp:include page="header.jsp"/>
<div id="wrap_sub">
	<span style="font-weight: bold; font-size: 14px;">통보문 등록</span>
	<div class="inputArea" style="margin-top: 20px;">
		<form name="frm" id="frm" method="post" enctype="multipart/form-data" action="<c:url value="/back/forecastReportForm.do"/>" >
        <table>
        	<tr>
                <th width="70">타입</th>
                <td>
                	<select name="type">
                		<option value="FCT">예보문</option>
                		<option value="WRN">특보문</option>
                	</select>
                </td>                  
            </tr>
            <tr>
                <th width="70">제목</th>
                <td><input name="title" style="width: 600px;" value="${report.title}"/></td>                  
            </tr>
            <tr>
                <th>발표일시</th>
                <td style="text-align: left;">
                	<input type="hidden" id="publishDate" name="publishDate" />
                	<input type="hidden" id="reportType" name="reportType" value="O" />
                	<input type="text" id="publishDay" readonly="readonly" value="<fmt:formatDate type="date" value="${report.publishDate}" pattern="yyyy-MM-dd"/>" size="12"/>
                	<select id="publishHour">
	                	<c:forEach begin="0" end="23" var="item"><option value="<fmt:formatNumber minIntegerDigits="2" value="${item}" />" <c:if test="${publishHour == item}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${item}"/></option></c:forEach>
                	</select>시
                	<select id="publishMinute">
	                	<c:forEach begin="0" end="59" var="item"><option value="<fmt:formatNumber minIntegerDigits="2" value="${item}" />" <c:if test="${publishMinute == item}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${item}"/></option></c:forEach>
                	</select>분
                </td>                  
            </tr>
            <tr>
                <th>발표자</th>
                <td><input type="text" id="writer" name="writer" value="관리자"/></td>                  
            </tr>
            <tr>
                <th>파일</th>
                <td>
                	<p>
                    	<input type="file" id="fileTitle1" name="fileTitle1" style="width:300px"/>
                    </p>
                </td>                  
            </tr>
            <tr>
                <th>등록키</th>
                <td>
                	<p>
                    	<input type="text" id="addKey" name="addKey" style="width:300px"/>
                    </p>
                </td>                  
            </tr>
            <tr>
            	<th></th>
            	<td style="text-align: right;">
		        	<button class="btn_search addBtn">등록</button>
            	</td>
            </tr>
            
        </table>
        </form>
    </div> 
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
