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
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lightbox/css/lightbox.css"/>" />
<style>
.board_list table th {
	text-align:center;
	width:16.6666%;
}
</style>
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<script type="text/javascript" src="<c:url value="/resources/lightbox/js/lightbox.js"/>" ></script>
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
		
		$("#sd1").datepicker(datepickerOption);
		$("#sd2").datepicker(datepickerOption);

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
			$("#tab4").removeClass("on");
			$("#tab5").removeClass("on");
			$("#ionsphere_tab").show();
			$("#ionosphere_frame").hide();
			$("#pwv_frame").hide();
			$("#tec_world").hide();
			$("#tec_korea").hide();
		});
		
		$("#tab2").click(function() {
			$(this).addClass("on");
			$("#tab1").removeClass("on");
			$("#tab3").removeClass("on");
			$("#tab4").removeClass("on");
			$("#tab5").removeClass("on");
			$("#ionosphere_frame").show();
			$("#ionsphere_tab").hide();
			$("#pwv_frame").hide();
			$("#tec_world").hide();
			$("#tec_korea").hide();
		});
		
		$("#tab3").click(function() {
			$(this).addClass("on");
			$("#tab1").removeClass("on");
			$("#tab2").removeClass("on");
			$("#tab4").removeClass("on");
			$("#tab5").removeClass("on");
			$("#pwv_frame").show();
			$("#ionsphere_tab").hide();
			$("#ionosphere_frame").hide();
			$("#tec_world").hide();
			$("#tec_korea").hide();
		});
		
		$("#tab4").click(function() {
			$(this).addClass("on");
			$("#tab1").removeClass("on");
			$("#tab2").removeClass("on");
			$("#tab3").removeClass("on");
			$("#tab5").removeClass("on");
			$("#pwv_frame").hide();
			$("#ionsphere_tab").hide();
			$("#ionosphere_frame").hide();
			$("#tec_world").show();
			$("#tec_korea").hide();
		});
		
		$("#tab5").click(function() {
			$(this).addClass("on");
			$("#tab1").removeClass("on");
			$("#tab2").removeClass("on");
			$("#tab3").removeClass("on");
			$("#tab4").removeClass("on");
			$("#pwv_frame").hide();
			$("#ionsphere_tab").hide();
			$("#ionosphere_frame").hide();
			$("#tec_world").hide();
			$("#tec_korea").show();
		});
		
		$(document).on('click', 'img.imageclick', function() {
			var imagesrc = $(this).attr('src');
			imagesrc = imagesrc.replace(/&/g, "*");
			window.open("element_image_click.do?imagesrc="+imagesrc,"_blank",'width=900,height=900,toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, directories=no, status=no')
		});
		
		$("#search_btn1").on('click', function() {
			var startDate = $("#sd1").datepicker('getDate');
			var year = $.datepicker.formatDate("yy", startDate);
			var month = $.datepicker.formatDate("mm", startDate);
			var date = $.datepicker.formatDate("dd", startDate);
			
			$("#tec_world_tbody .imageclick").remove();
			
			tecImageLoad("WORLD", year, month, date, "00");
			tecImageLoad("WORLD", year, month, date, "02");
			tecImageLoad("WORLD", year, month, date, "04");
			tecImageLoad("WORLD", year, month, date, "06");
			tecImageLoad("WORLD", year, month, date, "08");
			tecImageLoad("WORLD", year, month, date, "10");
			tecImageLoad("WORLD", year, month, date, "12");
			tecImageLoad("WORLD", year, month, date, "14");
			tecImageLoad("WORLD", year, month, date, "16");
			tecImageLoad("WORLD", year, month, date, "18");
			tecImageLoad("WORLD", year, month, date, "20");
			tecImageLoad("WORLD", year, month, date, "22");
		});
		
		$("#search_btn2").on('click', function() {
			var startDate = $("#sd2").datepicker('getDate');
			var year = $.datepicker.formatDate("yy", startDate);
			var month = $.datepicker.formatDate("mm", startDate);
			var date = $.datepicker.formatDate("dd", startDate);
			var dataString = year+"/"+month+"/"+date;
			var value = "value="+dataString;
			
			$("#tec_korea_tbody .imageclick").remove();
			
			tecImageLoad("KOREA", year, month, date, "00");
			tecImageLoad("KOREA", year, month, date, "01");
			tecImageLoad("KOREA", year, month, date, "02");
			tecImageLoad("KOREA", year, month, date, "03");
			tecImageLoad("KOREA", year, month, date, "04");
			tecImageLoad("KOREA", year, month, date, "05");
			tecImageLoad("KOREA", year, month, date, "06");
			tecImageLoad("KOREA", year, month, date, "07");
			tecImageLoad("KOREA", year, month, date, "08");
			tecImageLoad("KOREA", year, month, date, "09");
			tecImageLoad("KOREA", year, month, date, "10");
			tecImageLoad("KOREA", year, month, date, "11");
			tecImageLoad("KOREA", year, month, date, "12");
			tecImageLoad("KOREA", year, month, date, "13");
			tecImageLoad("KOREA", year, month, date, "14");
			tecImageLoad("KOREA", year, month, date, "15");
			tecImageLoad("KOREA", year, month, date, "16");
			tecImageLoad("KOREA", year, month, date, "17");
			tecImageLoad("KOREA", year, month, date, "18");
			tecImageLoad("KOREA", year, month, date, "19");
			tecImageLoad("KOREA", year, month, date, "20");
			tecImageLoad("KOREA", year, month, date, "21");
			tecImageLoad("KOREA", year, month, date, "22");
			tecImageLoad("KOREA", year, month, date, "23");
		});
		
		search();
		
		getPwvImage();
		
		checkAirwayHide('DEL-ICN');
		checkAirwayHide('ICN-LHR');
		checkAirwayHide('IST-ICN');
		checkAirwayHide('JFK-ICN');
		checkAirwayHide('JFK-ICN-polar');
		checkAirwayHide('LAX-ICN');
		checkAirwayHide('MSC-ICN');
		checkAirwayHide('PAR-ICN');
		checkAirwayHide('SAT-ICN');
		
		var isCheck = false;
		$(document).on("change", ".airway_check", function() {
			var airVal = $(this).val();  
			if(airVal == "all") {
				isCheck = !isCheck;
				if(isCheck) {
					$(".airway_check").each(function() {
						$(this).prop("checked", true);
					});
					checkAirwayShow();
				} else {
					$(".airway_check").each(function() {
						$(this).prop("checked", false);
					});
					checkAirwayHide();
				}
			} else {
				checkAirwayShow();
				checkAirwayHide();
			}
		});
	});
	
	function checkAirwayShow(){
		$(".airway_check:checked").each(function() {
			var airway_val = $(this).val();
			$(".img_overlay_" + airway_val).show();
		});
	};
	function checkAirwayHide(){
		$(".airway_check:not(:checked)").each(function() {
			var airway_val = $(this).val();
			$(".img_overlay_" + airway_val).hide();
		});
	};
	
	
	function getPwvImage(){
		var img = "<a href='getPwvImageResource.do?fileNm=[imgNm]' class='example-image-link' data-lightbox='image_field'><img src='getPwvImageResource.do?fileNm=[imgNm]' /></a>";
		$.getJSON('getPwvImageList.do', function(data){
			if(!data) return;
			
			$(data).each(function(idx, element){
				var image = img;
				image = img.replace('[imgNm]', element);
				image = image.replace('[imgNm]', element);
				$('#pwv_frame').append(image);
			});
		});
	}
	
	function tecImageLoad(area, year, month, date, hour){
		var imageTag = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraTEC.do?area="+ area +"&type=TEC&year="+ year +"&month="+ month +"&date="+ date +"&hour="+ hour +"'/>'/>";
		$("#th_img_"+area+"_"+hour).append(imageTag)
	}


</script>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->
<div id="contents">
    <h2>전리권</h2>    
    <div class="tab_date">
        <a href="#" class="on" id="tab1">총 전자밀도(TEC)</a>
    	<a href="#" id="tab2">CTIPe 모델 결과</a>
		<a href="#" id="tab3">가강수량(PWV)</a>
		<a href="#" id="tab4">전지구 TEC Map</a>
		<a href="#" id="tab5">한반도 TEC Map</a>
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
    <div id="ionosphere_frame" style="display:none; width: 100%; padding: 10px 10px 0 10px;">
    	<table class="example-set" style="width: 95%;" >
    		<colgroup>
    			<col width="32%"/>
    			<col width="32%"/>
    			<col width="32%"/>
    		</colgroup>
    		<thead>
	    		<tr>
	    			<th style="background-color: #2768b0; color: #fff; height: 20px;">TEC</th>
	    			<th style="background-color: #2768b0; color: #fff;">NmF2</th>
	    			<th style="background-color: #2768b0; color: #fff;">HmF2</th>
	    		</tr>
    		</thead>
    		<tbody>
    			<tr>
	    			<td><a class="example-image-link" href="http://172.19.15.73:8080/ionosphere/image/TEC.png" data-lightbox="image_field" data-title="TEC"><img src="http://172.19.15.73:8080/ionosphere/image/TEC.png" style="width: 100%;"/></a></td>
	    			<td><a class="example-image-link" href="http://172.19.15.73:8080/ionosphere/image/NmF2.png" data-lightbox="image_field" data-title="NmF2"><img src="http://172.19.15.73:8080/ionosphere/image/NmF2.png" style="width: 100%;"/></a></td>
	    			<td><a class="example-image-link" href="http://172.19.15.73:8080/ionosphere/image/HmF2.png" data-lightbox="image_field" data-title="HmF2"><img src="http://172.19.15.73:8080/ionosphere/image/HmF2.png" style="width: 100%;"/></a></td>
    			</tr>
    		</tbody>
    	</table>
    </div>
    <div id="pwv_frame" class="example-set" style="display:none; width: 100%; padding: 10px 10px 0 10px;">
    
    </div>
    <!-- 
    <iframe id="ionosphere_frame1" src="http://172.19.15.73:8080/ionosphere" style="width:100%;display:none;height:700px" frameborder="0" scrolling="auto"></iframe>
	<iframe id="pwv_frame2" src="http://172.19.15.73:8080/nmsc/whyi/pwv/" style="width:100%;display:none;height:700px" frameborder="0" scrolling="auto"></iframe>
     -->
     
    <div id="tec_world" style="display: none">
    	<div class="search_wrap">
			<div class="search">
				<label class="type_tit sun">검색(UTC)</label>
				<custom:DateTimeRangeSelectyymmdd1 offset="1"/>

				<div class="searchbtns">
					<input id="search_btn1" type="button" title="검색" value="검색" class="btnsearch"/>
				</div>
				
				<label class="type_tit" style="margin-left:50px"> 항공로 보기 : </label>
				<div style="display:inline-block;">
					<input class="airway_check" id="check_all" style="margin-left: 15px" type="checkbox" value="all"/> 전체
					<input class="airway_check" style="margin-left: 15px" type="checkbox" value="DEL-ICN" /> DEL-ICN 
					<input class="airway_check" style="margin-left: 15px" type="checkbox" value="ICN-LHR" /> ICN-LHR 
					<input class="airway_check" style="margin-left: 15px" type="checkbox" value="IST-ICN" /> ICN-LHR 
					<input class="airway_check" style="margin-left: 15px" type="checkbox" value="JFK-ICN" /> JFK-ICN 
					<input class="airway_check" style="margin-left: 15px" type="checkbox" value="JFK-ICN-polar" /> JFK-ICN-polar
					<input class="airway_check" style="margin-left: 15px" type="checkbox" value="LAX-ICN" /> LAX-ICN
					<input class="airway_check" style="margin-left: 15px" type="checkbox" value="MSC-ICN" /> MSC-ICN
					<input class="airway_check" style="margin-left: 15px" type="checkbox" value="PAR-ICN" /> PAR-ICN
					<input class="airway_check" style="margin-left: 15px" type="checkbox" value="SAT-ICN" /> SAT-ICN
				</div>
			</div>
		</div>
    	<div id="tec_world_list">
			<table id="tec_world_table" border="1" width="100%">
				<thead>
					<tr>
						<th colspan="5">전지구 총전자밀도(TEC) 지도</th>
					</tr>
				</thead>
				<tbody id="tec_world_tbody">
					<tr>
						<th>시간</th>
						<th>00시</th>
						<th>02시</th>
						<th>04시</th>
						<th>06시</th>

					</tr>
					<tr>
						<th width="100px">총전자밀도</th>
						<th id="th_img_WORLD_00" style="padding: 3px; position:relative; width: 400px; height: 400px">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=WORLD&type=TEC&hour=00'/>" />
							<img class="img_overlay_DEL-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=DEL-ICN'/>" />
							<img class="img_overlay_ICN-LHR" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=ICN-LHR'/>" />
							<img class="img_overlay_IST-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=IST-ICN'/>" />
							<img class="img_overlay_JFK-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN'/>" />
							<img class="img_overlay_JFK-ICN-polar" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN-polar'/>" />
							<img class="img_overlay_LAX-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=LAX-ICN'/>" />
							<img class="img_overlay_MSC-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=MSC-ICN'/>" />
							<img class="img_overlay_PAR-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=PAR-ICN'/>" />
							<img class="img_overlay_SAT-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=SAT-ICN'/>" />
						</th>
						<th id="th_img_WORLD_02" style="padding: 3px; position:relative; width: 400px; height: 400px">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=WORLD&type=TEC&hour=02'/>"/>
							<img class="img_overlay_DEL-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=DEL-ICN'/>" />
							<img class="img_overlay_ICN-LHR" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=ICN-LHR'/>" />
							<img class="img_overlay_IST-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=IST-ICN'/>" />
							<img class="img_overlay_JFK-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN'/>" />
							<img class="img_overlay_JFK-ICN-polar" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN-polar'/>" />
							<img class="img_overlay_LAX-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=LAX-ICN'/>" />
							<img class="img_overlay_MSC-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=MSC-ICN'/>" />
							<img class="img_overlay_PAR-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=PAR-ICN'/>" />
							<img class="img_overlay_SAT-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=SAT-ICN'/>" />
						</th>
						<th id="th_img_WORLD_04" style="padding: 3px; position:relative; width: 400px; height: 400px">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=WORLD&type=TEC&hour=04'/>"/>
							<img class="img_overlay_DEL-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=DEL-ICN'/>" />
							<img class="img_overlay_ICN-LHR" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=ICN-LHR'/>" />
							<img class="img_overlay_IST-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=IST-ICN'/>" />
							<img class="img_overlay_JFK-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN'/>" />
							<img class="img_overlay_JFK-ICN-polar" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN-polar'/>" />
							<img class="img_overlay_LAX-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=LAX-ICN'/>" />
							<img class="img_overlay_MSC-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=MSC-ICN'/>" />
							<img class="img_overlay_PAR-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=PAR-ICN'/>" />
							<img class="img_overlay_SAT-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=SAT-ICN'/>" />
						</th>
						<th id="th_img_WORLD_06" style="padding: 3px; position:relative; width: 400px; height: 400px">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=WORLD&type=TEC&hour=06'/>"/>
							<img class="img_overlay_DEL-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=DEL-ICN'/>" />
							<img class="img_overlay_ICN-LHR" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=ICN-LHR'/>" />
							<img class="img_overlay_IST-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=IST-ICN'/>" />
							<img class="img_overlay_JFK-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN'/>" />
							<img class="img_overlay_JFK-ICN-polar" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN-polar'/>" />
							<img class="img_overlay_LAX-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=LAX-ICN'/>" />
							<img class="img_overlay_MSC-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=MSC-ICN'/>" />
							<img class="img_overlay_PAR-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=PAR-ICN'/>" />
							<img class="img_overlay_SAT-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=SAT-ICN'/>" />
						</th>
					</tr>
					<tr><th colspan="5"><p></p></th></tr>
					<tr>
						<th>시간</th>
						<th>08시</th>
						<th>10시</th>
						<th>12시</th>
						<th>14시</th>
					</tr>
					<tr>
						<th width="100px">총전자밀도</th>
						<th id="th_img_WORLD_08" style="padding: 3px; margin-left:12px; position:relative; width: 400px; height: 400px">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=WORLD&type=TEC&hour=08'/>"/>
							<img class="img_overlay_DEL-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=DEL-ICN'/>" />
							<img class="img_overlay_ICN-LHR" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=ICN-LHR'/>" />
							<img class="img_overlay_IST-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=IST-ICN'/>" />
							<img class="img_overlay_JFK-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN'/>" />
							<img class="img_overlay_JFK-ICN-polar" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN-polar'/>" />
							<img class="img_overlay_LAX-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=LAX-ICN'/>" />
							<img class="img_overlay_MSC-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=MSC-ICN'/>" />
							<img class="img_overlay_PAR-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=PAR-ICN'/>" />
							<img class="img_overlay_SAT-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=SAT-ICN'/>" />
						</th>
						<th id="th_img_WORLD_10" style="padding: 3px; margin-left:12px; position:relative; width: 400px; height: 400px">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=WORLD&type=TEC&hour=10'/>"/>
							<img class="img_overlay_DEL-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=DEL-ICN'/>" />
							<img class="img_overlay_ICN-LHR" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=ICN-LHR'/>" />
							<img class="img_overlay_IST-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=IST-ICN'/>" />
							<img class="img_overlay_JFK-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN'/>" />
							<img class="img_overlay_JFK-ICN-polar" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN-polar'/>" />
							<img class="img_overlay_LAX-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=LAX-ICN'/>" />
							<img class="img_overlay_MSC-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=MSC-ICN'/>" />
							<img class="img_overlay_PAR-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=PAR-ICN'/>" />
							<img class="img_overlay_SAT-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=SAT-ICN'/>" />
						</th>
						<th id="th_img_WORLD_12" style="padding: 3px; margin-left:12px; position:relative; width: 400px; height: 400px">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=WORLD&type=TEC&hour=12'/>"/>
							<img class="img_overlay_DEL-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=DEL-ICN'/>" />
							<img class="img_overlay_ICN-LHR" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=ICN-LHR'/>" />
							<img class="img_overlay_IST-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=IST-ICN'/>" />
							<img class="img_overlay_JFK-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN'/>" />
							<img class="img_overlay_JFK-ICN-polar" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN-polar'/>" />
							<img class="img_overlay_LAX-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=LAX-ICN'/>" />
							<img class="img_overlay_MSC-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=MSC-ICN'/>" />
							<img class="img_overlay_PAR-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=PAR-ICN'/>" />
							<img class="img_overlay_SAT-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=SAT-ICN'/>" />
						</th>
						<th id="th_img_WORLD_14" style="padding: 3px; margin-left:12px; position:relative; width: 400px; height: 400px">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=WORLD&type=TEC&hour=14'/>"/>
							<img class="img_overlay_DEL-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=DEL-ICN'/>" />
							<img class="img_overlay_ICN-LHR" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=ICN-LHR'/>" />
							<img class="img_overlay_IST-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=IST-ICN'/>" />
							<img class="img_overlay_JFK-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN'/>" />
							<img class="img_overlay_JFK-ICN-polar" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN-polar'/>" />
							<img class="img_overlay_LAX-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=LAX-ICN'/>" />
							<img class="img_overlay_MSC-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=MSC-ICN'/>" />
							<img class="img_overlay_PAR-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=PAR-ICN'/>" />
							<img class="img_overlay_SAT-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=SAT-ICN'/>" />
						</th>
					</tr>
					<tr><th colspan="5"><p></p></th></tr>
					<tr>
						<th>시간</th>
						<th>16시</th>
						<th>18시</th>
						<th>20시</th>
						<th>22시</th>
					</tr>
					<tr>
						<th width="100px">총전자밀도</th>
						<th id="th_img_WORLD_16" style="padding: 3px; margin-left:12px; position:relative; width: 400px; height: 400px">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=WORLD&type=TEC&hour=16'/>"/>
							<img class="img_overlay_DEL-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=DEL-ICN'/>" />
							<img class="img_overlay_ICN-LHR" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=ICN-LHR'/>" />
							<img class="img_overlay_IST-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=IST-ICN'/>" />
							<img class="img_overlay_JFK-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN'/>" />
							<img class="img_overlay_JFK-ICN-polar" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN-polar'/>" />
							<img class="img_overlay_LAX-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=LAX-ICN'/>" />
							<img class="img_overlay_MSC-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=MSC-ICN'/>" />
							<img class="img_overlay_PAR-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=PAR-ICN'/>" />
							<img class="img_overlay_SAT-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=SAT-ICN'/>" />
						</th>
						<th id="th_img_WORLD_18" style="padding: 3px; margin-left:12px; position:relative; width: 400px; height: 400px">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=WORLD&type=TEC&hour=18'/>"/>
							<img class="img_overlay_DEL-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=DEL-ICN'/>" />
							<img class="img_overlay_ICN-LHR" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=ICN-LHR'/>" />
							<img class="img_overlay_IST-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=IST-ICN'/>" />
							<img class="img_overlay_JFK-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN'/>" />
							<img class="img_overlay_JFK-ICN-polar" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN-polar'/>" />
							<img class="img_overlay_LAX-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=LAX-ICN'/>" />
							<img class="img_overlay_MSC-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=MSC-ICN'/>" />
							<img class="img_overlay_PAR-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=PAR-ICN'/>" />
							<img class="img_overlay_SAT-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=SAT-ICN'/>" />
						</th>
						<th id="th_img_WORLD_20" style="padding: 3px; margin-left:12px; position:relative; width: 400px; height: 400px">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=WORLD&type=TEC&hour=20'/>"/>
							<img class="img_overlay_DEL-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=DEL-ICN'/>" />
							<img class="img_overlay_ICN-LHR" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=ICN-LHR'/>" />
							<img class="img_overlay_IST-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=IST-ICN'/>" />
							<img class="img_overlay_JFK-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN'/>" />
							<img class="img_overlay_JFK-ICN-polar" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN-polar'/>" />
							<img class="img_overlay_LAX-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=LAX-ICN'/>" />
							<img class="img_overlay_MSC-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=MSC-ICN'/>" />
							<img class="img_overlay_PAR-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=PAR-ICN'/>" />
							<img class="img_overlay_SAT-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=SAT-ICN'/>" />
						</th>
						<th id="th_img_WORLD_22" style="padding: 3px; margin-left:12px; position:relative; width: 400px; height: 400px">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=WORLD&type=TEC&hour=22'/>"/>
							<img class="img_overlay_DEL-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=DEL-ICN'/>" />
							<img class="img_overlay_ICN-LHR" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=ICN-LHR'/>" />
							<img class="img_overlay_IST-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=IST-ICN'/>" />
							<img class="img_overlay_JFK-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN'/>" />
							<img class="img_overlay_JFK-ICN-polar" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=JFK-ICN-polar'/>" />
							<img class="img_overlay_LAX-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=LAX-ICN'/>" />
							<img class="img_overlay_MSC-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=MSC-ICN'/>" />
							<img class="img_overlay_PAR-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=PAR-ICN'/>" />
							<img class="img_overlay_SAT-ICN" style="padding: 3px; top: 0px; left: 8px; position:absolute;" width="400px" src="<c:url value='/elementSWAA/intraTECSkyway.do?skyway=SAT-ICN'/>" />
						</th>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
		
    <div id="tec_korea" style="display: none">
    	<div class="search_wrap">
			<div class="search">
				<label class="type_tit sun">검색(UTC)</label>
				<custom:DateTimeRangeSelectyymmdd2 offset="2"/>

				<div class="searchbtns">
					<input id="search_btn2" type="button" title="검색" value="검색" class="btnsearch"/>
				</div>
			</div>
		</div>	
		<div id="tec_korea_list">
			<table id="tec_korea_table" border="1" width="100%">
				<thead>
					<tr>
						<th colspan="5">한반도 총전자밀도(TEC) 지도</th>
					</tr>
				</thead>
				<tbody id="tec_korea_tbody">
					<tr>
						<th>시간</th>
						<th>00시</th>
						<th>01시</th>
						<th>02시</th>
						<th>03시</th>

					</tr>
					<tr>
						<th width="100px">총전자밀도</th>
						<th id="th_img_KOREA_00">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=00'/>"/>
						</th>
						<th id="th_img_KOREA_01">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=01'/>"/>
						</th>
						<th id="th_img_KOREA_02">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=02'/>"/>
						</th>
						<th id="th_img_KOREA_03">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=03'/>"/>
						</th>
					</tr>
					<tr><th colspan="5"><p></p></th></tr>
					<tr>
						<th>시간</th>
						<th>04시</th>
						<th>05시</th>
						<th>06시</th>
						<th>07시</th>
					</tr>
					<tr>
						<th width="100px">총전자밀도</th>
						<th id="th_img_KOREA_04">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=04'/>"/>
						</th>
						<th id="th_img_KOREA_05">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=05'/>"/>
						</th>
						<th id="th_img_KOREA_06">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=06'/>"/>
						</th>
						<th id="th_img_KOREA_07">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=07'/>"/>
						</th>
					</tr>
					<tr><th colspan="5"><p></p></th></tr>
					<tr>
						<th>시간</th>
						<th>08시</th>
						<th>09시</th>
						<th>10시</th>
						<th>11시</th>
					</tr>
					<tr>
						<th width="100px">총전자밀도</th>
						<th id="th_img_KOREA_08">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=08'/>"/>
						</th>
						<th id="th_img_KOREA_09">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=09'/>"/>
						</th>
						<th id="th_img_KOREA_10">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=10'/>"/>
						</th>
						<th id="th_img_KOREA_11">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=11'/>"/>
						</th>
					</tr>
					<tr><th colspan="5"><p></p></th></tr>
					<tr>
						<th>시간</th>
						<th>12시</th>
						<th>13시</th>
						<th>14시</th>
						<th>15시</th>
					</tr>
					<tr>
						<th width="100px">총전자밀도</th>
						<th id="th_img_KOREA_12">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=12'/>"/>
						</th>
						<th id="th_img_KOREA_13">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=13'/>"/>
						</th>
						<th id="th_img_KOREA_14">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=14'/>"/>
						</th>
						<th id="th_img_KOREA_15">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=15'/>"/>
						</th>
					</tr>
					<tr><th colspan="5"><p></p></th></tr>
					<tr>
						<th>시간</th>
						<th>16시</th>
						<th>17시</th>
						<th>18시</th>
						<th>19시</th>
					</tr>
					<tr>
						<th width="100px">총전자밀도</th>
						<th id="th_img_KOREA_16">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=16'/>"/>
						</th>
						<th id="th_img_KOREA_17">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=17'/>"/>
						</th>
						<th id="th_img_KOREA_18">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=18'/>"/>
						</th>
						<th id="th_img_KOREA_19">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=19'/>"/>
						</th>
					</tr>
					<tr><th colspan="5"><p></p></th></tr>
					<tr>
						<th>시간</th>
						<th>20시</th>
						<th>21시</th>
						<th>22시</th>
						<th>23시</th>
					</tr>
					<tr>
						<th width="100px">총전자밀도</th>
						<th id="th_img_KOREA_20">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=20'/>"/>
						</th>
						<th id="th_img_KOREA_21">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=21'/>"/>
						</th>
						<th id="th_img_KOREA_22">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=22'/>"/>
						</th>
						<th id="th_img_KOREA_23">
							<img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraTEC.do?area=KOREA&type=TEC&hour=23'/>"/>
						</th>
					</tr>
				</tbody>
			</table>
		</div>
    </div>
     
     
     
     
     
</div>
<!-- END CONTENTS -->

<jsp:include page="../footer.jsp" />
</body>
</html>