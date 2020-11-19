<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.code.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 도움말</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/monitorSWAA.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/perfect-scrollbar.css"/>"/>
<jsp:include page="../../include/jquery.jsp" />
<jsp:include page="../../include/jquery-ui.jsp" />
<script type="text/javascript" src="<c:url value="/js/jquery.layout-latest.min.js"/>"></script>
<style>
#ui-datepicker-div {
  z-index: 9999999!important;
}
.dygraph-ylabel{
	font-weight: bold;
}
table {border: 1px solid white; width: 450px ; height:300px; left: 30% } 
td {border: 1px solid white; text-align: center; vertical-align: middle}
</style>
<script type="text/javascript" src="<c:url value="/js/date.format.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.mousewheel.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/perfect-scrollbar.js"/>"></script> 
</head>
<body> 
		<div class="queTitle">
		<font size="5">양성자 플럭스 (GOES-13) 도움말 </font>
		</div>  
		<div class="queTable">
		<font size="4"> 
		 태양에서 방출되는 양성자의 플럭스 차트이다. 양성자 플럭스는 극항로 우주방사선 증가와 극지방 통신장애에 직접적인 영향을 주는 요소이다. 국가기상위성센터에서는 태양 양성자 플럭스를 미국대기해양청(NOAA)의 등급기준을 준용하여 감시하고 있다.
		차트에서 각 등급의 임계값은 점선으로 표시하였다. (등급내용은 아래의 표 참고) 
		</font><br>
		</br>
		
		<table>
			<tr>
				<td>등급</td>
				<td>10MeV 양성자 플럭스(/cm<sup>-2</sup>s<sup>-1</sup>sr<sup>-1</sup>)</td>
			</tr>
			<tr>
				<td>5(심각)</td>
				<td>100000 ≤ 양성자 플럭스 </td>
			</tr>
			<tr>
				<td>4(경계)</td>
				<td>10000 ≤ 양성자 플럭스 < 100000</td>
			</tr>
			<tr>
				<td>3(주의)</td>
				<td>1000 ≤ 양성자 플럭스 < 10000</td>
			</tr>
			<tr>
				<td>2(관심)</td>
				<td>100 ≤ 양성자 플럭스 < 1000</td>
			</tr>
			<tr>
				<td>1(일반)</td>
				<td>10 ≤ 양성자 플럭스 < 100</td>
			</tr>
		</table><br>
		<font size="3">※ k = 10<sup>3</sup></font>
		</div>
	 
	



</body>
</html>