<%@page import="org.joda.time.LocalDate"%>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="com.gaia3d.web.dto.*, java.util.*, org.springframework.util.StringUtils"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%
	ForecastReportDTO report = (ForecastReportDTO)request.getAttribute("report");
	if(StringUtils.isEmpty(report.getTitle())) {
		report.setTitle("우주기상 통보");		
	}
	
	if(StringUtils.isEmpty(report.getContents())) {
		report.setContents("태양복사, 태양고에너지입자 및 지구자기장 교란이 일반수준을 유지하고 있어 기상위성운영, 극항로 항공기상 및 전리권기상에 영향없음.\n\n지구 자기권계면이 정상범위이므로 기상위성운영에 영향없음.");
	}
	
	Date publishDate = report.getPublish_dt();
	Calendar cal = Calendar.getInstance();
	cal.setTime(publishDate);
	
	org.joda.time.LocalDate localDate = new LocalDate(report.getWrite_dt());
	pageContext.setAttribute("probability1Date", localDate.plusDays(1));
	pageContext.setAttribute("probability2Date", localDate.plusDays(2));
	
	pageContext.setAttribute("publishHour", cal.get(Calendar.HOUR_OF_DAY));
	pageContext.setAttribute("publishMinute", cal.get(Calendar.MINUTE));
	
	pageContext.setAttribute("xrayGrade", ChartSummaryDTO.getGrade(ChartSummaryDTO.DataType.XRAY, report.getXray()));
	pageContext.setAttribute("protonGrade", ChartSummaryDTO.getGrade(ChartSummaryDTO.DataType.PROTON, report.getProton()));
	pageContext.setAttribute("kpGrade", ChartSummaryDTO.getGrade(ChartSummaryDTO.DataType.KP, report.getKp()));
	pageContext.setAttribute("mpGrade", ChartSummaryDTO.getGrade(ChartSummaryDTO.DataType.MP, report.getMp()));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 우주기상인트라넷</title>
<link rel="stylesheet" type="text/css" href="../css/default.css"  />
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<script type="text/javascript" src="<c:url value="/js/jquery.validate.min.js"/>"></script>
<script type="text/javascript">
$(function() {
	$("#title").focus();
	
	var datepickerOption = {
			changeYear:true,
			showOn: "button",
			buttonImage: '../images/btn_calendar.png', 
			buttonImageOnly: true
	};
	$("#publishDay").datepicker(datepickerOption);
	$("#publishDay").datepicker(datepickerOption);
	$("#publishDay").datepicker(datepickerOption);
	$("#publishDay").datepicker(datepickerOption);
	
	$("#report").validate({
		debug: false,
		rules: {
			title:"required",
		},
		messages: {
			title:"제목을 입력하세요"
		},
		errorPlacement: function(error, element) {
		       if (element.attr("name") == "tel1" || element.attr("name") == "tel2" || element.attr("name") == "tel3") 
		        error.insertAfter("#tel3");
		       else 
		        error.insertAfter(element);
		},		
		submitHandler: (function(form) {
			var publishDay = $("#publishDay").val();
			var publishDate = publishDay + " " + $("#publishHour").val() + ":" + $("#publishMinute").val() + ":00";
			$("#publish_dt").val(publishDate);
			if(confirm("등록하시겠습니까?")) {
				form.submit();
			}
		})
	});
	
	$(".btn_search").filter(":button").click(function() {
		if(confirm("취소하시겠습니까?")) {
			document.location.href = "forecast_list.do?page=${pageStatus.page}";			
		}
	});
});
</script>
<style>
.error {
	color: #ff0000;
}
 
.errorblock {
	color: #000;
	background-color: #ffEEEE;
	border: 3px solid #ff0000;
	padding: 8px;
	margin: 16px;
}
</style>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->
<form:form commandName="report" enctype="multipart/form-data" action="forecast_submit.do">
<form:hidden path="rpt_seq_n" />
<form:hidden path="rpt_type" />
<form:hidden path="write_dt" />
<form:hidden path="not1_max_val1"/>
<form:hidden path="not1_max_val2"/>
<form:hidden path="not1_max_val3"/>
<form:hidden path="not2_max_val1"/>
<form:hidden path="not2_max_val2"/>
<form:hidden path="not2_max_val3"/>
<form:hidden path="not3_max_val1"/>
<form:hidden path="not3_max_val2"/>
<form:hidden path="not3_max_val3"/>

<input type="hidden" name="page" value="${pageStatus.page}"/>
<div id="contents">
   	<c:if test="${report.rpt_seq_n == null}"><h2>예보 작성</h2></c:if>
   	<c:if test="${report.rpt_seq_n != null}"><h2>예보 수정</h2></c:if>
	<form:errors path="*" cssClass="errorblock" element="div" />
    <div class="report_form bm2">
        <table>
            <tr>
                <th width="70">제목</th>
                <td><form:input path="title" style="width:600px;" /></td>                  
            </tr>
            <tr>
                <th>발표일시</th>
                <td>
                	<form:hidden path="publish_dt" />
                	<input type="text" id="publishDay" readonly="readonly" value="<fmt:formatDate type="date" value="${report.publish_dt}" pattern="yyyy-MM-dd"/>" size="12"/>
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
                <td><form:input path="writer" /></td>                  
            </tr>
            <tr>
                <th>통보구분</th>
                <td>
                	<form:select path="rpt_kind">
                		<option value="N" <c:if test="${report.rpt_kind == 'N'}">selected="selected"</c:if>>신통보문</option>
                		<option value="O" <c:if test="${report.rpt_kind == 'O'}">selected="selected"</c:if> >구통보문</option>
                	</form:select>
                </td>                  
            </tr>
        </table>
    </div> 
    <div class="report_form bm1">
        <table>
            <tr>
                <th>개요</th>
                <td><form:textarea id="reportContents" path="contents" rows="" style="width:640px; height:300px;"/></td>                  
            </tr>
            <tr>
                <th>우주기상 실황</th>
                <td>
                	<table style="width:500px">
                		<tr>
                			<th width="200">감시요소</th>
                			<th>우주기상 등급</th>
                			<th width="100">현재 값</th>
                		</tr>
                		<tr>
                			<td>태양 X선 플럭스</td>
                			<td>${xrayGrade}</td>
                			<td><form:input path="xray" readonly="true" /></td>
                		</tr>
                		<tr>
                			<td>태양 양성자 플럭스</td>
                			<td>${protonGrade}</td>
                			<td><form:input path="proton" readonly="true" /></td>
                		</tr>
                		<tr>
                			<td>지구 자기장교란 지수 Kp</td>
                			<td>${kpGrade}</td>
                			<td><form:input path="kp" readonly="true" /></td>
                		</tr>
                		<tr>
                			<td>지구 자기권계면 위치</td>
                			<td>${mpGrade}</td>
                			<td><form:input path="mp" readonly="true" /></td>
                		</tr>
                	</table>
                </td>                  
            </tr>
            
            <tr>
                <th>주의사항</th>
                <td>
                	<p>
                        <label class="tit_warn">기상위성운영</label>
                        <form:checkboxes items="${not1_desc}" path="not1_desc" />
                    </p>
                    <p>
                        <label class="tit_warn">극항로 항공기상</label>
                       	<form:checkboxes items="${not2_desc}" path="not2_desc" />
                    </p> 
                    <p>
                        <label class="tit_warn">전리권기상</label>
                        <form:checkboxes items="${not3_desc}" path="not3_desc" />
                    </p>
                </td>                  
            </tr>
            <tr>
                <th>우주기상 예보</th>
                <td>
                	<table style="width:500px">
                	    <tr>
                			<th colspan="3" style="text-align:center">우주기상 특보 발생확률(시험운영)</th>
                		</tr>
                		<tr>
                			<th width="100">기상위성운영</th>
                			<td><form:select path="not1_probability1" items="${probabilityRange}"/>%</td>
                			<td><form:select path="not1_probability2" items="${probabilityRange}"/>%</td>
                		</tr>
                		<tr>
                			<th>극항로 항공기상</th>
                			<td><form:select path="not2_probability1" items="${probabilityRange}"/>%</td>
                			<td><form:select path="not2_probability2" items="${probabilityRange}"/>%</td>
                		</tr>
                		<tr>
                			<th>전리권기상</th>
                			<td><form:select path="not3_probability1" items="${probabilityRange}"/>%</td>
                			<td><form:select path="not3_probability2" items="${probabilityRange}"/>%</td>
                		</tr>
                		<tr>
                			<th>기 준</th>
                			<td>
                				<joda:format value="${probability1Date}" />
                			</td>
                			<td>
                				<joda:format value="${probability2Date}" />
                			</td>
                		</tr>                    		            		                		
                	</table>
                </td>                  
            </tr>
            <tr>
                <th>구통보문 파일첨부</th>
                <td>
                	<p>
                    	<form:input path="file_title1" style="width:300px"/>
                    	<br/>
                    	<input type="file" name="file1_data"/> <!--<input type="button" value="파일찾기" class="btn" />--> <c:if test="${!empty report.file_nm1}"><a href="download.do?rpt_seq_n=${report.rpt_seq_n}&fid=1">${report.file_nm1}</a></c:if> <!-- <img src="../images/btn_close_s.png" class="imgbtn" alt="" /> -->
                    </p>
                </td>                  
            </tr>            
        </table>
    </div>
    <div class="al_c bm2">
    	<c:if test="${report.rpt_seq_n == null}"><input type="submit" title="등록" value="등록" class="btn_search" /></c:if>
    	<c:if test="${report.rpt_seq_n != null}"><input type="submit" title="수정" value="수정" class="btn_search" /></c:if>
    	
    	<input type="button" title="최소" value="취소" class="btn_search" />
        <!-- <input type="button" title="미리보기" value="미리보기" class="btn_search" /> -->
    </div>
</div>
</form:form>
<!-- END CONTENTS -->
<jsp:include page="../footer.jsp" />

</body>
</html>
