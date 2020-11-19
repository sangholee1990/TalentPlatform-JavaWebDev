<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 우주기상인트라넷</title>
<link rel="stylesheet" type="text/css" href="../css/default.css"  />
<link rel="stylesheet" href="<c:url value="/js/themes/base/jquery-ui.css"/>" />
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<jsp:include page="../include/dygraph.jsp" />
<script type="text/javascript">
	function search() {
		var startDate = $("#sd").datepicker('getDate');
		var endDate = $("#ed").datepicker('getDate');

		var sd = $.datepicker.formatDate("yymmdd", startDate) + $("#sh").val() + "0000";
		var ed = $.datepicker.formatDate("yymmdd", endDate) + $("#eh").val() + "0000";
		
		chartGraphManager.load({sd : sd, ed: ed});
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

		$("#contents .search_wrap :button").click(function(ev) {
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
		
		
		chartGraphManager.addXRayFlux();
		chartGraphManager.addProtonFlux();
		chartGraphManager.addMagnetopauseRadius();
		//chartGraphManager.addElectronFlux();
		chartGraphManager.addElectronFluxAll();
		chartGraphManager.addKpIndexSwpc();
		//chartGraphManager.addKpIndexKhu();
		chartGraphManager.addDstIndexKyoto();
		//chartGraphManager.addDstIndexKhu();
		
		search();
		
		$("#contents .inbtn .view").click(function() {
			var type = $(this).attr('alt');
			var startDate = $("#sd").datepicker('getDate');
			var endDate = $("#ed").datepicker('getDate');
			var sd = $.datepicker.formatDate("yymmdd", startDate) + $("#sh").val() + "0000";
			var ed = $.datepicker.formatDate("yymmdd", endDate) + $("#eh").val() + "0000";
			var url = "<c:url value="/chart/chart_popup.do"/>?type=" + type + "&sd=" + sd + "&ed=" + ed;
			window.open(url, '_blank','width=1024,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
		});
		
		$("#contents .inbtn .unzoom").click(function() {
			var type = $(this).attr('alt');
			chartGraphManager.resetZoom(type);
		});
		
		$("#contents .inbtn .saveimg").click(function() {
			var type = $(this).attr('alt');
			chartGraphManager.exportImage(type);
		});
	});
</script>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->

<div id="contents">
    <h2>지구자기권</h2>    
    <!-- SEARCH -->
    <div class="search_wrap">
        <div class="search">
            <label class="type_tit sun">검색(UTC)</label>
            <custom:DateTimeRangeSelector/>                  
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
    <!-- X-선 플럭스 -->
    <div class="hour">
    	<h6><custom:ChartTItle type="XRAY_FLUX"/></h6>
        <div class="inbtn">
            <input type="button" title="새창보기" class="btnimg view" alt="XRAY_FLUX"/>
            <input type="button" title="화면리셋" class="btnimg unzoom" alt="XRAY_FLUX"/>
            <input type="button" title="이미지저장" class="btnimg saveimg" alt="XRAY_FLUX"/>       
        </div>
        <div id="XRAY_FLUX_LABELS_DIV" class="label"></div>
    </div>
    <div class="contents" style="height:300px;" id="XRAY_FLUX"></div>
    <!-- 양성자플럭스 -->
    <div class="hour">
    	<h6><custom:ChartTItle type="PROTON_FLUX"/></h6>
        <div class="inbtn">
            <input type="button" title="새창보기" class="btnimg view" alt="PROTON_FLUX"/> 
            <input type="button" title="화면리셋" class="btnimg unzoom" alt="PROTON_FLUX"/>
            <input type="button" title="이미지저장" class="btnimg saveimg" alt="PROTON_FLUX"/>     
        </div>
        <div id="PROTON_FLUX_LABELS_DIV" class="label"></div>
    </div>
    <div class="contents" style="height:300px;" id="PROTON_FLUX"></div>
    <!-- KP 지수 -->
    <div class="hour">
    	<h6><custom:ChartTItle type="KP_INDEX_SWPC"/></h6>
        <div class="inbtn">
            <input type="button" title="새창보기" class="btnimg view" alt="KP_INDEX_SWPC"/> 
            <input type="button" title="화면리셋" class="btnimg unzoom" alt="KP_INDEX_SWPC"/>
            <input type="button" title="이미지저장" class="btnimg saveimg" alt="KP_INDEX_SWPC"/>     
        </div>
        <div id="KP_INDEX_SWPC_LABELS_DIV" class="label"></div>
    </div>
    <div class="contents" style="height:300px;" id="KP_INDEX_SWPC"></div>
    
    <!-- 
    <div class="hour">
    	<h6>Kp 지수</h6>
        <div class="inbtn">
            <input type="button" title="새창보기" class="btnimg view" alt="KP_INDEX_KHU"/>
            <input type="button" title="화면리셋" class="btnimg unzoom" alt="KP_INDEX_KHU"/>       
            <input type="button" title="이미지저장" class="btnimg saveimg" alt="KP_INDEX_KHU"/>      
        </div>
        <div id="KP_INDEX_KHU_LABELS_DIV" class="label"></div>
    </div>
    <div class="contents" style="height:300px;" id="KP_INDEX_KHU"></div>
     -->
    
    <div class="hour">
    	<h6><custom:ChartTItle type="MAGNETOPAUSE_RADIUS"/></h6>
        <div class="inbtn">
            <input type="button" title="새창보기" class="btnimg view" alt="MAGNETOPAUSE_RADIUS"/>
            <input type="button" title="화면리셋" class="btnimg unzoom" alt="MAGNETOPAUSE_RADIUS"/>
            <input type="button" title="이미지저장" class="btnimg saveimg" alt="MAGNETOPAUSE_RADIUS"/>      
        </div>
        <div id="MAGNETOPAUSE_RADIUS_LABELS_DIV" class="label"></div>
    </div>
    <div class="contents" style="height:300px;" id="MAGNETOPAUSE_RADIUS"></div>
    <div class="hour">
    	<h6><custom:ChartTItle type="ELECTRON_FLUX_ALL"/></h6>
        <div class="inbtn">
            <input type="button" title="새창보기" class="btnimg view" alt="ELECTRON_FLUX_ALL"/>
            <input type="button" title="화면리셋" class="btnimg unzoom" alt="ELECTRON_FLUX_ALL"/>
            <input type="button" title="이미지저장" class="btnimg saveimg" alt="ELECTRON_FLUX_ALL"/>      
        </div>
        <div id="ELECTRON_FLUX_ALL_LABELS_DIV" class="label"></div>
    </div>
    <div class="contents" style="height:300px;" id="ELECTRON_FLUX_ALL"></div>
    
    
    <!-- 
     -->
    <div class="hour">
    	<h6><custom:ChartTItle type="DST_INDEX_KYOTO"/></h6>
        <div class="inbtn">
            <input type="button" title="새창보기" class="btnimg view" alt="DST_INDEX_KYOTO"/>
            <input type="button" title="화면리셋" class="btnimg unzoom" alt="DST_INDEX_KYOTO"/>
            <input type="button" title="이미지저장" class="btnimg saveimg" alt="DST_INDEX_KYOTO"/>        
        </div>
        <div id="DST_INDEX_KYOTO_LABELS_DIV" class="label"></div>
    </div>
    <div class="contents" style="height:300px;" id="DST_INDEX_KYOTO"></div>
    <!-- 
    <div class="hour">
    	<h6><custom:ChartTItle type="DST_INDEX_KHU"/></h6>
        <div class="inbtn">
            <input type="button" title="새창보기" class="btnimg view" alt="DST_INDEX_KHU"/>
            <input type="button" title="화면리셋" class="btnimg unzoom" alt="DST_INDEX_KHU"/>
            <input type="button" title="이미지저장" class="btnimg saveimg" alt="DST_INDEX_KHU"/>      
        </div>
        <div id="DST_INDEX_KHU_LABELS_DIV" class="label"></div>
    </div>
    <div class="contents" style="height:300px;" id="DST_INDEX_KHU"></div>
     -->
</div>
<!-- END CONTENTS -->
<jsp:include page="../footer.jsp" />

</body>
</html>
