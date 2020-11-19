<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/WEB-INF/views/include/engCommonHeader.jsp"/>
<link rel="stylesheet" href="<c:url value="/resources/common/js/themes/base/jquery-ui.css"/>" />
<jsp:include page="/WEB-INF/views/include/dygraph.jsp" />
</head>
<body>
<div id="graph_detail" style="margin:0px auto 0;width:100%;height:100%;padding:0px;">
      	<div class="graph_detail_p">
			<c:choose>
				<c:when test="${param.type == 'XRAY_FLUX'}">
					GOES-15 Solar X-ray Flux[Radio Blackouts]
				</c:when>
				<c:when test="${param.type == 'PROTON_FLUX'}">
					GOES-13 Solar Proton Flux[Solar Radiation Storm]
				</c:when>
				<c:when test="${param.type == 'KP_INDEX_SWPC'}">
					KP INDEX[Geomagnetic Storms]
				</c:when>
				<c:when test="${param.type == 'MAGNETOPAUSE_RADIUS'}">
					Magnetopause Radius[Magnetopause]
				</c:when>
				<c:when test="${param.type == 'ELECTRON_FLUX'}">
					GOES-13 ELECTRON FLUX
				</c:when>
				<c:when test="${param.type == 'ACE_MAG'}">
					ACE IMF Magnetopause
				</c:when>
				<c:when test="${param.type == 'ACE_SOLARWIND_SPD'}">
					ACE Solar Wind Speed
				</c:when>
				<c:when test="${param.type == 'ACE_SOLARWIND_DENS'}">
					ACE Solar Wind Density
				</c:when>
				<c:when test="${param.type == 'ACE_SOLARWIND_TEMP'}">
					ACE Solar Wind Temperature
				</c:when>
				<c:when test="${param.type == 'DST_INDEX_KYOTO'}">
					Kyoto DST Index
				</c:when>
			</c:choose>            	
            <div class='graphlist_bt'>
				<a href='#' class="calendar_btn" title="Search Time Config"><img src='<c:url value="/resources/en/images/common/bt_mm.png"/>' alt=''></a>
			</div>
          </div>
        <!-- END magnetopause -->
  	 <div>
		 <div id="${param.type}_LABELS_DIV" class="graph_info" style="margin-right:20px;"></div>
		 <div id="${param.type}" style="position:absolute;width:98%;height:88%;left:10px;right:10px;top:55px;bottom:10px;"></div>
	</div>
    <!-- END 지자기 및 전리권 관측정보 -->
</div>


<!-- 레이어 // 그래프 달력 -->
<div class="chart_calendar calendar">
	<div class="layer_contents">
    	<p>
        	<label for="start_date">Started</label>
        	<input type="text" size="12" id="start_date" value="${param.sd}" class="date"/>      
        </p>
        <p>
        	<label for="end_date">End</label>
        	<input type="text" size="12" id="end_date" value="${param.ed}" class="date"/>      
        </p>
		<p class="btn_box">
			<button type="button" class="btn submit" title="Submit Date">Submit</button>
	    	<button type="button" class="close btn" title="Close Calendar">Close</button>
    	</p>
    </div>
</div>
<script type="text/javascript" src="<c:url value="/resources/common/js/jquery-ui.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/common/js/date.format.js"/>"></script>
<script type="text/javascript">
$(function() {
	var chartOption = {axisLabelColor:'black'};
	<c:choose>
		<c:when test="${param.type == 'XRAY_FLUX'}">
			<c:out value="chartGraphManager.addXRayFlux({axisLabelColor:'black', colors: ['cyan', 'red']});" escapeXml="false"/>
		</c:when>
		<c:when test="${param.type == 'PROTON_FLUX'}">
			<c:out value="chartGraphManager.addProtonFlux(chartOption);"/>
		</c:when>
		<c:when test="${param.type == 'KP_INDEX_SWPC'}">
			<c:out value="chartGraphManager.addKpIndexSwpc({axisLabelColor:'black', colors: ['orange']});" escapeXml="false"/>
		</c:when>
		<c:when test="${param.type == 'MAGNETOPAUSE_RADIUS'}">
			<c:out value="chartGraphManager.addMagnetopauseRadius({axisLabelColor:'black', colors: ['red']});" escapeXml="false"/>
		</c:when>
		<c:when test="${param.type == 'ELECTRON_FLUX'}">
			<c:out value="chartGraphManager.addElectronFlux({axisLabelColor:'black', colors: ['cyan', 'red']});" escapeXml="false"/>
		</c:when>
		<c:when test="${param.type == 'ACE_MAG'}">
			<c:out value="chartGraphManager.addAceMag({axisLabelColor:'black', colors: ['cyan', 'blue', 'red', 'yellow']});" escapeXml="false"/>
		</c:when>
		<c:when test="${param.type == 'ACE_SOLARWIND_SPD'}">
			<c:out value="chartGraphManager.addAceSolarWindSpeed(chartOption);"/>
		</c:when>
		<c:when test="${param.type == 'ACE_SOLARWIND_DENS'}">
			<c:out value="chartGraphManager.addAceSolarWindDens({axisLabelColor:'black', colors: ['red']});" escapeXml="false"/>
		</c:when>
		<c:when test="${param.type == 'ACE_SOLARWIND_TEMP'}">
			<c:out value="chartGraphManager.addAceSolarWindTemp({axisLabelColor:'black', colors: ['red']});" escapeXml="false"/>
		</c:when>
		<c:when test="${param.type == 'DST_INDEX_KYOTO'}">
			<c:out value="chartGraphManager.addDstIndexKyoto({axisLabelColor:'black', colors: ['red']});" escapeXml="false"/>
		</c:when>
	</c:choose>
	
	chartGraphManager.load({
		sd : "${param.sd}",
		ed : "${param.ed}"
	});
	
	var datepickerOption = {
			dateFormat:"yy-mm-dd",
			changeYear:true,
			showOn: "button",
			buttonImage: '<c:url value="/resources/ko/images/btn_calendar.png"/>', 
			buttonImageOnly: true,
			maxDate:"0D",
			
	};
	var sd = $("#start_date").val();
	var ed = $("#end_date").val();
	$("#start_date").datepicker(datepickerOption).val(sd.substring(0,4) + "-" + sd.substring(4,6)+ "-" + sd.substring(6,8)).next(".ui-datepicker-trigger").addClass("imgbtn");
	$("#end_date").datepicker(datepickerOption).val(ed.substring(0,4) + "-" + ed.substring(4,6)+ "-" + ed.substring(6,8)).next(".ui-datepicker-trigger").addClass("imgbtn");
	
	
	$(".chart_calendar .close").click(function(e) {
		$(".chart_calendar").hide();
		e.defaultPrevented = true;
		return false;
	});
	
	$(".chart_calendar .submit").click(function(e) {
		var startDateVal = $("#start_date").val();
		var endDateVal = $("#end_date").val();
		if(startDateVal == "") {
			alert("시작일을 입력하세요!");
			return false; 
		}
		var startDate = Date.parse(startDateVal);
		if(isNaN(startDate)) {
			alert("시작일을 올바르게 입력하세요!");
			return false;
		}
		
		if(endDateVal == "") {
			alert("종료일을 입력하세요!");
			return false; 
		}
		var endDate = Date.parse(endDateVal);
		if(isNaN(endDate)) {
			alert("종료일을 올바르게 입력하세요!");
			return false;
		}
		
		var diff = (endDate - startDate)/1000;
		if(diff > 86400*7) {
			alert("7일 이내의 범위를 선택하세요!");
			return false;
		}
		if(diff < 0) {
			alert("시작일 또는 종료일을 다시 입력하세요!");
			return false;
		}
		chartGraphManager.load({
			sd : $.datepicker.formatDate('yymmdd', new Date(startDate)) + "00",
			ed : $.datepicker.formatDate('yymmdd', new Date(endDate)) + "23"
		});
		
		$(".chart_calendar").hide();		
		e.defaultPrevented = true;
		return false;
	});
	
	$(".graphlist_bt .calendar_btn").click(function(e) {
		var button = $(this);
		var calendar = $(".chart_calendar");
		var offset = button.offset();
		calendar.css('top', offset.top+25);
		calendar.css('left', offset.left-160);
		calendar.show();
		
		e.defaultPrevented = true;
		return false;
	});
});
</script>
</body>
</html>