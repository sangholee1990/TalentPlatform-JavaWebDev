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
<style type="text/css">
html {height:100%;}
</style>
<script type="text/javascript" src="<c:url value="/js/jquery-1.10.2.min.js"/>"></script>
<!--[if lt IE 9]><script type="text/javascript" src="<c:url value="/js/flashcanvas.js"/>"></script><![endif]-->
<script type="text/javascript" src="<c:url value="/js/jcanvas.min.js"/>"></script>
<script type="text/javascript">
$(function() {
	$("<canvas id='canvas'></canvas>").appendTo($("#canvasContainer"));
	if (typeof FlashCanvas != "undefined") {
		var canvasElement = $("#canvas").get(0);
	    FlashCanvas.initElement(canvasElement);
	}
	var container = $('#canvasContainer');
	var width = container.width();
	var height = container.height();
	$("#canvas").drawImage({
		layer: true,
		draggable: true,
		source: "view_browseimage.do?id=${dao.id}",
		x:0,
		y:0,
		fromCenter : false,
	});
	
    $(window).resize( respondCanvas );

    function respondCanvas(){ 
    	var container = $('#canvasContainer');
    	var width = container.width();
    	var heigth = container.height();
    	$("#canvas").attr('width', width ); //max width
    	$("#canvas").attr('height', heigth ); //max height
    	$("#canvas").drawLayers();
        //Call a function to redraw other content (texts, images etc)
    }
    respondCanvas();
    
    $(".ctrbtn a").click(function() {
    	if($(this).hasClass("allview")) {
    		zoom(0);
    	} else if($(this).hasClass("zoomin")) {
    		zoom(1);
    	} else {
    		zoom(-1);
    	}
    });
    
    $("#image_view").click(function() {
    	$(this).addClass("on");
    	$("#movie_view").removeClass("on");
    	$("#imageView").show();
    	$("#movieView").hide();
    });
    
    $("#movie_view").click(function() {
		window.open("view_movie.do?id=${dao.id}", '_blank','width=512,height=512,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
    });
});

function zoom(delta) {
	var canvas = $("#canvas");
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

<body>
<div id="popup">
	<h2>원본보기</h2>
    <h3><img src="<custom:MetaImageIconConverter value="${dao.code}"/>"/> <fmt:formatDate value="${dao.createDate}" pattern="yyyy.MM.dd HH:mm"/> </h3>
    
    <ul class="tab_result">
    	<li><a href="#" id="image_view" class="on">원본</a></li>
        <li><a href="#" id="movie_view">동영상</a></li>
    </ul>
    <div id="imageView">
		<div class="ctrbtn" style="position:absolute;top:120px;left:15px;width:150px;height:30px;">
	    	<a href="#" class="allview"></a>
	        <a href="#" class="zoomin"></a> 
	        <a href="#" class="zoomout"></a> 
	    </div>	
		<div class="view">
			<div id="canvasContainer" class="view" style="width:1024px;height:1024px"></div>
		</div>
	</div>
	<div id="movieView">
		<img id="movie_image"/>
	</div>
</div>
</body>
</html>
