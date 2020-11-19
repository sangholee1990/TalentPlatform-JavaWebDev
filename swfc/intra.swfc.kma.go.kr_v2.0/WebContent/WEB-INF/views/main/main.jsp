<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 우주기상인트라넷</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/default.css"/>"  />
<jsp:include page="../include/jquery.jsp" />
<script type="text/javascript">

$(function() {
	$("#contents .imgbtn").click(function() {
		var index = $("#contents .imgbtn").index(this);
		switch(index) {
		case 0:
			location.href="observe/observe_list.do";
			break;
		case 1:
			location.href="element/sun_list.do";
			break;
		case 2:
			location.href="forecast/spe_fp.do";
			break;
		case 3:
			location.href="report/forecast_list.do";
			break;
		}
		return false;
	});
	
	$("#j_username").focus();
	/*
	$('.monitorBtn').on('click', function(){
		location.href = "<c:url value="/monitor/monitor.do"/>";
	});
	*/
	$('.btnlogOut').on('click', function(){
		location.href = "<c:url value="/j_spring_security_logout" />";
	});
	
	$(".btnlogin").on("click",login)
	
	openPopup();
	
	
	$('.quickMenuBtn').on('click', function(event){
		event.preventDefault();
		if($(this).attr('popup') == 'false'){
			location.href = $(this).attr('url');	
		}else{
			openQuickMenu($(this).attr('url'));
		}
	});
});


function login(e){
	e.preventDefault();
	if($('#j_username').val() == ''){
		alert('아이디를 입력해주세요.');
		$('#j_username').focus();
		return false;
	}
	if($('#j_password').val() == ''){
		alert('비밀번호를 입력해주세요.');
		$('#j_password').focus();
		return false;
	}
	
	$("form[name='loginForm']").submit();

}

// 쿠키의 값을 얻어온다.
function notice_getCookie(name) {
	var nameOfCookie = name + "=";
	var x = 0;
	while(x <= document.cookie.length)
	{
		var y = (x+nameOfCookie.length);
		if(document.cookie.substring(x,y) == nameOfCookie) {
			if((endOfCookie=document.cookie.indexOf(";", y)) == -1)
				endOfCookie = document.cookie.length;
			return unescape( document.cookie.substring(y, endOfCookie));
		}
		x = document.cookie.indexOf(" ", x) + 1;
		
		if(x == 0)
			break;
	}
	return "";
}

//팝업을 표출한다.
function openPopup(){
	<c:forEach var="o" items="${noticePopupList}" varStatus="status">
		if(notice_getCookie("Notice_${o.board_seq}") != "done") {
			window.open('<c:url value="/board/notice_view_popup.do?board_seq=${o.board_seq}"/>', 'notice${o.board_seq}', 'width=400, height=415, status=no, menubar=no, toolbar=no, scrollbars=no');
		}
		</c:forEach>
}

function openQuickMenu(_url){
	window.open(_url, 'quickMenu', 'status=no, menubar=yes, toolbar=yes, scrollbars=yes');
}
</script>
<style>
.errorblock {
	color: #ff0000;
	background-color: #ffEEEE;
	border: 3px solid #ff0000;
	padding: 8px;
	margin: 16px;
}

.noticeTitle {
	margin-bottom: 15px;
}
</style>
</head>
<body>
<jsp:include page="../header.jsp" />
<div class="main">
	<div>
		<img src="images/main_visual.png" alt="" />
    </div>
</div>

<div id="contents" style="width:950px;">
	<div class="sitemap">
        <h2 class="noticeTitle">공지사항</h2>
        <c:choose>
        <c:when test="${empty noticeList}">
	    	<div class="group">
            <span>등록된 공지사항이 없습니다.</span>
        </div>
	    </c:when>
	    <c:otherwise>
			<c:forEach var="o" items="${noticeList}" varStatus="status">
				<div class="group">
	               <span><a href="<c:url value="/board/notice_view.do?board_seq=${o.board_seq}"/>"><spring:escapeBody>
	               <c:choose>
	               	<c:when test="${ fn:length(o.title) >  30}">${fn:substring(o.title, 0, 30)}..</c:when>
	               	<c:otherwise>${o.title}</c:otherwise>
	               </c:choose>
	               </spring:escapeBody>
	               <c:if test="${ o.is_new  eq 'Y'}"><span class="new">New</span></c:if>
	               </a></span>
	               <span class="dt"><spring:escapeBody>${o.create_date}</spring:escapeBody></span>
	            </div>
	           </c:forEach>
	        </c:otherwise>
	      </c:choose>
    </div>
    
    <div id="rightContent">
	    <!-- LOGIN -->
	    <security:authorize ifNotGranted="ROLE_USER">
	    <form action="<c:url value='/j_spring_security_check' />" method="post" name="loginForm">
	    <div id="login">
	    <!-- 
	        <p class="logintit">로그인</p>
	     -->
	        <p><input type="text" value="" size="12" name="j_username" id="j_username"/></p>
	        <p><input type="password" value="" size="12" name="j_password" id="j_password"/></p><br/>
	        <p class="info">관리자와 CME분석권한 사용자에 한하여 사용하실 수 있습니다.</p>
	        <div class="loginbtn">
	            <input type="submit" title="로그인" value="로그인" class="btnlogin" />
	        </div>
		</div> 
		</form>
		</security:authorize>
		<security:authorize ifAnyGranted="ROLE_USER">
	    <div id="login">
	    	<!-- 
	        <p class="logintit">로그아웃</p>
	    	 -->
			<br/>
	        <p class="info">안녕하세요 
	        	<security:authentication property="name"/>님 <br/>로그인을 환영합니다.
	        </p>
	        <div class="loginbtn">
	        	<input type="button" title="로그아웃" value="로그아웃" class="btnlogin btnlogOut"/>
	        </div>
		</div>
		</security:authorize>
		<div class="adminMenu">
			<ul>
				<security:authorize ifAnyGranted="ROLE_USER">
				<li><a href="" popup="false" url="<c:url value="/admin/report/report_list.do"/>" class="quickMenuBtn">특보문목록</a></li>
				<li><a href="" popup="true" url="<c:url value="/admin/report/report_auto.do?rpt_type=FCT&rpt_kind=O"/>" class="quickMenuBtn">구통보문작성</a></li>
				<li><a href="" popup="true" url="<c:url value="/admin/report/report_auto.do?rpt_type=FCT&rpt_kind=N"/>" class="quickMenuBtn">신통보문작성</a></li>
				<li><a href="" popup="true" url="<c:url value="/admin/report/daily_situation_report_form.do"/>" class="quickMenuBtn">일일상황보고작성</a></li>
				<li><a href="" popup="true" url="<c:url value="/admin/report/report_auto.do?rpt_type=WRN&rpt_kind=O"/>" class="quickMenuBtn">특보문작성</a></li>
				<li><a href="" popup="true" url="<c:url value="/admin/report/report_auto.do?rpt_type=WRN&rpt_kind=N"/>" class="quickMenuBtn">신특보문작성</a></li>
				<security:authorize ifAnyGranted="ROLE_ADMIN">
				<li><a href="" popup="false" class="quickMenuBtn" url="<c:url value="/admin/board/notice_list.do"/>">커뮤니티관리</a></li>
				</security:authorize>
				</security:authorize>
			</ul>
		</div>
		<!-- 
		 <div id="banner">
		 	<span>바로가기</span>
		 	<select>
		 		<option value="<c:url value="/monitor/monitor.do"/>">모니터링</option>
		 		<option value="<c:url value="/monitor/monitor.do"/>">STOA-2 모델 </option>
		 	</select>
		 	<button>이동</button>
		 	<img src="images/monitor-icon.png" alt="" height="40" />
	        <div class="linkBtn">
	            <input type="button" title="모니터링 바로가기" value="모니터링 바로가기" class="btnLink monitorBtn" />
	        </div>
		</div> 
		 -->
	    <!-- END LOGIN -->    
    
    </div>
</div>
<div id="links_wrap">
	<div class="links">
    	<span><b>바로가기</b></span>
    	<a href="<c:url value="/monitor/mainMonitor.do?min=1&index=1&rotate=true"/>" target="_blank">| 종합 모니터링 </a>
    	<a href="<c:url value="/monitor/monitor.do"/>" target="_blank">| 모니터링 </a>
    	<a href="<c:url value="/monitorSWAA/monitor1.do"/>" target="_blank">| 극항로 항공기상 상황판 </a>
    	<a href="<c:url value="/monitorSWAA/monitor2.do"/>" target="_blank">| 기상위성운영 및 전리권 상황판 </a>
    	<a href="http://172.19.15.73:8080/stoa2/" target="_blank">| STOA-2 모델</a>
    </div>
</div>
<jsp:include page="../footer.jsp" />
</body>
</html>
