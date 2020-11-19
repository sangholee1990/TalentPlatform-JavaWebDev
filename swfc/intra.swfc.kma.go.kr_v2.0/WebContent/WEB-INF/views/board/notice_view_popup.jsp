<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.BoardsDTO, org.springframework.util.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><spring:message code="title"/></title>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="../css/perfect-scrollbar.css"  />
<style type="text/css">
	/* Type Selector */
	*{font-family:Nanum Gothic,Dotum, Dotum, Gulim, AppleGothic, Sans-serif;}
	img, fieldset, button{border:none;}
	hr, button img{display:none;}
	li{list-style:none;}
	.imgbtn {cursor:pointer; }
	table {border-collapse:collapse }
	select,input {font-size:1em; padding:2px;}
	
	body {height:100%;margin:0;padding:0;font-size:0.75em;line-height:1.5em; color:#444;border:none;overflow: hidden;}
	/* 메인 공지사항 팝업 */
	#noticePopup{position:relative;width:100%;overflow: hidden;background:#f2f8fc }
	/*
		#noticePopup .title{padding:0 8px;padding-top:45px;margin:0;height:auto;background:url(../images/logo_popup.png) 5px 5px no-repeat;}
	*/
	#noticePopup .title{padding:0 8px;background: #428BCA;color:#ffffff;}
	#noticePopup .title h1{padding:7px 0px;padding-left:18px;margin:0; background:url(../images/popup_bullet.png) no-repeat 6px 13px;font-size:15px;font-weight: bold;}
	#noticePopup .contentBox{position:relative;background: url(../images/popup_content.png) right bottom no-repeat;overflow:hidden;}
	#noticePopup .content{padding:10px 12px;min-height:295px;line-height:20px;word-break:break-all;}
	#noticePopup .checkBox{padding:5px;margin:0;background:#2e2f42;color:#ffffff;text-align: right;}
	#noticePopup .checkBox input{vertical-align: middle;}
</style>
<jsp:include page="../include/jquery.jsp" />
<script type="text/javascript" src="<c:url value="/js/jquery.mousewheel.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/perfect-scrollbar.js"/>"></script>
<script type="text/javascript">
$(function(){
	$(window).load(function(){
		var height = 415;
		var topBottom = $(".title").innerHeight() + $(".checkBox").innerHeight();
		$(".contentBox").height(height - topBottom).perfectScrollbar();
	});
});
// 쿠키의 값을 설정한다.
function notice_setCookie(name, value, expiredays) {
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate() + expiredays);
	document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
}

function notice_popupClose() {
	if(document.getElementById("popup").checked) {			// 오늘 하루 보지 않기 체크박스를 체크한 경우
		notice_setCookie("Notice_${notice.board_seq}", "done", 1);				// cookie의 값을 셋팅한다. (체크한 경우 쿠키의 value값을 no로 세팅)
	}
	self.close();
}
</script>
</head>
<body>
<div class="container">
	<div id="noticePopup">
		<div class="title"><h1><spring:escapeBody htmlEscape="true">${notice.title}</spring:escapeBody></h1></div>
		<div class="contentBox">
			<div class="content">
				<spring:escapeBody htmlEscape="false">${notice.content}</spring:escapeBody>
			</div>
		</div>
		<p class="checkBox">
			<label for="popup">오늘 하루 보지 않기 <input type="checkbox" id="popup" name="popup" onclick="notice_popupClose();"></label>
		</p>
	</div>
</div>
</body>
</html>
