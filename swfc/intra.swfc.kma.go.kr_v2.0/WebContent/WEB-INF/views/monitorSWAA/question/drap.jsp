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
<link rel="stylesheet" type="text/css" href="<c:url value="/css/monitor1.css"/>"/>
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
 
</style>
<script type="text/javascript" src="<c:url value="/js/date.format.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.mousewheel.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/perfect-scrollbar.js"/>"></script>

</head>
<body> 
		<div class="queTitle">
		<font size="6">HF통신 전파 흡수 도움말</font>
		</div>  
		<div class="queTable">
		<font size="4">  
		각 영역에서 통신 가능한 HF통신 최소주파수로서 우주기상 현상을 반영한 모델이다. 
		D-RAP(D Region Absorption Prediction) 모델은 NOAA에서 개발한 전리권 D층 흡수 예측 모델이다.
		전파가 전리권 D층을 통과할 때 전자는 전파의 전기장에 의해 진동하며 중성 공기분자와 충돌한다.
		이 충돌에 의해 전파의 세기가 줄어들어 HF 통신 두절 현상이 발생한다. 
		평상시에는 HF통신 두절 현상이 발생하지 않지만 태양활동이 증가하면 태양으로부터 방출되는 다량의 X-선과 고에너지 입자들에 의해 HF통신 두절 현상이 발생한다. <br>
		<br></font>
		<font size="2">
		※ 0MHz(검정색): HF통신 우수 (전 단파영역 통신가능) <br>
		&nbsp;&nbsp; 15MHz(하늘색): HF통신 양호 (15MHz 이상 단파만 통신가능)<br>
		&nbsp;&nbsp; 30MHz(주황색): HF통신 불가 (전 단파영역 (30 MHz 까지) 통신 불가)<br> 
		</font>
		</div> 
</body>
</html>