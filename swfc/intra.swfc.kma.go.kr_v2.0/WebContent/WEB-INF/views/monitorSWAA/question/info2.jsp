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
		<font size="5">극항로 방사선 등급 </font>
		</div>  
		<div class="queTable">
		<font size="4"> 
		10MeV이상의 태양 양성자 현상에 의한 극항로 방사선 피폭량 등급을 나타낸다. 10MeV 이상의 태양 양성자 현상의 경우 고도 10~15km에 주로 방사선량을 증가시킨다. 태양 양성자 현상(특보기준 3등급의 경우)이 동반했을 때 우주선(Galactic Cosmic Radiation)만 고려했을 경우보다 방사선 피폭량이 최대 약 3.5배 증가하는 것으로 나타났다.  
		태양 양성자 현상의 등급 기준은 다음과 같다. (NOAA 기준을 준용) 
		</font><br>
		</br> 
		<table>
			<tr>
				<td>등급</td>
				<td>10MeV 양성자 플럭스(/cm<sup>-2</sup>s<sup>-1</sup>sr<sup>-1</sup>)</td>
			</tr>
			<tr>
				<td>5(심각)</td>
				<td>100000 ≤ 양성자 플럭스  </td>
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
		</table>
		※ 입자/cm<sup>-2</sup>s<sup>-1</sup>sr<sup>-1</sup> = Particle Flux Unit(pfu)  
		</div> 
</body>
</html>