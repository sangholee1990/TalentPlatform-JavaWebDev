<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>우주기상 예특보 서비스 :: 국가기상위성센터</title>
<jsp:include page="/WEB-INF/views/include/jquery.jsp" />
<style type="text/css">
	h5 {
	}
	
	ul, li {
		list-style-type: none;
		float: left;
		height: 100%;
	}
	
	li .vertical{
		float: none;
		text-align: center;
	}
	
	.imgBox {
		width: 25%;
	}
</style>
</head>
<body>
<div id="wrap_main">
    <h5>극항로 방사선_InSpace_Result</h5>
	<div style="height: 300px; width: 100%; overflow: auto;">
		<img src="<c:url value="/resources/ko/specificContent/etc/InSpace_Result/AIR.png"/>" style="height: 100%;" /> 
		<img src="<c:url value="/resources/ko/specificContent/etc/InSpace_Result/HCP.png"/>" style="height: 100%;" /> 
		<img src="<c:url value="/resources/ko/specificContent/etc/InSpace_Result/OVATION.png"/>" style="height: 100%;" /> 
		<img src="<c:url value="/resources/ko/specificContent/etc/InSpace_Result/TEC.png"/>"style="height: 100%;" />
	</div>
	<br/>
	<h5>극항로 통신_OVATION 모델 극관 INNER LINE 관련</h5>
	<div style="height: 300px; width: 100%; ">
		<img src="<c:url value="/resources/ko/specificContent/etc/OVATION/ovation1.png"/>" style="height:100%;"/>
		<img src="<c:url value="/resources/ko/specificContent/etc/OVATION/ovation2.png"/>" style="height:100%;"/>
	</div>
	<!-- 
	<div style="height: 300px; width: 100%; ">
		<ul>
			<li class="imgBox">
				<ul>
					<li class="vertical"><img src="<c:url value="/resources/ko/specificContent/etc/InSpace_Result/AIR.png"/>" style="height:100%;"/></li>
					<li class="vertical"><span>AIR</span></li>
				</ul>
			</li>
			<li class="imgBox">
				<ul>
					<li class="vertical"><img src="<c:url value="/resources/ko/specificContent/etc/InSpace_Result/HCP.png"/>" style="height:100%;"/></li>
					<li class="vertical"><span>HCP</span></li>
				</ul>
			</li>
			<li class="imgBox">
				<ul>
					<li class="vertical"><img src="<c:url value="/resources/ko/specificContent/etc/InSpace_Result/OVATION.png"/>" style="height:100%;"/></li>
					<li class="vertical"><span>OVATION</span></li>
				</ul>
			</li>
			<li class="imgBox">
				<ul>
					<li class="vertical"><img src="<c:url value="/resources/ko/specificContent/etc/InSpace_Result/TEC.png"/>" style="height:100%;"/></li>
					<li class="vertical"><span>TEC</span></li>
				</ul>
			</li>
		</ul>
	</div>
	<h5>극항로 통신_OVATION 모델 극관 INNER LINE 관련</h5>
	<div style="height: 300px; width: 100%; ">
		<ul>
			<li>
				<ul style="width: 50%">
					<li class="vertical"><img src="<c:url value="/resources/ko/specificContent/etc/OVATION/ovation1.png"/>" style="height:100%;"/></li>
					<li class="vertical"><span>AIR</span></li>
				</ul>
			</li>
			<li>
				<ul style="width: 50%">
					<li class="vertical"><img src="<c:url value="/resources/ko/specificContent/etc/OVATION/ovation2.png"/>" style="height:100%;"/></li>
					<li class="vertical"><span>HCP</span></li>
				</ul>
			</li>
		</ul>
	</div>
	 -->
</div>
</body>
</html>