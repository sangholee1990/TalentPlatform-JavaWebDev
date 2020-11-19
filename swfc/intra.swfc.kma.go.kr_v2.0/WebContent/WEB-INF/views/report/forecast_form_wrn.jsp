<%@page import="org.springframework.jdbc.datasource.SimpleDriverDataSource"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="com.gaia3d.web.dto.*, java.util.*, org.springframework.util.StringUtils"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%
	ForecastReportDTO report = (ForecastReportDTO)request.getAttribute("report");
	if(StringUtils.isEmpty(report.getTitle())) {
		report.setTitle("우주기상 특보");		
	}
	
	if(StringUtils.isEmpty(report.getContents())) {
		report.setContents("");
	}
	
	if(StringUtils.isEmpty(report.getFile_title1())) {
		report.setFile_title1("태양복사폭풍");
	}
	
	if(StringUtils.isEmpty(report.getFile_title2())) {
		report.setFile_title2("자기권계면 위치");
	}
	
	Date publishDate = report.getPublish_dt();
	SimpleDateFormat df = new SimpleDateFormat("MM.dd HH:mm");
	String noticePublish = df.format(publishDate);
	String noticeFinish = "진행 중";
	if(StringUtils.isEmpty(report.getNot1_publish())) {
		report.setNot1_publish(noticePublish);
	}
	if(StringUtils.isEmpty(report.getNot2_publish())) {
		report.setNot2_publish(noticePublish);
	}
	if(StringUtils.isEmpty(report.getNot3_publish())) {
		report.setNot3_publish(noticePublish);
	}
	if(StringUtils.isEmpty(report.getNot1_finish())) {
		report.setNot1_finish(noticeFinish);
	}
	if(StringUtils.isEmpty(report.getNot2_finish())) {
		report.setNot2_finish(noticeFinish);
	}
	if(StringUtils.isEmpty(report.getNot3_finish())) {
		report.setNot3_finish(noticeFinish);
	}

	Calendar cal = Calendar.getInstance();
	cal.setTime(publishDate);
	pageContext.setAttribute("publishHour", cal.get(Calendar.HOUR_OF_DAY));
	pageContext.setAttribute("publishMinute", cal.get(Calendar.MINUTE));

	List<String> noticeTypeList = new ArrayList<String>();
	noticeTypeList.add("주의보");
	noticeTypeList.add("경보");
	pageContext.setAttribute("noticeTypeList", noticeTypeList);

	
	List<String> noticeTargetList = new ArrayList<String>();
	noticeTargetList.add("기상위성");
	noticeTargetList.add("극항로 항공기 운항");
	noticeTargetList.add("위성항법시스템(GNSS)");
	pageContext.setAttribute("noticeTargetList", noticeTargetList);
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
	
	$('#reportType').on('change', function(){
		if($('#rpt_kind').val() == 'O'){
			<c:if test="${!empty report.file_title1}">
			$('#file_title1').val('구특보문');
			</c:if>
			<c:if test="${empty report.file_title1}">
			$('#file_title1').val('${report.file_title1}');
			</c:if>
			$('#fileArea2').hide();
		}else{
			<c:if test="${!empty report.file_title1}">
			$('#file_title1').val('태양복사폭풍');
			</c:if>
			<c:if test="${empty report.file_title1}">
			$('#file_title1').val('${report.file_title1}');
			</c:if>
			$('#fileArea2').show();
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
<input type="hidden" name="page" value="${pageStatus.page}"/>
<div id="contents">
	<h2>특보 작성</h2>
	<form:errors path="*" cssClass="errorblock" element="div" />
    <div class="report_form bm2">
        <table>
            <tr>
                <th width="70">제목</th>
                <td><form:input path="title" type="text" style="width:600px;" /></td>                  
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
                <th>특보구분</th>
                <td>
                	<form:select path="rpt_kind">
                		<option value="N" <c:if test="${report.rpt_kind == 'N'}">selected="selected"</c:if>>신특보문</option>
                		<option value="O" <c:if test="${report.rpt_kind == 'O'}">selected="selected"</c:if> >구특보문</option>
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
            	<th>주의사항 상세</th>
            	<td>
            		<table>
            			<tr>
            				<td style="width:50px;">구분</td>
            				<td>기상위성운영</td>
            				<td>극항로 항공기상</td>
            				<td>전리권기상</td>
            			</tr>
            			<tr>
            				<td>특보종류</td>
            				<td><form:select path="not1_type" items="${noticeTypeList}"/></td>
            				<td><form:select path="not2_type" items="${noticeTypeList}"/></td>
            				<td><form:select path="not3_type" items="${noticeTypeList}"/></td>
            			</tr>
            			<tr>
            				<td>발표시각</td>
            				<td><form:input path="not1_publish"/></td>
            				<td><form:input path="not2_publish"/></td>
            				<td><form:input path="not3_publish"/></td>
            			</tr>
            			<tr>
            				<td>종료시각</td>
            				<td><form:input path="not1_finish"/></td>
            				<td><form:input path="not2_finish"/></td>
            				<td><form:input path="not3_finish"/></td>
            			</tr>
            			<tr>
            				<td>대상</td>
            				<td><form:select path="not1_tar" items="${noticeTargetList}"/></td>
            				<td><form:select path="not2_tar" items="${noticeTargetList}"/></td>
            				<td><form:select path="not3_tar" items="${noticeTargetList}"/></td>
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
                <th>상세정보</th>
                <td>
                	<p>
                    	<form:input path="file_title1" style="width:300px"/>
                    	<br/>
                    	<input type="file" name="file1_data"/> <!--<input type="button" value="파일찾기" class="btn" />--> <c:if test="${!empty report.file_nm1}"><a href="download.do?rpt_seq_n=${report.rpt_seq_n}&fid=1">${report.file_nm1}</a></c:if> <!-- <img src="../images/btn_close_s.png" class="imgbtn" alt="" /> -->
                    </p>
                    <p id="fileArea2">
                    	<form:input path="file_title2" style="width:300px"/>
                    	<br/>
                    	<input type="file" name="file2_data"/> <!--<input type="button" value="파일찾기" class="btn" />--> <c:if test="${!empty report.file_nm2}"><a href="download.do?rpt_seq_n=${report.rpt_seq_n}&fid=2">${report.file_nm2}</a></c:if> <!-- <img src="../images/btn_close_s.png" class="imgbtn" alt="" />  -->
                    </p>
                </td>                  
            </tr>
        </table>
    </div>
    <div class="al_c bm2">
    	<input type="submit" title="등록" value="등록" class="btn_search" />
    	<input type="button" title="최소" value="취소" class="btn_search" />
        <!-- <input type="button" title="미리보기" value="미리보기" class="btn_search" /> -->
    </div>
</div>
</form:form>
<!-- END CONTENTS -->
<jsp:include page="../footer.jsp" />

</body>
</html>
