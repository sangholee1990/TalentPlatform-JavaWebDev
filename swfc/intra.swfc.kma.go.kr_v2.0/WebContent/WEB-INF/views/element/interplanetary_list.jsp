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
		
		chartGraphManager.addAceMag();
		chartGraphManager.addAceSolarWindSpeed();
		chartGraphManager.addAceSolarWindDens();
		chartGraphManager.addAceSolarWindTemp();
		
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
    <h2>행성간공간</h2>    
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
    
    <div class="hour" id="ACE_MAG_TITLE">
    	<h6><custom:ChartTItle type="ACE_MAG"/></h6>
        <div class="inbtn">
            <input type="button" title="새창보기" class="btnimg view" alt="ACE_MAG"/>
            <input type="button" title="화면리셋" class="btnimg unzoom" alt="ACE_MAG"/>       
            <input type="button" title="이미지저장" class="btnimg saveimg" alt="ACE_MAG"/>       
        </div>
        <div id="ACE_MAG_LABELS_DIV" class="label"></div>
    </div>
    <div class="contents" style="height:300px;" id="ACE_MAG"></div>
    
    <div class="hour" id="ACE_SOLARWIND_SPD_TITLE">
    	<h6><custom:ChartTItle type="ACE_SOLARWIND_SPD"/></h6>
        <div class="inbtn">
            <input type="button" title="새창보기" class="btnimg view" alt="ACE_SOLARWIND_SPD"/>
            <input type="button" title="화면리셋" class="btnimg unzoom" alt="ACE_SOLARWIND_SPD"/>
            <input type="button" title="이미지저장" class="btnimg saveimg" alt="ACE_SOLARWIND_SPD"/>       
        </div>
        <div id="ACE_SOLARWIND_SPD_LABELS_DIV" class="label"></div>
    </div>
    <div class="contents" style="height:300px;" id="ACE_SOLARWIND_SPD"></div>

    <div class="hour" id="ACE_SOLARWIND_DENS_TITLE">
    	<h6><custom:ChartTItle type="ACE_SOLARWIND_DENS"/></h6>
        <div class="inbtn">
            <input type="button" title="새창보기" class="btnimg view" alt="ACE_SOLARWIND_DENS"/>
            <input type="button" title="화면리셋" class="btnimg unzoom" alt="ACE_SOLARWIND_DENS"/>
            <input type="button" title="이미지저장" class="btnimg saveimg" alt="ACE_SOLARWIND_DENS"/>       
        </div>
        <div id="ACE_SOLARWIND_DENS_LABELS_DIV" class="label"></div>
    </div>
    <div class="contents" style="height:300px;" id="ACE_SOLARWIND_DENS"></div>

    <div class="hour" id="ACE_SOLARWIND_TEMP_TITLE">
    	<h6><custom:ChartTItle type="ACE_SOLARWIND_TEMP"/></h6>
        <div class="inbtn">
            <input type="button" title="새창보기" class="btnimg view" alt="ACE_SOLARWIND_TEMP"/>
            <input type="button" title="화면리셋" class="btnimg unzoom" alt="ACE_SOLARWIND_TEMP"/>
            <input type="button" title="이미지저장" class="btnimg saveimg" alt="ACE_SOLARWIND_TEMP"/>       
        </div>
        <div id="ACE_SOLARWIND_TEMP_LABELS_DIV" class="label"></div>
    </div>
    <div class="contents" style="height:300px;" id="ACE_SOLARWIND_TEMP"></div>
</div>
<!-- END CONTENTS -->

<jsp:include page="../footer.jsp" />
</body>
</html>
