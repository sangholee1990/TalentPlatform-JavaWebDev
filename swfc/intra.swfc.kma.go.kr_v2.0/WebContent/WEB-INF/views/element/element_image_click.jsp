<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<script type="text/javascript">
$( document ).ready(function(){
	var bodyWidth = $(window).width();	 
	$("img").attr("width", bodyWidth);  
}) 
$(window).resize(function(){	
	var bodyWidth = $(window).width();	 
	$("img").attr("width", bodyWidth);    
}).resize()
</script>
</head>
<body>
	<img src="<c:url value='${imagesrc}'/>"/>
</body>
</html>