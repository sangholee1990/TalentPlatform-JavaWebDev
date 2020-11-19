<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%><%@ taglib prefix="custom" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<style>
	*{font-family:Dotum, Gulim, AppleGothic, Sans-serif;}
	html, body {height:100%;}
	body {margin:0;padding:0;overflow: hidden;}
	/* 메인 공지사항 팝업 */
	#noticePopup{position:relative;width:100%;overflow: hidden;background:#e8f4f7;}
	/*
		#noticePopup .title{padding:0 8px;padding-top:45px;margin:0;height:auto;background:url(../images/logo_popup.png) 5px 5px no-repeat;}
	*/
	#noticePopup .title{border:none;margin:0;height:auto;color:#ffffff;background:#F95200;}
	#noticePopup .title h1{position:relative;float:none;padding:10px 15px;padding-left:25px;margin:0;width:auto;height:auto;background:none; font-size:15px;font-weight: bold;}
	#noticePopup .title h1:before{content: "";display: block;position:absolute;top:12px;left:7px;width:13px;height:13px;background:url(<c:url value="/resources/common/js/themes/base/images/ui-icons_454545_256x240.png"/>) -145px -162px;}
	#noticePopup .contentBox{position:relative;overflow:hidden;background: url(<c:url value="/resources/ko/images/eddy-9396_640.png"/>) center center no-repeat}
	#noticePopup .content{padding:10px 12px;min-height:295px;color:#000;line-height:20px;word-break:break-all;}
	#noticePopup .checkBox{padding:5px;margin:0;background:#525b6b;color:#ffffff;font-size:12px;text-align: right;}
	#noticePopup .checkBox input{vertical-align: middle;}
	
	.bt_spcfPop {display:block; width:82px; height:24px; }
</style>
<jsp:include page="/WEB-INF/views/include/jquery.jsp" />
<script type="text/javascript" src="<c:url value="/resources/common/js/jquery.slimscroll.js"/>"></script>
<script>
	$(function(){
		$(window).load(function(){
			var height = 415;
			var topBottom = $(".title").innerHeight() + $(".checkBox").innerHeight();
			$(".contentBox").height(height - topBottom).slimScroll({"height": height - topBottom});
		});
	});
	// 쿠키의 값을 설정한다.
	function notice_setCookie(name, value, expiredays) {
		var todayDate = new Date();
		todayDate.setDate(todayDate.getDate() + expiredays);
		document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
	}
	
	function notice_popupClose() {
		if(document.getElementById("popup").checked)
			notice_setCookie("Notice_${notice.board_seq}", "done", 1);				// 하루동안 공지사항 열지않게 설정
		self.close();
	}
</script>
</head>
<body>
<div class="container">
	<div id="noticePopup">
		<div class="title">
			<h1 class="page-header"><spring:escapeBody htmlEscape="true">${notice.title}</spring:escapeBody></h1>
		</div>
		<div class="contentBox">
			<div class="content">
				<spring:escapeBody htmlEscape="false">${notice.content}</spring:escapeBody>
			</div>
		</div>
		
		<p class="checkBox">
			<label for="popup">오늘 하루 보지 않기<input type="checkbox" id="popup" name="popup" onclick="notice_popupClose();"></label>
		</p>
	</div>
</div>
</body>
</html>
