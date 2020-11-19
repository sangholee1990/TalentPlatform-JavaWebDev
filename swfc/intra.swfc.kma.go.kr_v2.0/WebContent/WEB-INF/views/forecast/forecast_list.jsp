<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<script type="text/javascript" src="<c:url value="/js/date.format.js"/>"></script>
<script type="text/javascript">
	function search() {
		var startDate = $("#sd").datepicker('getDate');
		var endDate = $("#ed").datepicker('getDate');

		var sd = $.datepicker.formatDate("yymmdd", startDate) + $("#sh").val() + "0000";
		var ed = $.datepicker.formatDate("yymmdd", endDate) + $("#eh").val() + "0000";
		
		if($("#tab2").hasClass("on")) {
			chartGraphManager.addKpIndexKhu();
			chartGraphManager.addDstIndexKhu();

			chartGraphManager.load(sd, ed);
			
			//darwChartData("DST_INDEX_KHU", "DST_INDEX_KHU", sd, ed);
			//darwChartData("KP_INDEX_KHU", "KP_INDEX_KHU", sd, ed);
			
			$("#solar_maximum_tbody").empty();
			$.getJSON("<c:url value="../chart/chartData.do"/>", {
				type : "SOLAR_MAXIMUM",
				sd : sd,
				ed : ed
			}).done(function(data) {
				var html = "";
				$.each(data, function(key, val) {
					html += '<img src="view_solar_maximum.do?tm=' + val.tm + '"/>';
				});
				$("#solar_maximum_tbody").append(html);
			});			
		} else {
			var dataString = "sd=" + sd + "&ed=" + ed;
			$.ajax({
				url: "searchSPE.do",
				data: dataString,
				dataType: "json"
			}).success(function(data) {
				$("#speTable tbody").empty();
				var tableString = "";
				if(data.spe.length == 0) {
					tableString += "<tr><td colspan='7'>검색 결과가 없습니다.</td></tr>";
				} else {
					$.each(data.spe, function(index, line) {
						tableString += "<tr><td>" + line.spot + "</td><td>" + line.position + "</td><td>" + line.gcls + "</td><td>" + new Date(line.peak_date).format("yyyy/mm/dd HH:MM:ss") + "</td><td>" + line.probab + "</td><td>" + line.pkflux + "</td><td>" + (line.arr_date != null?new Date(line.arr_date).format("yyyy/mm/dd HH:MM:ss"):"") + "</td></tr>"; 
					});
				}
				$("#speTable tbody").append(tableString);
				
				$("#flareTables").empty();
				if(data.flare.length == 0) {
					var flareTable = '<table><thead><tr><th><h3>FLARE Prediction</h3></th></tr></thead><tbody><tr><td>검색 결과가 없습니다.</td></tr></tbody></table>';
					$("#flareTables").append(flareTable);
				} else {
					$.each(data.flare, function(index, flare) {
						var flareDate = new Date(flare.create_date).format("yyyy/mm/dd HH:MM:ss");
						var flareTable = '<table><thead><tr><th colspan="6"><h3>FLARE Prediction<br/>(' + flareDate + ')</h3></th></tr>' +
							'<tr><th>Zpc</th><th>AR</th><th>Phase</th><th>C-Class</th><th>M-Class</th><th>X-Class</th></tr>' +
							'<tr><th colspan="3">Total Prob.</th><td>' + Math.round(flare.total_c*10000)/100 + '%</td><td>' + Math.round(flare.total_m*10000)/100 + '%</td><td>' + Math.round(flare.total_x*10000)/100 + '%</td></tr>' +
							'</thead>' +
							'<tbody>';
						$.each(flare.details, function(detail_idx, detail) {
							flareTable += '<tr><td>' + detail.cls + '</td><td>' + detail.ar + '</td><td>' + detail.phase + '</td><td>' + Math.round(detail.c*10000)/100 + '</td><td>' + Math.round(detail.m*10000)/100 + '</td><td>' + Math.round(detail.x*10000)/100 + '</td></tr>'; 
						});
						flareTable += '</tbody></table>';
						$("#flareTables").append(flareTable);
					});
				}
			}).error(function() {
					alert("error");
			});						
		}
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
		
		
		search();
		
		$("#contents .inbtn input:button").click(function() {
			var type = $(this).attr('alt');
			var startDate = $("#sd").datepicker('getDate');
			var endDate = $("#ed").datepicker('getDate');
			var sd = $.datepicker.formatDate("yymmdd", startDate) + $("#sh").val() + "0000";
			var ed = $.datepicker.formatDate("yymmdd", endDate) + $("#eh").val() + "0000";
			var url = "<c:url value="/chart/chart_popup.do"/>?type=" + type + "&sd=" + sd + "&ed=" + ed;
			window.open(url, '_blank','width=1024,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
		});
		
		$("#tab1").click(function() {
			$("#tab2").removeClass("on");
			$(this).addClass("on");
			$("#contents2").show();
			$("#contents1").hide();
			
			search();
		});
		
		$("#tab2").click(function() {
			$("#tab1").removeClass("on");
			$(this).addClass("on");
			$("#contents1").show();
			$("#contents2").hide();
			
			search();
		});		
	});
</script>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->

<div id="contents">
    <h2>예측모델</h2>
    <div class="tab_date">
        <a href="#" class="on" id="tab1">Solar Proton Event, Flare Prediction</a>
    	<a href="#" id="tab2">Dst Index, Kp Index, Solar Maximum</a>
    </div>     
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

    <!-- RESULT LIST TABLE -->
    <div id="contents1" style="display:none;">
		<div class="hour">
	    	<h6>Dst 지수</h6>
	        <div class="inbtn">
	            <input type="button" title="새창보기" class="btnimg view" alt="DST_INDEX_KHU"/>      
	        </div>
	        <div id="DST_INDEX_KHU_LABELS_DIV" class="label"/>
	    </div>
	    <div class="contents" style="height:300px;" id="DST_INDEX_KHU">
	    </div>
	    <!-- END Dst Index --> 
	    <div class="hour">
	    	<h6>Kp 지수</h6>
	        <div class="inbtn">
	            <input type="button" title="새창보기" class="btnimg view" alt="KP_INDEX_KHU"/>      
	        </div>
	        <div id="KP_INDEX_KHU_LABELS_DIV" class="label"/>
	    </div>
	    <div class="contents" style="height:300px;" id="KP_INDEX_KHU">
	    </div>
	    <!-- END Kp Index -->
	    <div class="hour">
	    	<h6>Solar Maximum</h6>
	        <div class="inbtn">
	            <input type="button" title="새창보기" class="btnimg view" />      
	        </div>
	    </div>
	    <div class="contents" id="SOLAR_MAXIMUM">
		    <div class="board_list"  style="text-align:center">
		    	<table>
		        	<thead>
		            	<tr>
		                    <th>Solar Maximum</th>
		                </tr>
		            </thead>
		            <tbody id="solar_maximum_tbody">
		            </tbody>        
		        </table>
			</div>  
	    </div>
	    <!-- END Solar Maximum -->
	    </div>
	    
    <div id="contents2">
	    <div class="hour">
	    	<h6>Solar Proton Event</h6>
	    </div>	    

	    <div class="board_list">
		    <table id="speTable">
		    	<thead>
		    		<tr>
				    	<th>SPOT</th>
				    	<th>POSITION</th>
				    	<th>CLASS</th>
				    	<th>Peak Time</th>
				    	<th>Prob.</th>
				    	<th>Pk Flux</th>
				    	<th>Arr. Time</th>
			    	</tr>
		    	</thead>
		    	<tbody>
		    	</tbody>
		    </table>
	    </div>
	    
	    <div class="hour">
	    	<h6>Flare Prediction</h6>
	    </div>
	    <div class="board_list" id="flareTables"></div>
    </div>
</div>
<!-- END CONTENTS -->

<jsp:include page="../footer.jsp" />

</body>
</html>
