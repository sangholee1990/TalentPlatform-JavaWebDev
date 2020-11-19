<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 우주기상인트라넷</title>
<link rel="stylesheet" type="text/css" href="../css/default.css"  />
</head>

<body>
<div id="popup">
	<h2>위성운영</h2>
    <div class="date_wrap">
        <input type="text" size="12" /><img src="../images/btn_calendar.png" class="imgbtn" />
        <select name=""><option value="01">01</option></select>시
        <select name=""><option value="01">01</option></select>분
    </div>
    
    <div class="view">
    	<div class="unit">
        	<div class="222">X-선 플럭스??</div>
    		<img src="../images/test_graph.png" />
    	</div>
        <div class="unit">
        	<h4>양성자 플럭스</h4>
    		<img src="../images/test_graph.png" />
    	</div>
        <div class="unit">
        	<h4>Kp지수</h4>
    		<img src="../images/test_graph.png" />
    	</div>
        <div class="unit">
        	<h4>Dst지수</h4>
    		<img src="../images/test_graph.png" />
    	</div>
        <div class="unit">
        	<h4>자기권계면</h4>
    		<img src="../images/test_graph.png" />
    	</div>
    </div>
</div>
</body>
</html>
