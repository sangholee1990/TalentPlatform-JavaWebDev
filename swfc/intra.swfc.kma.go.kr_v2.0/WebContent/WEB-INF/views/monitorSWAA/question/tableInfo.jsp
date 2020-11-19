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
		<font size="4">우주방사선 탑승자별 경보 등급  <br>기준에 대한 근거</font>
		</div>  
		<div class="queTable"> 
		<font size="2">
		상단의 항공로별 순간 피폭량의 그림과 일치하는 항로에 대한 상세 정보를 나타낸다.  
		총 비행시간, 평균 순간 피폭량, 누적 피폭량을 항공기 승무원, 일반인, 임산부로 구분하여 방사선 노출 수준을 안전/주의/경보(바뀔 수 있음)의 3단계로 나누어 녹색/노랑/빨강색으로 표현된다.
		기준은 NASA가 운영하는 NAIRAS 홈페이지의 등급 결정 기준과 동일하며, 상세 정보 내용은 09:00KST에 업데이트 된다. <br>
		<br>
		※ 항공기 승무원의 경보단계 기준<br>
		항공기 승무원은 생활주변방사선 안전관리법을 따르는 국토교통부 고시 기준을 따라 연간 방사선 한계선량을 6mSv 기준으로 하여 연간 방사선 피폭량 상세정보를 제공한다. 
		항공로별 평균 순간 방사선 피폭량으로부터 연 800시간의 비행 시간을 가정하여 연간 방사선 누적선량이 6mSv를 넘지 않으면 ‘안전’ 등급, 6mSv 이상부터 연간한계선량의 2배인 12mSv 까지는 ‘주의’ 등급, 12mSv 이상이면 ‘경보’로 등급을 구분한다. <br>
		<br>
		※ 일반인의 경보단계 기준<br>
		일반인의 경우는 연간 방사선 한계선량이 1mSv 인 것을 감안하여, 1mSv의 1/3인 0.330mSv 까지는 ‘안전’, 1/3 이상 2/3에 해당하는 0.670mSv 까지는 ‘주의’, 0.670mSv 이상은 ‘경보’로 등급을 구분한다. <br>
		 <br>
		※ 임산부의 경보단계 기준<br>
		임산부의 경우는 태아의 방사선 허용량은 0.5mSv로 국제방사선방어위원회(ICRP)의 규정을 따른다.  
		0.5mSv의 약 1/3에 해당하는 0.167mSv 까지는 ‘안전’, 1/3에서 2/3에 해당하는 0.333mSv 까지는 ‘주의’, 0.333mSv 이상은 ‘경보’로 등급을 구분한다.<br>
		 <br>
		※ NAIRAS(Nowcast of Atmospheric Ionizing Radiation System) :  
		미항공우주국(NASA)에서 지원받아 Space Environment Technologies(SET)에서 개발한 프로그램으로 항공기 고도에서의 우주방사선의 공간선당량 및 유효선량을 실시간으로 제공한다.  
		현재 상용되고 있는 대다수의 프로그램들이 우주선(Galactic Cosmic Radiation : GCR)만을 고려하는 반면, 이 모델은 위성관측자료를 바탕으로 태양고에너지 입자에 의한 우주방사선량을 계산에 포함시킨 모델이다. 
		</font>
		

		</div>
	 
	



</body>
</html>