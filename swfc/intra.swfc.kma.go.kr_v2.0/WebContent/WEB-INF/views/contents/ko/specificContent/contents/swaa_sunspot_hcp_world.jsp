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
		var height = "";
		var selected = $(this).val();
		 
		if(selected==""){
			height = 0;
		}else if(selected=="2"){
			 height = 50;
		}else if(selected=="3"){
			height = 75;
		}else if(selected=="4"){
			height = 100;
		}
		  
		var src = "<c:url value='/ko/specificContent/swaa_image.do?type=HCP_WORLD&alt="+height+"'/>"
		
	    $("img").attr("src",src);		
		 
	}) 
})
</script>
</head>
<body>
<div style="position:absolute; top:5px; right:5px; background:white; color:black; border:1px solid white; z-index:1000">
<select id="height">
		<option value="">0km</option>
		<option value="2">5km</option>
		<option value="3">10km</option>
		<option value="4">15km</option>		
	</select>
</div>
	
	<img src="<c:url value="/ko/specificContent/swaa_image.do?type=HCP_WORLD&alt=0"/>" /> 
</body>
</html>