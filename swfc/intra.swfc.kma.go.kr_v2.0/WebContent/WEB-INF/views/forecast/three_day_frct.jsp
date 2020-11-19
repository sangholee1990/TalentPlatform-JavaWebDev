<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 우주기상인트라넷</title>
<link rel="stylesheet" type="text/css" href="../css/default.css" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/lightbox/css/lightbox.css"/>" />
<style>
.board_list table th {
	text-align: center;
	width: 16.6666%;
}
</style>
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<script type="text/javascript"
	src="<c:url value="/resources/lightbox/js/lightbox.js"/>"></script>
<script type="text/javascript">
	$(function() {
		var datepickerOption = {
			changeYear : true,
			showOn : "button",
			buttonImage : '../images/btn_calendar.png',
			buttonImageOnly : true
		};
		$("#sd").datepicker(datepickerOption);
	});
	
	function callData() {
		var startDate = $("#sd").datepicker('getDate');
		var year = $.datepicker.formatDate("yy", startDate);
		var month = $.datepicker.formatDate("mm", startDate);
		var date = $.datepicker.formatDate("dd", startDate);
		var frct_type = $('#frct_type').val();
		var am_type = $('#am_type').val();
		
		var dataString = "yyyy=" + year + "&mm=" + month + "&dd=" + date + "&frct_type=" + frct_type + "&am_type=" + am_type;
		
		$('#bodyContent').empty();
		$('#bodyContent').html("데이터 요청중입니다 잠시만 기다려 주세요.");
		
		$.ajax({
			url: "get_three_day_frct.do",
			data: dataString,
			dataType: "text"
		}).success(function(data) {
			$('#bodyContent').html(data);
		}).error(function() {
			alert("error");
		});						

		
	}
</script>
</head>

<body>
	<jsp:include page="../header.jsp" />
	<!-- END HEADER -->

	<div id="contents">
		<h2>NOAA 3일 예보</h2>
		<!-- SEARCH -->
		<div class="search_wrap">
			<div class="search">
				<label class="type_tit sun" for="frct_type">구분</label>
				<select name="frct_type" id="frct_type">
					<option value="RSGA">RSGA</option>
					<option value="THREEDAY">THREE DAY</option>
				</select>
				
				<label class="type_tit sun">검색(UTC)</label>
				<custom:DateTimeRangeSelectyymmdd offset="1" />
				
				
				<label class="type_tit sun" for="am_type" >시간구분</label>
				<select name="am_type" style="width: 50px;" id="am_type">
					<option value="00">AM</option>
					<option value="12">PM</option>
				</select>
				<div class="searchbtns">
					<input type="button" title="검색" value="검색" class="btnsearch" onclick="callData()" />
				</div>
			</div>
		</div>

		<div id="bodyContent" align="left" style="margin-left: 20px;"></div>

	</div>
	<!-- END CONTENTS -->

	<jsp:include page="../footer.jsp" />

</body>
</html>
