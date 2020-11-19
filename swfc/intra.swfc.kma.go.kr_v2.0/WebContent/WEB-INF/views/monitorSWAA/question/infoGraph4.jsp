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
		<font size="6">자기권계면 도움말 </font>
		</div> 
		<div class="queTable">
		<font size="4">
		태양풍의 변화에 따른 자기권계면의 위치를 나타낸 그림이다. 
		자기권계면은 태양풍에 의한 위험으로부터 정지궤도 위성을 보호한다. 
		정지궤도 위성의 안정적 운영을 위해 자기권계면 위치에 따라 위험수준를 5단계로 나누어 자기권계면 위치를 감시하고 있다. 
		자료는 1분마다 업데이트 된다. 
		</font>
		<br>
		</br>
		<table align="center">
			<tr>
				<td>등급</td>
				<td>자기권계면 위치(Re)</td>
			</tr>
			<tr>
				<td>5(심각)</td>
				<td>자기권계면 위치 ≤ 4.6 </td>
			</tr>
			<tr>
				<td>4(경계)</td>
				<td>4.6 < 자기권계면 위치 ≤ 5.6</td>
			</tr>
			<tr>
				<td>3(주의)</td>
				<td>5.6 < 자기권계면 위치 ≤ 6.6</td>
			</tr>
			<tr>
				<td>2(관심)</td>
				<td>6.6 < 자기권계면 위치 ≤ 8.6</td>
			</tr>
			<tr>
				<td>1(일반)</td>
				<td>8.6 < 자기권계면 위치</td>
			</tr>
		</table>
		</div>
	 
	



</body>
</html>