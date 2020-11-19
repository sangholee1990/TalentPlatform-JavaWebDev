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
	var bodyWidth = $(window).width()/3;
	$("iframe").attr("width", bodyWidth);  
	$("iframe").attr("height", bodyWidth);
}) 
$(window).resize(function(){	
	var bodyWidth = $(window).width()/3;	 
	$("iframe").attr("width", bodyWidth); 
	$("iframe").attr("height", bodyWidth);
}).resize()
  
  
$(function(){
	
	$("#airway").change(function() {
		
		var value = $(this).val(); 
		
		if(value==""){  
			var src = "http://localhost:8080/SWFCWeb/ko/specificContent/hcp_world.do";		 
			$("#iframe1").attr("src", src);   
		}else if(value==2){
			var src = "http://localhost:8080/SWFCWeb/ko/specificContent/hcp_airway.do" ;		 
			$("#iframe1").attr("src", src);  
		}else if(value==3){
			var src = "http://localhost:8080/SWFCWeb/ko/specificContent/ovation.do" ;		 
			$("#iframe1").attr("src", src);  
		}else if(value==4){
			var src = "http://localhost:8080/SWFCWeb/ko/specificContent/tec_world.do" ;		 
			$("#iframe1").attr("src", src);  
		}else if(value==5){
			var src = "http://localhost:8080/SWFCWeb/ko/specificContent/tec_korea.do" ;		 
			$("#iframe1").attr("src", src);
		}else if(value==6){
			var src = "http://localhost:8080/SWFCWeb/ko/specificContent/rbsp.do" ;		 
			$("#iframe1").attr("src", src);
		}else if(value==7){
			var src = "http://localhost:8080/SWFCWeb/ko/specificContent/drap.do" ;		 
			$("#iframe1").attr("src", src);
		}else if(value==8){
			var src = "http://localhost:8080/SWFCWeb/ko/specificContent/mag.do" ;		 
			$("#iframe1").attr("src", src);
		} 
	}) 
})
</script>
</head>
<body> 
	<iframe width='800' height='800' src="http://localhost:8080/SWFCWeb/ko/specificContent/hcp_world.do" 
	frameborder='3' scrolling='auto' marginwidth=0 marginheight=0 id='iframe1'></iframe><br>
	
	<select id="airway">
		<option value="">전지구피폭량</option>
		<option value="2">항공로피폭량</option>
		<option value="3">OVATION</option>
		<option value="4">TEC WORLD</option>
		<option value="5">TEC KOREA</option>
		<option value="6">RBSP</option>
		<option value="7">DRAP</option>
		<option value="8">MAG</option>		
	</select>
	
	 
	
</body>
</html>