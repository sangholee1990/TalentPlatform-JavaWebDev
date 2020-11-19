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
<link rel="stylesheet" type="text/css" href="../css/defaultSWAA.css" />
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
		$("#ed").datepicker(datepickerOption);
		
		$(document).on('click', 'img.imageclick', function() {
			var imagesrc = $(this).attr('src');
			imagesrc = imagesrc.replace(/&/g, "*");
			window.open("element_image_click.do?imagesrc="+imagesrc,"_blank",'width=900,height=900,toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, directories=no, status=no')
		});
	});
	
	function rbspImage() {
		var startDate = $("#sd").datepicker('getDate');
		var year = $.datepicker.formatDate("yy", startDate);
		var month = $.datepicker.formatDate("mm", startDate);
		var date = $.datepicker.formatDate("dd", startDate);

		//alert(year+"/"+month+"/"+date);

		$("#rbsp_list").empty();
		
		var str = "<a href='#'><img class='imageclick' style='padding: 3px;' height='500px' src='<c:url value='/elementSWAA/intraRBSP.do?index=-2&year="+year+"&month="+month+"&date="+date+"'/>'/></a>"
		str += "<a href='#'><img class='imageclick' style='padding: 3px;' height='500px' src='<c:url value='/elementSWAA/intraRBSP.do?index=-1&year="+year+"&month="+month+"&date="+date+"'/>'/></a>"
		str += "<a href='#'><img class='imageclick' style='padding: 3px;' height='500px' src='<c:url value='/elementSWAA/intraRBSP.do?index=0&year="+year+"&month="+month+"&date="+date+"'/>'/></a>"
		
		$("#rbsp_list").append(str);
	}
</script>
</head>

<body>
	<jsp:include page="../header.jsp" />
	<!-- END HEADER -->

	<div id="contents">
		<h2>Van Allen Probes(RBSP)</h2>
		<!-- SEARCH -->
		<div class="search_wrap">
			<div class="search">
				<label class="type_tit sun">검색(UTC)</label>
				<custom:DateTimeRangeSelectyymmdd offset="1" />
				<div class="searchbtns">
					<input type="button" title="검색" value="검색" class="btnsearch" onclick="rbspImage()" />
				</div>
			</div>
		</div>

		<div id="rbsp_list" align="center">
			<a href="#"><img class='imageclick' style="padding: 3px;" height="500px" src="<c:url value='/elementSWAA/intraRBSP.do?index=-2'/>"/></a>
			<a href="#"><img class='imageclick' style="padding: 3px;" height="500px" src="<c:url value='/elementSWAA/intraRBSP.do?index=-1'/>"/></a>
			<a href="#"><img class='imageclick' style="padding: 3px;" height="500px" src="<c:url value='/elementSWAA/intraRBSP.do?index=0'/>"/></a>
		</div>

	</div>
	<!-- END CONTENTS -->

	<jsp:include page="../footer.jsp" />

</body>
</html>
