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
<style>
.board_list table th {
	text-align:center;
	width:16.6666%;
}
</style>
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<script type="text/javascript">
	function search() {
		var startDate = $("#sd").datepicker('getDate');
		var endDate = $("#ed").datepicker('getDate');

		var sd = $.datepicker.formatDate("yymmdd", startDate) + "000000";
		var ed = $.datepicker.formatDate("yymmdd", endDate) + "000000";
		
		$.getJSON("<c:url value="/chart/chartData.do"/>", {
			type : 'TEC_IMAGE',
			sd : sd,
			ed : ed
		}).success(function(data) {
			var html = "";
			if(data.length > 0) {
				var dataList = {};
				$.each(data, function(key, val) {
					var yyyymmdd = val[0].substring(0, 8);
					if(dataList[yyyymmdd] == undefined) {
						dataList[yyyymmdd] = {};
						for(var i=0; i<24; ++i) {
							dataList[yyyymmdd][i] = '';
						}
					}
					var hour = parseInt(val[0].substring(8, 10));
					dataList[yyyymmdd][hour] = '<img tm="'+val[0]+'"src="view_tec_image.do?f=' + val[1] + '" style="width:100%;" class="imgbtn"/>'; 
				});
				$.each(dataList, function(key, val) {
					html += '<div class="board_list">'
			    	+ '<table><thead><tr><th colspan="6">' + key.substring(0,4) + ". " + key.substring(4,6) + ". " + key.substring(6) + '</th></tr></thead><tbody>'
	            	+ '<tr><th>00시</td><th>01시</th><th>02시</th><th>03시</th><th>04시</th><th>05시</th></tr>'
		            + '<tr><td>'+val[0]+'</td><td>'+val[1]+'</td><td>'+val[2]+'</td><td>'+val[3]+'</td><td>'+val[4]+'</td><td>'+val[5]+'</td></tr>'
		            
	            	+ '<tr><th>06시</td><th>07시</th><th>08시</th><th>09시</th><th>10시</th><th>11시</th></tr>'
		            + '<tr><td>'+val[6]+'</td><td>'+val[7]+'</td><td>'+val[8]+'</td><td>'+val[9]+'</td><td>'+val[10]+'</td><td>'+val[11]+'</td></tr>'
		            
	            	+ '<tr><th>12시</td><th>13시</th><th>14시</th><th>15시</th><th>16시</th><th>17시</th></tr>'
		            + '<tr><td>'+val[12]+'</td><td>'+val[13]+'</td><td>'+val[14]+'</td><td>'+val[15]+'</td><td>'+val[16]+'</td><td>'+val[17]+'</td></tr>'
		            
	            	+ '<tr><th>18시</td><th>19시</th><th>20시</th><th>21시</th><th>22시</th><th>23시</th></tr>'
		            + '<tr><td>'+val[18]+'</td><td>'+val[19]+'</td><td>'+val[20]+'</td><td>'+val[21]+'</td><td>'+val[22]+'</td><td>'+val[23]+'</td></tr>'
			    	+ '</tbody></table></div>';					
				});
			} else {
				html += '<div class="board_list">'
			    	+ '<table><thead><tr><th>검색 결과가 없습니다.</th></tr></thead><tbody>'
			    	+ '</tbody></table></div>';
			}
			$("#tec_list").empty().append(html);
		}).error(function(request, status, error) {
	        alert("Error!");
		});
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
				newDate.setDate($("#ed").datepicker("getDate").getDate() - day + 1);
				$("#sd").datepicker("setDate", newDate);
				$("#sh").val($("#eh").val());
			}
			search();
			return false;
		});
		
		$("#tec_list").on('click', 'img', function() {
			var url = "tec_image_popup.do?tm=" + $(this).attr("tm");
			window.open(url, '_blank','width=600,height=790,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
		});
		
		$("#tab1").click(function() {
			$(this).addClass("on");
			$("#tab2").removeClass("on");
			$("#tab3").removeClass("on");
			$("#ionsphere_tab").show();
			$("#ionosphere_frame").hide();
			$("#pwv_frame").hide();
		});
		
		$("#tab2").click(function() {
			$(this).addClass("on");
			$("#tab1").removeClass("on");
			$("#tab3").removeClass("on");
			$("#ionosphere_frame").show();
			$("#ionsphere_tab").hide();
			$("#pwv_frame").hide();
		});
		
		$("#tab3").click(function() {
			$(this).addClass("on");
			$("#tab1").removeClass("on");
			$("#tab2").removeClass("on");
			$("#pwv_frame").show();
			$("#ionsphere_tab").hide();
			$("#ionosphere_frame").hide();
		});
		
		search();
	});
</script>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->

<div id="contents">
    <h2>전리권</h2>    
    <div class="tab_date">
        <a href="#" class="on" id="tab1">총 전자밀도(TEC)</a>
    	<a href="#" id="tab2">전지구 총 전자밀도(Global Ionosphere TEC)</a>
		<a href="#" id="tab3">PWV</a>
    </div>
    <div id="ionsphere_tab">
    <!-- SEARCH -->
    <div class="search_wrap">
        <div class="search">
            <label class="type_tit sun">검색(UTC)</label>
            <custom:DateRangeSelector offset="0"/>                  
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
    
    <div id="tec_list"></div>
    </div>
    <iframe id="ionosphere_frame" src="http://172.19.15.73:8080/ionosphere" style="width:100%;display:none;height:700px" frameborder="0" scrolling="auto"></iframe>
	<iframe id="pwv_frame" src="http://172.19.15.73:8080/nmsc/whyi/pwv/" style="width:100%;display:none;height:700px" frameborder="0" scrolling="auto"></iframe>
</div>
<!-- END CONTENTS -->

<jsp:include page="../footer.jsp" />

</body>
</html>