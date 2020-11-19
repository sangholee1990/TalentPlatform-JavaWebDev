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
		<font size="6">지구 자기권 방사선대 도움말 </font>
		</div>   
		<div class="queTable">
		<font size="4">
		 Van Allen Probes 위성이 관측한 1 MeV 전자 플럭스 그림이다. 
		 정지궤도 안쪽 영역의 전자 플럭스 상태를 확인 할 수 있다. 
		 전자는 위성 표면과 내부에 대전현상을 발생시킬 수 있는데, 
		 주로 저에너지(40keV)의 전자는 표면대전현상, 고에너지(2MeV)의 전자는 내부대전현상을 발생시킨다. 
		 그림의 X축 + 방향이 태양 방향을 나타낸다. 그림은 매일 00:00KST에 업데이트 된다. 
		<br></br> ※ Van Allen Probes위성 : Radiation Belt Storm Probes (RBSP)위성으로 알려져 있으며, 
		 지구 주변의 밴앨런 방사선대를 하루에 두 번 통과하면서 근지구 영역의 물리 변화를 실시간으로 측정한다.
		</font>
		</div>
	 
	



</body>
</html>