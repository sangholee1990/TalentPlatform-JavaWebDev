<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 우주기상인트라넷</title>
<link rel="stylesheet" type="text/css" href="../css/defaultSWAA.css" />
<link rel="stylesheet" type="text/css" href="../css/jquery.bxslider.css"  />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lightbox/css/lightbox.css"/>" />
<style>
.board_list table th {
	text-align: center;
	width: 16.6666%;
} 
</style>
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<script type="text/javascript" src="<c:url value="/resources/lightbox/js/lightbox.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.paging.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.bxslider.min.js"/>"></script>
<script type="text/javascript">

	$(function() {
		var datepickerOption = {
			changeYear : true,
			showOn : "button",
			buttonImage : '<c:url value="/images/btn_calendar.png"/>',
			buttonImageOnly : true
		};
		$("#sd1").datepicker(datepickerOption);
		$("#sd2").datepicker(datepickerOption);
		$("#sd5").datepicker(datepickerOption);
		
		$("#sd").datepicker(datepickerOption);
		$("#ed").datepicker(datepickerOption);

		$("#sd3").datepicker(datepickerOption);
		$("#ed3").datepicker(datepickerOption);
		
		$("#sd4").datepicker(datepickerOption);
		$("#ed4").datepicker(datepickerOption);

		$("#tab1").click(function() {
			$(this).addClass("on");
			$("#tab2").removeClass("on");
			$("#tab3").removeClass("on");
			$("#tab4").removeClass("on");
			$("#tab5").removeClass("on");
			$("#hcp_world").show();
			$("#hcp_airway").hide();
			$("#hcp_korea").hide();
			$("#ovation").hide();
			$("#drap").hide();
		});
		
		$("#tab2").click(function() {
			$(this).addClass("on");
			$("#tab1").removeClass("on");
			$("#tab3").removeClass("on");
			$("#tab4").removeClass("on");
			$("#tab5").removeClass("on");
			$("#hcp_world").hide();
			$("#hcp_airway").show();
			$("#hcp_korea").hide();
			$("#ovation").hide();
			$("#drap").hide();
		});
		
		$("#tab3").click(function() {
			$(this).addClass("on");
			$("#tab1").removeClass("on");
			$("#tab2").removeClass("on");
			$("#tab4").removeClass("on");
			$("#tab5").removeClass("on");
			$("#hcp_world").hide();
			$("#hcp_airway").hide();
			$("#hcp_korea").show();
			$("#ovation").hide();
			$("#drap").hide();
		});

		$("#tab4").click(function() {
			$(this).addClass("on");
			$("#tab1").removeClass("on");
			$("#tab2").removeClass("on");
			$("#tab3").removeClass("on");
			$("#tab5").removeClass("on");
			$("#hcp_world").hide();
			$("#hcp_airway").hide();
			$("#hcp_korea").hide();
			$("#ovation").show();
			$("#drap").hide();
			searchOvation("1시간");
		});

		$("#tab5").click(function() {
			$(this).addClass("on");
			$("#tab1").removeClass("on");
			$("#tab2").removeClass("on");
			$("#tab3").removeClass("on");
			$("#tab4").removeClass("on");
			$("#hcp_world").hide();
			$("#hcp_airway").hide();
			$("#hcp_korea").hide();
			$("#ovation").hide();
			$("#drap").show();
			searchDrap("1시간");
		});
		
		
		
		$("#search_btn1").on('click', function() {
			var startDate = $("#sd1").datepicker('getDate');
			var year = $.datepicker.formatDate("yy", startDate);
			var month = $.datepicker.formatDate("mm", startDate);
			var date = $.datepicker.formatDate("dd", startDate);
			
			//alert(year+"/"+month+"/"+date);
			
			$("#hcp_world_table tbody").empty();
			
			var tbody = "<tr><th>고도</th><th>0km</th><th>5km</th><th>10km</th><th>15km</th></tr>"
			tbody += "<tr><th>피폭량</th>"
			tbody += "<th><a href='#'><img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_WORLD&year="+year+"&month="+month+"&date="+date+"&alt=0'/>'/></a></th>"
			tbody += "<th><a href='#'><img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_WORLD&year="+year+"&month="+month+"&date="+date+"&alt=50'/>'/></a></th>"
			tbody += "<th><a href='#'><img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_WORLD&year="+year+"&month="+month+"&date="+date+"&alt=75'/>'/></a></th>"
			tbody += "<th><a href='#'><img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_WORLD&year="+year+"&month="+month+"&date="+date+"&alt=100'/>'/></a></th>"
			tbody += "</tr>"
				
			$("#hcp_world_table tbody").append(tbody);
		});
		
		$("#search_btn2").on('click', function() {
			var startDate = $("#sd2").datepicker('getDate');
			var year = $.datepicker.formatDate("yy", startDate);
			var month = $.datepicker.formatDate("mm", startDate);
			var date = $.datepicker.formatDate("dd", startDate);
			var dataString = year+"/"+month+"/"+date;
			var value = "value="+dataString;
			
			$("#hcp_airway .imageclick").remove();
			$("#hcp_airway .th_flighttime").empty();
			$("#hcp_airway .div_grade").removeClass("sign2");
			$("#hcp_airway .div_grade").removeClass("sign3");
			$("#hcp_airway .div_grade").removeClass("sign4");
			$("#hcp_airway .th_ave_dose").empty();
			$("#hcp_airway .th_total_dose").empty();
			$("#hcp_airway .grade_text").empty();
			
			var route1 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=LAX-ICN&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>";
			$("#hcp_airway_tbody_1 .th_img").append(route1);
			var route2 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=JFK-ICN&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_airway_tbody_2 .th_img").append(route2);
			var route3 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=JFK-ICN-polar&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_airway_tbody_3 .th_img").append(route3);
			var route4 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=DEL-ICN&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_airway_tbody_4 .th_img").append(route4);
			var route5 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=MSC-ICN&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_airway_tbody_5 .th_img").append(route5);
			var route6 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=SAT-ICN&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_airway_tbody_6 .th_img").append(route6);
			var route7 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=IST-ICN&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_airway_tbody_7 .th_img").append(route7);
			var route8 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=ICN-LHR&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_airway_tbody_8 .th_img").append(route8);
			var route9 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=PAR-ICN&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_airway_tbody_9 .th_img").append(route9);
			
			$.ajax({
				url : "intraSunspotAirway.do",
				data : value,
				dataType : "json"
			}).success(
					function(data) {
						var airway = data.airway1;
						airwayData(airway, 1);
						airway = data.airway2;
						airwayData(airway, 2);
						airway = data.airway3;
						airwayData(airway, 3);
						airway = data.airway4;
						airwayData(airway, 4);
						airway = data.airway5;
						airwayData(airway, 5);
						airway = data.airway6;
						airwayData(airway, 6);
						airway = data.airway7;
						airwayData(airway, 7);
						airway = data.airway8;
						airwayData(airway, 8);
						airway = data.airway9;
						airwayData(airway, 9);
					}
			);		
		});
		
		$("#search_btn3").on('click', function() {
			var startDate = $("#sd5").datepicker('getDate');
			var year = $.datepicker.formatDate("yy", startDate);
			var month = $.datepicker.formatDate("mm", startDate);
			var date = $.datepicker.formatDate("dd", startDate);
			var dataString = year+"/"+month+"/"+date;
			var value = "value="+dataString;
			
			$("#hcp_korea .imageclick").remove();
			$("#hcp_korea .th_flighttime").empty();
			$("#hcp_korea .div_grade").removeClass("sign2");
			$("#hcp_korea .div_grade").removeClass("sign3");
			$("#hcp_korea .div_grade").removeClass("sign4");
			$("#hcp_korea .th_ave_dose").empty();
			$("#hcp_korea .th_total_dose").empty();
			$("#hcp_korea .grade_text").empty();
			
			var route1 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=LAX-ICN&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>";
			$("#hcp_korea_tbody_1 .th_img").append(route1);
			var route2 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=JFK-ICN&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_korea_tbody_2 .th_img").append(route2);
			var route3 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=JFK-ICN-polar&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_korea_tbody_3 .th_img").append(route3);
			var route4 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=DEL-ICN&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_korea_tbody_4 .th_img").append(route4);
			var route5 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=MSC-ICN&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_korea_tbody_5 .th_img").append(route5);
			var route6 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=SAT-ICN&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_korea_tbody_6 .th_img").append(route6);
			var route7 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=IST-ICN&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_korea_tbody_7 .th_img").append(route7);
			var route8 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=ICN-LHR&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_korea_tbody_8 .th_img").append(route8);
			var route9 = "<img class='imageclick' style='padding: 3px;' width='400px' src='<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=PAR-ICN&year=" + year +"&month="+ month + "&date=" + date + "'/>'/>"; 
			$("#hcp_korea_tbody_9 .th_img").append(route9);
			
			$.ajax({
				url : "intraSunspotAirway.do",
				data : value,
				dataType : "json"
			}).success(
					function(data) {
						var airway = data.airway1;
						koreaData(airway, 1);
						airway = data.airway2;
						koreaData(airway, 2);
						airway = data.airway3;
						koreaData(airway, 3);
						airway = data.airway4;
						koreaData(airway, 4);
						airway = data.airway5;
						koreaData(airway, 5);
						airway = data.airway6;
						koreaData(airway, 6);
						airway = data.airway7;
						koreaData(airway, 7);
						airway = data.airway8;
						koreaData(airway, 8);
						airway = data.airway9;
						koreaData(airway, 9);
					}
			);		
		});
		
		$(".mg .btn").click(function(){ 
			searchOvation($(this).val()); 
		})
		
		$(".mg1 .btn").click(function(){ 
			searchDrap($(this).val()); 
		})

		$(document).on('click', '.imageclick', function() {
			var imagesrc = $(this).attr('src');
			imagesrc = imagesrc.replace(/&/g, "*");
			window.open("element_image_click.do?imagesrc="+imagesrc,"_blank",'width=900,height=900,toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, directories=no, status=no')
		});
		
		$("#searchOvation").click(function(ev) {
			var hour = parseInt($(this).val());
			if(!isNaN(hour)) {
				var newDate = new Date();
				var startHour = parseInt($("#eh").val(), 10) - hour + 1;
				if(startHour >= 0) {
					newDate.setDate($("#ed").datepicker("getDate").getDate());
					$("#sd").datepicker("setDate", newDate);
					$("#sh").val(pad(startHour));
				} else {
					newDate.setDate($("#ed").datepicker("getDate").getDate() - 1);
					$("#sd").datepicker("setDate", newDate);
					$("#sh").val(pad(24 + startHour));
				}
			}
			searchOvation(0);
			return false;
		});
		
		$("#searchDrap").click(function(ev) {
			var hour = parseInt($(this).val());
			if(!isNaN(hour)) {
				var newDate = new Date();
				var startHour = parseInt($("#eh").val(), 10) - hour + 1;
				if(startHour >= 0) {
					newDate.setDate($("#ed").datepicker("getDate").getDate());
					$("#sd").datepicker("setDate", newDate);
					$("#sh").val(pad(startHour));
				} else {
					newDate.setDate($("#ed").datepicker("getDate").getDate() - 1);
					$("#sd").datepicker("setDate", newDate);
					$("#sh").val(pad(24 + startHour));
				}
			}
			searchDrap(0);
			return false;
		});
		
		var bxSliderParam = {
				infiniteLoop: false,
				pager: true,
				controls: false,
				maxSlides: 100,
				slideMargin: 2,
				slideWidth:400
		};
		bxslider_OVATION = $("#bxslider_OVATION").bxSlider(bxSliderParam);
		bxslider_DRAP = $("#bxslider_DRAP").bxSlider(bxSliderParam);
	});
	
	function airwayData(data, num) {
		var text = new Array();
		text = data.split(" ");
		
		var hr = (text[0] / 60).toFixed(2);
		var ave = (text[1] / 1000).toFixed(4);
		var total = (text[2] / 1000).toFixed(4);
		
		$("#hcp_airway_tbody_"+num+" .th_flighttime").text(hr);
		$("#hcp_airway_tbody_"+num+" .th_ave_dose").text(ave);
		$("#hcp_airway_tbody_"+num+" .th_total_dose").text(total);
		
		
							
		var cabinValue = ave * 800;
		var grade_text = "";
		if (cabinValue <= 6.0) {
			$("#hcp_airway_tbody_"+num+" .div_grade").addClass("sign4");
			grade_text = "일반";
		} else if (cabinValue <= 12.0) {
			$("#hcp_airway_tbody_"+num+" .div_grade").addClass("sign2");
			grade_text = "주의보";
		} else {
			$("#hcp_airway_tbody_"+num+" .div_grade").addClass("sign3");
			grade_text = "경보";
		}
		$("#hcp_airway_tbody_"+num+" .grade_text").text(grade_text);
	}
	
	function koreaData(data, num) {
		var text = new Array();
		text = data.split(" ");
		
		var hr = (text[0] / 60).toFixed(2);
		var ave = (text[1] / 1000).toFixed(4);
		var total = (text[2] / 1000).toFixed(4);
		
		$("#hcp_korea_tbody_"+num+" .th_flighttime").text(hr);
		$("#hcp_korea_tbody_"+num+" .th_ave_dose").text(ave);
		$("#hcp_korea_tbody_"+num+" .th_total_dose").text(total);
		
		
							
		var cabinValue = ave * 800;
		var grade_text = "";
		if (cabinValue <= 6.0) {
			$("#hcp_korea_tbody_"+num+" .div_grade").addClass("sign4");
			grade_text = "일반";
		} else if (cabinValue <= 12.0) {
			$("#hcp_korea_tbody_"+num+" .div_grade").addClass("sign2");
			grade_text = "주의보";
		} else {
			$("#hcp_korea_tbody_"+num+" .div_grade").addClass("sign3");
			grade_text = "경보";
		}
		$("#hcp_korea_tbody_"+num+" .grade_text").text(grade_text);
	}
	 
	function searchOvation(time) {
		var startDate = $("#sd3").val();
		var sd = startDate+"-" + $("#shour").val()+"-" + $("#smin").val(); 
		if(time == 0){ 
			var endDate =  $("#ed3").val();			
			var ed = endDate+"-" + $("#ehour").val()+"-" + $("#emin").val();  
		}else if(time=="1시간"){
			var endDate = $("#sd3").val();
			var num = (Number($("#shour").val())+1)+"";
			if(num.length<2){
				num = "0"+num;
			}  
			var ed = endDate+"-" +num +"-" + $("#smin").val(); 
		}else if(time=="3시간"){
			var endDate = $("#sd3").val();
			var num = (Number($("#shour").val())+3)+"";
			if(num.length<2){
				num = "0"+num;
			}  
			var ed = endDate+"-" +num +"-" + $("#smin").val(); 
		}else if(time=="6시간"){
			var endDate = $("#sd3").val();
			var num = (Number($("#shour").val())+6)+"";
			if(num.length<2){
				num = "0"+num;
			} 
			var ed = endDate+"-" +num +"-" + $("#smin").val(); 
		}else if(time=="12시간"){
			var endDate = $("#sd3").val();
			var num = (Number($("#shour").val())+12)+"";
			if(num.length<2){
				num = "0"+num;
			}  
			var ed = endDate+"-" +num +"-" + $("#smin").val();
		}else if(time=="24시간"){
			var endDatep = $("#sd3").val();
			var endspl = new Array();
			endspl = endDatep.split("-");
			endspl[2] =Number(endspl[2])+1;
			if(endspl[2].length<2){
				endspl[2] = "0"+endspl[2];
			} 
			endDate = endspl[0]+"-"+endspl[1]+"-"+endspl[2];
			var ed = endDate+"-" + $("#ehour").val()+"-" + $("#emin").val(); 
		}  
		var dataString = "sd=" + sd + "&ed=" + ed +"&type=ovation"; 
		$.ajax({
			url: "searchNorthRoute.do",
			data: dataString,
			dataType: "json"
			}).success(function(data) {
				var bxslider_OVATION_html = '';
				$.each(data, function(key, val) {	 
					var valarr = new Array();
					valarr=val.split("/");
					var fileNm = valarr[valarr.length-1]; 
					var html = '<li><br><a href="#"><img src="view_imageNorthRoute.do?f=' + val + '" class="imageclick on" height="400" /></a><br>'+fileNm+'</li>';
					bxslider_OVATION_html += html;
					val.indexO
				});
				$('#bxslider_OVATION').empty().append(bxslider_OVATION_html); 
				bxslider_OVATION.reloadSlider();				 
				
			})
	}
	
	
	function searchDrap(time) {
		var startDate = $("#sd4").val();
		var sd = startDate+"-" + $("#shour2").val()+"-" + $("#smin2").val(); 
		if(time == 0){ 
			var endDate =  $("#ed4").val();			
			var ed = endDate+"-" + $("#ehour2").val()+"-" + $("#emin2").val();  
		}else if(time=="1시간"){
			var endDate = $("#sd4").val();
			var num = (Number($("#shour2").val())+1)+"";
			if(num.length<2){
				num = "0"+num;
			}  
			var ed = endDate+"-" +num +"-" + $("#smin2").val(); 
		}else if(time=="3시간"){
			var endDate = $("#sd4").val();
			var num = (Number($("#shour2").val())+3)+"";
			if(num.length<2){
				num = "0"+num;
			}  
			var ed = endDate+"-" +num +"-" + $("#smin2").val(); 
		}else if(time=="6시간"){
			var endDate = $("#sd4").val();
			var num = (Number($("#shour2").val())+6)+"";
			if(num.length<2){
				num = "0"+num;
			}  
			var ed = endDate+"-" +num +"-" + $("#smin2").val(); 
		}else if(time=="12시간"){
			var endDate = $("#sd4").val();
			var num = (Number($("#shour2").val())+12)+"";
			if(num.length<2){
				num = "0"+num;
			}  
			var ed = endDate+"-" +num +"-" + $("#smin2").val();
		}else if(time=="24시간"){
			var endDatep = $("#sd4").val();
			var endspl = new Array();
			endspl = endDatep.split("-");
			endspl[2] =Number(endspl[2])+1;
			if(endspl[2].length<2){
				endspl[2] = "0"+endspl[2];
			} 
			endDate = endspl[0]+"-"+endspl[1]+"-"+endspl[2];
			var ed = endDate+"-" + $("#ehour2").val()+"-" + $("#emin2").val(); 
		}  
		var dataString = "sd=" + sd + "&ed=" + ed+"&type=drap";	 
		$.ajax({
			url: "searchNorthRoute.do",
			data: dataString,
			dataType: "json"
			}).success(function(data) {
				var bxslider_DRAP_html = '';
				$.each(data, function(key, val) {
					var valarr = new Array();
					valarr=val.split("/");
					var fileNm = valarr[valarr.length-1];
					var html = '<li><br><a href="#"><img src="view_imageNorthRoute.do?f=' + val + '" class="imgbtn"   height="400" /></a><br>'+fileNm+'</li>';
					bxslider_DRAP_html += html;	
				});
				$('#bxslider_DRAP').empty().append(bxslider_DRAP_html); 
				bxslider_DRAP.reloadSlider();
			})
	}
	
	
</script>
</head>

<body>
	<jsp:include page="../header.jsp" />
	<!-- END HEADER -->
	<div id="contents">
		<h2>극항로 항공기상</h2>
		<div class="tab_date">
			<a href="#" class="on" id="tab1">전지구 방사선 순간 피폭량</a>
			<a href="#"	id="tab2">항공로 방사선 순간 피폭량</a>
			<a href="#" id="tab3">한반도 방사선 순간 피폭량</a>
			<a href="#" id="tab4">극관크기(Ovation-Prime Model)</a>
			<a href="#" id="tab5">D층 전파흡수</a>
		</div>
		
		<!-- tab1 end -->
		<div id="hcp_world">
			<!-- SEARCH -->
			<div class="search_wrap">
				<div class="search">
					<label class="type_tit sun">검색(UTC)</label>
					<custom:DateTimeRangeSelectyymmdd1 offset="1"/>

					<div class="searchbtns">
						<input id="search_btn1" type="button" title="검색" value="검색" class="btnsearch"/>
					</div>
				</div>
			</div>

			<div id="hcp_world_list">
				<table id="hcp_world_table" border="1" width="100%">
					<thead>
						<tr>
							<th colspan="5">전지구 방사선 순간 피폭량</th>
						</tr>
					</thead>
					<tbody id="hcp_world_tbody">
						<tr>
							<th>고도</th>
							<th>0km</th>
							<th>5km</th>
							<th>10km</th>
							<th>15km</th>
						</tr>
						<tr>
							<th>피폭량</th>
							<th>
								<a href="#"><img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_WORLD&alt=0'/>"/></a>
							</th>
							<th>
								<a href="#"><img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_WORLD&alt=50'/>"/></a>
							</th>
							<th>
								<a href="#"><img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_WORLD&alt=75'/>"/></a>
							</th>
							<th>
								<a href="#"><img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_WORLD&alt=100'/>"/></a>
							</th>
						</tr>
					</tbody>
				</table>
			</div>			
		</div>
		<!-- tab1 end -->
		
		<!-- tab2 start -->
		<div id="hcp_airway" style="display: none">
			<!-- SEARCH -->
			<div class="search_wrap">
				<div class="search">
					<label class="type_tit sun">검색(UTC)</label>
					<custom:DateTimeRangeSelectyymmdd2 offset="2"/>

					<div class="searchbtns">
						<input id="search_btn2" type="button" title="검색" value="검색" class="btnsearch"/>
					</div>
				</div>
			</div>
			
			<!-- airway 1 start -->
			<div id="hcp_airway_list_1" class="hcp_airway" style="display: inline-block;">
				<table id="hcp_airway_table_1" border="1" >
					<thead>
						<tr>
							<th colspan="3">[로스앤젤러스-인천] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_airway_tbody_1">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=LAX-ICN'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_1_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_1_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_1_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_1_mSvhr}</th>
							<th class="th_total_dose">${airway_1_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- airway 1 end -->
			
			<!-- airway 2 start -->
			<div id="hcp_airway_list_2" class="hcp_airway" style="display: inline-block;">
				<table id="hcp_airway_table_2" border="1" >
					<thead>
						<tr>
							<th colspan="3">[뉴욕-인천] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_airway_tbody_2">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=JFK-ICN'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_2_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_2_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_2_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_2_mSvhr}</th>
							<th class="th_total_dose">${airway_2_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- airway 2 end -->



			<!-- airway 3 start -->
			<div id="hcp_airway_list_3" class="hcp_airway" style="display: inline-block;">
				<table id="hcp_airway_table_3" border="1" >
					<thead>
						<tr>
							<th colspan="3">[뉴욕-인천(북극항로)] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_airway_tbody_3">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=JFK-ICN-polar'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_3_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_3_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_3_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_3_mSvhr}</th>
							<th class="th_total_dose">${airway_3_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- airway 3 end -->
			
			<!-- airway 4 start -->
			<div id="hcp_airway_list_4" class="hcp_airway" style="display: inline-block;">
				<table id="hcp_airway_table_4" border="1" >
					<thead>
						<tr>
							<th colspan="3">[댈러스-인천] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_airway_tbody_4">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=DEL-ICN'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_4_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_4_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_4_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_4_mSvhr}</th>
							<th class="th_total_dose">${airway_4_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- airway 4 end -->

			<!-- airway 5 start -->
			<div id="hcp_airway_list_5" class="hcp_airway" style="display: inline-block;">
				<table id="hcp_airway_table_5" border="1" >
					<thead>
						<tr>
							<th colspan="3">[모스크바-인천] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_airway_tbody_5">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=MSC-ICN'/>"/></a>							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_5_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_5_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_5_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_5_mSvhr}</th>
							<th class="th_total_dose">${airway_5_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- airway 5 end -->
			
			<!-- airway 6 start -->
			<div id="hcp_airway_list_6" class="hcp_airway" style="display: inline-block;">
				<table id="hcp_airway_table_6" border="1" >
					<thead>
						<tr>
							<th colspan="3">[시애틀-인천] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_airway_tbody_6">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=SAT-ICN'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_6_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_6_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_6_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_6_mSvhr}</th>
							<th class="th_total_dose">${airway_6_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- airway 6 end -->

			<!-- airway 7 start -->
			<div id="hcp_airway_list_7" class="hcp_airway" style="display: inline-block;">
				<table id="hcp_airway_table_7" border="1" >
					<thead>
						<tr>
							<th colspan="3">[이스탄불-인천] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_airway_tbody_7">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=IST-ICN'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_7_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_7_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_7_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_7_mSvhr}</th>
							<th class="th_total_dose">${airway_7_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- airway 7 end -->
			
			<!-- airway 8 start -->
			<div id="hcp_airway_list_8" class="hcp_airway" style="display: inline-block;">
				<table id="hcp_airway_table_8" border="1" >
					<thead>
						<tr>
							<th colspan="3">[인천-런던] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_airway_tbody_8">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=ICN-LHR'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_8_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_8_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_8_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_8_mSvhr}</th>
							<th class="th_total_dose">${airway_8_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- airway 8 end -->

			<!-- airway 9 start -->
			<div id="hcp_airway_list_9" class="hcp_airway" style="display: inline-block;">
				<table id="hcp_airway_table_9" border="1" >
					<thead>
						<tr>
							<th colspan="3">[파리-인천] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_airway_tbody_9">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_AIRWAY&airway=PAR-ICN'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_9_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_9_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_9_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_9_mSvhr}</th>
							<th class="th_total_dose">${airway_9_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- airway 9 end -->
		</div>
		<!-- tab2 end -->
		
		<!-- tab3 start -->
		<div id="hcp_korea" style="display: none">
			<!-- SEARCH -->
			<div class="search_wrap">
				<div class="search">
					<label class="type_tit sun">검색(UTC)</label>
					<custom:DateTimeRangeSelectyymmdd5 offset="5"/>

					<div class="searchbtns">
						<input id="search_btn3" type="button" title="검색" value="검색" class="btnsearch"/>
					</div>
				</div>
			</div>
			
			<!-- korea 1 start -->
			<div id="hcp_korea_list_1" class="hcp_korea" style="display: inline-block;">
				<table id="hcp_korea_table_1" border="1" >
					<thead>
						<tr>
							<th colspan="3">[로스앤젤러스-인천] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_korea_tbody_1">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class="imageclick" style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=LAX-ICN'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_1_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_1_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_1_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_1_mSvhr}</th>
							<th class="th_total_dose">${airway_1_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- korea 1 end -->
			
			<!-- korea 2 start -->
			<div id="hcp_korea_list_2" class="hcp_korea" style="display: inline-block;">
				<table id="hcp_korea_table_2" border="1" >
					<thead>
						<tr>
							<th colspan="3">[뉴욕-인천] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_korea_tbody_2">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=JFK-ICN'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_2_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_2_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_2_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_2_mSvhr}</th>
							<th class="th_total_dose">${airway_2_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- korea 2 end -->



			<!-- korea 3 start -->
			<div id="hcp_korea_list_3" class="hcp_korea" style="display: inline-block;">
				<table id="hcp_korea_table_3" border="1" >
					<thead>
						<tr>
							<th colspan="3">[뉴욕-인천(북극항로)] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_korea_tbody_3">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=JFK-ICN-polar'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_3_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_3_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_3_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_3_mSvhr}</th>
							<th class="th_total_dose">${airway_3_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- korea 3 end -->
			
			<!-- korea 4 start -->
			<div id="hcp_korea_list_4" class="hcp_korea" style="display: inline-block;">
				<table id="hcp_korea_table_4" border="1" >
					<thead>
						<tr>
							<th colspan="3">[댈러스-인천] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_korea_tbody_4">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=DEL-ICN'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_4_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_4_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_4_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_4_mSvhr}</th>
							<th class="th_total_dose">${airway_4_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- korea 4 end -->

			<!-- korea 5 start -->
			<div id="hcp_korea_list_5" class="hcp_korea" style="display: inline-block;">
				<table id="hcp_korea_table_5" border="1" >
					<thead>
						<tr>
							<th colspan="3">[모스크바-인천] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_korea_tbody_5">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=MSC-ICN'/>"/></a>							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_5_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_5_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_5_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_5_mSvhr}</th>
							<th class="th_total_dose">${airway_5_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- korea 5 end -->
			
			<!-- korea 6 start -->
			<div id="hcp_korea_list_6" class="hcp_korea" style="display: inline-block;">
				<table id="hcp_korea_table_6" border="1" >
					<thead>
						<tr>
							<th colspan="3">[시애틀-인천] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_korea_tbody_6">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=SAT-ICN'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_6_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_6_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_6_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_6_mSvhr}</th>
							<th class="th_total_dose">${airway_6_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- korea 6 end -->

			<!-- korea 7 start -->
			<div id="hcp_korea_list_7" class="hcp_korea" style="display: inline-block;">
				<table id="hcp_korea_table_7" border="1" >
					<thead>
						<tr>
							<th colspan="3">[이스탄불-인천] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_korea_tbody_7">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=IST-ICN'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_7_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_7_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_7_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_7_mSvhr}</th>
							<th class="th_total_dose">${airway_7_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- korea 7 end -->
			
			<!-- korea 8 start -->
			<div id="hcp_korea_list_8" class="hcp_korea" style="display: inline-block;">
				<table id="hcp_korea_table_8" border="1" >
					<thead>
						<tr>
							<th colspan="3">[인천-런던] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_korea_tbody_8">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=ICN-LHR'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_8_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_8_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_8_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_8_mSvhr}</th>
							<th class="th_total_dose">${airway_8_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- korea 8 end -->

			<!-- korea 9 start -->
			<div id="hcp_korea_list_9" class="hcp_korea" style="display: inline-block;">
				<table id="hcp_korea_table_9" border="1" >
					<thead>
						<tr>
							<th colspan="3">[파리-인천] 항공로 방사선 피폭량 </th>
						</tr>
					</thead>
					<tbody id="hcp_korea_tbody_9">
						<tr>
							<th rowspan="5">
								<a href='#' class='th_img'><img class='imageclick' style="padding: 3px;" width="400px" src="<c:url value='/elementSWAA/intraSunspot.do?type=HCP_KOREA&airway=PAR-ICN'/>"/></a>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>비행 시간<br/>(hr)</th>
							<th>상황 등급<br/>(승무원기준)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_flighttime">${airway_9_hr}</th>
							<th>
								<div class="info" id="proton_info">
									<div class="div_grade ${airway_9_sign}" id="man">
										<span class="num"></span>
									</div>
								</div>
								<div class="grade_text">${airway_9_text}</div>
							</th>
						</tr>
						<tr class="tr_airway">
							<th>평균 피폭량<br/>(mSv/hr)</th>
							<th>누적 피폭량<br/>(mSv)</th>
						</tr>
						<tr class="tr_airway">
							<th class="th_ave_dose">${airway_9_mSvhr}</th>
							<th class="th_total_dose">${airway_9_mSv}</th>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- korea 9 end -->
		</div>
		<!-- tab3 end -->
		
		<!-- tab4 start -->
		<div id="ovation" style="display: none">
		    <!-- SEARCH -->
		    <div class="search_wrap">    
		        <div class="search">
		            <label class="type_tit ovation">검색(UTC)</label>
					<custom:DateTimeRangeSelectyymmdd3 offset="1"/>
		            <span class="mg">
		                <input type="button" title="1시간" value="1시간" class="btn" />
		                <input type="button" title="3시간" value="3시간" class="btn" />
		                <input type="button" title="6시간" value="6시간" class="btn" />
		                <input type="button" title="12시간" value="12시간" class="btn" />
		                <input type="button" title="24시간" value="24시간" class="btn" />
		            </span>
		            
		            <div class="searchbtns">           
		                <input type="button" title="검색" value="검색" class="btnsearch" id="searchOvation" />
		            </div>               
		        </div>
		    </div>
		    
		    <div class="board_list">
		    	<table>
		        	<thead>
		            	<tr>
		                	<th>영상 리스트</th>
		                </tr>
		           	</thead>
		           	<tbody id="search_result">
		                <tr>
		                	<td><ul id="bxslider_OVATION"></ul></td>
		                </tr>
		            </tbody>
		        </table>
			</div>      
		</div>
		<!-- tab4 end -->

		<!-- tab5 start -->		
		<div id="drap" style="display: none">
			<div class="search_wrap">    
		        <div class="search">
		            <label class="type_tit ovation">검색(UTC)</label>
					<custom:DateTimeRangeSelectyymmdd4 offset="1"/>
		            <span class="mg1">
		                <input type="button" title="1시간" value="1시간" class="btn" />
		                <input type="button" title="3시간" value="3시간" class="btn" />
		                <input type="button" title="6시간" value="6시간" class="btn" />
		                <input type="button" title="12시간" value="12시간" class="btn" />
		                <input type="button" title="24시간" value="24시간" class="btn" />
		            </span>
		            
		            <div class="searchbtns">           
		                <input type="button" title="검색" value="검색" class="btnsearch" id="searchDrap" />
		            </div>               
		        </div>
		    </div>
		    
		    <div class="board_list">
		    	<table>
		        	<thead>
		            	<tr>
		                	<th>영상 리스트</th>
		                </tr>
		           	</thead>
		           	<tbody id="search_result">
		                <tr>
		                	<td><ul id="bxslider_DRAP"></ul></td>
		                </tr>
		            </tbody>
		        </table>
			</div>      
		</div>
		<!-- tab5 end -->
	</div>
	<!-- END CONTENTS -->

	<jsp:include page="../footer.jsp" />
</body>
</html>