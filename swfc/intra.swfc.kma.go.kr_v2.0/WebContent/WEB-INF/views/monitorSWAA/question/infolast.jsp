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
table {border: 1px solid white; width: 450px ; height:250px; left: 30% } 
td {border: 1px solid white; text-align: center; vertical-align: middle}
</style>
<script type="text/javascript" src="<c:url value="/js/date.format.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.mousewheel.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/perfect-scrollbar.js"/>"></script>

</head>
<body> 

	<div class="queTitle">
		<font size="6">극항로 통신장애 등급 </font>
		</div>  

		<div class="queTable">
		<font size="4"> 
		 10MeV이상의 태양 양성자 현상에 의한 극항로 통신장애 등급을 나타낸다. 통신에 영향을 주는 우주기상 주요 요소는 X-ray 플럭스와 양성자 플럭스인데, 고위도 지방의 경우 양성자 플럭스에 지배적인 영향을 받기 때문에 태양 양성자 현상에 대해 등급을 나누었다. 북위 65도이상의 지역에서 0등급은 HF통신(3~30MHz)이 모두 가능하며, 1등급 이상의 경우는 HF통신이 불가능하다.  
		태양 양성자 현상의 등급 및 통신가능 주파수는 다음과 같다.  
		</font><br>
		</br>
		
		<table>
			<tr>
				<td>등급</td>
				<td>10MeV 양성자 플럭스(/cm<sup>-2</sup>s<sup>-1</sup>sr<sup>-1</sup>)</td>
				<td>통신가능 주파수</td>
			</tr>
			<tr>
				<td>5(심각)</td>
				<td>100000 ≤ 양성자 플럭스  </td>
				<td></td>
			</tr>
			<tr>
				<td>4(경계)</td>
				<td>10000 ≤ 양성자 플럭스 < 100000</td>
				<td></td>
			</tr>
			<tr>
				<td>3(주의)</td>
				<td>1000 ≤ 양성자 플럭스 < 10000</td>
				<td>약 90Hz이상</td>
			</tr>
			<tr>
				<td>2(관심)</td>
				<td>100 ≤ 양성자 플럭스 < 1000</td>
				<td>약 85MHz이상</td>
			</tr>
			<tr>
				<td>1(일반)</td>
				<td>10 ≤ 양성자 플럭스 < 100</td>
				<td>약 50MHz이상</td>
			</tr>
		</table>
		※ 입자/cm<sup>-2</sup>s<sup>-1</sup>sr<sup>-1</sup> = Particle Flux Unit(pfu) 
		</div>
	 
	



</body>
</html>