<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../../../../include/jquery.jsp" />
<jsp:include page="../../../../include/jquery-ui.jsp" />
<script type="text/javascript">
$( document ).ready(function(){
	var bodyWidth = $(window).width();	 
	$("img").attr("width", bodyWidth);  
}) 
$(window).resize(function(){	
	var bodyWidth = $(window).width();	 
	$("img").attr("width", bodyWidth);    
}).resize()
$(function(){

	$("#height").change(function() { 
		var selected = $(this).val();
	
		var src = "<c:url value='/ko/specificContent/swaa_image.do?type=tec_world&alt="+selected+"'/>"
		
	    $("img").attr("src",src);		
		 
	}) 
})  


</script>
</head>
<body> 
<div style="position:absolute; top:5px; right:5px; background:white; color:black; border:1px solid white; z-index:1000">
	<select id="height">
		<option value="00">00</option>
		<option value="02">02</option>
		<option value="04">04</option>
		<option value="06">06</option>
		<option value="08">08</option>
		<option value="10">10</option>
		<option value="12">12</option>
		<option value="14">14</option>
		<option value="16">16</option>	
		<option value="18">18</option>
		<option value="20">20</option>
		<option value="22">22</option>	
	</select>
</div>	 
	 <img src="<c:url value="/ko/specificContent/swaa_image.do?type=tec_world"/>"/> 
</body>
</html>