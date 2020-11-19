<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="../css/default.css" />
<style type="text/css">
body { 
  margin:0; 
  padding:0; 
  height:100%; 
}
</style>
<jsp:include page="../include/jquery.jsp" />
<script type="text/javascript">
$(function() {
	
});
</script>
</head>
<body>
	<div id="popup">
		<h2></h2>
	</div>
	<div class="view" style="position:absolute;left:10px;right:10px;top:50px;bottom:10px;">
		<img src="getSpeImage.do?tm=${param.tm}" style="width:100%;"/>
	</div>
</body>
</html>