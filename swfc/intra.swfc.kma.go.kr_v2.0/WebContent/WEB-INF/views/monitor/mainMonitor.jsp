<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.code.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%

	Integer min = 1; //화면 갱신 주기
	Integer index = 1; //처음 표출할 화면 번호
	boolean rotate = true; //자동 새로고침 여부
	
	try{
		min = Integer.parseInt( request.getParameter("min") );
	}catch(NumberFormatException e){
		min = 1;
	}
	
	try{
		index = Integer.parseInt( request.getParameter("index") );
	}catch(NumberFormatException e){
		index = 1;
	}
	
	try{
		rotate = Boolean.parseBoolean(request.getParameter("rotate") );
	}catch(NumberFormatException e){
		rotate = true;
	}
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
<style type="text/css">
	iframe {
		width : 100%;
		border : 0px;
	}
</style>
</head>
<body>
	<iframe id="frame1" src="<c:url value="/monitor/monitor.do"/>" style="display:<%= (index == 1) ? "block":"none" %>;"></iframe>
	<iframe id="frame2" src="<c:url value="/monitorSWAA/monitor1.do"/>" style="display:<%= (index == 2) ? "block":"none" %>;"></iframe>
  	<iframe id="frame3" src="<c:url value="/monitorSWAA/monitor2.do"/>" style="display:<%= (index == 3) ? "block":"none" %>;"></iframe>
 <script language="javascript">
	var timer = <%= min %>;
	var index = <%= index %>;
	var isRotate = <%= rotate  %>;
	var currentFrame = <%= index %>;	
	function init(){
		window.setInterval("rotate()", 1000 * 60 * timer);
	}

	function rotate(){
		document.getElementById('frame' + currentFrame).style.display = 'none';
		currentFrame++;
		var frameLen = document.getElementsByTagName('iframe').length;		
		if(frameLen < currentFrame) currentFrame = 1;
		document.getElementById('frame' + currentFrame).style.display = 'block';
	}
	
	function reSize(){
		var space = $(window).height();
		$('iframe').each(function(){
			$(this).css({"height" : space + "px"});
		});	
	}
	
	$( window ).resize(function() {
		reSize();
	});
	
	$(function() {
		reSize();
		if(isRotate)init();
	});
	//init();
  </script>
</body>
</html>