<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>국가기상위성센터 :: 상황판</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/monitor.css"/>"/>
<style type="text/css">
body { 
  margin:0; 
  padding:0; 
  height:100%; 
}
#ui-datepicker-div {
  z-index: 9999999 !important;
}

.graph {
height:auto !important
}
</style>
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<jsp:include page="../include/dygraph.jsp" />
<script type="text/javascript">
function search() {
	var startDate = $("#sd").val();
	var endDate = $("#ed").val();
	chartGraphManager.load({
		sd : startDate.replace(/-/gi, '') + "000000",
		ed : endDate.replace(/-/gi, '') + "230000",
		type : $(".graph").attr("id")
	});
}

$(function() {
	$(".calendar").click(function(e) {
		var offset = $(this).offset();
		var calenar = $("#calendar_chart");
		calenar.css('top', offset.top+25);
		calenar.css('left', offset.left-175);
		$("#ui-datepicker-div").css("z-index", 20);
		calenar.show();
	});
	var datepickerOption = {
			changeYear:true,
			showOn: "button",
			buttonImage: '<c:url value="/images/monitor/btn_calendar.png"/>', 
			buttonImageOnly: true
	};
	$("#sd").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
	$("#ed").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
	
	$("#calendar_chart .btn").click(function(e) {
		var startDate = $("#sd").val();
		var endDate = $("#ed").val();
		if(startDate == "") {
			alert("시작일을 입력하세요!");
			return false; 
		}
		
		if(endDate == "") {
			alert("종료일을 입력하세요!");
			return false; 
		}
		
		$("#wrap_graph h2 a").removeClass("on");
		chartGraphManager.updateOptions({autoRefresh:false});
		
		search();
		
		$("#calendar_chart").hide();

		e.defaultPrevented = true;
		return false;
	});
	
	$("#calendar_chart .close").click(function(e) {
		$("#calendar_chart").hide();
		
		e.defaultPrevented = true;
		return false;
	});
	
	$("#wrap_graph h2 a").click(function(e) {
		$("#wrap_graph h2 a").addClass("on");
		chartGraphManager.updateOptions({autoRefresh:true});
		
		e.defaultPrevented = true;
		return false;
	});
	
	var chartOption = {axisLabelColor:'white'};
	  <c:choose>
		<c:when test="${param.type == 'XRAY_FLUX'}">
			<c:out value="chartGraphManager.addXRayFlux({axisLabelColor:'white', colors: ['cyan', 'red']});" escapeXml="false"/>
		</c:when>
		<c:when test="${param.type == 'PROTON_FLUX'}">
			<c:out value="chartGraphManager.addProtonFlux(chartOption);"/>
		</c:when>
		<c:when test="${param.type == 'ELECTRON_FLUX'}">
			<c:out value="chartGraphManager.addElectronFlux({axisLabelColor:'white', colors: ['cyan', 'red']});" escapeXml="false"/>
		</c:when>
		<c:when test="${param.type == 'KP_INDEX_KHU'}">
			<c:out value="chartGraphManager.addKpIndexKhu(chartOption);"/>
		</c:when>
		<c:when test="${param.type == 'KP_INDEX_SWPC'}">
			<c:out value="chartGraphManager.addKpIndexSwpc(chartOption);"/>
		</c:when>
		<c:when test="${param.type == 'MAGNETOPAUSE_RADIUS'}">
			<c:out value="chartGraphManager.addMagnetopauseRadius(chartOption);"/>
		</c:when>
		<c:when test="${param.type == 'DST_INDEX_KYOTO'}">
			<c:out value="chartGraphManager.addDstIndexKyoto(chartOption);"/>
		</c:when>
		<c:when test="${param.type == 'DST_INDEX_KHU'}">
			<c:out value="chartGraphManager.addDstIndexKhu(chartOption);"/>
		</c:when>
		<c:when test="${param.type == 'POES_NOAA'}">
			<c:out value="chartGraphManager.addAceMag(chartOption);"/>
		</c:when>
		<c:when test="${param.type == 'TEC'}">
			<c:out value="chartGraphManager.addAceMag(chartOption);"/>
		</c:when>	
		<c:when test="${param.type == 'ACE_MAG'}">
			<c:out value="chartGraphManager.addAceMag({axisLabelColor:'white', colors: ['cyan', 'blue', 'red', 'yellow']});" escapeXml="false"/>
		</c:when>
		<c:when test="${param.type == 'ACE_SOLARWIND_SPD'}">
			<c:out value="chartGraphManager.addAceSolarWindSpeed(chartOption);"/>
		</c:when>
		<c:when test="${param.type == 'ACE_SOLARWIND_DENS'}">
			<c:out value="chartGraphManager.addAceSolarWindDens({axisLabelColor:'white', colors: ['red']});" escapeXml="false"/>
		</c:when>
		<c:when test="${param.type == 'ACE_SOLARWIND_TEMP'}">
			<c:out value="chartGraphManager.addAceSolarWindTemp({axisLabelColor:'white', colors: ['red']});" escapeXml="false"/>
		</c:when>
	 </c:choose>
	 
	  <c:choose>
		<c:when test="${param.autoRefresh == true}">
		<c:out value="chartGraphManager.updateOptions({autoRefresh:true});"/>
		</c:when>
		<c:otherwise>
		<c:out value="search();"/>
		</c:otherwise>
	</c:choose>
});
</script>
</head>
<body>
<div id="wrap" style="width:100%;height:100%">
    <div id="wrap_graph"  style="width:100%;height:100%">
        <div class="gr_graph" style="width:100%;height:100%">
            <div class="header">
                <h2>
                	<a href="#" <c:if test="${param.autoRefresh == true}">class="on"</c:if>><custom:ChartTItle type="${param.type}"/></a>
                </h2>
                <div class="ginfo" id="${param.type}_LABELS_DIV"></div>
                <p class="date">
                    <a href="#" class="calendar"><span>달력</span></a>
                </p>
            </div>
        </div>
	</div>
</div>
<div class="graph" id="${param.type}" style="position:absolute;left:10px;right:10px;top:46px;bottom:10px;"></div>

<div class="layer" style="display:none;" id="calendar_chart">
	<div class="layer_contents">
    	<p>
        	<label>시작일</label>
        	<input type="text" size="12" id="sd" value="${param.sd}"/>      
        </p>
        <p>
        	<label>종료일</label>
        	<input type="text" size="12" id="ed" value="${param.ed}"/>      
        </p>

		<input type="button" class="btn" value="검색"  />
    	<a href="#" class="close"><span>영상선택</span></a>
    </div>
</div>
</body>
</html>