<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.code.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%
	Map<String, String> imageTypeList = new LinkedHashMap<String, String>();
	for(Iterator<IMAGE_CODE> iter = IMAGE_CODE.availableValues(); iter.hasNext();) {
		IMAGE_CODE code = iter.next();
		imageTypeList.put(code.toString(), code.getGroup() + "/" + code.getText());
	}
	pageContext.setAttribute("imageTypeList", imageTypeList);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 상황판</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/monitor.css"/>"/>
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<script type="text/javascript" src="<c:url value="/js/jquery.layout-latest.min.js"/>"></script>
<style>
#ui-datepicker-div {
  z-index: 9999999!important;
}
body {
	overflow:hidden;
}

.dygraph-ylabel{
	font-weight: bold;
}
</style>
<script type="text/javascript" src="<c:url value="/js/date.format.js"/>"></script>
<jsp:include page="../include/dygraph.jsp" />
<script type="text/javascript">
var imageManager1 = null;
var imageManager2 = null;
var imageManager3 = null;
var imageManager4 = null;

var timer =  {
	date: new Date(),
	clockTimer: setInterval("timer.clockUpdate()", 1000),
	imageTimer: setInterval("timer.imageUpdate()", 1000*60*5),
	indicatorTimer: setInterval("timer.indicatorUpdate()", 1000*60*5),
	
	clockUpdate: function() {
		var now = new Date();
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
			setElementInfo($("#xray_info"), data.XRAY);
			setElementInfo($("#proton_info"), data.PROTON);
			setElementInfo($("#kp_index_info"), data.KP_INDEX);
			setElementInfo($("#magnetopause_radius_info"), data.MAGNETOPAUSE_RADIUS);
			
			var maxCode1 = null;
			var maxCode2 = null;
			var maxCode3 = null;
			if(data.XRAY != null && data.XRAY.H0 != null) {
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
			setSummaryValue($("#summary1"), maxCode1);
			setSummaryValue($("#summary2"), maxCode2);
			setSummaryValue($("#summary3"), maxCode3);
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
		calenar.css('top', 135);
		calenar.css('left', offset.left-139);
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
		
		$("#wrap_graph .calendar").each(function() {
			var calenarButton = $(this);
			var chartType = calenarButton.parents(".gr_graph").children('.graph').attr('id');
			$(this).data({
				type:	chartType,
				sd:'',
				ed:'',
				autoRefresh: true,
			});
			
			calenarButton.parents(".header").find('h2 a').click(function(e) {
				$(this).addClass("on");
				
				var data = calenarButton.data();
				data.autoRefresh = true;
				chartGraphManager.setAutoRefreshLayer(data.type, true);
				chartGraphManager.autoRefresh();
				
				e.defaultPrevented = true;
				return false;
			});
		});
		
		$("#wrap_graph .detail").click(function(e) {
			var calendarButton = $(this).prev();
			var data = calendarButton.data();
			var url = "chart_popup.do?" + $.param(calendarButton.data());
			
			window.open(url, '_blank','width=1024,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
			e.defaultPrevented = true;
			return false;
		});
		
		
		$("#calendar_chart_start_date").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
		$("#calendar_chart_end_date").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
		
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
				startDate: startDate,
				endDate: endDate,
				autoRefresh: false
			});
			
			calenarButton.parents(".header").find('a').removeClass("on");
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
		chartCalendar.calenarButton = calendarButton;
		
		var offset = calendarButton.offset();
		var calendarData = calendarButton.data();
		
		$("#calendar_chart_start_date").val(calendarData.startDate);
		$("#calendar_chart_end_date").val(calendarData.endDate);
		
		var calenar = $("#calendar_chart");
		calenar.css('top', offset.top+25);
		calenar.css('left', offset.left-139);
		$("#ui-datepicker-div").css("z-index", 20);
		calenar.show();
	},
	hide: function() {
		$("#calendar_chart").hide();
	}		
};

function setSummaryValue(obj, code) {
	obj.text(code);
	var textObj = obj.next();
	obj.removeClass("w g b y o r");
	textObj.removeClass("fw fg fb fy fo fr");
	switch(code) {
	case 0:
		obj.addClass("w");
		textObj.text("낮음");
		textObj.addClass("fw");
		break;
	case 1:
		obj.addClass("g");
		textObj.text("일반");
		textObj.addClass("fg");
		break;
	case 2:
		obj.addClass("b");
		textObj.text("관심");
		textObj.addClass("fb");
		break;
	case 3:
		obj.addClass("y");
		textObj.text("주의");
		textObj.addClass("fy");
		break;
	case 4:
		obj.addClass("o");
		textObj.text("경계");
		textObj.addClass("fo");
		break;
	case 5:
		obj.addClass("r");
		obj.next().text("심각");
		textObj.addClass("fr");
		break;
	};	
}

function toExponential(val) {
	return (val > 10000 || val < 0.0001)?val.toExponential():val;
}

function setElementInfo(obj, data, prefix) {
	var sign = obj.children(".sign");
	var message = obj.find("span:first");
	sign.removeClass("w g b y o r");
	message.removeClass("fw fg fb fy fo fr");

	var signText = "";
	var messageText = "데이터 없음";
	var H0Text = "";
	var H3Text = "";
	var H24Text = "";
	if(data != null) {
		if(data.H0 != null) {
			signText = data.H0.code2;
			messageText = data.H0.codeText;
			H0Text = toExponential(data.H0.val);
			
			switch(data.H0.code) {
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
		}
		
		if(data.H3 != null) {
			var month = data.H3.tm.substring(4, 6);
			var day = data.H3.tm.substring(6, 8);
			var hour = data.H3.tm.substring(8, 10);
			var minute = data.H3.tm.substring(10, 12);
			H3Text = toExponential(data.H3.val) + " (" + month + "." + day + " " + hour + ":" + minute + ")";
		}
		
		if(data.H24 != null) {
			H24Text = toExponential(data.H24.val) + " (" + data.H24.code2 +")";
		}
	}
	
	sign.text(signText);
	message.text(messageText);
	message.next().text("현재: " + H0Text);
	message.next().next().text("3시간 최대값: " + H3Text);
	message.next().next().next().text("24시간 최대값: " + H24Text);
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
	
	this.container.find(".header h2 a img").click(function(e) {
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
	
	this.title.click(function(e) {
		manager.realtime = true;
		manager.load();
	});
	
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
	console.log(options);
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
			alert("Error");
		});
	}
}

ImageManager.prototype.updateData = function(data) {
	this.currentData = data;
	if(data != null) {
		var date = new Date(data.createDate);
		this.setDate(date);
		if(this.viewMovie) {
			this.image.attr("src", "<c:url value="/element/view_movie.do"/>?id=" + data.id + "&size=390&frames=100");
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

function chartResize() {
	var width = $("#wrap_graph").width()-20;
	var height = $("#wrap").height()-$("#wrap_img").height() - 90;
	$(".graph").width(width/2).height(height/2);
	chartGraphManager.resize();
}

$(window).resize(function() {
	onResize();
});

function onResize() {
	$("#wrap").width($("body").width() - $("#wrap_info").width());
};

$(function() {
	/*
	$('body').layout({
		//	reference only - these options are NOT required because 'true' is the default
			closable:					false	// pane can open & close
		,	resizable:					false	// when open, pane can be resized 
		,	slidable:					false	// when closed, pane can 'slide' open over other panes - closes on mouse-out
		,	livePaneResizing:			true
		,	center__onresize: function() {
			chartResize();
		}
		//	some resizing/toggling settings
		,	north__slidable:			false	// OVERRIDE the pane-default of 'slidable=true'
		,	north__togglerLength_closed: '100%'	// toggle-button is full-width of resizer-bar
		,	north__spacing_closed:		20		// big resizer-bar when open (zero height)
		,	south__resizable:			false	// OVERRIDE the pane-default of 'resizable=true'
		,	south__spacing_open:		0		// no resizer-bar when open (zero height)
		,	south__spacing_closed:		20		// big resizer-bar when open (zero height)

		//	some pane-size settings
		,	east__size:					400
		,	center__minWidth:			200
		});
	*/
	timer.indicatorUpdate();
	
	imageSearchCalenar.initialize();
	chartCalendar.initialize();
	
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
	chartGraphManager.addKpIndexSwpc(chartOption);
	chartGraphManager.addMagnetopauseRadius(chartOption);
	
	//chartGraphManager.loadOneDayFromNow();
	//chartGraphManager.setAutoRefresh(1000*60*5);
	//chartGraphManager.setAutoRefresh({enable:true});
	chartGraphManager.updateOptions({autoRefresh:true});
	
	//chartResize();
	onResize();
});

function searchChart() {
	//var startDate = $("#sd").datepicker('getDate');
	//var endDate = $("#ed").datepicker('getDate');

	//var sd = $.datepicker.formatDate("yymmdd", startDate) + $("#sh").val() + "0000";
	//var ed = $.datepicker.formatDate("yymmdd", endDate) + $("#eh").val() + "0000";
	
	//chartGraphManager.load('20131012121212', '20131212121212');
}
</script>
</head>

<body>
<div id="header">
	<h1>
    	<img src="<c:url value="/images/monitor/title.png"/>" alt="NMSC Space Weather Monitoring" />
    </h1>
    <div class="time utc">
    	<p class="tdate" id="utc_date"></p>
        <p class="hms">
        	<span id="utc_hour"></span>
            <span id="utc_minute"></span>
            <span id="utc_second"></span>
        </p>
    </div>    
    <div class="time kst">
    	<p class="tdate" id="kst_date"></p>
        <p class="hms">
        	<span id="kst_hour"></span>
            <span id="kst_minute"></span>
            <span id="kst_second"></span>
        </p>
    </div>
</div>
<div id="wrap_info">
	<!-- 태양복사폭풍 -->
    <div class="header">
        <h2>우주기상 특보상황</h2>
    </div>
    <div class="info_total" style="height:249px;">
    	<div class="sign_wrap">
        	<p>기상위성운영</p>
            <div class="signt" style="margin-left:20px;margin-top:10px;" id="summary1"></div>
            <p></p>
        </div>
        
        <div class="sign_wrap">
        	<p>극항로기상</p>
            <div class="signt" style="margin-left:10px;margin-top:10px;" id="summary2"></div>
            <p></p>
        </div> 
        
        <div class="sign_wrap">
        	<p>전리권기상</p>
            <div class="signt" style="margin-left:10px;margin-top:10px;" id="summary3"></div>
            <p></p>
        </div>  
             	    	
    </div>
	<!-- 태양복사폭풍 -->
    <div class="header">
         <h2>
            태양복사폭풍
        </h2>
    </div>
    <div class="info" id="xray_info"> 
        <div class="sign"></div>
        <p>
            <span class="message">데이터 없음</span>
            <span>현재: </span>
            <span>3시간 최대값: </span>
            <span>24시간 최대값: </span>
        </p>               	    	
    </div>
    <!-- 태양입자폭풍 -->
    <div class="header">
         <h2>
            태양입자폭풍
        </h2>
    </div>
    <div class="info" id="proton_info"> 
        <div class="sign"></div>
        <p>
            <span class="message">데이터 없음</span>
            <span>현재: </span>
            <span>3시간 최대값: </span>
            <span>24시간 최대값: </span>
        </p>               	    	
    </div>
    <!-- 지자기폭풍 -->
    <div class="header">
         <h2>
            지자기폭풍
        </h2>
    </div>
    <div class="info" id="kp_index_info"> 
        <div class="sign"></div>
        <p>
            <span class="message">데이터 없음</span>
            <span>현재: </span>
            <span>3시간 최대값: </span>
            <span>24시간 최대값: </span>
        </p>               	    	
    </div>
    <!-- 자기권계면 -->           
    <div class="header">
         <h2>
            자기권계면
        </h2>
    </div>
    <div class="info" id="magnetopause_radius_info"> 
        <div class="sign"></div>
        <p>
            <span class="message">데이터 없음</span>
            <span>현재: </span>
            <span>3시간 최대값: </span>
            <span>24시간 최대값: </span>
        </p>               	    	
    </div> 
</div>
<!-- END WRAP INFO -->
<div id="wrap">
    <div id="wrap_img">
    	<table>
    		<tr>
    			<td style="width:25%">
        <!-- 태양영상 1 -->
        <div class="gr_img" id="imageManager1">
            <div class="header">
                <h2>
                    <a href="#"><img src="<c:url value="/images/monitor/ico_arrow.png"/>" alt="" /></a>
                    <a href="#" class="on" name="SDO__01001">SDO/AIA 0131</a>
                </h2>
                <div class="alist" style="left:5px;">
				<c:forEach var="entry" items="${imageTypeList}">
                    <a href="#" name="<c:out value="${entry.key}"/>"><c:out value="${entry.value}"/></a>
				</c:forEach>                
                </div>
                <p class="date">
                    <span></span>
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="vod"><span>동영상</span></a>
                </p>
            </div>
            <div class="contents">
                <img src="<c:url value="/images/monitor/sun.jpg"/>" alt="" style="max-width:100%;max-height:100%;width:100%;"/> 	
            </div>
        </div>    			
    			</td>
    			<td style="width:25%">
        <!-- 태양영상 2 -->
        <div class="gr_img" id="imageManager2">
            <div class="header">
                 <h2>
                    <a href="#"><img src="<c:url value="/images/monitor/ico_arrow.png"/>" alt="" /></a>
                    <a href="#" class="on" name="SDO__01002">SDO/AIA 0171</a>
                </h2>
                <div class="alist" style="left:5px;">
				<c:forEach var="entry" items="${imageTypeList}">
                    <a href="#" name="<c:out value="${entry.key}"/>"><c:out value="${entry.value}"/></a>
				</c:forEach>                
                </div>
                <p class="date">
                    <span></span>
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="vod"><span>동영상</span></a>
                </p>
            </div>
            <div class="contents">
                <img src="<c:url value="/images/monitor/sun2.jpg"/>" alt="" style="max-width:100%;max-height:100%;width:100%;"/>        	    	
            </div>
        </div>
    			</td>
    			<td style="width:25%">
        <!-- 태양영상 3 -->
        <div class="gr_img" id="imageManager3">
            <div class="header">
                 <h2>
                    <a href="#"><img src="<c:url value="/images/monitor/ico_arrow.png"/>" alt="" /></a>
                    <a href="#" class="on" name="SDO__01003">SDO/AIA 0193</a>
                </h2>
                <div class="alist" style="left:5px;">
				<c:forEach var="entry" items="${imageTypeList}">
                    <a href="#" name="<c:out value="${entry.key}"/>"><c:out value="${entry.value}"/></a>
				</c:forEach>                
                </div>
                <p class="date">
                    <span></span>
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="vod"><span>동영상</span></a>
                </p>
            </div>
            <div class="contents">
                <img src="<c:url value="/images/monitor/sun3.jpg"/>" alt="" style="max-width:100%;max-height:100%;width:100%;"/>        	    	
            </div>
        </div>    			
    			</td>
    			<td style="width:25%">
        <!-- 태양영상 4 -->
        <div class="gr_img" id="imageManager4">
            <div class="header">
                 <h2>
                    <a href="#"><img src="<c:url value="/images/monitor/ico_arrow.png"/>" alt="" /></a>
                    <a href="#" class="on" name="SDO__01004">SDO/AIA 0211</a>
                </h2>
                <div class="alist" style="left:5px;">
				<c:forEach var="entry" items="${imageTypeList}">
                    <a href="#" name="<c:out value="${entry.key}"/>"><c:out value="${entry.value}"/></a>
				</c:forEach>                
                </div>
                <p class="date">
                    <span></span>
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="vod"><span>동영상</span></a>
                </p>
            </div>
            <div class="contents">
                <img src="<c:url value="/images/monitor/sun4.jpg"/>" alt="" style="max-width:100%;max-height:100%;width:100%;"/>        	    	
            </div>
        </div>    			
    			</td>
    		</tr>
    	</table>

    </div>
    <!-- END 영상 -->
    
    <div id="wrap_graph">
    	<table style="width:100%">
    	<tr>
    		<td>
        <div class="gr_graph">
            <div class="header">
                <h2>
                	<a href="#" class="on"><custom:ChartTItle type="XRAY_FLUX"/></a>
                </h2>
                <div class="ginfo" id="XRAY_FLUX_LABELS_DIV"></div>
                <p class="date">
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="detail"><span>상세보기</span></a>
                </p>
            </div>
            <div class="graph" id="XRAY_FLUX"></div>
        </div>
        <!-- END GRAPH 1 -->    		
    		</td>
    		<td>
        <div class="gr_graph">
            <div class="header">
                <h2>
                	<a href="#" class="on"><custom:ChartTItle type="PROTON_FLUX"/></a>
                </h2>
                <div class="ginfo" id="PROTON_FLUX_LABELS_DIV"></div>
                <p class="date">
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="detail"><span>상세보기</span></a>
                </p>
            </div>
            <div class="graph" id="PROTON_FLUX"></div>
        </div>
        <!-- END GRAPH 2 -->
    		</td>
    	</tr>
    	<tr>
    		<td>
        <div class="gr_graph">
            <div class="header">
                <h2>
                	<a href="#" class="on"><custom:ChartTItle type="KP_INDEX_SWPC"/></a>
                </h2>
                <div class="ginfo" id="KP_INDEX_SWPC_LABELS_DIV"></div>
                <p class="date">
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="detail"><span>상세보기</span></a>
                </p>
            </div>
            <div class="graph" id="KP_INDEX_SWPC"></div>
        </div>
        <!-- END GRAPH 3 -->
    		</td>
    		<td>
        <div class="gr_graph">
            <div class="header">
                <h2>
                	<a href="#" class="on"><custom:ChartTItle type="MAGNETOPAUSE_RADIUS"/></a>
                </h2>                
                <div class="ginfo" id="MAGNETOPAUSE_RADIUS_LABELS_DIV"></div>
                <p class="date">
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="detail"><span>상세보기</span></a>
                </p>
            </div>
            <div class="graph" id="MAGNETOPAUSE_RADIUS"></div>
        </div>
        <!-- END GRAPH 4 -->
    		</td>
    	</tr>
        </table>
    </div>
    <!-- END 그래프 -->
</div>
<!-- END WRAP -->

<div class="ui-layout-south"></div>

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