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
		<font size="6">방사선 순간 피폭량 도움말 </font>
		</div> 
		<div class="queTable t">	
		<font size="4">
		고도 0, 5, 10, 15km 상공에서 우주선(Galactic Cosmic Radiation)에 의한 당일의 방사선 순간 피폭량을 나타낸 그림이다. 
		그림에서 푸른색은 방사선 순간 피폭량이 낮음, 붉은 색은 방사선 순간 피폭량이 높음을 나타낸다.  
		방사선 유효선량은 CARI-6M을 사용하여 계산하였고, CARI-6M의 입력인자로 사용하는 HCP(HelioCentric Potential)를 예측하여 당일의 전지구 방사선 순간 피폭량을 산출하였다. 
		(기존의 CARI-6M은 미국 연방항공청에서 제공하는데 HCP값 사용하는데 HCP값을 1개월 늦게 제공하여 실시간 방사선 유효선량을 산출할 수 없는 단점이 있었음.) 
		그림은 매일 09:00KST에 업데이트 되며, 상단의 선택 버튼으로 고도별 순간 방사선 피폭량을 나타낼 수 있다.<br></br>  
		※ CARI-6M : 미국 연방항공청의 Civil Aerospace Medical Institute에서 개발한 프로그램으로, 
		우주선에 의해 비행하는 항공기내의 개인이 받는 우주방사선의 유효선량를 계산하는 프로그램이다. <br></br>
		※ HCP(HelioCentric Potential) : 태양활동의 세기를 나타내는 지표로서 지상에서 검출되는 중성자 수와 연관된다.   
		</font> 
		</div> 
</body>
</html>