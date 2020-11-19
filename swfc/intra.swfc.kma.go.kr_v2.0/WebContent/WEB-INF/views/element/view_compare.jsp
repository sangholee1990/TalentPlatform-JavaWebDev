<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="com.gaia3d.web.dto.*, java.util.*"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%
	SWFCImageMetaDTO item1 = (SWFCImageMetaDTO)request.getAttribute("item1");
	if(item1 != null) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(item1.getCreateDate());
		pageContext.setAttribute("item1hour", cal.get(Calendar.HOUR_OF_DAY));
		pageContext.setAttribute("item1minute", cal.get(Calendar.MINUTE));
	}
	
	SWFCImageMetaDTO item2 = (SWFCImageMetaDTO)request.getAttribute("item2");
	if(item2 != null) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(item2.getCreateDate());
		pageContext.setAttribute("item2hour", cal.get(Calendar.HOUR_OF_DAY));
		pageContext.setAttribute("item2minute", cal.get(Calendar.MINUTE));
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 우주기상인트라넷</title>
<link rel="stylesheet" type="text/css" href="../css/default.css"  />
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<!--[if lt IE 9]><script type="text/javascript" src="<c:url value="/js/flashcanvas.js"/>"></script><![endif]-->
<script type="text/javascript" src="<c:url value="/js/jcanvas.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/date.format.js"/>"></script>
<script type="text/javascript">
$(function() {
	var datepickerOption = {
			changeYear : true,
			showOn : "button",
			buttonImage : '../images/btn_calendar.png',
			buttonImageOnly : true,
			onSelect:function(dateText, inst) {
				inst.input.trigger("change");
			}
		};
	$("#item1date").datepicker(datepickerOption);
	$("#item2date").datepicker(datepickerOption);
		
	$("#item1date").on("change", function() {
		loadMinute1();
	});
	
	$("#item1hour").on("change", function() {
		loadMinute1();		
	});
	
	$("#item1minute").on("change", function() {
		loadImage($("#canvas"), $(this).val());
	});

	$("#item2date").change(function() {
		loadMinute2();
	});
	
	$("#item2hour").on("change", function() {
		loadMinute2();		
	});
	
	$("#item2minute").on("change", function() {
		loadImage($("#canvas2"), $(this).val());
	});
		
	$("<canvas id='canvas'></canvas>").appendTo($("#canvasContainer"));
	$("<canvas id='canvas2'></canvas>").appendTo($("#canvasContainer2"));
	if (typeof FlashCanvas != "undefined") {
		var canvasElement = $("#canvas").get(0);
	    FlashCanvas.initElement(canvasElement);
	    
		var canvasElement2 = $("#canvas2").get(0);
	    FlashCanvas.initElement(canvasElement2);
	}
	$("#canvas").drawImage({
		layer: true,
		draggable: true,
		source: "view_browseimage.do?id=${item1.id}",
		x:0,
		y:0,
		width:512,
		height:512,
		fromCenter : false,
	});
	
	$("#canvas2").drawImage({
		layer: true,
		draggable: true,
		source: "view_browseimage.do?id=${item2.id}",
		x:0,
		y:0,
		width:512,
		height:512,
		fromCenter : false,
	});
	
    $(window).resize( respondCanvas );

    function respondCanvas(){ 
    	var container = $('#canvasContainer');
    	var width = container.width();
    	var heigth = container.height();
    	$("#canvas").attr('width', width ); //max width
    	$("#canvas").attr('height', heigth ); //max height
    	$("#canvas2").attr('width', width ); //max width
    	$("#canvas2").attr('height', heigth ); //max height
    	
    	$("#canvas").drawLayers();
    	$("#canvas2").drawLayers();
        //Call a function to redraw other content (texts, images etc)
    }
    respondCanvas();
    
    $("#canvas1ctrl a").click(function() {
    	if($(this).hasClass("allview")) {
    		zoom($("#canvas"), 0);
    	} else if($(this).hasClass("zoomin")) {
    		zoom($("#canvas"), 1);
    	} else {
    		zoom($("#canvas"), -1);
    	}
    });
    
    $("#canvas2ctrl a").click(function() {
    	if($(this).hasClass("allview")) {
    		zoom($("#canvas2"), 0);
    	} else if($(this).hasClass("zoomin")) {
    		zoom($("#canvas2"), 1);
    	} else {
    		zoom($("#canvas2"), -1);
    	}
    });    
});

function loadMinute1() {
	var date = $("#item1date").datepicker('getDate');
	var selectedDate = $.datepicker.formatDate("yymmdd", date) + $("#item1hour").val();
	$.ajax({
		url: "search_in_time.do",
		data: "id=${item1.id}&date=" + selectedDate,
		dataType: "json"
		}).success(function(data) {
			var optionString = "";
			$.each(data, function(idx, info) {
				var date = new Date(info.createDate);
				optionString += "<option value=\"" + info.id + "\">" + date.format("MM") + "</option>";
			});
			$("#item1minute").empty().append(optionString).trigger("change");
		});
}

function loadMinute2() {
	var date = $("#item2date").datepicker('getDate');
	var selectedDate = $.datepicker.formatDate("yymmdd", date) + $("#item2hour").val();
	$.ajax({
		url: "search_in_time.do",
		data: "id=${item2.id}&date=" + selectedDate,
		dataType: "json"
		}).success(function(data) {
			var optionString = "";
			$.each(data, function(idx, info) {
				var date = new Date(info.createDate);
				optionString += "<option value=\"" + info.id + "\">" + date.format("MM") + "</option>";
			});
			$("#item2minute").empty().append(optionString).trigger("change");
		});
}


function loadImage(canvas, id) {
	canvas.removeLayers();
	if(id != null) {
		canvas.drawImage({
			layer: true,
			draggable: true,
			source: "view_browseimage.do?id=" + id,
			x:0,
			y:0,
			width:512,
			height:512,
			fromCenter : false,
		});
	}
}

function zoom(canvas, delta) {
	var layer = canvas.getLayer(0);
	if(delta == 0) {
		layer.scale = 1;
		layer.x = 0;	
		layer.y = 0;
	} else {
		layer.scale *= delta > 0 ? 1.5 : (1/1.5);
	}
	canvas.drawLayers();
}
</script>
</head>

<body scroll="no">
<div id="compare">
<div class="compare_wrap" style="height:35px;">
	<div>
        <h5><img src="<custom:MetaImageIconConverter value="${item1.code}"/>"/></h5>
        <div class="date_wrap" style="width:100%;margin-bottom:0px;">
            <input type="text" size="12" id="item1date" value="<fmt:formatDate type="date" value="${item1.createDate}" pattern="yyyy-MM-dd"/>"/>
            <select id="item1hour">
            	<c:forEach begin="0" end="23" var="item">
            	<option value="<fmt:formatNumber minIntegerDigits="2" value="${item}" />" <c:if test="${item1hour == item}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${item}"/></option>
            	</c:forEach>
            </select>시
            <select id="item1minute">
            	<c:forEach items="${item1List}" var="item">
            	<option value="${item.id}" <%
            	SWFCImageMetaDTO item = (SWFCImageMetaDTO)pageContext.getAttribute("item");
            	Integer itemHour = (Integer)pageContext.getAttribute("item1minute");
            	if(itemHour != null) {
	            	Calendar cal = Calendar.getInstance();
	            	cal.setTime(item.getCreateDate());
	            	if(cal.get(Calendar.MINUTE) == itemHour) 
	            		out.print("selected=\"selected\"");
            	}
            	%>><fmt:formatDate type="date" value="${item.createDate}" pattern="mm" timeZone="UTC"/></option>
            	</c:forEach>
            </select>분
        </div>
    </div>
    <div>
    	<h5><img src="<custom:MetaImageIconConverter value="${item2.code}"/>"/></h5>
        <div class="date_wrap" style="width:100%;margin-bottom:0px;">
            <input type="text" size="12" id="item2date" value="<fmt:formatDate type="date" value="${item2.createDate}" pattern="yyyy-MM-dd"/>"/><img src="../images/btn_calendar.png" class="imgbtn" />
            <select id="item2hour">
            	<c:forEach begin="0" end="23" var="item">
            	<option value="<fmt:formatNumber minIntegerDigits="2" value="${item}" />" <c:if test="${item2hour == item}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${item}" /></option>
            	</c:forEach>
            </select>시
            <select id="item2minute">
            	<c:forEach items="${item2List}" var="item">
            	<option value="${item.id}" <%
            	SWFCImageMetaDTO item = (SWFCImageMetaDTO)pageContext.getAttribute("item");
            	Integer itemHour = (Integer)pageContext.getAttribute("item2minute");
            	if(itemHour != null) {
	            	Calendar cal = Calendar.getInstance();
	            	cal.setTime(item.getCreateDate());
	            	if(cal.get(Calendar.MINUTE) == itemHour) 
	            		out.print("selected=\"selected\"");
            	}
            	%>><fmt:formatDate type="date" value="${item.createDate}" pattern="mm" timeZone="UTC"/></option>
            	</c:forEach>
            </select>분
        </div>
    </div>
</div>
<div class="compare_wrap" style="height:512px;margin-top:50px;">
	<div id="canvas2ctrl" class="ctrbtn" style="position:absolute;top:85px;left:50%;width:150px;height:30px;">
    	<a href="#" class="allview"></a>
        <a href="#" class="zoomin"></a> 
        <a href="#" class="zoomout"></a> 
    </div>
    
    <div id="canvas1ctrl" class="ctrbtn" style="position:absolute;top:85px;left:5px;width:150px;height:30px;">
    	<a href="#" class="allview"></a>
        <a href="#" class="zoomin"></a> 
        <a href="#" class="zoomout"></a> 
    </div>	
    	
	<div id="canvasContainer"></div>
	
	<div id="canvasContainer2"></div>
</div>



</div>
</body>
</html>
