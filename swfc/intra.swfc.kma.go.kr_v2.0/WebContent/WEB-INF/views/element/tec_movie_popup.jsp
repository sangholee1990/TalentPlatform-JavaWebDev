<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="../css/default.css" />
<style type="text/css">
body { 
  margin:0; 
  padding:0; 
  height:100%; 
}
</style>
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<jsp:include page="../include/dygraph.jsp" />
<script type="text/javascript">
function search() {
	var startDate = $("#sd").datepicker('getDate');
	var endDate = $("#ed").datepicker('getDate');

	var sd = $.datepicker.formatDate("yymmdd", startDate) + $("#sh").val() + "0000";
	var ed = $.datepicker.formatDate("yymmdd", endDate) + $("#eh").val() + "0000";

	//darwChartData("graph", "${param.type}", sd, ed);
	chartGraphManager.load(sd, ed);
}

$(function() {
	var datepickerOption = {
			changeYear : true,
			showOn : "button",
			buttonImage : '../images/btn_calendar.png',
			buttonImageOnly : true
		};
	$("#sd").datepicker(datepickerOption);
	$("#ed").datepicker(datepickerOption);

	$("#popup .search_wrap :button").click(function(ev) {
		var day = parseInt($(this).val());
		if(!isNaN(day)) {
			var newDate = new Date();
			newDate.setDate($("#ed").datepicker("getDate").getDate() - day);
			$("#sd").datepicker("setDate", newDate);
			$("#sh").val($("#eh").val());
		}
		search();
		return false;
	});
	  <c:choose>
		<c:when test="${param.type == 'XRAY_FLUX'}">
			<c:out value="chartGraphManager.addXRayFlux();"/>
		</c:when>
		<c:when test="${param.type == 'ELECTRON_FLUX'}">
			<c:out value="chartGraphManager.addElectronFlux();"/>
		</c:when>
		<c:when test="${param.type == 'KP_INDEX_KHU'}">
			<c:out value="chartGraphManager.addKpIndexKhu();"/>
		</c:when>
		<c:when test="${param.type == 'KP_INDEX_SWPC'}">
			<c:out value="chartGraphManager.addKpIndexSwpc();"/>
		</c:when>
		<c:when test="${param.type == 'MAGNETOPAUSE_RADIUS'}">
			<c:out value="chartGraphManager.addMagnetopauseRadius();"/>
		</c:when>
		<c:when test="${param.type == 'DST_INDEX_KYOTO'}">
			<c:out value="chartGraphManager.addDstIndexKyoto();"/>
		</c:when>
		<c:when test="${param.type == 'DST_INDEX_KHU'}">
			<c:out value="chartGraphManager.addDstIndexKhu();"/>
		</c:when>
		<c:when test="${param.type == 'POES_NOAA'}">
			<c:out value="chartGraphManager.addAceMag();"/>
		</c:when>
		<c:when test="${param.type == 'TEC'}">
			<c:out value="chartGraphManager.addAceMag();"/>
		</c:when>	
		<c:when test="${param.type == 'ACE_MAG'}">
			<c:out value="chartGraphManager.addAceMag();"/>
		</c:when>
		<c:when test="${param.type == 'ACE_SOLARWIND_SPD'}">
			<c:out value="chartGraphManager.addAceSolarWindSpeed();"/>
		</c:when>
		<c:when test="${param.type == 'ACE_SOLARWIND_DENS'}">
			<c:out value="chartGraphManager.addAceSolarWindDens();"/>
		</c:when>
		<c:when test="${param.type == 'ACE_SOLARWIND_TEMP'}">
			<c:out value="chartGraphManager.addAceSolarWindTemp();"/>
		</c:when>				
	 </c:choose>	
	search();
});
</script>
</head>
<body>
	<div id="popup">
		<h2><custom:ChartTItle type="${param.type}"/></h2>
		<!-- SEARCH -->
		<div class="search_wrap">
			<div class="search">
				<label class="type_tit sun">검색</label>
				<custom:LocalDateTimeRangeSelector startDate="${startDate}" endDate="${endDate}"/>
				<span class="mg"> 
					<input type="button" title="1일" value="1일" class="btn" /> 
					<input type="button" title="2일" value="2일" class="btn" /> 
					<input type="button" title="3일" value="3일" class="btn" />
					<input type="button" title="7일" value="7일" class="btn" />
				</span>

				<div class="searchbtns">
					<input type="button" title="검색" value="검색" class="btnsearch" />
				</div>
			</div>
		</div>
	</div>
	<div class="view" style="position:absolute;left:10px;right:10px;top:110px;bottom:10px;" id="${param.type}"></div>
</body>
</html>