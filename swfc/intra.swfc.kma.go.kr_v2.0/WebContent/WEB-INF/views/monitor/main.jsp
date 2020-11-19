<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.code.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%
	Map<String, String> imageTypeList = new LinkedHashMap<String, String>();
	for(Iterator<IMAGE_CODE> iter = IMAGE_CODE.availableValues(); iter.hasNext();) {
		IMAGE_CODE code = iter.next();
		String group = code.getGroup();
		switch(code) {
		case STA__01001:
		case STA__01002:
			group = "STA";
			break;
		case STB__01001:
		case STB__01002:
			group = "STB";
			break;
			default:
				group = code.getGroup();
		}
		imageTypeList.put(code.toString(), group + "/" + code.getText());
	}
	pageContext.setAttribute("imageTypeList", imageTypeList);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 상황판</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/monitor.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/perfect-scrollbar.css"/>"/>
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<script type="text/javascript" src="<c:url value="/js/jquery.layout-latest.min.js"/>"></script>
<style>
#ui-datepicker-div {
  z-index: 9999999!important;
}
.dygraph-ylabel{
	font-weight: bold;
}
</style>
<script type="text/javascript" src="<c:url value="/js/date.format.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.mousewheel.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/perfect-scrollbar.js"/>"></script>

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
	},
	imageUpdate: function() {
		imageManager1.load();
		imageManager2.load();
		imageManager3.load();
		imageManager4.load();
	},
	indicatorUpdate: function() {
		$.ajax({
			url : "<c:url value="/monitor/chart_indicator.do"/>"
		}).done(function(data) {
			setElementInfo($("#xray_info"), data.elements.XRAY);
			setElementInfo($("#proton_info"), data.elements.PROTON);
			setElementInfo($("#kp_index_info"), data.elements.KP);
			setElementInfo($("#magnetopause_radius_info"), data.elements.MP);
			/*
			var maxCode1 = null;
			var maxCode2 = null;
			var maxCode3 = null;
			if(data.XRAY != null && data.XRAY.NOW != null) {
				maxCode1 = Math.max(data.XRAY.H0.code, maxCode1);
				maxCode2 = Math.max(data.XRAY.H0.code, maxCode2);
				maxCode3 = Math.max(data.XRAY.H0.code, maxCode3);
			}
			
			if(data.PROTON != null && data.PROTON.H0 != null) {
				maxCode1 = Math.max(data.PROTON.H0.code, maxCode1);
				maxCode2 = Math.max(data.PROTON.H0.code, maxCode2);
			}
			if(data.KP_INDEX != null && data.KP_INDEX.H0 != null) {
				maxCode1 = Math.max(data.KP_INDEX.H0.code, maxCode1);
				maxCode2 = Math.max(data.KP_INDEX.H0.code, maxCode2);
				maxCode3 = Math.max(data.KP_INDEX.H0.code, maxCode3);
			}
			if(data.MAGNETOPAUSE_RADIUS != null && data.MAGNETOPAUSE_RADIUS.H0 != null) {
				maxCode1 = Math.max(data.MAGNETOPAUSE_RADIUS.H0.code, maxCode1);
			}
			*/
			setSummaryValue($("#summary1"), data.notice1);
			setSummaryValue($("#summary2"), data.notice2);
			setSummaryValue($("#summary3"), data.notice3);
		});	
	}
};

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
		$.getJSON("<c:url value="/monitor/search_by_code.do"/>", {
			code : code,
			createDate: createDate
		}).success(function(data) {
			var minuteObj = $("#calendar_image_minute");
			minuteObj.empty();
			$.each(data, function(key, val) {
				var date = new Date(val.createDate);
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
		calenar.css('top', offset.top + 24);
		calenar.css('left', offset.left  - 80);
		calenar.show();
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
				type:	chartType,
				sd: yes.format('yyyymmddhhMMss', true),
				ed: now.format('yyyymmddhhMMss', true),
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
					}else if(type == "ELECTRON_FLUX"){	//전자 플럭스
						chartGraphManager.addElectronFlux({axisLabelColor:'white', colors: ['cyan', 'red'], "div" : div, "box" : box});
					}else if(type == "KP_INDEX_KHU"){	//Kp 지수
						//chartGraphManager.addKpIndexSwpc(chartOption);
						chartGraphManager.addKpIndexKhu({axisLabelColor:'white',colors: ['cyan', 'orange', 'red'], "div" : div, "box" : box});
					}else if(type == "DST_INDEX_KYOTO"){ //Dst 지수
						chartGraphManager.addDstIndexKyoto({axisLabelColor:'white',colors: ['red'], "div" : div, "box" : box});
					}
					var now = timer.date;
					var yes = new Date();
					yes.setDate(now.getDate() - 1);
					data.sd = yes.format('yyyymmddhh', true) + '0000';
					data.ed = now.format('yyyymmddhhMM', true) + '00';
					chartGraphManager.resize($("#wrap_graph .graph").width(),$("#wrap_graph .graph").height());
				}
				data.autoRefresh = true;
				chartGraphManager.setAutoRefreshLayer(data.type, true);
				chartGraphManager.load(data);
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
		
		$("#wrap_graph .unzoom").click(function(e) {
			var calendarButton = $(this).prev().prev();
			var chartType = calendarButton.data().type;
			chartGraphManager.resetZoom(chartType);
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
			
			var sd = startDate.replace(/-/gi, '')  + "000000";
			var ed = endDate.replace(/-/gi, '') + "230000";
			
			calenarButton.data({
				sd: sd,
				ed: ed,
				autoRefresh: false
			});
			
			calenarButton.parents(".header").find('h2 a').removeClass("on");
			chartGraphManager.load({
				sd : sd,
				ed : ed,
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
		var sd = calendarData.sd;
		var ed = calendarData.ed;
		$("#calendar_chart_start_date").val(sd.substring(0,4) + '-' + sd.substring(4,6) + '-' + sd.substring(6,8));
		$("#calendar_chart_end_date").val(ed.substring(0,4) + '-' + ed.substring(4,6) + '-' + ed.substring(6,8));
		
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
	var isKp = false;
	var emptyH3 = true;
	sign.removeClass("w g b y o r");
	message.removeClass("fw fg fb fy fo fr");

	var signText = "";
	var messageText = "없음";
	var H0Text = "";
	var H3Text = "";
	var H6Text = "";
	var H24Text = "";
	if(data != null) {
		if(data.NOW != null) {
			H0Text = toExponential(data.NOW.val);
		}
		
		if(data.H3 != null) {
			emptyH3 = false;
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
		
		
		var tmpSign = "";
		var tmpMsg = "";
		var tmpSignText = "";
		var tmpMessageText = "";
		
		if(data.H6 != null) {
			isKp = true;
			switch(data.H6.code) {
			case 0:
				tmpSign ="w";
				tmpMsg = "fw";
				break;
			case 1:
				tmpSign ="g";
				tmpMsg = "fg";
				break;
			case 2:
				tmpSign ="b";
				tmpMsg = "fb";
				break;
			case 3:
				tmpSign ="y";
				tmpMsg = "fy";
				break;
			case 4:
				tmpSign ="o";
				tmpMsg = "fo";
				break;
			case 5:
				tmpSign ="r";
				tmpMsg = "fr";
				break;
			};		
			
			tmpSignText = data.H6.grade;
			tmpMessageText = data.H6.gradeText;
			
			var month = data.H6.tm.substring(4, 6);
			var day = data.H6.tm.substring(6, 8);
			var hour = data.H6.tm.substring(8, 10);
			var minute = data.H6.tm.substring(10, 12);
			H6Text = toExponential(data.H6.val) + " (" + month + "." + day + " " + hour + ":" + minute + ")";
		}
		
		if(data.D1 != null) {
			H24Text = toExponential(data.D1.val) + " (<b>" + data.D1.grade +"</b>)";
		}
	}
	
	sign.children(".num").text(signText);
	message.text(messageText);
	
	var now = obj.find("p span:first");
	now.text("현재: " + H0Text);
	if(isKp){
		if(emptyH3){
			sign.addClass(tmpSign);
			message.addClass(tmpMsg);
			
			sign.children(".num").text(tmpSignText);
			message.text(tmpMessageText);
			
			now.next().text("6시간 최대값: " + H6Text);
		}else{
			now.next().text("3시간 최대값: " + H3Text);
		}
	}else{
		now.next().text("3시간 최대값: " + H3Text);
	}
	now.next().next().html("24시간 최대값: " + H24Text);
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
		manager.load();
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
		$.getJSON("<c:url value="/monitor/search_by_code.do"/>", {
			code : code,
			createDate: options.createDate
		}).success(function(data) {
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
			this.image.attr("src", "<c:url value="/element/view_movie.do"/>?id=" + data.id + "&size=512&frames=100");
		} else {
			this.image.attr("src", "<c:url value="/element/view_browseimage.do"/>?id=" + data.id);
		}
	} else {
		this.updateDate(null);
		this.image.attr("src", "")
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
		$("#wrap_left").removeAttr("style");
	}

	//Info 리사이즈

	var contentHeight = bodyHeight - $("#header").outerHeight();
	var infoHeight = contentHeight * 0.195;
	var infoTHeight = contentHeight * 0.22;
	var infoTConHeight = infoTHeight - $(".wrap_info .header").outerHeight();
	var infoConHeight = infoHeight - $(".wrap_info .header").outerHeight();

	$(".wrap_info").height(infoHeight - 2);	//우주기상 특보상황
	$(".wrap_info:first").height(infoTHeight - 2);	//나머지
	$(".info_total").css({"height": infoTConHeight,"line-height":infoTConHeight * 1.1  +"px"}); //우주기상 특보상황 내용
	$(".info").css({"padding-left": "3%" ,"line-height":infoConHeight -2  +"px"}); //나머지 내용
	$(".sign_wrap").css({"padding-left": ($(".info_total").width() - $(".sign_wrap").width()*3)/8});
	
	//그래프 박스 리사이즈
	var graphHeight = ((bodyHeight - $("#header").outerHeight()) -  $("#wrap_img").outerHeight())/2;
	if(slice){
		$("#wrap_graph .gr_graph").width($("#wrap_left").width()/2 - 2).height(graphHeight - 2);
		$("#wrap_graph .graph").height(graphHeight -$(".gr_graph .header").outerHeight());
		$("#wrap_graph .graph").width($(".gr_graph").width() - 2).css("padding","5px");
		$("#wrap_graph").width("100%").height(graphHeight - 2);
	}else{
		graphHeight =	bodyHeight - $("#header").outerHeight()-  $("#wrap_img").outerHeight();
		$("#wrap_graph .gr_graph").width($("#wrap_left").width()).height(graphHeight - 2);
		$("#wrap_graph .graph").height(graphHeight -$(".gr_graph .header").outerHeight());
		$("#wrap_graph .graph").width($(".gr_graph").width() - 2).css("padding","5px");
		$("#wrap_graph").width($("#wrap_graph .graph").outerWidth() * 4).height(graphHeight - 2);
		$.each($("#wrap_graph .gr_graph"),function(){
			var now = $(this);
			if(!now.hasClass("selected")){
				now.css("left", $("#wrap_graph .graph").outerWidth());
			}else{
				now.css("left",0);
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
	onResize();
	$(window).load(function(){
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
		
		var chartOption = {axisLabelColor:'white'};
		chartGraphManager.addXRayFlux({axisLabelColor:'white', colors: ['cyan', 'red']});
		chartGraphManager.addProtonFlux(chartOption);
		//chartGraphManager.addKpIndexSwpc(chartOption);
		chartGraphManager.addKpIndexKhu({axisLabelColor:'white',colors: [ 'cyan', 'orange', 'red']});
		chartGraphManager.addMagnetopauseRadius(chartOption);
		
		//chartGraphManager.loadOneDayFromNow();
		//chartGraphManager.setAutoRefresh(1000*60*5);
		//chartGraphManager.setAutoRefresh({enable:true});
		chartGraphManager.updateOptions({autoRefresh:true});
		
		rollingEvent();
	}).resize(function() {
		clearTimeout(setTime);
		setTime = setTimeout(onResize,200);
	}).resize();
	
	
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
		var roll = $("#wrap_left");
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
			rolling = setInterval(graphRolling, 1000*5);	//재생
		}else{
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
</script>
</head>

<body>
<div id="scrollBar">
<div id="wrap">
	<div id="header">
		<h1 class="title">
	    	<img src="<c:url value="/images/monitor/title.png"/>" alt="NMSC Space Weather Monitoring" />
	    </h1><!-- 
	 --><div class="wrap_time">
		    <div class="time utc">
		    	<p class="tdate" id="utc_date"></p>
		        <p class="hms">
		        	<span id="utc_hour"></span><span id="utc_minute"></span><span id="utc_second"></span>
		        </p>
		    </div>    
		    <div class="time kst">
		    	<p class="tdate" id="kst_date"></p>
		        <p class="hms">
		        	<span id="kst_hour"></span><span id="kst_minute"></span><span id="kst_second"></span>
		        </p>
		    </div>
	    </div>
	
	</div>
	<div id="contents">
		<div id="wrap_left">
		    <div id="wrap_img">
		        <!-- 태양영상 1 -->
		        <div class="gr_img" id="imageManager1">
		            <div class="header">
		                <h2>
		                    <a href="#" class="on" name="SDO__01001">SDO/AIA 0131</a>
		                </h2>
		                <div class="combo alist">
						<c:forEach var="entry" items="${imageTypeList}">
		                    <a href="#" name="<c:out value="${entry.key}"/>"><c:out value="${entry.value}"/></a>
						</c:forEach>                
		                </div>
		                <p class="date">
		                    <span class="img_time"></span>   
		                    <a href="#" class="calendar"><span>달력</span></a>
		                    <a href="#" class="vod"><span>동영상</span></a>
		                </p>
		            </div>
		            <div class="contents">
		                <img src="<c:url value="/element/view_browseimage.do?id=565052"/>" alt="" /> 	
		            </div>
		        </div><!--  
	태양영상 2 --><div class="gr_img" id="imageManager2">
		            <div class="header">
		                 <h2>
		                    <a href="#" class="on" name="SDO__01002">SDO/AIA 0171</a>
		                </h2>
		                <div class="combo alist">
						<c:forEach var="entry" items="${imageTypeList}">
		                    <a href="#" name="<c:out value="${entry.key}"/>"><c:out value="${entry.value}"/></a>
						</c:forEach>                
		                </div>
		                <p class="date">
		                    <span class="img_time"></span>
		                    <a href="#" class="calendar"><span>달력</span></a>
		                    <a href="#" class="vod"><span>동영상</span></a>
		                </p>
		            </div>
		            <div class="contents">
		                <img src="<c:url value="/element/view_browseimage.do?id=565051"/>" alt=""/>        	    	
		            </div>
		        </div><!-- 
	태양영상 3  --><div class="gr_img" id="imageManager3">
		            <div class="header">
		                 <h2>
		                    <a href="#" class="on" name="SDO__01003">SDO/AIA 0193</a>
		                </h2>
		                <div class="combo alist over">
						<c:forEach var="entry" items="${imageTypeList}">
		                    <a href="#" name="<c:out value="${entry.key}"/>"><c:out value="${entry.value}"/></a>
						</c:forEach>                
		                </div>
		                <p class="date">
		                   <span class="img_time"></span>
		                    <a href="#" class="calendar"><span>달력</span></a>
		                    <a href="#" class="vod"><span>동영상</span></a>
		                </p>
		            </div>
		            <div class="contents">
		                <img src="<c:url value="/element/view_browseimage.do?id=565050"/>" alt="" />        	    	
		            </div>
		        </div><!-- 
	태양영상 4  --><div class="gr_img" id="imageManager4">
		            <div class="header">
		                 <h2>
		                    <a href="#" class="on" name="SDO__01004">SDO/AIA 0211</a>
		                </h2>
		                <div class="combo alist over" >
						<c:forEach var="entry" items="${imageTypeList}">
		                    <a href="#" name="<c:out value="${entry.key}"/>"><c:out value="${entry.value}"/></a>
						</c:forEach>                
		                </div>
		                <p class="date">
		                     <span class="img_time"></span>
		                    <a href="#" class="calendar"><span>달력</span></a>
		                    <a href="#" class="vod"><span>동영상</span></a>
		                </p>
		            </div>
		            <div class="contents">
		                <img src="<c:url value="/element/view_browseimage.do?id=565053"/>" alt="" />        	    	
		            </div>
		        </div>
		    </div>
		    <!-- END 영상 -->
		    
		    <div id="wrap_graph">
		        <div class="gr_graph">
		            <div class="header">
		                <h2>
		                	<a href="#" class="on"><span><custom:ChartTItle type="XRAY_FLUX"/></span></a>
		                </h2>
		                <ul class="combo glist">
		                	<li>ACE IMF 자기장<input type="hidden" name="type" value="ACE_MAG"/></li>
		                	<li>ACE 태양풍 속도<input type="hidden" name="type" value="ACE_SOLARWIND_SPD"/></li>
		                	<li>ACE 태양풍 밀도<input type="hidden" name="type" value="ACE_SOLARWIND_DENS"/></li>
		                	<li>ACE 태양풍 온도<input type="hidden" name="type" value="ACE_SOLARWIND_TEMP"/></li>
		                	<li>자기권계면<input type="hidden" name="type" value="MAGNETOPAUSE_RADIUS"/></li>
		                	<li>X-선 플럭스(GOES-15)<input type="hidden" name="type" value="XRAY_FLUX"/></li>
		                	<li>양성자 플럭스(GOES-13)<input type="hidden" name="type" value="PROTON_FLUX"/></li>
		                	<li>전자 플럭스(GOES-13)<input type="hidden" name="type" value="ELECTRON_FLUX"/></li>
		                	<li>Kp 지수<input type="hidden" name="type" value="KP_INDEX_KHU"/></li>
		                	<li>Dst 지수<input type="hidden" name="type" value="DST_INDEX_KYOTO"/></li>
		                </ul>
		                <div class="ginfo" id="XRAY_FLUX_LABELS_DIV"></div>
		                <p class="date">
		                    <a href="#" class="play" title="재생"><span>재생</span></a>
		                	<a href="#" class="slice" title="롤링"><span>롤링</span></a>
		                    <a href="#" class="calendar" title="달력"><span>달력</span></a>
		                    <a href="#" class="detail" title="상세보기"><span>상세보기</span></a>
		                    <a href="#" class="unzoom" title="리셋"><span>리셋</span></a>
		                </p>
		            </div>
		            <div class="graph" id="XRAY_FLUX"></div>
		        </div><!--
 END GRAPH 1 --><div class="gr_graph">
		            <div class="header">
		                <h2>
		                	<a href="#" class="on"><span><custom:ChartTItle type="PROTON_FLUX"/></span></a>
		                </h2>
		                <ul class="combo glist">
		                	<li>ACE IMF 자기장<input type="hidden" name="type" value="ACE_MAG"/></li>
		                	<li>ACE 태양풍 속도<input type="hidden" name="type" value="ACE_SOLARWIND_SPD"/></li>
		                	<li>ACE 태양풍 밀도<input type="hidden" name="type" value="ACE_SOLARWIND_DENS"/></li>
		                	<li>ACE 태양풍 온도<input type="hidden" name="type" value="ACE_SOLARWIND_TEMP"/></li>
		                	<li>자기권계면<input type="hidden" name="type" value="MAGNETOPAUSE_RADIUS"/></li>
		                	<li>X-선 플럭스(GOES-15)<input type="hidden" name="type" value="XRAY_FLUX"/></li>
		                	<li>양성자 플럭스(GOES-13)<input type="hidden" name="type" value="PROTON_FLUX"/></li>
		                	<li>전자 플럭스(GOES-13)<input type="hidden" name="type" value="ELECTRON_FLUX"/></li>
		                	<li>Kp 지수<input type="hidden" name="type" value="KP_INDEX_KHU"/></li>
		                	<li>Dst 지수<input type="hidden" name="type" value="DST_INDEX_KYOTO"/></li>
		                </ul>
		                <div class="ginfo" id="PROTON_FLUX_LABELS_DIV"></div>
		                <p class="date">
		                    <a href="#" class="play" title="재생"><span>재생</span></a>
		                	<a href="#" class="slice" title="롤링"><span>롤링</span></a>
		                    <a href="#" class="calendar" title="달력"><span>달력</span></a>
		                    <a href="#" class="detail" title="상세보기"><span>상세보기</span></a>
		                    <a href="#" class="unzoom" title="리셋"><span>리셋</span></a>
		                </p>
		            </div>
		            <div class="graph" id="PROTON_FLUX"></div>
		        </div><!--
 END GRAPH 2 --><div class="gr_graph">
		            <div class="header">
		                <h2>
		                	<a href="#" class="on"><span><custom:ChartTItle type="KP_INDEX_KHU"/></span></a>
		                </h2>
		                <ul class="combo glist over">
		                	<li>ACE IMF 자기장<input type="hidden" name="type" value="ACE_MAG"/></li>
		                	<li>ACE 태양풍 속도<input type="hidden" name="type" value="ACE_SOLARWIND_SPD"/></li>
		                	<li>ACE 태양풍 밀도<input type="hidden" name="type" value="ACE_SOLARWIND_DENS"/></li>
		                	<li>ACE 태양풍 온도<input type="hidden" name="type" value="ACE_SOLARWIND_TEMP"/></li>
		                	<li>자기권계면<input type="hidden" name="type" value="MAGNETOPAUSE_RADIUS"/></li>
		                	<li>X-선 플럭스(GOES-15)<input type="hidden" name="type" value="XRAY_FLUX"/></li>
		                	<li>양성자 플럭스(GOES-13)<input type="hidden" name="type" value="PROTON_FLUX"/></li>
		                	<li>전자 플럭스(GOES-13)<input type="hidden" name="type" value="ELECTRON_FLUX"/></li>
		                	<li>Kp 지수<input type="hidden" name="type" value="KP_INDEX_KHU"/></li>
		                	<li>Dst 지수<input type="hidden" name="type" value="DST_INDEX_KYOTO"/></li>
		                </ul>
		                <div class="ginfo" id="KP_INDEX_KHU_LABELS_DIV"></div>
		                <p class="date">
		                    <a href="#" class="play" title="재생"><span>재생</span></a>
		                	<a href="#" class="slice" title="롤링"><span>롤링</span></a>
		                    <a href="#" class="calendar" title="달력"><span>달력</span></a>
		                    <a href="#" class="detail" title="상세보기"><span>상세보기</span></a>
		                    <a href="#" class="unzoom" title="리셋"><span>리셋</span></a>
		                </p>
		            </div>
		            <div class="graph" id="KP_INDEX_KHU"></div>
		        </div><!--
 END GRAPH 3 --><div class="gr_graph">
		            <div class="header">
		                <h2>
		                	<a href="#" class="on"><span><custom:ChartTItle type="MAGNETOPAUSE_RADIUS"/></span></a>
		                </h2>   
		                <ul class="combo glist over">
		                	<li>ACE IMF 자기장<input type="hidden" name="type" value="ACE_MAG"/></li>
		                	<li>ACE 태양풍 속도<input type="hidden" name="type" value="ACE_SOLARWIND_SPD"/></li>
		                	<li>ACE 태양풍 밀도<input type="hidden" name="type" value="ACE_SOLARWIND_DENS"/></li>
		                	<li>ACE 태양풍 온도<input type="hidden" name="type" value="ACE_SOLARWIND_TEMP"/></li>
		                	<li>자기권계면<input type="hidden" name="type" value="MAGNETOPAUSE_RADIUS"/></li>
		                	<li>X-선 플럭스(GOES-15)<input type="hidden" name="type" value="XRAY_FLUX"/></li>
		                	<li>양성자 플럭스(GOES-13)<input type="hidden" name="type" value="PROTON_FLUX"/></li>
		                	<li>전자 플럭스(GOES-13)<input type="hidden" name="type" value="ELECTRON_FLUX"/></li>
		                	<li>Kp 지수<input type="hidden" name="type" value="KP_INDEX_KHU"/></li>
		                	<li>Dst 지수<input type="hidden" name="type" value="DST_INDEX_KYOTO"/></li>
		                </ul>             
		                <div class="ginfo" id="MAGNETOPAUSE_RADIUS_LABELS_DIV"></div>
		                <p class="date">
		                   <a href="#" class="play" title="재생"><span>재생</span></a>
		                   <a href="#" class="slice" title="롤링"><span>롤링</span></a>
		                   <a href="#" class="calendar" title="달력"><span>달력</span></a>
		                   <a href="#" class="detail" title="상세보기"><span>상세보기</span></a>
		                   <a href="#" class="unzoom" title="리셋"><span>리셋</span></a>
		                </p>
		            </div>
		            <div class="graph" id="MAGNETOPAUSE_RADIUS"></div>
		        </div>
		        <!-- END GRAPH 4 -->
		    </div>
		    <!-- END 그래프 -->
	    </div>
	     <!-- END WRAP LEFT INFO -->  
	    <div id="wrap_right">
		    <div id="wrap_info">
		    	<!-- 태양복사폭풍 -->
		    	<div class="wrap_info">
			        <div class="header">
			            <h2>우주기상 특보상황</h2>
			        </div>
			        <div class="info_total">
			        	<div class="sign_wrap">
			            	<p>기상위성운영</p>
			                <div class="signt" id="summary1">
			                	<span class="num"></span>
			                	<span class="txt"></span>
			                </div>
			            </div>
			            
			            <div class="sign_wrap">
			            	<p>극항로기상</p>
			                <div class="signt" id="summary2">
			                	<span class="num"></span>
			                	<span class="txt"></span>
			                </div>
			            </div> 
			            
			            <div class="sign_wrap">
			            	<p>전리권기상</p>
			                <div class="signt" id="summary3">
			                	<span class="num"></span>
			                	<span class="txt"></span>
			                </div>
			            </div>  
			                 	    	
			        </div>
			    </div>
		    	<!-- 태양복사폭풍 -->
		    	<div class="wrap_info">
			        <div class="header">
			             <h2>
			                태양복사폭풍
			            </h2>
			        </div>
			        <div class="info" id="xray_info"> 
			            <div class="sign">
			            	<span class="num"></span>
			                <span class="txt"></span>
			            </div>
			            <p>
			                <span>현재: </span>
			                <span>3시간 최대값: </span>
			                <span>24시간 최대값: </span>
			            </p>               	    	
			        </div>
			    </div>
			        <!-- 태양입자폭풍 -->
			    <div class="wrap_info">
			        <div class="header">
			             <h2>
			                태양입자폭풍
			            </h2>
			        </div>
			        <div class="info" id="proton_info"> 
			            <div class="sign">
			            	<span class="num"></span>
			                <span class="txt"></span>
			            </div>
			            <p>
			                <span>현재: </span>
			                <span>3시간 최대값: </span>
			                <span>24시간 최대값: </span>
			            </p>               	    	
			        </div>
			   	</div>
		        <!-- 지자기폭풍 -->
		        <div class="wrap_info">
			        <div class="header">
			             <h2>
			                지자기폭풍
			            </h2>
			        </div>
			        <div class="info" id="kp_index_info"> 
			            <div class="sign">
			            	<span class="num"></span>
			                <span class="txt"></span>
			            </div>
			            <p>
			                <span>현재: </span>
			                <span>3시간 최대값: </span>
			                <span>24시간 최대값: </span>
			            </p>               	    	
			        </div>
			    </div>
		        <!-- 자기권계면 -->        
		        <div class="wrap_info">   
			        <div class="header">
			             <h2>
			                자기권계면
			            </h2>
			        </div>
			        <div class="info" id="magnetopause_radius_info"> 
			            <div class="sign">
			            	<span class="num"></span>
			                <span class="txt"></span>
			            </div>
			            <p>
			                <span>현재: </span>
			                <span>3시간 최소값: </span>
			                <span>24시간 최소값: </span>
			            </p>               	    	
			        </div>
			    </div> 
		    </div>
	    	<!-- END WRAP INFO -->   
	    </div>
	    <!-- END WRAP RIGHT INFO -->   
	 </div>
	 <!-- END CONTENTS  -->  
</div>
<!-- END WRAP -->
</div>

<!-- 레이어 // 태양영상 달력 -->
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

<!-- 레이어 // 그래프 달력 -->
<div class="layer" style="display:none;" id="calendar_chart">
	<div class="layer_contents">
    	<p>
        	<label>시작일</label>
        	<input type="text" size="12" id="calendar_chart_start_date"/>      
        </p>
        <p>
        	<label>종료일</label>
        	<input type="text" size="12" id="calendar_chart_end_date"/>      
        </p>

		<input type="button" class="btn" value="검색"  />
    	<a href="#" class="close"><span>영상선택</span></a>
    </div>
</div>
</body>
</html>