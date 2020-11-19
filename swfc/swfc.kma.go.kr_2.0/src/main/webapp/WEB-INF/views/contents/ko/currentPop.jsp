<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<style>
.dygraph-ylabel{
	font-weight: bold;
	color:white;
}
</style>
<jsp:include page="/WEB-INF/views/include/jquery.jsp" />
<jsp:include page="/WEB-INF/views/include/jquery-ui.jsp" />
<jsp:include page="/WEB-INF/views/include/dygraph.jsp" />
<script type="text/javascript">
$(function() {
	var chartOption = {axisLabelColor:'white'};
	<c:choose>
		<c:when test="${param.type == 'XRAY_FLUX'}">
			<c:out value="chartGraphManager.addXRayFlux({axisLabelColor:'white', colors: ['cyan', 'red']});" escapeXml="false"/>
		</c:when>
		<c:when test="${param.type == 'PROTON_FLUX'}">
			<c:out value="chartGraphManager.addProtonFlux(chartOption);"/>
		</c:when>
		<c:when test="${param.type == 'KP_INDEX_SWPC'}">
			<c:out value="chartGraphManager.addKpIndexSwpc({axisLabelColor:'white', colors: ['orange']});" escapeXml="false"/>
		</c:when>
		<c:when test="${param.type == 'MAGNETOPAUSE_RADIUS'}">
			<c:out value="chartGraphManager.addMagnetopauseRadius({axisLabelColor:'white', colors: ['red']});" escapeXml="false"/>
		</c:when>
		<c:when test="${param.type == 'ELECTRON_FLUX'}">
			<c:out value="chartGraphManager.addElectronFlux({axisLabelColor:'white', colors: ['cyan', 'red']});" escapeXml="false"/>
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
		<c:when test="${param.type == 'DST_INDEX_KYOTO'}">
			<c:out value="chartGraphManager.addDstIndexKyoto({axisLabelColor:'white', colors: ['red']});" escapeXml="false"/>
		</c:when>
	</c:choose>
	
	chartGraphManager.load({
		sd : "${param.sd}",
		ed : "${param.ed}"
	});
	
	var datepickerOption = {
			changeYear:true,
			showOn: "button",
			buttonImage: '<c:url value="/resources/ko/images/btn_calendar.png"/>', 
			buttonImageOnly: true,
			maxDate:"0D"
	};
	$("#calendar_chart_start_date").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
	$("#calendar_chart_end_date").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
	
	
	$("#calendar_layer a.close").click(function(e) {
		$("#calendar_layer").hide();
		e.defaultPrevented = true;
		return false;
	});
	
	$("#calendar_layer :button").click(function(e) {
		var startDateVal = $("#calendar_chart_start_date").val();
		var endDateVal = $("#calendar_chart_end_date").val();
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
		
		$("#calendar_layer").hide();		
		e.defaultPrevented = true;
		return false;
	});
	
	$("#wrap_current a.calendar").click(function(e) {
		var button = $(this);
		var calendar = $("#calendar_layer");
		var offset = button.offset();
		calendar.css('top', offset.top+25);
		calendar.css('left', offset.left-180);
		$("#ui-datepicker-div").css("z-index", 20);
		calendar.show();
		
		e.defaultPrevented = true;
		return false;
	});
});
</script>
</head>
<body style="background-image:none;">
<div id="wrap_current" style="margin:0px auto 0;width:100%;height:100%;padding:0px;">
    <div class="wrap_info" style="width:100%;height:100%;margin:0px;">
    	<div class="cgroup s_info" style="width:100%;">
        	<div class="title">
            	<h5>
				<c:choose>
					<c:when test="${param.type == 'XRAY_FLUX'}">
						X-선 플럭스(GOES-15)
					</c:when>
					<c:when test="${param.type == 'PROTON_FLUX'}">
						양성자 플럭스(GOES-13)
					</c:when>
					<c:when test="${param.type == 'KP_INDEX_SWPC'}">
						Kp 지수
					</c:when>
					<c:when test="${param.type == 'MAGNETOPAUSE_RADIUS'}">
						자기권계면
					</c:when>
					<c:when test="${param.type == 'ELECTRON_FLUX'}">
						전자기 플럭스(GOES-13)
					</c:when>
					<c:when test="${param.type == 'ACE_MAG'}">
						ACE IMF 자기장
					</c:when>
					<c:when test="${param.type == 'ACE_SOLARWIND_SPD'}">
						ACE 태양풍 속도
					</c:when>
					<c:when test="${param.type == 'ACE_SOLARWIND_DENS'}">
						ACE 태양풍 밀도
					</c:when>
					<c:when test="${param.type == 'ACE_SOLARWIND_TEMP'}">
						ACE 태양풍 온도
					</c:when>
					<c:when test="${param.type == 'DST_INDEX_KYOTO'}">
						Dst 지수
					</c:when>
				</c:choose>            	
            	</h5>
                <p class="date" style="padding-right: 10px;">
                    <a href="#" class="calendar"><span>달력</span></a>
                </p>
            </div>
            <div id="${param.type}_LABELS_DIV" class="graph_info" style="margin-right:20px;"></div>
        </div>
        <!-- END magnetopause -->
    </div>
    <!-- END 지자기 및 전리권 관측정보 -->
</div>
<div id="${param.type}" style="position:absolute;width:97%;height:88%;left:10px;right:10px;top:55px;bottom:10px;"></div>
<!-- 레이어 // 그래프 달력 -->
<div class="layer" style="top:955px; left:595px;display:none;" id="calendar_layer">
	<div class="layer_contents">
    	<p>
        	<label>시작일</label>
        	<input type="text" size="10" id="calendar_chart_start_date" value=""/>      
        </p>
        <p>
        	<label>종료일</label>
        	<input type="text" size="10" id="calendar_chart_end_date" value=""/>
        </p>

		<input type="button" class="btn" value="검색"  />
    	<a href="#" class="close"><span>닫기</span></a>
    </div>
</div>
</body>
</html>