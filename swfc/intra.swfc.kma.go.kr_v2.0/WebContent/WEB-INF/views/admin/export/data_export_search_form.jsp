<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!doctype html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />
</head>
<body>
<div class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">기간별 위성자료 데이타 다운로드</h4>
			<!-- content area start -->

			<nav class="navbar navbar-default" role="navigation">
				<div class="collapse navbar-collapse navbar-ex1-collapse text-right">
			    	<form class="navbar-form navbar-right" role="search" method="post" name="searchForm" id="searchForm">
				    	<input type="hidden" id="filename" name="filename" />
				    	
				    	<label for="search_type" class="control-label">데이타 구분</label>
				    	<div class="form-group">
				    		<select class="form-control input-sm" name="search_type" id="search_type">
				    			<option value="">선택</option>
				    			<c:forEach var="subcodeList" items="${subcodeList }" varStatus="status">
				    				<option value="${subcodeList.code }" <c:if test="${params.search_type eq subcodeList.code}">selected="selected"</c:if>>
				    					<spring:escapeBody>${subcodeList.code_nm }</spring:escapeBody>
				    				</option>
				    			</c:forEach>
				    		</select>&nbsp;&nbsp;
				    	</div>
				    	
				    	<div class="form-group">
				    	
				    		<label for="startDate" class="control-label">검색시작</label>
				    		<div class="form-group">
					        	<input type="text" name="startDate" id="startDate" class="form-control input-sm" placeholder="${ params.startDate }" value="${ params.startDate }" style="width: 95px;">
					        	<select class="form-control input-sm" name="startHour" id="startHour" style="width: 60px;">
									<c:forEach var="i" begin="0" end="23" step="1">
										<option value="<fmt:formatNumber minIntegerDigits="2" value="${i}"/>" <c:if test="${params.startHour + 0 == i }">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${i}"/>&nbsp;&nbsp;</option> 
									</c:forEach>				        	
					        	</select>&nbsp;<label class="control-label">시&nbsp;&nbsp;</label>
					      	</div>
					      	
					      	<label for="endDate" class="control-label">검색종료</label>
					      	<div class="form-group">
					        	<input type="text" name="endDate" id="endDate" class="form-control input-sm" placeholder="${ params.endDate }" value="${ params.endDate }" style="width: 95px;">
					        	<select class="form-control input-sm" name="endHour" id="endHour" style="width: 60px;">
								<c:forEach var="i" begin="0" end="23" step="1">
									<option value="<fmt:formatNumber minIntegerDigits="2" value="${i}"/>" <c:if test="${params.endHour + 0 == i }">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${i}"/>&nbsp;&nbsp;</option> 
								</c:forEach>				        	
				        		</select>&nbsp;<label class="control-label">시&nbsp;</label>
					      	</div>
				    	</div>
				    	
				     	<button type="button" id="downloadBtn" class="btn btn-primary btn-sm">다운로드</button>
				     	
			    	</form>
			  	</div>
			</nav>
			<!-- content area end -->
			
			<div style="margin-top: -15px; margin-bottom: 15px; text-align: right; padding-right: 20px;"><span style="color: red; font-weight: bold;">* 검색기간에 따라 다소 시간이 소요될 수 있습니다.</span></div>
			<div class="panel panel-default">
	     		<div class="panel-body">
	     		<p>
	     			X-선 플럭스(GOES-15)<br/>
					양성자 플럭스(GOES-13)<br/>
					양성자 플럭스(GOES-15)<br/>
					자기권계면<br/>
					Kp 지수 <br/>
					ACE IMF 자기장 <br/>
					ACE 태양풍 (속도, 밀도, 온도 )<br/>
					Dst 지수(경희)<br/>
					Dst 지수(교토)<br/>
	     		</p>
	     		</div>
	     	</div>
			
			<jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />
		</div>		
	</div>
		
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript">
var dayNames = ['일', '월', '화', '수', '목', '금', '토'];
var monthNames = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
var datepickerOption = {
		hangeYear : true,
		showOn : "button",
		dayNames: dayNames,
		dayNamesMin: dayNames,
		dayNamesShort: dayNames,
		monthNames : monthNames,
		monthNamesShort : monthNames,
		buttonImage : '<c:url value="/images/btn_calendar.png"/>',
		buttonImageOnly : true,
		dateFormat: "yy-mm-dd"
};

$(function() {
	$("#downloadBtn").on("click", function() {
		if($("#search_type").val() == "") {
			alert("Data 구분을 확인해주십시오.");
			
			$("#search_type").focus();
			
			return false;
		}
		
		var str = "";
		
		var start_dt_str = "";
		var st_temp = $("#startDate").val().split("-");
		start_dt_str += st_temp[0] + "년 ";
		start_dt_str += st_temp[1] + "월 ";
		start_dt_str += st_temp[2] + "일 ";
		
		var end_dt_str = "";
		var end_temp = $("#endDate").val().split("-");
		end_dt_str += end_temp[0] + "년 ";
		end_dt_str += end_temp[1] + "월 ";
		end_dt_str += end_temp[2] + "일 ";
		
		str += "데이타 구분: ";
		str += $("#search_type").find(":selected").text().trim();
		str += "\n검 색  시 작: ";
		str += start_dt_str;
		str += " " + $("#startHour").val() + "시";
		str += "\n검 색  종 료: ";
		str += end_dt_str;
		str += " " + $("#endHour").val() + "시\n";
		
		if(confirm(str + "\n엑셀파일로 저장하시겠습니까?")) {
			submit();
		}
	});
	
	$("#startDate").datepicker(datepickerOption);
	$("#endDate").datepicker(datepickerOption);
});

function submit() {
	$("#filename").val($("#search_type").find(":selected").text().trim());
// 	alert($("#filename").val());
// 	location.href = "export_data_to_excel.do?search_type=" + $("#search_type").val() + "&startDate=" + $("#startDate").val() + "&startHour=" + $("#startHour").val() + "&endDate=" + $("#endDate").val() + "&endHour=" + $("#endHour").val() + "&filename="+$("#filename").val();
	
	$("#searchForm").attr("action", "export_data_to_excel.do");
	$("#searchForm").attr("target", "commonIframe");
	$("#searchForm").submit();
}
</script>	
</body>
</html>