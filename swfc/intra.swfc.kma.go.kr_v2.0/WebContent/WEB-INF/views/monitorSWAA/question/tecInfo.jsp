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
		<font size="6">총전자밀도 도움말</font>
		</div> 
		<div class="queTable">
		<font size="4">
		GPS위성 신호로부터 추정한 전리층의 총전자량(Total Electron Cotent, TEC)으로 GPS 위성에서 보낸 두 전파 신호가 수신소에 도달하는데 각각 시간 지연이 생기게 되고 그 시간 지연의 차를 이용하여 전리층의 총전자량 유추해 낼 수 있다. 전리층의 총 전자량이 증가하면 GPS 거리 오차가 증가한다. 총전자량의 단위는 TECU로 나타내며 1TECU=1016electrons/m2이다. 
		TEC를 산출하는데 사용된 GPS 자료는 한국천문연구원과 국토지리정보원, 위성항법중앙사무소의 자료를 사용하였다. 
		</font>
		</div>
	 
	



</body>
</html>