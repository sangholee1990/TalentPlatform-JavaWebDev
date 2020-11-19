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
		var src = "<c:url value='/ko/specificContent/swaa_image.do?type=HCP_KOREA&airway="+selected+"'/>"; 
	    $("img").attr("src",src);		 
	}) 
})


</script>
</head>
<body> 
<div style="position:absolute; top:5px; right:5px; background:white; color:black; border:1px solid white; z-index:1000">
	<select id="height">
		<option value="ICN-LHR">ICN-LHR</option>
		<option value="IST-ICN">IST-ICN</option>
		<option value="JFK-ICN">JFK-ICN</option>
		<option value="JFK-ICN-polar">JFK-ICN-polar</option>
		<option value="LAX-ICN">LAX-ICN</option>
		<option value="MSC-ICN">MSC-ICN</option>
		<option value="PAR-ICN">PAR-ICN</option>
		<option value="SAT-ICN">SAT-ICN</option>
		<option value="DEL-ICN">DEL-ICN</option>		
	</select>
</div>	
	<img src="<c:url value="/ko/specificContent/swaa_image.do?type=HCP_KOREA&airway=DEL-ICN"/>"/>
	
</body>
</html>