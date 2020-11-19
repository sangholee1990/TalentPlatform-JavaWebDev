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
		<font size="5">전자플럭스(GOES-13 2MeV) 도움말</font>
		</div> 
		<div class="queTable">
		<font size="3">
		 2MeV : GOES-13 및 15 위성이 관측한 전자플럭스 값을 과거 24시간에 대해 누적한 것이다. 
		 2MeV 전자플럭스가 높은 상태를 장시간 유지하면 내부대전현상 발생확률이 높아진다. 
		 내부대전현상의 감시등급을 전자플럭스에 따라 5단계로 나누어 가이던스를 제공한다. <br></br>
		※ 내부대전현상의 영향 : 고에너지 전자는 쉽게 위성체의 보호막을 관통하고 유전체(동축케이블, 회로판, 절연체 등)에 머무르며 대전된다. 
		만일 전자 플럭스가 일정 기간 이상 높게 지속되면, 위성의 깊은 곳에서 급속한 방전이 발생할 수 있다.
		</font><br></br>
		<table align="center">
			<tr>
				<td>등급</td>
				<td>2MeV 전자 플럭스 누적량(/cm<sup>-2</sup>s<sup>-1</sup>sr<sup>-1</sup>)</td>
			</tr>
			<tr>
				<td>5(심각)</td>
				<td>1.2×10<sup>9</sup> ≤ 전자 플럭스  </td>
			</tr>
			<tr>
				<td>4(경계)</td>
				<td>4.4×10<sup>8</sup> ≤ 전자 플럭스 < 1.2×10<sup>9</sup></td>
			</tr>
			<tr>
				<td>3(주의)</td>
				<td>5.7×10<sup>7</sup> ≤ 전자 플럭스 < 4.4×10<sup>8</sup></td>
			</tr>
			<tr>
				<td>2(관심)</td>
				<td>7.5×10<sup>6</sup> ≤ 전자 플럭스 < 5.7×10<sup>7</sup></td>
			</tr>
			<tr>
				<td>1(일반)</td>
				<td>전자 플럭스 <7.5×10<sup>6</sup></td>
			</tr>
		</table> 
		</div> 
</body>
</html>