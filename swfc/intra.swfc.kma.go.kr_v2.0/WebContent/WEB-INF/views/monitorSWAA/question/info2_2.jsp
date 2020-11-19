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
table {border: 1px solid white; width: 490px ; height:300px; left: 5% } 
td {border: 1px solid white; text-align: center; vertical-align: middle}
 
</style>
<script type="text/javascript" src="<c:url value="/js/date.format.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.mousewheel.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/perfect-scrollbar.js"/>"></script>

</head>
<body> 
		<div class="queTitle">
		<font size="6">기상위성 운영등급 </font>
		</div> 
		<div class="queTable">
		<font size="4"> 정지궤도에서 위성의 표면대전과 내부대전현상의 감시수준을 5단계로 나누어 융합 표출한 것이다. 표면대전등급은 40keV 전자플럭스를 기준으로 사용하였고, 내부대전등급은 현재시간을 기준으로 과거 24시간까지 >2MeV 전자플럭스 누적량을 기준으로 사용하였다. 두 등급 중 높은 등급으로 정지궤도위성 대전영향이 표출된다. 
		</font> 
		</br></div>
		<div class="info_pop">	
		<table align="center">
			<tr>
				<td>등급</td>
				<td>40keV 전자 플럭스(/cm<sup>-2</sup>s<sup>-1</sup>sr<sup>-1</sup>)</td>
				<td>2MeV 전자 플럭스 누적량(/cm<sup>-2</sup>s<sup>-1</sup>sr<sup>-1</sup>)</td>
			</tr>
			<tr>
				<td>5(심각)</td>
				<td>4.5×10<sup>5</sup> ≤ 전자 플럭스</td>
				<td>1.2×10<sup>9</sup> ≤ 전자 플럭스</td>
			</tr>
			<tr>
				<td>4(경계)</td>
				<td>2.9×10<sup>5</sup> ≤ 전자 플럭스 < 4.5×10<sup>5</sup></td>
				<td>4.4×10<sup>8</sup> ≤ 전자 플럭스 < 1.2×10<sup>9</sup></td>
			</tr>
			<tr>
				<td>3(주의)</td>
				<td>1.2×10<sup>5</sup> ≤ 전자 플럭스 < 2.9×10<sup>5</sup></td>
				<td>5.7×10<sup>7</sup> ≤ 전자 플럭스 < 4.4×10<sup>8</sup></td>
			</tr>
			<tr>
				<td>2(관심)</td>
				<td>5.2×10<sup>4</sup> ≤ 전자 플럭스 < 1.2×10<sup>5</sup></td>
				<td>7.5×10<sup>6</sup> ≤ 전자 플럭스 < 5.7×10<sup>7</sup></td>
			</tr>
			<tr>
				<td>1(일반)</td>
				<td>전자 플럭스 < 5.2×10<sup>4</sup></td>
				<td>전자 플럭스 <7.5×10<sup>6</sup></td>
			</tr>
		</table>
		※ 입자//cm<sup>-2</sup>s<sup>-1</sup>sr<sup>-1</sup> = Particle Flux Unit(pfu) 
		</div>
		
	 
	



</body>
</html>