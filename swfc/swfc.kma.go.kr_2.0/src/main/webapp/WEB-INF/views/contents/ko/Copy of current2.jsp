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
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>우주기상 예특보 서비스 :: 국가기상위성센터</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/default.css"/>"  />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/js/datetimepicker-master/jquery.datetimepicker.css"/>"  />
<style>
.dygraph-ylabel{
	font-weight: bold;
	color:white;
}
</style>
<jsp:include page="/WEB-INF/views/include/jquery.jsp" />
<jsp:include page="/WEB-INF/views/include/jquery-ui.jsp" />
<jsp:include page="/WEB-INF/views/include/dygraph.jsp" />
<script type="text/javascript" src="<c:url value="/resources/common/js/datetimepicker-master/jquery.datetimepicker.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/common/js/date.format.js"/>"></script>
<script type="text/javascript">

var imageManager1 = null;
var imageManager2 = null;
var imageManager3 = null;
var imageManager4 = null;

var timer =  {
		date: new Date(),
		imageTimer: setInterval("timer.imageUpdate()", 1000*60*5),
		imageUpdate: function() {
			imageManager1.load();
			imageManager2.load();
			imageManager3.load();
			imageManager4.load();
		}		
	};

var imageSearchCalenar = {
		imageManager: null,
		initialize: function() {
			var datepickerOption = {
				changeYear:true,
				showOn: "button",
				buttonImage: '<c:url value="/resources/ko/images/btn_calendar.png"/>', 
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
	this.image = container.find(".contents img");
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
			this.image.attr("src", "<c:url value="/ko/monitor/view_movie.do"/>?id=" + data.id + "&size=512&frames=100");
			this.image.attr("alt", "<c:url value="/ko/monitor/view_movie.do"/>?id=" + data.id + "&size=512&frames=100");
		} else {
			this.image.attr("src", "<c:url value="/ko/monitor/view_browseimage.do"/>?id=" + data.id);
			this.image.attr("alt", "<c:url value="/ko/monitor/view_browseimage.do"/>?id=" + data.id);
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


$(function() {
	
	
	imageSearchCalenar.initialize();
	
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
	chartGraphManager.updateOptions({autoRefresh:false});
	chartGraphManager.addProtonFlux(chartOption);
	chartGraphManager.addKpIndexSwpc(chartOption);
	chartGraphManager.addMagnetopauseRadius(chartOption);
	
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
	
	/*
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
	
});
</script>
<style>
	.cgroup .title {
		position: relative;
		
	}
	.cgroup .title .top_con{
		float:left;
			height:32px;
			line-height: 32px;
			overflow: hidden;
	}

	.cgroup .title .top_con > .arrow{
		float:left;
		cursor: pointer;
		margin-top:11px;
		margin-right:4px;
		margin-left: 2px;
		vertical-align: middle;
	}
	
	.cgroup .title .top_con .select_box{
		float:left;
		display:block;
		font-size:13px;
		font-weight:bold;
		width: 130px;
		cursor: pointer;
	}
	
	.cgroup .title .top_con .t_date{
		float:left;
		display:block;
		font-size:12px;
		letter-spacing:-1px;
		font-weight:bold;
		width: 95px;
	}
	
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

	.cgroup .title .select_list{
		position: absolute;
		top:30px;
		left:0;
		list-style: none;
		padding:0;
		margin:0;
	}
	.cgroup .title .select_list > li{
		padding:5px 10px;
		background: gray;
		border-top:1px solid #ffffff;
	}
	.cgroup .title .select_list > li.selected{
		background: #000;
	}
	
	.cgroup .title .select_list > li:FIRST-CHILD {
		border:none;
    }
    
    
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/topMenu.jsp"/>
<div id="wrap_current">
	<h3 class="sun"><span>태양영상</span></h3>
	<div class="wrap_sun">
        <div class="cgroup s_sun" id="imageManager1">
        	<div class="title">
        		<div class="top_con">
        			<a href="#" class="arrow"><img src="<c:url value="/resources/ko/images/ico_arrow.png"/>" alt="" /></a>
        			<span class="select_box on" name="SDO__01001">SDO/AIA 0131</span><span class="t_date"></span> 
        			<button class="cal"></button> 
        			<button class="vod"></button> 
        		 </div>
        		<ul class="select_list" style="display: none;">
        			<li code="SDO__01001">SDO/AIA 0131</li>
        			<li code="SDO__01002">SDO/AIA 0171</li>
        			<li code="SDO__01003">SDO/AIA 0193</li>
        			<li code="SDO__01004">SDO/AIA 0211</li>
        			<li code="SDO__01005">SDO/AIA 0304</li>
        			<li code="SDO__01006">SDO/AIA 1600</li>
        			<li code="SOHO__01001">SOHO/LASCO C2</li>
        			<li code="SOHO__01002">SOHO/LASCO C3</li>
        			<li code="STA__01001">STA/COR1</li>
        			<li code="STA__01002">STA/COR2</li>
        			<li code="STB__01001">STB/COR1</li>
        			<li code="STB__01002">STB/COR2</li>
        		</ul>
        		<!-- 
            	<h5>${imageList.SDO__01001.codeText}</h5>
        		 -->
            </div>
            <div class="body s_sun contents">
            	<img src="<c:url value="${imageList.SDO__01001.imageUrl}"/>" alt="" style="width:100%;max-height:100%"/>
            </div>
        </div>
        
        <div class="cgroup s_sun" id="imageManager2">
        	<div class="title">
            	<div class="top_con">
            		<a href="#" class="arrow"><img src="<c:url value="/resources/ko/images/ico_arrow.png"/>" alt="" /></a>
        			 <span class="select_box  on" name="SDO__01002">SDO/AIA 0171</span><span class="t_date"></span> 
        			 <button class="cal"></button> 
        			 <button class="vod"></button> 
        		</div>
        		<ul class="select_list" style="display: none;">
        			<li code="SDO__01001">SDO/AIA 0131</li>
        			<li code="SDO__01002">SDO/AIA 0171</li>
        			<li code="SDO__01003">SDO/AIA 0193</li>
        			<li code="SDO__01004">SDO/AIA 0211</li>
        			<li code="SDO__01005">SDO/AIA 0304</li>
        			<li code="SDO__01006">SDO/AIA 1600</li>
        			<li code="SOHO__01001">SOHO/LASCO C2</li>
        			<li code="SOHO__01002">SOHO/LASCO C3</li>
        			<li code="STA__01001">STA/COR1</li>
        			<li code="STA__01002">STA/COR2</li>
        			<li code="STB__01001">STB/COR1</li>
        			<li code="STB__01002">STB/COR2</li>
        		</ul>
            </div>
            <div class="body s_sun contents">
            	<img src="<c:url value="${imageList.SDO__01002.imageUrl}"/>" alt="" style="width:100%;max-height:100%"/>
            </div>
        </div>
        
        <div class="cgroup s_sun" id="imageManager3">
        	<div class="title">
        		<div class="top_con">
        			<a href="#" class="arrow"><img src="<c:url value="/resources/ko/images/ico_arrow.png"/>" alt="" /></a>
        			<span class="select_box on" name="SDO__01003">SDO/AIA 0193</span><span class="t_date"></span> 
        			<button class="cal"></button> 
        			<button class="vod"></button> 
        		 </div>
        		<ul class="select_list" style="display: none;">
        			<li code="SDO__01001">SDO/AIA 0131</li>
        			<li code="SDO__01002">SDO/AIA 0171</li>
        			<li code="SDO__01003">SDO/AIA 0193</li>
        			<li code="SDO__01004">SDO/AIA 0211</li>
        			<li code="SDO__01005">SDO/AIA 0304</li>
        			<li code="SDO__01006">SDO/AIA 1600</li>
        			<li code="SOHO__01001">SOHO/LASCO C2</li>
        			<li code="SOHO__01002">SOHO/LASCO C3</li>
        			<li code="STA__01001">STA/COR1</li>
        			<li code="STA__01002">STA/COR2</li>
        			<li code="STB__01001">STB/COR1</li>
        			<li code="STB__01002">STB/COR2</li>
        		</ul>
        		<!-- 
            	<h5>${imageList.SDO__01005.codeText}</h5>
        		 -->
            </div>
            <div class="body s_sun contents">
            	<img src="<c:url value="${imageList.SDO__01005.imageUrl}"/>" alt="" style="width:100%;max-height:100%"/>
            </div>
        </div>
        
        <div class="cgroup s_sun" id="imageManager4">
        	<div class="title">
        		<div class="top_con">
        			<a href="#" class="arrow"><img src="<c:url value="/resources/ko/images/ico_arrow.png"/>" alt="" /></a>
        			<span class="select_box on" name="SDO__01004">SDO/AIA 0211</span><span class="t_date"></span> 
        			 <button class="cal"></button> 
        			 <button class="vod"></button> 
        		 </div>
        		<ul class="select_list" style="display: none;">
        			<li code="SDO__01001">SDO/AIA 0131</li>
        			<li code="SDO__01002">SDO/AIA 0171</li>
        			<li code="SDO__01003">SDO/AIA 0193</li>
        			<li code="SDO__01004">SDO/AIA 0211</li>
        			<li code="SDO__01005">SDO/AIA 0304</li>
        			<li code="SDO__01006">SDO/AIA 1600</li>
        			<li code="SOHO__01001">SOHO/LASCO C2</li>
        			<li code="SOHO__01002">SOHO/LASCO C3</li>
        			<li code="STA__01001">STA/COR1</li>
        			<li code="STA__01002">STA/COR2</li>
        			<li code="STB__01001">STB/COR1</li>
        			<li code="STB__01002">STB/COR2</li>
        		</ul>
        		<!-- 
            	<h5>${imageList.SDO__01004.codeText}</h5>
        		 -->
            </div>
            <div class="body s_sun contents">
            	<img src="<c:url value="${imageList.SDO__01004.imageUrl}"/>" alt="" style="width:100%;max-height:100%"/>
            </div>
        </div>
	</div>
    <!-- END 태양영상 -->
    
    <h3 class="alert"><span>예특보상황</span></h3>
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
        
        <div class="group s_alert">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_rad.png"/>" alt="태양복사폭풍" />
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.XRAY_H3}"/>">
					<p>${summary.XRAY_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.XRAY_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<p class="infotext">
					<span class="message fw">${summary.XRAY_H3.gradeText}</span> 
					<span>현재 : ${summary.XRAY_NOW.val} (W/m2)</span>
					<span>
					<c:choose>
						<c:when test="${summary.XRAY_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : ${summary.XRAY_H3.val} (W/m2)</span>
					<span><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></span>
				</p>
			</div>            
        </div>
        <!-- END 태양복사폭풍 -->
        <div class="group">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_par.png"/>" alt="태양입자폭풍" />
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.PROTON_H3}"/>">
					<p>${summary.PROTON_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.PROTON_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<p class="infotext">
					<span class="message fw">${summary.PROTON_H3.gradeText}</span> 
					<span>현재 : ${summary.PROTON_NOW.val} (pfu)</span>
					<span>
					<c:choose>
						<c:when test="${summary.PROTON_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : ${summary.PROTON_H3.val} (pfu)</span>
					<span><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></span>
				</p>
			</div>            
        </div>
        <!-- END 태양입자폭풍 -->
        <div class="group">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_ter.png"/>" alt="지자기폭풍" />
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.KP_H3}"/>">
					<p>${summary.KP_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.KP_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<p class="infotext">
					<span class="message fw">${summary.KP_H3.gradeText}</span> 
					<span>현재 : ${summary.KP_NOW.val}</span>
					<span>
					<c:choose>
						<c:when test="${summary.KP_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : ${summary.KP_H3.val}</span>
					<span><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></span>
				</p>
			</div>            
        </div>
        <!-- END 지자기폭풍 -->
        <div class="group">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_mag.png"/>" alt="자기권계면" />
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.MP_H3}"/>">
					<p>${summary.MP_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.MP_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<p class="infotext">
					<span class="message fw">${summary.MP_H3.gradeText}</span> 
					<span>현재 : ${summary.MP_NOW.val} (RE)</span>
					<span>
					<c:choose>
						<c:when test="${summary.MP_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : ${summary.MP_H3.val} (RE)</span>
					<span><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></span>
				</p>
			</div>            
        </div>
        <!-- END 자기권계면 -->
    
    
    </div>
    <!-- END 예특보상황 -->
    
    <h3 class="info"><span>지자기 및 전리권 관측정보</span></h3>
    <div class="wrap_info" style="height:500px;">
    	<div class="cgroup s_info">
        	<div class="title">
            	<h5>X-선 플럭스(GOES-13) [태양복사폭풍]</h5>
                <p class="date">
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="detail"><span>상세보기</span></a>
                </p>
                <ul class="select_list" >
        			<li code="ACE_MAG">ACE IMF 자기장</li>
        			<li code="ACE_SOLARWIND_SPD">ACE 태양풍 속도</li>
        			<li code="ACE_SOLARWIND_DENS">ACE 태양풍 밀도</li>
        			<li code="ACE_SOLARWIND_TEMP">ACE 태양풍 온도</li>
        			<li code="MAGNETOPAUSE_RADIUS">자기권계면 위치 [자기권계면]</li>
        			<li code="XRAY_FLUX">X-선 플럭스(GOES-13) [태양복사폭풍]</li>
        			<li code="PROTON_FLUX">양성자 플럭스(GOES-13) [태양복사폭풍]</li>
        			<li code="ELECTRON_FLUX">전자기 플럭스(GOES-13)</li>
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
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="detail"><span>상세보기</span></a>
                </p>
                <ul class="select_list" >
        			<li code="ACE_MAG">ACE IMF 자기장</li>
        			<li code="ACE_SOLARWIND_SPD">ACE 태양풍 속도</li>
        			<li code="ACE_SOLARWIND_DENS">ACE 태양풍 밀도</li>
        			<li code="ACE_SOLARWIND_TEMP">ACE 태양풍 온도</li>
        			<li code="MAGNETOPAUSE_RADIUS">자기권계면 위치 [자기권계면]</li>
        			<li code="XRAY_FLUX">X-선 플럭스(GOES-13) [태양복사폭풍]</li>
        			<li code="PROTON_FLUX">양성자 플럭스(GOES-13) [태양복사폭풍]</li>
        			<li code="ELECTRON_FLUX">전자기 플럭스(GOES-13)</li>
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
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="detail"><span>상세보기</span></a>
                </p>
                <ul class="select_list" >
        			<li code="ACE_MAG">ACE IMF 자기장</li>
        			<li code="ACE_SOLARWIND_SPD">ACE 태양풍 속도</li>
        			<li code="ACE_SOLARWIND_DENS">ACE 태양풍 밀도</li>
        			<li code="ACE_SOLARWIND_TEMP">ACE 태양풍 온도</li>
        			<li code="MAGNETOPAUSE_RADIUS">자기권계면 위치 [자기권계면]</li>
        			<li code="XRAY_FLUX">X-선 플럭스(GOES-13) [태양복사폭풍]</li>
        			<li code="PROTON_FLUX">양성자 플럭스(GOES-13) [태양복사폭풍]</li>
        			<li code="ELECTRON_FLUX">전자기 플럭스(GOES-13)</li>
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
                    <a href="#" class="calendar"><span>달력</span></a>
                    <a href="#" class="detail"><span>상세보기</span></a>
                </p>
                <ul class="select_list" >
        			<li code="ACE_MAG">ACE IMF 자기장</li>
        			<li code="ACE_SOLARWIND_SPD">ACE 태양풍 속도</li>
        			<li code="ACE_SOLARWIND_DENS">ACE 태양풍 밀도</li>
        			<li code="ACE_SOLARWIND_TEMP">ACE 태양풍 온도</li>
        			<li code="MAGNETOPAUSE_RADIUS">자기권계면 위치 [자기권계면]</li>
        			<li code="XRAY_FLUX">X-선 플럭스(GOES-13) [태양복사폭풍]</li>
        			<li code="PROTON_FLUX">양성자 플럭스(GOES-13) [태양복사폭풍]</li>
        			<li code="ELECTRON_FLUX">전자기 플럭스(GOES-13)</li>
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

<div class="layer_graph" style="top:955px; left:595px;display:none;" id="calendar_layer">
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
