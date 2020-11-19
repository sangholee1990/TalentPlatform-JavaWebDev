<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.code.*"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 기상위성운영 및 전리권 상황판</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/monitorSWAA.css"/>" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/perfect-scrollbar.css"/>" />
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<script type="text/javascript"
	src="<c:url value="/js/jquery.layout-latest.min.js"/>"></script>
<style>
#ui-datepicker-div {
	z-index: 9999999 !important;
}

.dygraph-ylabel {
	font-weight: bold;
}
</style>
<script type="text/javascript" src="<c:url value="/js/date.format.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/js/jquery.mousewheel.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/js/perfect-scrollbar.js"/>"></script>

<jsp:include page="../include/dygraph.jsp" />
<script type="text/javascript">
var imageManager1 = null;
var imageManager2 = null;
var imageManager3 = null;
var imageManager4 = null;

var xmlHttp;
function srvTime() {
	if(window.XMLHttpRequest) {
		req = new XMLHttpRequest();
	} else if(window.ActiveXObject) {
		req = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlHttp = req;
	xmlHttp.open('HEAD', window.location.href.toString(), false);
	xmlHttp.setRequestHeader("Content-Type", "text/html");
	xmlHttp.send('');
	
	return xmlHttp.getResponseHeader("Date");
}	

var timer =  {
	date: new Date(),
	clockTimer: setInterval("timer.clockUpdate()", 1000),
	imageTimer: setInterval("timer.imageUpdate()", 1000*60*5),
	indicatorTimer: setInterval("timer.indicatorUpdate()", 1000*60*5),
	
	clockUpdate: function() {
		//var now = new Date();
		var st = srvTime();
		var now = new Date(st);
		
		$("#utc_date").text(now.format('yyyy.mm.dd', true));
		$("#utc_hour").text(now.format('HH', true));
		$("#utc_minute").text(now.format('MM', true));
		$("#utc_second").text(now.format('ss', true));
		
		$("#kst_date").text(now.format('yyyy.mm.dd', false));
		$("#kst_hour").text(now.format('HH', false));
		$("#kst_minute").text(now.format('MM', false));
		$("#kst_second").text(now.format('ss', false));
		
		var year = now.format('yyyy', true);
		var month = now.format('mm', true);
		var date = now.format('dd', true);
		var hour = now.format('HH', true);
		var mtimer = now.format('MM', true);
		var stimer = now.format('ss', true);
		
		var year_kst = now.format('yyyy', false);
		var month_kst = now.format('mm', false);
		var date_kst = now.format('dd', false);
		var hour_kst = now.format('HH', false);
		var minute_kst = now.format('MM', false);
		var second_kst = now.format('ss', false);
		
		var reloadTime = now.format('HH:MM:ss', true);
		if (reloadTime == '00:00:00')
			location.reload();
		
		if(mtimer == 30 && stimer == 00){
			texImage(year,month,date,hour);
		}
		
		if(stimer == 00) {
			magnetoImage(year_kst,month_kst,date_kst,hour_kst,minute_kst);
		}
		
	},
	imageUpdate: function() {

	},
	indicatorUpdate: function() {
		$.ajax({
			url : "<c:url value="/monitor/chart_indicator.do"/>"
		}).done(function(data) {	
			setElementInfo_ef($("#eletron_flux_info"), 
					data.elements.ELECTRON_FLUX_20_13, data.elements.ELECTRON_FLUX_40_13);			
			setElementInfo($("#magnetopause_radius_info"), data.elements.MP);
			
			setSummaryValue($("#summary1"), data.notice1);
			setSummaryValue($("#summary2"), data.notice2);
			setSummaryValue($("#summary3"), data.notice3);
		});	
	}
};

var imageType = null;

var imageSearchCalenar = {
	imageManager: null,
	initialize: function() {
		var datepickerOption = {
				changeYear:true,
				showOn: "button",
				buttonImage: '<c:url value="/images/monitor/btn_calendar.png"/>', 
				buttonImageOnly: true,
				onSelect: function(dateText) {
					imageSearchCalenar.updateMinuteList();
				}
		};
		$("#calendar_image_date").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
		
		$("#calendar_image_hour").change(function() {
			imageSearchCalenar.updateMinuteList();
		});
		
		$("#calendar_image .btn").click(function(e) {
			
			var data = $("#calendar_image option:selected").data();
			
			var date = $("#calendar_image_date").val();
			var hour = $("#calendar_image_hour").val();
			var min = $("#calendar_image_min").val();
			 
			var year = date.substring(0,4);
			var month = date.substring(5,7);
			var date = date.substring(8);
				
			var type = imageType;
			var fileName = null;
			var imageNum = null;
			var root = null;
			
			
			switch(imageType){
			
			case "Magnetopause" :
				var addr = "<c:url value='/monitorSWAA/loadImageMagnetopause.do?year="
					+ year
					+ "&month="
					+ month
					+ "&date="
					+ date
					+ "&hour="
					+ hour
					+ "&minute="
					+ min
					+ "'/>";
				$("#image1 img").attr("src", addr);
				
			break;
			
			case "RBSP" : 
				var addr = "<c:url value='/monitorSWAA/loadImageRBSP.do?year="
					+ year
					+ "&month="
					+ month
					+ "&date="
					+ date
					+ "'/>";
				$("#image2 img").attr("src", addr);
				
		    break;
				
			case "TEC" : 
				var addr = "<c:url value='/monitorSWAA/loadImageTEC.do?year="
					+ year
					+ "&month="
					+ month
					+ "&date="
					+ date
					+ "&hour="
					+ hour
					+ "'/>";
				$("#image3 img").attr("src", addr);	

				 
		    break;
			
			}
			var addr = "http://localhost:8080/VImage/"+root+"/"+type+"/Y"+year+"/M"+month+"/D"+date+"/"+fileName; 
			$("#"+imageNum+" img").attr("src", addr); 
			
			$("#calendar_image").hide();
		
		});
		
		$("#calendar_image .close").click(function() {
			$("#calendar_image").hide();
		});
	},
	
	updateMinuteList: function() {

	},
	
	show: function(manager, offset) {
		this.imageManager = manager;
		
		$("#calendar_image_date").val(manager.currentDate.format("yyyy-mm-dd"));
		$("#calendar_image_hour").val(manager.currentDate.format("HH"));

		if(manager.dataList != null) {
			$.each(manager.dataList, function(key, val) {
				var date = new Date(val.createDate);
				var minute = date.format("MM");
				var option = $("<option>", {value:minute, text:minute, data:val});
			});
		}
		
		var calenar = $("#calendar_image");
		calenar.css('top', offset.top + 24);
		calenar.css('left', offset.left  - 80);
		calenar.show();
		
	/* 	var offLeft = offset.left.toFixed(0);
		alert(offLeft); */
		
	 
		var width = $("#wrap_left_weather").width();
		var standard = width/3;
		 
		if(offset.left < standard){
			imageType = "Magnetopause";
		}else if(offset.left < standard*2){
	    	imageType = "RBSP";
		}else{
			imageType = "TEC";
		}
		 
	},
	hide: function() {
		$("#calendar_image").hide();
	}
};

var chartCalendar = {
	calenarButton: null,
	initialize: function() {
		var datepickerOption = {
				changeYear:true,
				showOn: "button",
				buttonImage: '<c:url value="/images/monitor/btn_calendar.png"/>', 
				buttonImageOnly: true
		};

		$("#wrap_graph .calendar").click(function(e) {
			chartCalendar.show($(this));
			e.defaultPrevented = true;
			return false;
		});
		
		$("#calendar_chart_start_date").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
		$("#calendar_chart_end_date").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
		
		var now = timer.date;
		var yes = new Date();
		yes.setDate(now.getDate() - 1);
		
		$("#wrap_graph .calendar").each(function() {
			var calenarButton = $(this);
			var chartType = calenarButton.parents(".gr_graph").children('.graph').attr('id');
			
			$(this).data({
				type: chartType,
				sd:yes.format('yyyy-mm-dd', true),
				ed: now.format('yyyy-mm-dd', true),
				autoRefresh: true
			});
			
			calenarButton.parents(".header").find('h2 a').click(function(e) {
				$(this).addClass("on");
				$(this).parents(".header").find('.glist').toggle();
				var data = calenarButton.data();
				
				calendarOn = true;
				
//				data.autoRefresh = true;
//				chartGraphManager.setAutoRefreshLayer(data.type, true);
//				chartGraphManager.autoRefresh();
				
				e.defaultPrevented = true;
				return false;
			});
			//*****추가
			calenarButton.parents(".header").find('.glist li').click(function(e) {
				calendarOn = false;
				var selected = $(this);
				selected.parent().hide();
				var type = selected.children().val();
				
				var removeId = selected.parents(".header").next().attr("id");
				var data = calenarButton.data();
				//중복 체크
				if(type  != removeId){
					data.type = type;
					data.popup = type;
					chartGraphManager.remove(removeId,"");
					var idx = "";
					if($("#" + type).length > 0){
						idx = selected.parents(".header").parent().index();
						data.type = type + idx;
					}
					selected.parents(".header").find('h2 a span').text(selected.text());
					var div = selected.parents(".header").find('.ginfo').attr({"id":type + "_LABELS_DIV" + idx});
					var box = selected.parents(".header").next().attr({"id":type + idx}).empty();
					var chartOption = {axisLabelColor:'white', "div" : div, "box" : box};
					
					if(type == "ACE_MAG"){	//ACE IMF 자기장
						chartGraphManager.addAceMag({axisLabelColor:'white', colors: ['cyan', 'blue', 'red', 'yellow'], "div" : div, "box" : box});
					}else if(type == "ACE_SOLARWIND_SPD"){	//ACE 태양풍 속도
						chartGraphManager.addAceSolarWindSpeed(chartOption);
					}else if(type == "ACE_SOLARWIND_DENS"){	//ACE 태양풍 밀도
						chartGraphManager.addAceSolarWindDens({axisLabelColor:'white', colors: ['red'], "div" : div, "box" : box});
					}else if(type == "ACE_SOLARWIND_TEMP"){	//ACE 태양풍 온도
						chartGraphManager.addAceSolarWindTemp({axisLabelColor:'white', colors: ['red'], "div" : div, "box" : box});
					}else if(type == "MAGNETOPAUSE_RADIUS"){	//자기권계면
						chartGraphManager.addMagnetopauseRadius(chartOption);
					}else if(type == "XRAY_FLUX"){	//X-선 플럭스
						chartGraphManager.addXRayFlux({axisLabelColor:'white', colors: ['cyan', 'red'], "div" : div, "box" : box});
					}else if(type == "PROTON_FLUX"){	//양성자 플럭스
						chartGraphManager.addProtonFlux(chartOption);
					}else if(type == "GOES_MAG_SWAA"){
						chartGraphManager.addGoesMagSWAA(chartOption);
					}else if(type == "ELECTRON_FLUX_SWAA"){
						chartGraphManager.addElectronFluxSWAA(chartOption);
					}else if(type == "ELECTRON_FLUX"){	//전자기 플럭스
						chartGraphManager.addElectronFlux({axisLabelColor:'white', colors: ['cyan', 'red'], "div" : div, "box" : box});
					}else if(type == "KP_INDEX_SWPC"){	//Kp 지수
						chartGraphManager.addKpIndexSwpc(chartOption);
					}else if(type == "DST_INDEX_KYOTO"){ //Dst 지수
						chartGraphManager.addDstIndexKyoto(chartOption);
					}
					var now = timer.date;
					var yes = new Date();
					yes.setDate(now.getDate() - 1);
					data.sd =  yes.format('yyyy-mm-dd', true);
					data.ed = now.format('yyyy-mm-dd', true);
					chartGraphManager.resize($("#wrap_graph .graph").width(),$("#wrap_graph .graph").height());
				}
				data.autoRefresh = true;
				chartGraphManager.setAutoRefreshLayer(data.type, true);
				chartGraphManager.autoRefresh();
				e.defaultPrevented = true;
				return false;
			});
			//*****추가

		});
		
		$("#wrap_graph .detail").click(function(e) {
			var calendarButton = $(this).prev();
			var data = calendarButton.data();
			var url = "chart_popup.do?" + $.param(calendarButton.data());
			if(data.popup != null){	//중복되는 그래프면
				url = "chart_popup.do?type="  + data.popup + "&sd=" + data.sd +"&ed=" + data.ed + "&autoRefresh=" + data.autoRefresh;
			}
			window.open(url, '_blank','width=1024,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
			e.defaultPrevented = true;
			return false;
		});
		
		$("#calendar_chart .btn").click(function(e) {
			e.defaultPrevented = true;
			var calenarButton = chartCalendar.calenarButton;
			var chartType = calenarButton.data().type;
			var startDate = $("#calendar_chart_start_date").val();
			var endDate = $("#calendar_chart_end_date").val();
			if(startDate == "") {
				alert("시작일을 입력하세요!");
				return false; 
			}
			
			if(endDate == "") {
				alert("종료일을 입력하세요!");
				return false; 
			}
			
			calenarButton.data({
				sd: startDate,
				ed: endDate,
				autoRefresh: false
			});
			
			calenarButton.parents(".header").find('h2 a').removeClass("on");
			chartGraphManager.load({
				sd : startDate.replace(/-/gi, '') + "000000",
				ed : endDate.replace(/-/gi, '') + "230000",
				type: chartType
			});
			
			chartCalendar.hide();
			return false;
		});
		
		$("#calendar_chart .close").click(function(e) {
			chartCalendar.hide();
			e.defaultPrevented = true;
			return false;
		});
	},
	
	show: function(calendarButton) {
		calendarOn = true;
		chartCalendar.calenarButton = calendarButton;
		
		var offset = calendarButton.offset();
		var calendarData = calendarButton.data();

		$("#calendar_chart_start_date").val(calendarData.sd);
		$("#calendar_chart_end_date").val(calendarData.ed);
		
		var calenar = $("#calendar_chart");
		calenar.css('top', offset.top+25);
		calenar.css('left', offset.left-139);
		$("#ui-datepicker-div").css("z-index", 20);
		calenar.show();
	},
	hide: function() {
		calendarOn = false;		
		$("#calendar_chart").hide();
	}		
};

function setSummaryValue(obj, data) {
	if(data != null) {
		obj.children(".num").text(data.code);
		var textObj = obj.children(".txt");
		textObj.text(data.gradeText);
		obj.removeClass("w g b y o r");
		textObj.removeClass("fw fg fb fy fo fr"); 
		switch(data.code) {
		case 0:
			obj.addClass("w");
			textObj.addClass("fw");
			break;
		case 1:
			obj.addClass("g");
			textObj.addClass("fg");
			break;
		case 2:
			obj.addClass("b");
			textObj.addClass("fb");
			break;
		case 3:
			obj.addClass("y");
			textObj.addClass("fy");
			break;
		case 4:
			obj.addClass("o");
			textObj.addClass("fo");
			break;
		case 5:
			obj.addClass("r");
			textObj.addClass("fr");
			break;
		};
		
	} else {
		obj.children(".num").text(""); 
		var textObj =  obj.children(".txt");
		textObj.text("없음");
		obj.removeClass("w g b y o r");
		textObj.removeClass("fw fg fb fy fo fr");
	}
}

function toExponential(val) {
	return (val > 10000 || val < 0.0001)?val.toExponential():val;
}

function setElementInfo(obj, data, prefix) {
	var sign = obj.children(".sign");
	var message = obj.find(".txt");
	sign.removeClass("w g b y o r");
	message.removeClass("fw fg fb fy fo fr");

	var signText = "";
	var messageText = "없음";
	var H0Text = "";
	var H3Text = "";
	var H24Text = "";
	if(data != null) {
		if(data.NOW != null) {
			H0Text = toExponential(data.NOW.val);
		}
		
		if(data.H3 != null) {
			switch(data.H3.code) {
			case 0:
				sign.addClass("w");
				message.addClass("fw");
				break;
			case 1:
				sign.addClass("g");
				message.addClass("fg");
				break;
			case 2:
				sign.addClass("b");
				message.addClass("fb");
				break;
			case 3:
				sign.addClass("y");
				message.addClass("fy");
				break;
			case 4:
				sign.addClass("o");
				message.addClass("fo");
				break;
			case 5:
				sign.addClass("r");
				message.addClass("fr");
				break;
			};		
			
			signText = data.H3.grade;
			messageText = data.H3.gradeText;
			
			var month = data.H3.tm.substring(4, 6);
			var day = data.H3.tm.substring(6, 8);
			var hour = data.H3.tm.substring(8, 10);
			var minute = data.H3.tm.substring(10, 12);
			H3Text = toExponential(data.H3.val) + " (" + month + "." + day + " " + hour + ":" + minute + ")";
		}
		
		if(data.D1 != null) {
			H24Text = toExponential(data.D1.val) + " (<b>" + data.D1.grade +"</b>)";
		}
	}
	
	sign.children(".num").text(signText);
	message.text(messageText);
	
	var now = obj.find("p span:first");
	now.text("현재: " + H0Text);
	now.next().text("3시간 최대값: " + H3Text);
	now.next().next().html("24시간 최대값: " + H24Text);
}

function setElementInfo_ef(obj, d20_13, d40_13, prefix) {
	var sign = obj.children(".sign");
	var message = obj.find(".txt");
	sign.removeClass("w g b y o r");
	message.removeClass("fw fg fb fy fo fr");

	var signText = "";
	var messageText = "없음";
	var H0Text20_13 = "";
	var H0Text40_13 = "";
	var H3Text20_13 = "";
	var H3Text40_13 = "";
	var H24Text20_13 = "";
	var H24Text40_13 = "";
	if(d20_13 != null && d40_13 != null) {
		if(d20_13.NOW != null)
			H0Text20_13 = toExponential(d20_13.NOW.val);
		
		if(d40_13.NOW != null)
			H0Text40_13 = toExponential(d40_13.NOW.val);
		
		var dH3 = d20_13;
		if( d20_13.NOW != null && d40_13.NOW != null &&
			d20_13.NOW.code < d40_13.NOW.code )
			dH3 = d40_13;
		
		switch(dH3.NOW.code) {
		case 0:
			sign.addClass("w");
			message.addClass("fw");
			break;
		case 1:
			sign.addClass("g");
			message.addClass("fg");
			break;
		case 2:
			sign.addClass("b");
			message.addClass("fb");
			break;
		case 3:
			sign.addClass("y");
			message.addClass("fy");
			break;
		case 4:
			sign.addClass("o");
			message.addClass("fo");
			break;
		case 5:
			sign.addClass("r");
			message.addClass("fr");
			break;
		};
		
		signText = dH3.NOW.grade;
		messageText = dH3.NOW.gradeText;
		
		var month = d20_13.H3.tm.substring(4, 6);
		var day = d20_13.H3.tm.substring(6, 8);
		var hour = d20_13.H3.tm.substring(8, 10);
		var minute = d20_13.H3.tm.substring(10, 12);
		H3Text20_13 = toExponential(d20_13.H3.val) + " (2MeV " + month + "." + day + " " + hour + ":" + minute + ")";
		
		month = d40_13.H3.tm.substring(4, 6);
		day = d40_13.H3.tm.substring(6, 8);
		hour = d40_13.H3.tm.substring(8, 10);
		minute = d40_13.H3.tm.substring(10, 12);
		H3Text40_13 = toExponential(d40_13.H3.val) + " (40keV " + month + "." + day + " " + hour + ":" + minute + ")";
		
		if(d20_13.D1 != null)
			H24Text20_13 = toExponential(d20_13.D1.val);
		
		if(d40_13.D1 != null)
			H24Text40_13 = toExponential(d40_13.D1.val);
	}
	
	sign.children(".num").text(signText);
	message.text(messageText);
	
	var now = obj.find("p span:first");
	now.text("현재: " + H0Text20_13 + " (2MeV) / " + H0Text40_13 + " (40keV)");
	now.next().text("3시간 최대값: " + H3Text20_13);
	now.next().next().text(H3Text40_13);
	now.next().next().next().html("24시간 최대값: " + H24Text20_13 + " (2MeV) / " + H24Text40_13 + " (40keV)");
}

function ImageManager() {
	this.container = null;
	this.imageTypeList = null;
	this.title = null;
	this.currentDate = new Date();
	this.dateLabel = null;
	this.dataList = null;
	this.currentData = null;
	this.image = null;
	this.viewMovie = false;
	this.realtime = true;
};

function pad(val, len) {
	var valString = String(val);
	len = len || 2;
	while (valString.length < len) valString = "0" + valString;
	return valString;
};

ImageManager.prototype.initialize = function(container) {
	var manager = this;
	this.container = container;
	this.imageTypeList = container.find(".header .alist");
	this.title = container.find(".header h2 a").last();
	this.dateLabel = container.find(".header .date span");
	this.image = container.find(".contents img");
	
	this.container.find(".header h2 a").click(function(e) {
		imageSearchCalenar.hide();
		manager.imageTypeList.toggle();
		e.defaultPrevented = true;
		return false;
	});
	
	this.imageTypeList.children("a").click(function(e) {
		manager.container.find(".date .vod").removeClass("on");
		manager.viewMovie = false;
		
		var code = $(this).attr("name");
		var text = $(this).text();
		manager.title.text(text);
		manager.title.attr("name", code);
		manager.imageTypeList.hide();
		e.defaultPrevented = true;
		return false;
	});
	
//	this.title.click(function(e) {
//		manager.realtime = true;
//		manager.load();
//	});
	
	this.container.find(".date .calendar").click(function(e) {
		var buttonOffset = $(this).offset();
		imageSearchCalenar.show(manager, buttonOffset);

		e.defaultPrevented = true;
		return false;
	});
	
	this.container.find(".date .vod").click(function(e) {
		$(this).toggleClass("on");
		manager.viewMovie = $(this).hasClass("on");
		e.defaultPrevented = true;
		return false;
	});
	
	this.setDate(new Date());
};

ImageManager.prototype.setDate = function(date) {
	this.currentDate = date;
	if(date != null) {
		this.dateLabel.text(date.format("yyyy.mm.dd HH:MM"));
	} else {
		this.dateLabel.text("");
	}
}

ImageManager.prototype.setRealtime = function(realtime) {
	if(realtime) {
		this.title.addClass("on");
	} else {
		this.title.removeClass("on");
	}
}

ImageManager.prototype.isRealtime = function() {
	return this.title.addClass("on");
}
var setTime = null;
$(window).resize(function() {
	clearTimeout(setTime);
	setTime = setTimeout(onResize,200);
});
//resize
function onResize() {
	clearTimeout(setTime);
	/* *
	 * Min 800 X ?
	*/
	var bodyWidth = $(window).width() < 1024 ? 1024 : $(window).width();	//너비
	var limiteHeight = 800;	//최소 높이
	//최소 높이 조절
	if(bodyWidth < 1761){
		limiteHeight = 700;
	}
	
	var bodyHeight = $(window).height() < limiteHeight ? limiteHeight : $(window).height();	//높이
	 
	//WARP 리사이즈
	$("#wrap").width(bodyWidth);	
	$("#wrap").height(bodyHeight);
	
	//너비 체크
	if(bodyWidth < 1761){
		$("#wrap, #header").addClass("width1760");// 클래스 추가
			if(bodyWidth < 1200){
				$("#wrap, #header").addClass("width1200"); 
			}else{
				$("#wrap, #header").removeClass("width1200"); 
			}
	}else{
		$("#wrap, #header").removeClass();
		$("#wrap_left_weather").removeAttr("style");
	}
	 
	//Info 리사이즈
	var contentHeight = bodyHeight - $("#header").outerHeight();
	var infoHeight = contentHeight * 0.195;
	var infoTHeight = contentHeight * 0.22;
	var infoTConHeight = infoTHeight - $(".wrap_info .header").outerHeight();
	var infoConHeight = infoHeight - $(".wrap_info .header").outerHeight();

	var warp_dec1 = 30;
	var warp_dec2 = 10;
	var info_dec1 = 70;
	var info_dec2 = 40;
	if( bodyWidth < 1761 )
	{
		warp_dec1 = 55;
		warp_dec2 = 60;
		info_dec1 = 90;
		info_dec2 = 70;
	}
	
	$(".wrap_info").height(infoHeight - warp_dec1);	//우주기상 특보상황
	$(".wrap_info:first").height(infoTHeight - warp_dec2);	//나머지
	$(".info_total").css({
		"height": infoTConHeight,
		"line-height":infoTConHeight - info_dec1  +"px"
		}); //우주기상 특보상황 내용
	$(".info").css({
		"padding-left": "3%" ,
		"line-height":infoConHeight - info_dec2  +"px"
		}); //나머지 내용
	$(".sign_wrap").css({
		"padding-left": ($(".info_total").width() - $(".sign_wrap").width()*3)/8
		});
	
	
		var infoH = $("#wrap_right_weather").height();
		var info0 = $("#wrap_info").height();
		var info1 = $("#info1").height();
		var info2 = $("#info2").height();
		var info3 = $("#info3").height();
		
		var sign_wrap  = $("#infototal ").height();
		var eletron_flux_info  = $("#eletron_flux_info ").height();
		var magnetopause_radius_info  = $("#magnetopause_radius_info ").height();
		 
		var img = $("#wrap_left_weather").height();  
		
		 $("#wrap_right_weather").height(img);
		 $("#info1").height(img/3);
		 $("#info2").height(img/3);
		 $("#info3").height(img/3);
		  
		 var signH = $("#info1").height();
		 
		 if(signH<120){ 
			 $(".signt").addClass("width120"); 
			 $(".signt").removeClass("width99"); 
		 }else if(signH<80){
			 //alert("작아짐"+signH)
			 $(".signt").addClass("width99"); 
		 } 
		 
		//이미지 헤더 
		 var imgHaederW = $("#imageManager1").width(); 
			if(imgHaederW<330){
				$("#imgTitle1").html("자기권계면<br>&nbsp;");
				$("#imgTitle2").html("지구 자기권 방사선대<br>(Van Allen Probes)");
				$("#imgTitle3").html("총전자밀도<br>&nbsp;"); 
			}
			if(imgHaederW>=330){
				$("#imgTitle1").html("자기권계면 ");
				$("#imgTitle2").html("지구 자기권 방사선대 (Van Allen Probes)");
				$("#imgTitle3").html("총전자밀도 ");  
			}	   
		 
	//그래프 박스 리사이즈 
	var graphHeight = ((bodyHeight - $("#header").outerHeight()) -  $("#wrap_left_weather").outerHeight())/2;
	if(slice){
		$("#wrap_graph .gr_graph").width($("#wrap_left_weather").width()/0.705/2).height(graphHeight - 2);
		$("#wrap_graph .graph").height(graphHeight -$(".gr_graph .header").outerHeight());
		$("#wrap_graph .graph").width($(".gr_graph").width() - 5).css("padding","5px");
		$("#wrap_graph").width("99.5%").height(graphHeight - 2);
	}else{
		graphHeight =	bodyHeight - $("#header").outerHeight()-  $("#wrap_left_weather").outerHeight();
		$("#wrap_graph .gr_graph").width($("#wrap_left_weather").width()+$("#wrap_right_weather").width()).height(graphHeight - 2);
		$("#wrap_graph .graph").height(graphHeight -$(".gr_graph .header").outerHeight());
		$("#wrap_graph .graph").width($(".gr_graph").width() - 5).css("padding","5px");
		$("#wrap_graph").width($("#wrap_graph .graph").outerWidth() * 4).height(graphHeight - 2);
		
		$.each($("#wrap_graph .gr_graph"),function(){
			var now = $(this); 
			
			if(!now.hasClass("selected")){
				//now.css("left", $("#wrap_graph .graph").outerWidth());
				now.css("display","none");
			}else{
				now.css("display","block");
				//now.css("left",0);
			}
		});
		
	}
	
 
	//그래프 리사이즈
	chartGraphManager.resize($("#wrap_graph .graph").width() - 10,$("#wrap_graph .graph").height() - 10);
		
	//스크롤바 리사이즈
	$("#scrollBar").width($(window).width());
	$("#scrollBar").height($(window).height());
	$("#scrollBar").perfectScrollbar("update");
};

$(function() {
	$("#scrollBar").perfectScrollbar({wheelSpeed:100});
	timer.indicatorUpdate();
	
	imageSearchCalenar.initialize();
	chartCalendar.initialize();
	$(window).load(function(){
		imageManager1 = new ImageManager();
		imageManager1.initialize($("#imageManager1"));
		//imageManager1.load();
		
		imageManager2 = new ImageManager();
		imageManager2.initialize($("#imageManager2"));
		//imageManager2.load();
	
		imageManager3 = new ImageManager();
		imageManager3.initialize($("#imageManager3"));
		//imageManager3.load();
	
		imageManager4 = new ImageManager();
		imageManager4.initialize($("#imageManager4"));
		//imageManager4.load();
		
		var chartOption = {axisLabelColor:'white'};
		//chartGraphManager.addXRayFlux({axisLabelColor:'white', colors: ['cyan', 'red']});
		//chartGraphManager.addElectronFlux({axisLabelColor:'white', colors: ['cyan', 'red']});
		chartGraphManager.addElectronFluxSWAA(chartOption);
		chartGraphManager.addProtonFlux(chartOption);
		chartGraphManager.addElectronFluxSWAA2(chartOption);
		//chartGraphManager.addGoesMagSWAA(chartOption);
		chartGraphManager.addMagnetopauseRadius(chartOption);
		
		//chartGraphManager.loadOneDayFromNow();
		//chartGraphManager.setAutoRefresh(1000*60*5);
		//chartGraphManager.setAutoRefresh({enable:true});
		chartGraphManager.updateOptions({autoRefresh:true});
		
		setTimeout(onResize,500);
		rollingEvent();
	});
	
	var pop = new Array(10);
	
	
		//도움말 이벤트
	$("#qeu1").click(function(e) {	
		for(var i=0; i<10; i++) {
			if(pop[i] != null) {
				pop[i].focus();	
			}
		}
		pop[0] = window.open("image1.do", 'qeu1','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
		pop[0].focus();
	});  
	$("#qeu2").click(function(e) {	
		for(var i=0; i<10; i++) {
			if(pop[i] != null) {
				pop[i].focus();	
			}
		}
		pop[1] = window.open("rbspInfo.do", 'qeu2','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
		pop[1].focus();
	});
	$("#qeu3").click(function(e) {	
		for(var i=0; i<10; i++) {
			if(pop[i] != null) {
				pop[i].focus();	
			}
		}
		pop[2] = window.open("tecInfo.do", 'qeu3','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
		pop[2].focus();
	});
	$("#qeu4").click(function(e) {	
		for(var i=0; i<10; i++) {
			if(pop[i] != null) {
				pop[i].focus();	
			}
		}
		pop[3] = window.open("infoGraph1.do", 'qeu4','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
		pop[3].focus();
	});
	$("#qeu5").click(function(e) {	
		for(var i=0; i<10; i++) {
			if(pop[i] != null) {
				pop[i].focus();	
			}
		}
		pop[4] = window.open("infoGraph2.do", 'qeu5','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
		pop[4].focus();
	});
	$("#qeu6").click(function(e) {	
		for(var i=0; i<10; i++) {
			if(pop[i] != null) {
				pop[i].focus();	
			}
		}
		pop[5] = window.open("infoGraph3.do", 'qeu6','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
		pop[5].focus();
	});
	$("#qeu7").click(function(e) {	
		for(var i=0; i<10; i++) {
			if(pop[i] != null) {
				pop[i].focus();	
			}
		}
		pop[6] = window.open("infoGraph4.do", 'qeu7','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
		pop[6].focus();
	});
	$("#que_info1").click(function(e) {	
		for(var i=0; i<10; i++) {
			if(pop[i] != null) {
				pop[i].focus();	
			}
		}
		pop[7] = window.open("info2_1.do", 'qeu8','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
		pop[7].focus();
	});
	$("#que_info2").click(function(e) {	
		for(var i=0; i<10; i++) {
			if(pop[i] != null) {
				pop[i].focus();	
			}
		}
		pop[8] = window.open("info2_2.do", 'qeu9','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
		pop[8].focus();
	});
	$("#que_info3").click(function(e) {	
		for(var i=0; i<10; i++) {
			if(pop[i] != null) {
				pop[i].focus();	
			}
		}
		pop[9] = window.open("info2_3.do", 'qeu10','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
		pop[9].focus();
	});
});

var slice = true;	//분할   t:4등분  f : 크게
var play = true;	//재생   t:준비 f : 재생중
var mouseOn = false;	//그래프 마우스 t:마우스 인 f:마우스 아웃
var calendarOn = false; //달력  t:보임 f:숨김
var rolling;
var count;
function graphRolling(){
	if(!slice && !play && !mouseOn && !calendarOn){	//크게 보기, 재생 중, 마우스 아웃상태, 달력/리스트 안보임 일때 >> 다음 그래프 보기
		$(".gr_graph.selected").removeClass("selected");
		$(".gr_graph:eq("+count+")").addClass("selected");
		count++;
		if(count > 3){count = 0;}
		setTimeout(onResize,500);
	}
}
function rollingEvent(){
	//4등분
	$(".slice").on("click",function(e){
		var now = $(this);
		count = now.parents(".gr_graph").index();	//선택 그래프
		var roll = $("#wrap_left_weather");
		if(!roll.hasClass("rolling")){
			slice = false;	//크게 보기
			play = false;	//재생 시작
			roll.addClass("rolling");
			$(".play, .slice").addClass("on");
			now.parents(".gr_graph").addClass("selected");
			//재생
			$(".play").bind("click",function(e){
				$(this).toggleClass("on");
				play = !$(this).hasClass("on");
			});
			//그래프 마우스 오버
			$("#wrap_graph .graph").bind("mouseover", function(e){
				mouseOn = true;
			});
			//그래프 마우스 아웃
			$("#wrap_graph .graph").bind("mouseout", function(e){
				mouseOn = false;
			});
			//rolling = setInterval(graphRolling, 1000*5);	//재생
		}else{			
			$(".gr_graph").css("display", "block");			
			slice = true;
			play = false;
			roll.removeClass("rolling");
			$(".play, .slice").removeClass("on");
			$(".gr_graph.selected").removeClass("selected");
			$(".play, #wrap_graph .graph").unbind("click mouseover mouseout");
			clearInterval(rolling);
			rolling = null;
		}
		setTimeout(onResize,500);
	});
}


function searchChart(type) {
	//var startDate = $("#sd").datepicker('getDate');
	//var endDate = $("#ed").datepicker('getDate');

	//var sd = $.datepicker.formatDate("yymmdd", startDate) + $("#sh").val() + "0000";
	//var ed = $.datepicker.formatDate("yymmdd", endDate) + $("#eh").val() + "0000";
	
	//chartGraphManager.load('20131012121212', '20131212121212');
	 
}

function chartHide(){
	
	$("#calendar_chart .close").click(function(e) {
		chartCalendar.hide();
		e.defaultPrevented = true;
		return false;
	});
	
}

//총전자밀도 1시간 마다 변경
function texImage(year,month,date,hour){
	
	var addr = "<c:url value='/monitorSWAA/loadImageTEC.do?year=" + year
	+ "&month=" + month + "&date=" + date + "&hour=" + hour + "'/>";

	$("#image3 img").attr("src", addr);	
}

function magnetoImage(year,month,date,hour,minute){
	
	var addr = "<c:url value='/monitorSWAA/loadImageMagnetopause.do?year=" + year
	+ "&month=" + month + "&date=" + date + "&hour=" + hour + "&minute=" + minute + "'/>";

	$("#image1 img").attr("src", addr);	
}
</script>
</head>

<body>
	<div id="scrollBar">
		<div id="wrap">
			<div id="header" style="height:78px">
				<h1 class="title">
			    	<img src="<c:url value="/images/monitor/titleSWAA2.png"/>"/>
			    </h1>
				<!-- 
	 -->
				<div class="wrap_time">
					<div class="time utc">
						<p class="tdate" id="utc_date"></p>
						<p class="hms">
							<span id="utc_hour"></span><span id="utc_minute"></span><span
								id="utc_second"></span>
						</p>
					</div>
					<div class="time kst">
						<p class="tdate" id="kst_date"></p>
						<p class="hms">
							<span id="kst_hour"></span><span id="kst_minute"></span><span
								id="kst_second"></span>
						</p>
					</div>
				</div>
			</div>
			<div id="contents">
				<div id="wrap_left_weather">
					<!-- 태양영상 1 -->
					<div class="gr_img_weather" id="imageManager1">
						<div class="header" >
							<h2>
								<!-- <a href="#" class="on" name="SDO__01001">자기권계면</a> -->
								<font color="yellow" id="imgTitle1">자기권계면</font>
							</h2>
							<p class="date">
								<a href="#" class="calendar"><span>달력</span></a> <a
									href="#" class="question" id="qeu1"><span>도움말</span></a>
							</p>
						</div>
						<div class="contents" id="image1">
							<img
								src="<c:url value='/monitorSWAA/loadImageMagnetopause.do?year=${year_kst}&month=${month_kst}&date=${date_kst}&hour=${hour_kst}&minute=${minute_kst}'/>" />
						</div>
					</div>
					<!--  
	태양영상 2 -->
					<div class="gr_img_weather" id="imageManager2">
						<div class="header">
							<h2>
								<!-- <a href="#" class="on" name="SDO__01002">지구 자기권 방사선대(Van Allen Probes)</a> -->
								<font color="yellow" id="imgTitle2">지구 자기권 방사선대(Van Allen Probes)</font>
							</h2>
							<p class="date">
								<a href="#" class="calendar"><span>달력</span></a> <a
									href="#" class="question" id="qeu2"><span>도움말</span></a>
							</p>
						</div>
						<div class="contents" id="image2">
							<img
								src="<c:url value='/monitorSWAA/loadImageRBSP.do?year=${year}&month=${month}&date=${date}'/>" />
						</div>
					</div>
					<!-- 
	태양영상 3  -->
					<div class="gr_img_weather" id="imageManager3">
						<div class="header">
							<h2>
								<!--<a href="#" class="on" name="SDO__01003">총전자밀도(TEC)</a> -->
								<font color="yellow" id="imgTitle3">총전자밀도</font>
							</h2>
							<p class="date">
								<a href="#" class="calendar"><span>달력</span></a> <a
									href="#" class="question" id="qeu3"><span>도움말</span></a>
							</p>
						</div>
						<div class="contents" id="image3">
							<img
								src="<c:url value='/monitorSWAA/loadImageTEC.do?year=${year}&month=${month}&date=${date}&hour=${hour}'/>" />
						</div>
					</div>
					<!-- END 영상 -->

					<!-- END 그래프 -->
				</div>
				<!-- END WRAP LEFT INFO -->
				<div id="wrap_right_weather">
					<div id="wrap_info" >
						<!-- 태양복사폭풍 -->
						<div class="wrap_info" id="info1">
							<div class="header">
								<h2>우주기상 특보상황</h2>
								<p class="date"> 
								<a href="#" class="question" id="que_info1"><span>도움말</span></a>
								</p>
							</div>
							<div class="info_total">
								<div class="sign_wrap" id="infototal">
									<p>기상위성운영</p>
									<div class="signt" id="summary1">
										<span class="num"></span> <span class="txt"></span>
									</div>
								</div>
								<div class="sign_wrap">
									<p>극항로 항공기상</p>
									<div class="signt" id="summary2">
										<span class="num"></span> <span class="txt"></span>
									</div>
								</div>

								<div class="sign_wrap">
									<p>전리권기상</p>
									<div class="signt" id="summary3">
										<span class="num"></span> <span class="txt"></span>
									</div>
								</div>

							</div>
						</div>
						<!-- 태양복사폭풍 -->
						<div class="wrap_info" id="info2">
							<div class="header">
								<h2>정지궤도위성 대전영향</h2>
								<p class="date"> 
								<a href="#" class="question" id="que_info2"><span>도움말</span></a>
								</p>
							</div>
							<div class="info" id="eletron_flux_info">
								<div class="sign">
									<span class="num"></span> <span class="txt"></span>
								</div>
								<p class="m2">
									<span>현재: </span> <span>3시간 최대값: </span> <span> </span> <span>24시간 최대값:
									</span>
								</p>
							</div>
						</div>
						<!-- 태양입자폭풍 -->
						<div class="wrap_info" id="info3">
							<div class="header">
								<h2>자기권계면</h2>
								<p class="date"> 
								<a href="#" class="question" id="que_info3"><span>도움말</span></a>
								</p>
							</div>
							<div class="info" id="magnetopause_radius_info">
								<div class="sign">
									<span class="num"></span> <span class="txt"></span>
								</div>
								<p class="m2">
									<span>현재: </span> <span>3시간 최대값: </span> <span>24시간 최대값:
									</span>
								</p>
							</div>
						</div>


					</div>
					<!-- END WRAP INFO -->
				</div>
				<!-- END WRAP RIGHT INFO -->
			</div>

			<div id="wrap_graph">
				<div class="gr_graph">
					<div class="header">
						<h2>
							<%-- <a href="#" class="on"><span><custom:ChartTItle type="XRAY_FLUX"/></span></a> --%>
							<font color="yellow">전자 플럭스(GOES-13 : 40keV flux)</font>

						</h2>
						<ul class="combo glist">
						</ul>
						<div class="ginfo" id="ELECTRON_FLUX_SWAA_LABELS_DIV"></div>
						<p class="date">
							<a href="#" class="play" title="재생"><span>재생</span></a> <a
								href="#" class="slice" title="롤링"><span>롤링</span></a> <a
								href="#" class="calendar" title="달력"><span>달력</span></a> <a
								href="#" class="detail" title="상세보기"><span>상세보기</span></a> <a
								href="#" class="question" id="qeu4"><span>도움말</span></a>
						</p>
					</div>
					<div class="graph" id="ELECTRON_FLUX_SWAA"></div>
				</div>
				<!--
 END GRAPH 1 -->
				<div class="gr_graph">
					<div class="header">
						<h2>
							<!--<a href="#" class="on"><span><custom:ChartTItle
										type="PROTON_FLUX" /></span></a> -->
							<font color="yellow">양성자 플럭스(GOES-13)</font>			
						</h2>
						<ul class="combo glist">
						</ul>
						<div class="ginfo" id="PROTON_FLUX_LABELS_DIV"></div>
						<p class="date">
							<a href="#" class="play" title="재생"><span>재생</span></a> <a
								href="#" class="slice" title="롤링"><span>롤링</span></a> <a
								href="#" class="calendar" title="달력"><span>달력</span></a> <a
								href="#" class="detail" title="상세보기"><span>상세보기</span></a> <a
								href="#" class="question" id="qeu5"><span>도움말</span></a>
						</p>
					</div>
					<div class="graph" id="PROTON_FLUX"></div>
				</div>
				<!--
 END GRAPH 2 -->
 				<div class="gr_graph">
					<div class="header">
						<h2>
							<%-- <a href="#" class="on"><span><custom:ChartTItle type="XRAY_FLUX"/></span></a> --%>
							<font color="yellow">전자 플럭스(GOES-13 : 2MeV fluence)</font>

						</h2>
						<ul class="combo glist">
						</ul>
						<div class="ginfo" id="ELECTRON_FLUX_SWAA_2_LABELS_DIV"></div>
						<p class="date">
							<a href="#" class="play" title="재생"><span>재생</span></a> <a
								href="#" class="slice" title="롤링"><span>롤링</span></a> <a
								href="#" class="calendar" title="달력"><span>달력</span></a> <a
								href="#" class="detail" title="상세보기"><span>상세보기</span></a> <a
								href="#" class="question" id="qeu6"><span>도움말</span></a>
						</p>
					</div>
					<div class="graph" id="ELECTRON_FLUX_SWAA_2"></div>
				</div>
				<!-- div class="gr_graph">
					<div class="header">
						<h2>
							<font color="yellow">자기장 세기(GOES-13, GOES-15)</font>
						</h2>
						<ul class="combo glist over">
						</ul>
						<div class="ginfo" id="GOES_MAG_SWAA_LABELS_DIV"></div>
						<p class="date">
							<a href="#" class="play" title="재생"><span>재생</span></a> <a
								href="#" class="slice" title="롤링"><span>롤링</span></a> <a
								href="#" class="calendar" title="달력"><span>달력</span></a> <a
								href="#" class="detail" title="상세보기"><span>상세보기</span></a> <a
								href="#" class="question" id="qeu6"><span>도움말</span></a>
						</p>
					</div>
					<div class="graph" id="GOES_MAG_SWAA"></div>
				</div> -->
				<!--
 END GRAPH 3 -->
				<div class="gr_graph">
					<div class="header">
						<h2>
							<!-- <a href="#" class="on"><span><custom:ChartTItle
										type="MAGNETOPAUSE_RADIUS" /></span></a> -->
							<font color="yellow">자기권계면</font>
						</h2>
						<ul class="combo glist over">
						</ul>
						<div class="ginfo" id="MAGNETOPAUSE_RADIUS_LABELS_DIV"></div>
						<p class="date">
							<a href="#" class="play" title="재생"><span>재생</span></a> <a
								href="#" class="slice" title="롤링"><span>롤링</span></a> <a
								href="#" class="calendar" title="달력"><span>달력</span></a> <a
								href="#" class="detail" title="상세보기"><span>상세보기</span></a> <a
								href="#" class="question" id="qeu7"><span>도움말</span></a>
						</p>
					</div>
					<div class="graph" id="MAGNETOPAUSE_RADIUS"></div>
				</div>
				<!-- END GRAPH 4 -->
			</div>
			<!-- END CONTENTS  -->
		</div>
		<!-- END WRAP -->
	</div>

	<!-- 레이어 // 태양영상 달력 -->
	<div class="layer" style="top: 135px; left: 592px; display: none;"
		id="calendar_image">
		<div class="layer_contents">
			<p>
				<label>날짜</label> <input id="calendar_image_date" type="text"
					size="12" readonly="readonly" />
			</p>
			<p>
				<label>시</label> <select name="" id="calendar_image_hour">
					<c:forEach begin="0" end="23" var="item">
						<option
							value="<fmt:formatNumber minIntegerDigits="2" value="${item}"/>"><fmt:formatNumber
								minIntegerDigits="2" value="${item}" /></option>
					</c:forEach>
				</select>
			</p>
			<p>
				<label>분</label> <select name="" id="calendar_image_min">
					<c:forEach begin="0" end="50" var="item" step="10">
						<option
							value="<fmt:formatNumber minIntegerDigits="2" value="${item}"/>"><fmt:formatNumber
								minIntegerDigits="2" value="${item}" /></option>
					</c:forEach>
				</select>
			</p>

			<input type="button" class="btn" value="확인" /> <a href="#"
				class="close"><span>영상선택</span></a>
		</div>
	</div>

	<!-- 레이어 // 그래프 달력 -->
	<div class="layer" style="display: none;" id="calendar_chart">
		<div class="layer_contents">
			<p>
				<label>시작일</label> <input type="text" size="12"
					id="calendar_chart_start_date" />
			</p>
			<p>
				<label>종료일</label> <input type="text" size="12"
					id="calendar_chart_end_date" />
			</p>

			<input type="button" class="btn" value="검색" /> <a href="#"
				class="close"><span>영상선택</span></a>
		</div>
	</div>
</body>
</html>