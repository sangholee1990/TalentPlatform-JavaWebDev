<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/jquery.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/topMenu.jsp"/>
<div id="wrap_sub">
	<h2 class="login">
    	<span>로그인</span>
    </h2>
    
    <!-- 로그인 -->
    <form name="loginForm" id="loginForm" action="<c:url value="/ko/login.do"/>" method="post">
    <div id="loginbox">
    	<p class="message"> <c:out value="${result }"/> </p>
		<dl>
			<dt class='txt_id'><span>아이디</span></dt>
				<dd><input type="text" name="user_id" id="user_id" maxlength="15"/></dd>
			<dt class='txt_pwd'><span>비밀번호</span></dt>
				<dd><input type="password" name="user_pw" id="user_pw" maxlength="15"/></dd>
		</dl>
		<a href='#' class='bt_login'><span>로그인</span></a>
		<!-- 
		<ul class='unitmn'>
			<li><a href='' class='bt_join'><span>회원가입</span></a></li>
			<li><a href='' class='bt_idsearch'><span>아이디,비밀번호 찾기</span></a></li>
		</ul>
		 -->
	</div><!-- // 로그인 -->
	</form>
</div>    
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
<script type="text/javascript">
function login(){
	if($('#user_id').val() == ''){
		alert('아이디를 입력해주세요.');
		$('#user_id').focus();
		return false;
	}
	if($('#user_pw').val() == ''){
		alert('비밀번호를 입력해주세요.');
		$('#user_pw').focus();
		return false;
	}
	
	$('#loginForm').submit();
}

$(function() {
	
	
	$('#user_id').focus();
	
	$('#user_id, #user_pw').on('keydown',function(event){
		$(".message").empty();
	});
	
	$('.bt_login').on('click', function(event){
		event.preventDefault();
		login();
	});
	
	$('#user_pw').on('keydown', function(event){
		if(event.keyCode == 13){
			event.preventDefault();
			login();
		}
	});

});
</script>
</body>
</html>
