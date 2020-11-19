<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%
	Calendar cal = Calendar.getInstance();
	pageContext.setAttribute("endDate", cal.getTime());
	cal.add(Calendar.DATE, -1);
	pageContext.setAttribute("startDate", cal.getTime());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9" />	
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
function indexToChartType(index) {
	switch(index) {
	case 0:	chartType = "XRAY_FLUX";			break;
	case 1:	chartType = "PROTON_FLUX";			break;
	case 2:	chartType = "KP_INDEX_SWPC";		break;
	case 3:	chartType = "MAGNETOPAUSE_RADIUS";	break;
	default:
		alert("Invalid Chart Index");
	}
};

$(function() {
	var chartOption = {axisLabelColor:'white'};
	chartGraphManager.addXRayFlux({axisLabelColor:'white', colors: ['red','cyan']});
	chartGraphManager.updateOptions({autoRefresh:false});
	chartGraphManager.addProtonFlux(chartOption);
	chartGraphManager.addKpIndexSwpc(chartOption);
	chartGraphManager.addMagnetopauseRadius(chartOption);
	
	var sd = "<fmt:formatDate value="${startDate}" pattern="yyyyMMddHH" timeZone="UTC"/>";
	var ed = "<fmt:formatDate value="${endDate}" pattern="yyyyMMddHH" timeZone="UTC"/>";
	chartGraphManager.load({sd:sd, ed:ed});
	
	var datepickerOption = {
			changeYear:true,
			showOn: "button",
			buttonImage: '<c:url value="/resources/ko/images/btn_calendar.png"/>', 
			buttonImageOnly: true
	};
	$("#calendar_chart_start_date").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
	$("#calendar_chart_end_date").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
	
	$("#calendar_layer a.close").click(function(e) {
		$("#calendar_layer").hide();
		e.defaultPrevented = true;
		return false;
	});
	
	var dataHolders = $("#wrap_current .wrap_info p.date"); 
	dataHolders.each(function(idx, item) {
		var chartType = "";
		switch(idx) {
		case 0:	chartType = "XRAY_FLUX";			break;
		case 1:	chartType = "PROTON_FLUX";			break;
		case 2:	chartType = "KP_INDEX_SWPC";		break;
		case 3:	chartType = "MAGNETOPAUSE_RADIUS";	break;
		default:
			alert("Invalid Chart Index");
		}
		$(this).data({sd:sd,ed:ed,chartType:chartType});
	});
	
	$("#calendar_layer :button").click(function(e) {
		var dataHolder = dataHolders.eq($("#calendar_layer").data("dataHolderIndex"));

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
		
		var sd = $.datepicker.formatDate('yymmdd', new Date(startDate)) + "00";
		var ed = $.datepicker.formatDate('yymmdd', new Date(endDate)) + "23";
		dataHolder.data({sd:sd,ed:ed});
		chartGraphManager.load({
			sd : sd,
			ed : ed,
			type: dataHolder.data("chartType")
		});
		
		$("#calendar_layer").hide();		
		e.defaultPrevented = true;
		return false;
	});
	
	var calendarButtons = $("#wrap_current .wrap_info a.calendar"); 
	calendarButtons.click(function(e) {
		var button = $(this);
		var buttonIndex = calendarButtons.index(button);
		var calendar = $("#calendar_layer");
		calendar.data({
			dataHolderIndex:buttonIndex	
		});
		
		var offset = button.offset();
		calendar.css('top', offset.top+25);
		calendar.css('left', offset.left-139);
		$("#ui-datepicker-div").css("z-index", 20);
		calendar.show();
		
		e.defaultPrevented = true;
		return false;
	});
	
	var detailButtons = $("#wrap_current .wrap_info a.detail");
	detailButtons.click(function(e) {
		var button = $(this);
		var buttonIndex = detailButtons.index(button);
		var dataHolder = dataHolders.eq(buttonIndex);
		var url = "<c:url value="/ko/current/pop"/>?" + $.param(dataHolder.data());
		window.open(url, '_blank','width=1024,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
		
		e.defaultPrevented = true;
		return false;
	});
});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/topMenu.jsp"/>
<div id="wrap_current">
	<h3 class="sun"><span>태양영상</span></h3>
	<div class="wrap_sun">
        <div class="cgroup s_sun">
        	<div class="title">
            	<h5>${imageList.SDO__01001.codeText}</h5>
			 </div>
			<div class="body s_sun">
				<img src="<c:url value="${imageList.SDO__01001.imageUrl}"/>" alt="" style="width:100%;max-height:100%"/>
            </div>
        </div>
        
        <div class="cgroup s_sun">
        	<div class="title">
            	<h5>${imageList.SDO__01002.codeText}</h5>
            </div>
            <div class="body s_sun">
            	<img src="<c:url value="${imageList.SDO__01002.imageUrl}"/>" alt="" style="width:100%;max-height:100%"/>
            </div>
        </div>
        
        <div class="cgroup s_sun">
        	<div class="title">
            	<h5>${imageList.SDO__01005.codeText}</h5>
            </div>
            <div class="body s_sun">
            	<img src="<c:url value="${imageList.SDO__01005.imageUrl}"/>" alt="" style="width:100%;max-height:100%"/>
            </div>
        </div>
        
        <div class="cgroup s_sun">
        	<div class="title">
            	<h5>${imageList.SDO__01004.codeText}</h5>
            </div>
            <div class="body s_sun">
            	<img src="<c:url value="${imageList.SDO__01004.imageUrl}"/>" alt="" style="width:100%;max-height:100%"/>
            </div>
        </div>
	</div>
    <!-- END 태양영상 -->
    
    <h3 class="alert"><span>예특보상황</span></h3>
    <div class="wrap_forecast">
        <div class="current_sum">
            <div class="sign sat2 <custom:CodeSign notice="${summary.notice1}"/>">
                <p><c:if test="${summary.notice1 != null}">${summary.notice1.code}</c:if></p>
            </div>
            <div class="sign pol2 <custom:CodeSign notice="${summary.notice2}"/>">
                <p><c:if test="${summary.notice2 != null}">${summary.notice2.code}</c:if></p>
            </div>
            <div class="sign ion2 <custom:CodeSign notice="${summary.notice3}"/>">
                <p><c:if test="${summary.notice3 != null}">${summary.notice3.code}</c:if></p>
            </div>
        </div>  
        
        <div class="group s_alert">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_rad.png"/>" alt="태양복사폭풍" />
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.XRAY_H3}"/>">
					<p>${summary.XRAY_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.XRAY_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<p class="infotext">
					<span class="message fw">${summary.XRAY_H3.gradeText}</span> 
					<span>현재 : ${summary.XRAY_NOW.val}</span>
					<span>
					<c:choose>
						<c:when test="${summary.XRAY_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : ${summary.XRAY_H3.val}</span>
					<span><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></span>
				</p>
			</div>            
        </div>
        <!-- END 태양복사폭풍 -->
        <div class="group">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_par.png"/>" alt="태양입자폭풍" />
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.PROTON_H3}"/>">
					<p>${summary.PROTON_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.PROTON_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<p class="infotext">
					<span class="message fw">${summary.PROTON_H3.gradeText}</span> 
					<span>현재 : ${summary.PROTON_NOW.val}</span>
					<span>
					<c:choose>
						<c:when test="${summary.PROTON_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : ${summary.PROTON_H3.val}</span>
					<span><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></span>
				</p>
			</div>            
        </div>
        <!-- END 태양입자폭풍 -->
        <div class="group">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_ter.png"/>" alt="지자기폭풍" />
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.KP_H3}"/>">
					<p>${summary.KP_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.KP_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<p class="infotext">
					<span class="message fw">${summary.KP_H3.gradeText}</span> 
					<span>현재 : ${summary.KP_NOW.val}</span>
					<span>
					<c:choose>
						<c:when test="${summary.KP_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : ${summary.KP_H3.val}</span>
					<span><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></span>
				</p>
			</div>            
        </div>
        <!-- END 지자기폭풍 -->
        <div class="group">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_mag.png"/>" alt="자기권계면" />
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.MP_H3}"/>">
					<p>${summary.MP_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.MP_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<p class="infotext">
					<span class="message fw">${summary.MP_H3.gradeText}</span> 
					<span>현재 : ${summary.MP_NOW.val}</span>
					<span>
					<c:choose>
						<c:when test="${summary.MP_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : ${summary.MP_H3.val}</span>
					<span><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></span>
				</p>
			</div>            
        </div>
        <!-- END 자기권계면 -->
    
    
    </div>
    <!-- END 예특보상황 -->
    
    <h3 class="info"><span>지자기 및 전리권 관측정보</span></h3>
    <div class="wrap_info" style="height:500px;">
    	<div class="cgroup s_info">
        	<div class="title">
            	<h5>X-선 플럭스(GOES-15) [태양복사폭풍]</h5>
                <p class="date">
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="detail"><span>상세보기</span></a>
                </p>
            </div>
            <div id="XRAY_FLUX_LABELS_DIV" class="graph_info"></div>
            <div class="body" id="XRAY_FLUX"></div>
        </div>
        <!-- END X-ray Flux -->
        <div class="cgroup s_info">
        	<div class="title">
            	<h5>양성자 플럭스(GOES-13) [태양입자폭풍]</h5>
                <p class="date">
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="detail"><span>상세보기</span></a>
                </p>
            </div>
            <div id="PROTON_FLUX_LABELS_DIV" class="graph_info"></div>
            <div class="body" id="PROTON_FLUX"></div>
        </div>
        <!-- END Proton Flux -->
        <div class="cgroup s_info">
        	<div class="title">
            	<h5>Kp 지수 [지자기폭풍]</h5>
                <p class="date">
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="detail"><span>상세보기</span></a>
                </p>
            </div>
			<div id="KP_INDEX_SWPC_LABELS_DIV" class="graph_info"></div>
            <div class="body" id="KP_INDEX_SWPC"></div>
        </div>
        <!-- END K Index -->
        <div class="cgroup s_info">
        	<div class="title">
            	<h5>자기권계면 위치 [자기권계면]</h5>
                <p class="date">
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="detail"><span>상세보기</span></a>
                </p>
            </div>
            <div id="MAGNETOPAUSE_RADIUS_LABELS_DIV" class="graph_info"></div>
            <div class="body" id="MAGNETOPAUSE_RADIUS"></div>
        </div>
        <!-- END magnetopause -->
    </div>
    <!-- END 지자기 및 전리권 관측정보 -->
</div>
        <!-- 레이어 // 그래프 달력 -->
<div class="layer" style="top:955px; left:595px;display:none;" id="calendar_layer">
	<div class="layer_contents">
    	<p>
        	<label>시작일</label>
        	<input type="text" size="12" id="calendar_chart_start_date" value="<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd" timeZone="UTC"/>"/>      
        </p>
        <p>
        	<label>종료일</label>
        	<input type="text" size="12" id="calendar_chart_end_date" value="<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd" timeZone="UTC"/>"/>      
        </p>

		<input type="button" class="btn" value="검색"  />
    	<a href="#" class="close"><span>닫기</span></a>
    </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
