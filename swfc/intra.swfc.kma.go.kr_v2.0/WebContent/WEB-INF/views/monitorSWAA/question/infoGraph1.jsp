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
		<font size="5">전자플럭스(GOES-13 40KeV) 도움말</font>
		</div> 
		<div class="queTable">
		<font size="3">
		<br>
		40keV : GOES-13 및 15 위성이 관측한 40keV 이하의 전자플럭스를 평균한 것이다. 
		40keV 전자플럭스가 높아지면 표면대전현상 발생확률이 높아진다. 
		대전표면현상의 감시등급을 전자플럭스에 따라 5단계로 나누어 가이던스를 제공한다. 
		<br></br>
		※ 표면대전현상의 영향 : 위성체의 표면이 고전압으로 대전되는 것은 일반적으로 
		위성에 직접적인 영향을 주지는 않지만 위성체 부위별로 다른 수준으로 대전되어 
		방전이 이루어질 경우 위성체 표면에 해를 입힐 수 있으며 전자기파 간섭이 발생하여 위성체 내의 전자 장비에 해를 입힐 수 있다.
		</font>
		<br></br>
		<table align="center">
			<tr>
				<td>등급</td>
				<td>40keV 전자 플럭스(/cm<sup>-2</sup>s<sup>-1</sup>sr<sup>-1</sup>)</td>
			</tr>
			<tr>
				<td>5(심각)</td>
				<td>4.5×10<sup>5</sup> ≤ 전자 플럭스 </td>
			</tr>
			<tr>
				<td>4(경계)</td>
				<td>2.9×10<sup>5</sup> ≤ 전자 플럭스 < 4.5×10<sup>5</sup></td>
			</tr>
			<tr>
				<td>3(주의)</td>
				<td>1.2×10<sup>5</sup> ≤ 전자 플럭스 < 2.9×10<sup>5</sup></td>
			</tr>
			<tr>
				<td>2(관심)</td>
				<td>5.2×10<sup>4</sup> ≤ 전자 플럭스 < 1.2×10<sup>5</sup></td>
			</tr>
			<tr>
				<td>1(일반)</td>
				<td>전자 플럭스 < 5.2×10<sup>4</sup></td>
			</tr>
		</table> 
		</div> 
</body>
</html>