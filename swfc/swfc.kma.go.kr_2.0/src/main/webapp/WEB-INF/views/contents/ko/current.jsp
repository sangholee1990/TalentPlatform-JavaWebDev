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
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/js/plugin/datetimepicker-master/jquery.datetimepicker.css"/>"  />
<style>
.dygraph-ylabel{
	font-weight: bold;
	color:white;
}

.chart-on {
	border: solid 1px white;

}
</style>
<jsp:include page="/WEB-INF/views/include/jquery.jsp" />
<jsp:include page="/WEB-INF/views/include/jquery-ui.jsp" />
<jsp:include page="/WEB-INF/views/include/dygraph.jsp" />
<script type="text/javascript" src="<c:url value="/resources/common/js/plugin/datetimepicker-master/jquery.datetimepicker.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/common/js/date.format.js"/>"></script>
<script type="text/javascript">

var imageManager1 = null;
var imageManager2 = null;
var imageManager3 = null;
var imageManager4 = null;

//var timer =  {
//		date: new Date(),
//		imageTimer: setInterval("timer.imageUpdate()", 1000*60*5),
//		imageUpdate: function() {
//			imageManager1.load();
//			imageManager2.load();
//			imageManager3.load();
//			imageManager4.load();
//		}		
//	};
	
var refreshTime = 5;

var time = null;
var timer = {
	start : function(){
		if(time == null){
			time = setInterval("timer.update()", 1000 * 60 * refreshTime);
		}
	},
	stop : function(){
		if(time != null){
			clearInterval(time);
			time = null;
		}
	},
	update : function(){
		timer.imageUpdate();
		timer.indicatorUpdate();
		chartGraphManager.autoRefresh();
	},
	imageUpdate : function(){
		imageManager1.load();
		imageManager2.load();
		imageManager3.load();
		imageManager4.load();
	},
	indicatorUpdate: function() {
		$.ajax({
			url : "<c:url value="/ko/monitor/summary.do"/>"
		}).done(function(data) {
			var result = data.summary;
			setSummaryValue($(".sign.sat2"), result.notice1);
			setSummaryValue($(".sign.pol2"), result.notice2);
			setSummaryValue($(".sign.ion2"), result.notice3);
		
			setElementInfo($(".group1"), result.XRAY_NOW, result.XRAY_H3);
			setElementInfo($(".group2"), result.PROTON_NOW, result.PROTON_H3);
			setElementInfo($(".group3"), result.KP_NOW, result.KP_H3);
			setElementInfo($(".group4"), result.MP_NOW, result.MP_H3);
		});	
	}
	
};

function setSummaryValue(obj, data) {
	obj.removeClass("w g b y o r");
	var textObj = obj.children();
	if(data != null) {
		switch(data.code) {
		case 0:
			obj.addClass("w");
			break;
		case 1:
			obj.addClass("g");
			break;
		case 2:
			obj.addClass("b");
			break;
		case 3:
			obj.addClass("y");
			break;
		case 4:
			obj.addClass("o");
			break;
		case 5:
			obj.addClass("r");
			break;
		};
		textObj.text(data.code);
	} else {
		textObj.text("0"); 
	}
}

function toExponential(val) {
	return (val > 10000 || val < 0.0001)?val.toExponential():val;
}

function setElementInfo(obj, now, h3) {
	var sign = obj.find(".sign");
	var message = obj.find(".message");
	sign.removeClass("w g b y o r");
	message.removeClass("fw fg fb fy fo fr");

	var signText = "";
	var messageText = "없음";
	var H0Text = "";
	var H3Text = "";
	var date = "()";

	if(now != null) {
		H0Text = toExponential(now.val);
	}
	
	if(h3 != null) {
		switch(h3.code) {
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
		
		signText = h3.grade;
		messageText = h3.gradeText;
		
		var month = h3.tm.substring(4, 6);
		var day = h3.tm.substring(6, 8);
		var hour = h3.tm.substring(8, 10);
		var minute = h3.tm.substring(10, 12);
		H3Text = toExponential(h3.val);
		date = " (" + month + "." + day + " " + hour + ":" + minute + ")";
	}
	
	sign.children().text(signText);
	message.text(messageText);
	
	obj.find(".now").text(H0Text);
	obj.find(".max").text(H3Text);
	obj.find(".date").text(date);
	
}

var imageSearchCalenar = {
		imageManager: null,
		initialize: function() {
			var datepickerOption = {
				changeYear:true,
				showOn: "button",
				buttonImage: '<c:url value="/resources/ko/images/btn_calendar.png"/>', 
				buttonImageOnly: true,
				buttonText:'달력',
				onSelect: function(dateText) {
					imageSearchCalenar.updateMinuteList();
				}
			};
			$("#calendar_image_date").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
			
			$("#calendar_image_hour").change(function() {
				imageSearchCalenar.updateMinuteList();
			});
			
			$("#calendar_image .btn").click(function(e) {
				var data = $("#calendar_image_minute option:selected").data();
				if(data != null) {
					imageSearchCalenar.imageManager.setRealtime(false);
					imageSearchCalenar.imageManager.updateData(data);
					imageSearchCalenar.hide();
				} else {
					alert("검색 결과가 없습니다!");
				}
				e.defaultPrevented = true;
				return false;
			});
			
			$("#calendar_image .close").click(function() {
				$("#calendar_image").hide();
			});
		},
		
		updateMinuteList: function() {
			var date = $("#calendar_image_date").val();
			var hour = $("#calendar_image_hour").val();
			var code = imageSearchCalenar.imageManager.currentData.code;
			var createDate = date.replace(/-/gi, '') + hour;
			$.getJSON("<c:url value="/ko/monitor/search_by_code.do"/>", {
				code : code,
				createDate: createDate
			}).success(function(resultData) {
				var data = resultData.data;
				var minuteObj = $("#calendar_image_minute");
				minuteObj.empty();
				//alert(data.data.length);
				$.each(data, function(key, val) {
					var date = new Date(val.createDate);
					//alert(date);
					var minute = date.format("MM");
					var option = $("<option>", {value:minute, text:minute, data:val});
					minuteObj.append(option);
				});
			});

		},
		
		show: function(manager, offset) {
			this.imageManager = manager;
			$("#calendar_image_date").val(manager.currentDate.format("yyyy-mm-dd"));
			$("#calendar_image_hour").val(manager.currentDate.format("HH"));
			var minuteObj = $("#calendar_image_minute");
			minuteObj.empty();
			if(manager.dataList != null) {
				$.each(manager.dataList, function(key, val) {
					var date = new Date(val.createDate);
					var minute = date.format("MM");
					var option = $("<option>", {value:minute, text:minute, data:val});
					minuteObj.append(option);
				});
			}
			minuteObj.val(manager.currentDate.format("MM"));
			var calenar = $("#calendar_image"); 
			calenar.css('top', offset.top+25);
			calenar.css('left', offset.left-139);
			calenar.show();
		},
		hide: function() {
			$("#calendar_image").hide();
		}
	};
	
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

ImageManager.prototype.initialize = function(container) {
	var manager = this;
	this.container = container;
	this.imageTypeList = container.find(".title .select_list");
	this.title = container.find(".top_con span.select_box");
	this.dateLabel = container.find(".title .top_con span.t_date");
	this.image = container.find(".contents > img");
	var layer = this.container.find('.select_list');
	
	//위성 레이어 선택
	this.container.find(".title .top_con a img").click(function(e) {
		imageSearchCalenar.hide();
		if(layer.css("display") == "none"){
			layer.show();
		}else{
			layer.hide();
		}
		e.defaultPrevented = true;
		return false;
	});
	
	this.imageTypeList.children("li").click(function(e) {
		manager.container.find(".vod").removeClass("play");
		manager.viewMovie = false;
		
		var code = $(this).attr("code");
		var text = $(this).text();
		manager.title.text(text);
		manager.title.attr("name", code);
		manager.imageTypeList.hide();
		manager.load();
		e.defaultPrevented = true;
		return false;
	});
	
	this.title.click(function(e) {
		manager.realtime = true;
		manager.load();
	});
	
	this.container.find(".title .top_con button.cal").click(function(e) {
		var buttonOffset = $(this).offset();
		imageSearchCalenar.show(manager, buttonOffset);

		e.defaultPrevented = true;
		return false;
	});
	
	this.container.find(".title .top_con button.vod").click(function(e) {
		$(this).parent().parent().parent().children(".contents").children(".loading_mask").css("display", "block");
		
		$(this).toggleClass("play");
		manager.viewMovie = $(this).hasClass("play");
		manager.load();
		
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

ImageManager.prototype.load = function(param) {
	var options = $.extend({createDate: null}, param);
	var manager = this;
	var code = this.title.attr("name");
	if(this.isRealtime()) {
		$.getJSON("<c:url value="/ko/monitor/search_by_code.do"/>", {
			code : code,
			createDate: options.createDate
		}).success(function(resultData) {
			var data = resultData.data;
			manager.dataList = data;
			if(data != null && data.length > 0) {
				manager.updateData(data[data.length-1]);	
			} else {
				manager.updateData(null);
			}
		}).error(function() {
			//alert("image manger load Error");
		});
	}
}

ImageManager.prototype.updateData = function(data) {
	this.currentData = data;
	if(data != null) {
		var date = new Date(data.createDate);
		this.setDate(date);
		if(this.viewMovie) {
 			this.image.attr("src", "<c:url value="/ko/monitor/view_movie.do"/>?id=" + data.id + "&size=512&frames=50");
 			this.image.attr("alt", "<c:url value="/ko/monitor/view_movie.do"/>?id=" + data.id + "&size=512&frames=50");
			//this.image.attr("src", "<c:url value="http://swfc.kma.go.kr/monitor/view_movie.do"/>?id=" + data.id + "&size=512&frames=100");
			//this.image.attr("alt", "<c:url value="http://swfc.kma.go.kr/monitor/view_movie.do"/>?id=" + data.id + "&size=512&frames=100");
		} else {
			this.image.attr("src", "<c:url value="/ko/monitor/view_browseimage.do"/>?id=" + data.id);
			this.image.attr("alt", "<c:url value="/ko/monitor/view_browseimage.do"/>?id=" + data.id);
			//this.image.attr("src", "<c:url value="http://swfc.kma.go.kr/monitor/view_browseimage.do"/>?id=" + data.id);
			//this.image.attr("alt", "<c:url value="http://swfc.kma.go.kr/monitor/view_browseimage.do"/>?id=" + data.id);
		}
	} else {
		this.updateDate(null);
		this.image.attr("src", "");
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

var chartCalendar = {
	calenarButton: null,
	initialize: function() {
		var datepickerOption = {
			changeYear:true,
			showOn: "button",
			buttonImage: '<c:url value="/resources/ko/images/btn_calendar.png"/>', 
			buttonImageOnly: true
		};

		$(".s_info .calendar").click(function(e) {
			chartCalendar.show($(this));
			e.defaultPrevented = true;
			return false;
		});
		
		$("#calendar_chart_start_date").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
		$("#calendar_chart_end_date").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
		
		var sd = "<fmt:formatDate value="${startDate}" pattern="yyyyMMddHH" timeZone="UTC"/>";
		var ed = "<fmt:formatDate value="${endDate}" pattern="yyyyMMddHH" timeZone="UTC"/>";
		
		$(".s_info .calendar").each(function() {
			var calenarButton = $(this);
			var chartType = calenarButton.parents(".s_info").children('.body').attr('id');
			$(this).data({
				type:	chartType,
				autoRefresh: true,
				sd: sd,
				ed: ed
			});
			
			calenarButton.parents(".title").find('h5').click(function(e) {
				//$(this).addClass("on");
				$(this).next().next().toggle();
				var data = calenarButton.data();
				e.defaultPrevented = true;
				return false;
			});
			
			//*****추가
			calenarButton.parents(".title").find('.select_list li').click(function(e) {
				
				$(this).parent().hide();
				
				var selected = $(this);
				var type = selected.attr("code");
				
				var removeId = selected.parents(".s_info").find(".body").attr("id");
				var data = calenarButton.data();
					
				if(type  != removeId){
					data.type = type;
					data.popup = type;
					chartGraphManager.remove(removeId,"");
					var idx = "";
					if($("#" + type).length > 0){
						idx = selected.parents(".s_info").index();
						data.type = type + idx;
					}
						
					selected.parents(".title").find('h5').text(selected.text());
					var div = selected.parents(".s_info").find('.graph_info').attr({"id":type + "_LABELS_DIV" + idx});
					var box = selected.parents(".s_info").find(".body").attr({"id":type + idx}).empty();
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
						chartGraphManager.addMagnetopauseRadius({axisLabelColor:'white', colors: ['red'], "div" : div, "box" : box});
					}else if(type == "XRAY_FLUX"){	//X-선 플럭스
						chartGraphManager.addXRayFlux({axisLabelColor:'white', colors: ['cyan', 'red'], "div" : div, "box" : box});
					}else if(type == "PROTON_FLUX"){	//양성자 플럭스
						chartGraphManager.addProtonFlux(chartOption);
					}else if(type == "ELECTRON_FLUX"){	//전자기 플럭스
						chartGraphManager.addElectronFlux({axisLabelColor:'white', colors: ['cyan', 'red'], "div" : div, "box" : box});
					}else if(type == "KP_INDEX_SWPC"){	//Kp 지수
// 						chartGraphManager.addKpIndexSwpc(chartOption);
						chartGraphManager.addKpIndexSwpc({axisLabelColor:'white', colors: ['orange'], "div" : div, "box" : box});
					}else if(type == "DST_INDEX_KYOTO"){ //Dst 지수
						chartGraphManager.addDstIndexKyoto({axisLabelColor:'white', colors: ['red'], "div" : div, "box" : box});
					}
					
					var date = new Date();
					date.setHours(date.getHours() + 1);
					var ed = chartGraphManager.getUTCDateString(date);
					date.setDate(date.getDate() -1);
					var sd = chartGraphManager.getUTCDateString(date);
					
					data.sd = sd.substring(0, 10);
					data.ed = ed.substring(0, 10);
					
					chartGraphManager.resize($("#wrap_graph .graph").width(),$("#wrap_graph .graph").height());
					
				}
				
				data.autoRefresh = true;
				//chartGraphManager.setAutoRefreshLayer(data.type, true);
				chartGraphManager.load(data);
					
				e.defaultPrevented = true;
				return false;
			});
			
			//*****추가
			
		});
		
		$(".s_info .detail").click(function(e) {
			var calendarButton = $(this).prev();
			var data = calendarButton.data();
			var url = "<c:url value='/ko/currentPop.do'/>?" + $.param(calendarButton.data());
			if(data.popup != null){
				url = "<c:url value='/ko/currentPop.do'/>?type=" + data.popup + "&sd=" + data.sd +"&ed=" + data.ed + "&autoRefresh=" + data.autoRefresh;
			}
			
			window.open(url, '_blank','width=1024,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
			e.defaultPrevented = true;
			return false;
		});
			
		$("#calendar_layer .btn").click(function(e) {
			e.defaultPrevented = true;
			var calenarButton = chartCalendar.calenarButton;
			var chartType = calenarButton.data().type;
			var data = calenarButton.data();
			
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
			var sd = startDateVal.replace(/-/gi, '')  + "00";
			var ed = endDateVal.replace(/-/gi, '') + "23";
				
			calenarButton.data({
				sd: sd,
				ed: ed,
				autoRefresh: false
			});
				
			chartGraphManager.load({
				sd : sd,
				ed : ed,
				type: chartType
			});
			
			chartCalendar.hide();
			return false;
		});
			
		$("#calendar_layer .close").click(function(e) {
			chartCalendar.hide();
			e.defaultPrevented = true;
			return false;
		});
	},	
	show: function(calendarButton) {
		chartCalendar.calenarButton = calendarButton;
		
		var offset = calendarButton.offset();
		//var calendarData = calendarButton.data();
		var calenar = $("#calendar_layer");
		calenar.css('top', offset.top+25);
		calenar.css('left', offset.left-139);
		$("#ui-datepicker-div").css("z-index", 20);
		calenar.show();
	},
	hide: function() {
		$("#calendar_layer").hide();
	}	
	
};

$(function() {
	
	
	timer.start();
	$("#refresh_time").change(function(){
		refreshTime = $(this).val();
		timer.stop();
		if(refreshTime != 0){
			timer.start();
		}
	});
	imageSearchCalenar.initialize();
	chartCalendar.initialize();
	
	var chartOption = {axisLabelColor:'white'};
	chartGraphManager.addXRayFlux({axisLabelColor:'white', colors: ['cyan', 'red']});
	chartGraphManager.addProtonFlux(chartOption);
	chartGraphManager.addKpIndexSwpc({axisLabelColor:'white', colors: ['orange']});
	chartGraphManager.addMagnetopauseRadius({axisLabelColor:'white', colors: ['red']});
	chartGraphManager.updateOptions({autoRefresh:true});
	
	$(".s_sun").each(function() {
		$(this).children(".contents").children("img").on("load", function() {
			$(this).parent().children(".loading_mask").css("display", "none");
			$(this).parent().children(".loading_mask").children("img").css("margin-top", "140px");
		});
	});
	
	imageManager1 = new ImageManager();
	imageManager1.initialize($("#imageManager1"));
	imageManager1.load();
	
	imageManager2 = new ImageManager();
	imageManager2.initialize($("#imageManager2"));
	imageManager2.load();

	imageManager3 = new ImageManager();
	imageManager3.initialize($("#imageManager3"));
	imageManager3.load();

	imageManager4 = new ImageManager();
	imageManager4.initialize($("#imageManager4"));
	imageManager4.load();
	
	//$(window).load(function(){
	//});
	
	/*
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
		var url = "<c:url value="/current/pop"/>?" + $.param(dataHolder.data());
		window.open(url, '_blank','width=1024,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
		
		e.defaultPrevented = true;
		return false;
	});
	
	$("#calendar_search_date").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
	$("#calendar_time_layer a.close").click(function(e) {
		$("#calendar_time_layer").hide();
		e.defaultPrevented = true;
		return false;
	});
	
	
	var calendarTimeButtons = $("#wrap_current .wrap_sun button.cal"); 
	calendarTimeButtons.click(function(e) {
		var button = $(this);
		var buttonIndex = calendarTimeButtons.index(button);
		var calendar = $("#calendar_time_layer");
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
	
	var sunSatCategoryButtons = $('#wrap_current .wrap_sun span.select_box');
	sunSatCategoryButtons.click(function(e) {
		var button = $(this);
		var buttonIndex = sunSatCategoryButtons.index(button);
		var layer = $(".select_list:eq("+buttonIndex+")");
		if(layer.css("display") == "none"){
			layer.show();
		}else{
			layer.hide();
		}
		e.defaultPrevented = true;
		return false;
	});
	
	var sunSatButtons = $('#wrap_current .wrap_sun ul.select_list li');
	sunSatButtons.click(function(e) {
		var button = $(this);
		var buttonIndex = sunSatButtons.index(button);
		alert(buttonIndex);
		e.defaultPrevented = true;
		return false;
	});
	*/
	
	$('.groupLink').on('mouseover',function(event){
		event.preventDefault();
		$('#' + $(this).attr('target-role-id')).addClass('chart-on');
	});
	$('.groupLink').on('mouseout',function(event){
		event.preventDefault();
		$('#' + $(this).attr('target-role-id')).removeClass('chart-on');
		
	});

	
	
	
	
});
</script>
<style>
	.s_info .select_list{z-index:999;display:none;}
.s_info .title h5{float: left;padding-left:25px;background: url('<c:url value="/resources/ko/images/ico_arrow.png"/>') 4px 9px no-repeat;cursor: pointer;}

.cgroup .title {position: relative;}
.cgroup .title .top_con{float:left;height:32px;line-height: 32px;overflow: hidden;}
.cgroup .title .top_con > .arrow{float:left;cursor: pointer;margin-top:11px;margin-right:4px;margin-left: 2px;vertical-align: middle;}
.cgroup .title .top_con .select_box{float:left;display:block;font-size:13px;font-weight:bold;width: 130px;cursor: pointer;}
.cgroup .title .top_con .t_date{float:left;display:block;font-size:12px;letter-spacing:-1px;font-weight:bold;width: 95px;}
.cgroup .title .select_list{position: absolute;top:30px;left:0;list-style: none;padding:0;margin:0;}
.cgroup .title .select_list > li{padding:5px 10px;background: gray;border-top:1px solid #ffffff;cursor: pointer;}
.cgroup .title .select_list > li:hover{background: #555}
.cgroup .title .select_list > li.selected{background: #000;}
.cgroup .title .select_list > li:FIRST-CHILD {border:none;}

	
	.cgroup .title .top_con > .cal{
		display:block;
		background-image: url('<c:url value="/resources/ko/images/ico.png"/>'); 
		width:23px;
		height: 23px;
		background-position: -1px -1px;
		margin-right:2px;
		vertical-align: middle;
		float:left;
		margin-top:4px;
	}
	
	.cgroup .title .top_con > .vod{
		display:block;
		width:23px;
		height: 23px;
		vertical-align: middle;
		background:url('<c:url value="/resources/ko/images/ico.png"/>') no-repeat -51px -1px;
		margin-top:4px;
	}
	
	.cgroup .title .top_con > .play{
		display:block;
		width:23px;
		height: 23px;
		background:url('<c:url value="/resources/ko/images/ico.png"/>') no-repeat -76px -1px;
		vertical-align: middle;
		margin-top:4px;
	}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/topMenu.jsp"/>
<div id="wrap_current">
	<h3 class="sun"><span>태양영상</span></h3>
	<p class="refresh">
		<label class="refresh_btn" for="refresh_time">자동 갱신 : 
		<select id="refresh_time">
			<option value="0">정지</option>
			<option value="0.5">30 초</option>
			<option value="1">1 분</option>
			<option value="5" selected>5 분</option>
			<option value="10">10 분</option>
			<option value="30">30 분</option>
			<option value="60">1 시간</option>
		</select> 
		</label>
	</p>
	<div class="wrap_sun">
        <div class="cgroup s_sun" id="imageManager1">
        	<div class="title">
        		<div class="top_con">
        			<a href="#" class="arrow"><img src="<c:url value="/resources/ko/images/ico_arrow.png"/>" alt="" /></a>
        			<span class="select_box on" name="SDO__01001">SDO/AIA 0131</span><span class="t_date"></span> 
        			<button class="cal" title="검색"></button> 
        			<button class="vod" title="동영상"></button> 
        		 </div>
        		<ul class="select_list" style="display: none; z-index: 999;">
        			<li code="SDO__01001">SDO/AIA 0131</li>
        			<li code="SDO__01002">SDO/AIA 0171</li>
        			<li code="SDO__01003">SDO/AIA 0193</li>
        			<li code="SDO__01004">SDO/AIA 0211</li>
        			<li code="SDO__01005">SDO/AIA 0304</li>
        			<li code="SDO__01006">SDO/AIA 1600</li>
        			<li code="SOHO_01001">SOHO/LASCO C2</li>
        			<li code="SOHO_01002">SOHO/LASCO C3</li>
        			<li code="STA__01001">STA/COR1</li>
        			<li code="STA__01002">STA/COR2</li>
        			<li code="STB__01001">STB/COR1</li>
        			<li code="STB__01002">STB/COR2</li>
        		</ul>
        		<!-- 
            	<h5>${imageList.SDO__01001.codeText}</h5>
        		 -->
            </div>
            <div class="body s_sun contents" style="position: relative;">
            	<div class="loading_mask" style="position:absolute; text-align:center; display:block; width: 295px; height: 295px;">
            		<img src="<c:url value="/resources/ko/images/ajax-loader5.gif" />" style="width: 128px; height: 15px; margin-top:155px;" />
            		<div style="position: absolute; top: 0px;  width: 100%; height: 100%; background-color: gray; opacity:0.4;"></div>
            	</div>
            	<img src="<c:url value="/resources/ko/images/noimg250.gif"/>" alt="" style="width:100%;max-height:100%;"/>
            </div>
        </div>
        
        <div class="cgroup s_sun" id="imageManager2">
        	<div class="title">
            	<div class="top_con">
            		<a href="#" class="arrow"><img src="<c:url value="/resources/ko/images/ico_arrow.png"/>" alt="" /></a>
        			 <span class="select_box  on" name="SDO__01002">SDO/AIA 0171</span><span class="t_date"></span> 
        			<button class="cal" title="검색"></button> 
        			<button class="vod" title="동영상"></button> 
        		</div>
        		<ul class="select_list" style="display: none; z-index: 999;">
        			<li code="SDO__01001">SDO/AIA 0131</li>
        			<li code="SDO__01002">SDO/AIA 0171</li>
        			<li code="SDO__01003">SDO/AIA 0193</li>
        			<li code="SDO__01004">SDO/AIA 0211</li>
        			<li code="SDO__01005">SDO/AIA 0304</li>
        			<li code="SDO__01006">SDO/AIA 1600</li>
        			<li code="SOHO_01001">SOHO/LASCO C2</li>
        			<li code="SOHO_01002">SOHO/LASCO C3</li>
        			<li code="STA__01001">STA/COR1</li>
        			<li code="STA__01002">STA/COR2</li>
        			<li code="STB__01001">STB/COR1</li>
        			<li code="STB__01002">STB/COR2</li>
        		</ul>
            </div>
            <div class="body s_sun contents" style="position: relative;">
            	<div class="loading_mask" style="position:absolute; text-align:center; display:block; width: 295px; height: 295px;">
            		<img src="<c:url value="/resources/ko/images/ajax-loader5.gif" />" style="width: 128px; height: 15px; margin-top:155px;" />
            		<div style="position: absolute; top: 0px;  width: 100%; height: 100%; background-color: gray; opacity:0.4;"></div>
            	</div>
            	<img src="<c:url value="/resources/ko/images/noimg250.gif"/>" alt="" style="width:100%;max-height:100%"/>
            </div>
        </div>
        
        <div class="cgroup s_sun" id="imageManager3">
        	<div class="title">
        		<div class="top_con">
        			<a href="#" class="arrow"><img src="<c:url value="/resources/ko/images/ico_arrow.png"/>" alt="" /></a>
        			<span class="select_box on" name="SDO__01003">SDO/AIA 0193</span><span class="t_date"></span> 
        			<button class="cal" title="검색"></button> 
        			<button class="vod" title="동영상"></button> 
        		 </div>
        		<ul class="select_list" style="display: none; z-index: 999;">
        			<li code="SDO__01001">SDO/AIA 0131</li>
        			<li code="SDO__01002">SDO/AIA 0171</li>
        			<li code="SDO__01003">SDO/AIA 0193</li>
        			<li code="SDO__01004">SDO/AIA 0211</li>
        			<li code="SDO__01005">SDO/AIA 0304</li>
        			<li code="SDO__01006">SDO/AIA 1600</li>
        			<li code="SOHO_01001">SOHO/LASCO C2</li>
        			<li code="SOHO_01002">SOHO/LASCO C3</li>
        			<li code="STA__01001">STA/COR1</li>
        			<li code="STA__01002">STA/COR2</li>
        			<li code="STB__01001">STB/COR1</li>
        			<li code="STB__01002">STB/COR2</li>
        		</ul>
        		<!-- 
            	<h5>${imageList.SDO__01005.codeText}</h5>
        		 -->
            </div>
            <div class="body s_sun contents" style="position: relative;">
            	<div class="loading_mask" style="position:absolute; text-align:center; display:block; width: 295px; height: 295px;">
            		<img src="<c:url value="/resources/ko/images/ajax-loader5.gif" />" style="width: 128px; height: 15px; margin-top:155px;" />
            		<div style="position: absolute; top: 0px;  width: 100%; height: 100%; background-color: gray; opacity:0.4;"></div>
            	</div>
            	<img src="<c:url value="/resources/ko/images/noimg250.gif"/>" alt="" style="width:100%;max-height:100%"/>
            </div>
        </div>
        
        <div class="cgroup s_sun" id="imageManager4">
        	<div class="title">
        		<div class="top_con">
        			<a href="#" class="arrow"><img src="<c:url value="/resources/ko/images/ico_arrow.png"/>" alt="" /></a>
        			<span class="select_box on" name="SDO__01004">SDO/AIA 0211</span><span class="t_date"></span> 
        			<button class="cal" title="검색"></button> 
        			<button class="vod" title="동영상"></button> 
        		 </div>
        		<ul class="select_list" style="display: none; z-index: 999;">
        			<li code="SDO__01001">SDO/AIA 0131</li>
        			<li code="SDO__01002">SDO/AIA 0171</li>
        			<li code="SDO__01003">SDO/AIA 0193</li>
        			<li code="SDO__01004">SDO/AIA 0211</li>
        			<li code="SDO__01005">SDO/AIA 0304</li>
        			<li code="SDO__01006">SDO/AIA 1600</li>
        			<li code="SOHO_01001">SOHO/LASCO C2</li>
        			<li code="SOHO_01002">SOHO/LASCO C3</li>
        			<li code="STA__01001">STA/COR1</li>
        			<li code="STA__01002">STA/COR2</li>
        			<li code="STB__01001">STB/COR1</li>
        			<li code="STB__01002">STB/COR2</li>
        		</ul>
        		<!-- 
            	<h5>${imageList.SDO__01004.codeText}</h5>
        		 -->
            </div>
            <div class="body s_sun contents" style="position: relative;">
            	<div class="loading_mask" style="position:absolute; text-align:center; display:block; width: 295px; height: 295px;">
            		<img src="<c:url value="/resources/ko/images/ajax-loader5.gif" />" style="width: 128px; height: 15px; margin-top:155px;" />
            		<div style="position: absolute; top: 0px;  width: 100%; height: 100%; background-color: gray; opacity:0.4;"></div>
            	</div>
            	<img src="<c:url value="/resources/ko/images/noimg250.gif"/>" alt="" style="width:100%;max-height:100%;"/>
            </div>
        </div>
	</div>
    <!-- END 태양영상 -->
    
    <h3 class="alert"><span>예특보상황</span> <a href="<c:url value="/ko/intro.do?tab=alert#newsflashHelp1"/>" title="도움말 페이지 이동" class="manual size16"><span>도움말</span></a></h3>
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
        
        <div class="group s_alert groupLink group1" target-role-id="XRAY_FLUX">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_rad.png"/>" alt="태양복사폭풍" />
            	<!-- 
            	<a href="/" title="도움말 페이지 이동" class="manual size16"><span>도움말</span></a>
            	 -->
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.XRAY_H3}"/>">
					<p>${summary.XRAY_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.XRAY_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<div class="infotext">
					<p class="message fw">${summary.XRAY_H3.gradeText}</p> 
					<p>현재 : <span class="now">${summary.XRAY_NOW.val}</span> (W/m2)</p>
					<p>
					<c:choose>
						<c:when test="${summary.XRAY_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : <span class="max">${summary.XRAY_H3.val}</span> (W/m2)</p>
					<p class="date"><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></p>
				</div>
			</div>            
        </div>
        <!-- END 태양복사폭풍 -->
        <div class="group groupLink group2" target-role-id="PROTON_FLUX">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_par.png"/>" alt="태양입자폭풍" />
            	<!-- 
            	<a href="/" title="도움말 페이지 이동" class="manual size16"><span>도움말</span></a>
            	 -->
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.PROTON_H3}"/>">
					<p>${summary.PROTON_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.PROTON_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<div class="infotext">
					<p class="message fw">${summary.PROTON_H3.gradeText}</p> 
					<p>현재 : <span class="now">${summary.PROTON_NOW.val}</span> (pfu)</p>
					<p>
					<c:choose>
						<c:when test="${summary.PROTON_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : <span class="max">${summary.PROTON_H3.val}</span> (pfu)</p>
					<p class="date"><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></p>
				</div>
			</div>            
        </div>
        <!-- END 태양입자폭풍 -->
        <div class="group groupLink group3" target-role-id="KP_INDEX_SWPC">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_ter.png"/>" alt="지자기폭풍" />
            	<!-- 
            	<a href="/" title="도움말 페이지 이동" class="manual size16"><span>도움말</span></a>
            	 -->
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.KP_H3}"/>">
					<p>${summary.KP_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.KP_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<div class="infotext">
					<p class="message fw">${summary.KP_H3.gradeText}</p> 
					<p>현재 : <span class="now">${summary.KP_NOW.val}</span></p>
					<p>
					<c:choose>
						<c:when test="${summary.KP_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : <span class="max">${summary.KP_H3.val}</span></p>
					<p class="date"><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></p>
				</div>
			</div>            
        </div>
        <!-- END 지자기폭풍 -->
        <div class="group groupLink group4" target-role-id="MAGNETOPAUSE_RADIUS">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_mag.png"/>" alt="자기권계면" />
            	<!-- 
            	<a href="/" title="도움말 페이지 이동" class="manual size16"><span>도움말</span></a>
            	 -->
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.MP_H3}"/>">
					<p>${summary.MP_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.MP_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<div class="infotext">
					<p class="message fw">${summary.MP_H3.gradeText}</p> 
					<p>현재 : <span class="now">${summary.MP_NOW.val}</span> (RE)</p>
					<p>
					<c:choose>
						<c:when test="${summary.MP_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : <span class="max">${summary.MP_H3.val}</span> (RE)</p>
					<p class="date"><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></p>
				</div>
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
                    <a href="#" class="calendar" title="검색 기간"><span>달력</span></a>
                    <a href="#" class="detail" title="상세보기"><span>상세보기</span></a>
                </p>
                <ul class="select_list" >
        			<li code="ACE_MAG">ACE IMF 자기장</li>
        			<li code="ACE_SOLARWIND_SPD">ACE 태양풍 속도</li>
        			<li code="ACE_SOLARWIND_DENS">ACE 태양풍 밀도</li>
        			<li code="ACE_SOLARWIND_TEMP">ACE 태양풍 온도</li>
        			<li code="MAGNETOPAUSE_RADIUS">자기권계면 위치 [자기권계면]</li>
        			<li code="XRAY_FLUX">X-선 플럭스(GOES-15) [태양복사폭풍]</li>
        			<li code="PROTON_FLUX">양성자 플럭스(GOES-13) [태양입자폭풍]</li>
        			<li code="ELECTRON_FLUX">전자 플럭스(GOES-13)</li>
        			<li code="KP_INDEX_SWPC">Kp 지수 [지자기폭풍]</li>
        			<li code="DST_INDEX_KYOTO">Dst 지수</li>
                </ul> 
            </div>
            <div id="XRAY_FLUX_LABELS_DIV" class="graph_info"></div>
            <div class="body" id="XRAY_FLUX"></div>
        </div>
        <!-- END X-ray Flux -->
        <div class="cgroup s_info">
        	<div class="title">
            	<h5>양성자 플럭스(GOES-13) [태양입자폭풍]</h5>
                <p class="date">
                    <a href="#" class="calendar" title="검색 기간"><span>달력</span></a>
                    <a href="#" class="detail" title="상세보기"><span>상세보기</span></a>
                </p>
                <ul class="select_list" >
        			<li code="ACE_MAG">ACE IMF 자기장</li>
        			<li code="ACE_SOLARWIND_SPD">ACE 태양풍 속도</li>
        			<li code="ACE_SOLARWIND_DENS">ACE 태양풍 밀도</li>
        			<li code="ACE_SOLARWIND_TEMP">ACE 태양풍 온도</li>
        			<li code="MAGNETOPAUSE_RADIUS">자기권계면 위치 [자기권계면]</li>
        			<li code="XRAY_FLUX">X-선 플럭스(GOES-15) [태양복사폭풍]</li>
        			<li code="PROTON_FLUX">양성자 플럭스(GOES-13) [태양입자폭풍]</li>
        			<li code="ELECTRON_FLUX">전자 플럭스(GOES-13)</li>
        			<li code="KP_INDEX_SWPC">Kp 지수 [지자기폭풍]</li>
        			<li code="DST_INDEX_KYOTO">Dst 지수</li>
                </ul> 
            </div>
            <div id="PROTON_FLUX_LABELS_DIV" class="graph_info"></div>
            <div class="body" id="PROTON_FLUX"></div>
        </div>
        <!-- END Proton Flux -->
        <div class="cgroup s_info">
        	<div class="title">
            	<h5>Kp 지수 [지자기폭풍]</h5>
                <p class="date">
                   <a href="#" class="calendar" title="검색 기간"><span>달력</span></a>
                   <a href="#" class="detail" title="상세보기"><span>상세보기</span></a>
                </p>
                <ul class="select_list" >
        			<li code="ACE_MAG">ACE IMF 자기장</li>
        			<li code="ACE_SOLARWIND_SPD">ACE 태양풍 속도</li>
        			<li code="ACE_SOLARWIND_DENS">ACE 태양풍 밀도</li>
        			<li code="ACE_SOLARWIND_TEMP">ACE 태양풍 온도</li>
        			<li code="MAGNETOPAUSE_RADIUS">자기권계면 위치 [자기권계면]</li>
        			<li code="XRAY_FLUX">X-선 플럭스(GOES-15) [태양복사폭풍]</li>
        			<li code="PROTON_FLUX">양성자 플럭스(GOES-13) [태양입자폭풍]</li>
        			<li code="ELECTRON_FLUX">전자 플럭스(GOES-13)</li>
        			<li code="KP_INDEX_SWPC">Kp 지수 [지자기폭풍]</li>
        			<li code="DST_INDEX_KYOTO">Dst 지수</li>
                </ul> 
            </div>
			<div id="KP_INDEX_SWPC_LABELS_DIV" class="graph_info"></div>
            <div class="body" id="KP_INDEX_SWPC"></div>
        </div>
        <!-- END K Index -->
        <div class="cgroup s_info">
        	<div class="title">
            	<h5>자기권계면 위치 [자기권계면]</h5>
                <p class="date">
                    <a href="#" class="calendar" title="검색 기간"><span>달력</span></a>
                    <a href="#" class="detail" title="상세보기"><span>상세보기</span></a>
                </p>
                <ul class="select_list" >
        			<li code="ACE_MAG">ACE IMF 자기장</li>
        			<li code="ACE_SOLARWIND_SPD">ACE 태양풍 속도</li>
        			<li code="ACE_SOLARWIND_DENS">ACE 태양풍 밀도</li>
        			<li code="ACE_SOLARWIND_TEMP">ACE 태양풍 온도</li>
        			<li code="MAGNETOPAUSE_RADIUS">자기권계면 위치 [자기권계면]</li>
        			<li code="XRAY_FLUX">X-선 플럭스(GOES-15) [태양복사폭풍]</li>
        			<li code="PROTON_FLUX">양성자 플럭스(GOES-13) [태양입자폭풍]</li>
        			<li code="ELECTRON_FLUX">전자 플럭스(GOES-13)</li>
        			<li code="KP_INDEX_SWPC">Kp 지수 [지자기폭풍]</li>
        			<li code="DST_INDEX_KYOTO">Dst 지수</li>
                </ul> 
            </div>
            <div id="MAGNETOPAUSE_RADIUS_LABELS_DIV" class="graph_info"></div>
            <div class="body" id="MAGNETOPAUSE_RADIUS"></div>
        </div>
        <!-- END magnetopause -->
    </div>
    <!-- END 지자기 및 전리권 관측정보 -->
</div>

<div class="layer" style="top:135px; left:592px;display:none;" id="calendar_image">
	<div class="layer_contents">
    	<p>
        	<label>날짜</label>
        	<input id="calendar_image_date" type="text" size="12" readonly="readonly"/>
        </p>
        <p>
        	<label>시</label>
        	<select name="" id="calendar_image_hour">
        		<c:forEach begin="0" end="23" var="item">
        		<option value="<fmt:formatNumber minIntegerDigits="2" value="${item}"/>"><fmt:formatNumber minIntegerDigits="2" value="${item}"/></option>
        		</c:forEach>
        	</select>
        </p>
        <p>
        	<label>분</label>
            <select name="" id="calendar_image_minute">
                <option value="01">01</option>
                <option value="02">02</option>
                <option value="03">03</option>
            </select>
        </p>
		<input type="button" class="btn" value="확인"  />
    	<a href="#" class="close"><span>영상선택</span></a>
    </div>
</div>

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
