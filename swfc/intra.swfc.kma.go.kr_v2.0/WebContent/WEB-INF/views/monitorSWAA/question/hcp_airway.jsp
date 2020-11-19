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
		<font size="6">항공로별 순간 피폭량 도움말  </font>
		</div>  
		<div class="queTable">
		 <font size="4"> 
		인천에서 출발하는 국제선에 대한 항공로별 고도 0~15km 상공에서의 방사선 순간 피폭량을 나타낸 그림이다.  
		실제 비행항로는 하얀색 실선으로 표시되며, 그림에서 푸른색은 방사선 순간 피폭량이 낮음, 붉은 색은 방사선 순간 피폭량이 높음을 나타낸다. 
		그림은 매일 09:00KST에 업데이트 되고 상단의 선택 버튼으로 항공로별 순간 방사선 피폭량을 확인 할 수 있다.  <br><br>
		
		※ 표출되는 비행항로 <br>
		로스앤젤레스-인천, 뉴욕-인천, 뉴욕-인천(북극항로 경유), 댈러스-인천, 모스크바-인천, 시애틀-인천, 이스탄불-인천, 인천-런던, 파리-인천 <br>
 
		</div>
	 
	



</body>
</html>