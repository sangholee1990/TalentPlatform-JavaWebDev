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
		<div id="header">
			<h1 class="title">
				<font size="10">도움말 </font>
			</h1>
		</div>
		<br></br> <br></br> <br></br> 
		<div class="queTable">
		<h2>국제방사선방호위원회(ICPP : International Commission on Radiological Protection)의 
		<br />우주 방사선 탑승자 별 방사는 노출량 권고 수준</h2>
		<br></br>
		1. 실시간 방사선 노출량은 인체 기관과 조직에 축적되는 양으로 effective dose rate(유효선량)으로 계산, 또한 연간 축적된 유효선량은 millisievert 단위로 표현(1mSv=1000uSv)<br>
		</br>
		2. ICRP는 방사선 관련 작업종사자(승무원 포함)의 연간 유효선량이 20mSv이하로 권고, 만약 연간 방서선 노출량이 20mSv의 1/3dlaus green으로, 1/3~2/3 사이이면 노랑색으로, 2/3이상이면 빨강색으로 표시<br>
		</br>
		3. ICRP는 일반인 승객의 연간 방사선 노출량은 1mSv 이하로 권고, 만약 연간 노출량이 1mSv의 1/3이면 green으로, 1/3~2/3 사이이면 노랑색으로, 2/3 이상이면 빨강색으로 표시<br>
		</br>
		4. ICRP는 태아의 연간 방사선 노출량을 1mSv 이하로, 임산부는 한달 노출량이 0.5mSv 이하로 권고, 만약 연간 노출량이 0.5mSv의 1/3이면 green으로, 1/3~2/3 사이이면 노랑색으로, 2/3이상이면 빨강색으로 표시<br>
		</br><br></br>
		참고문헌 : ICRP Publication 103, The 2007 Recommendation of the International Commission on Radiological Protection

		</div>
	 
	



</body>
</html>