<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/jquery.jsp" />
<script type="text/javascript">
	
	
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
	
	// 팝업을 표출한다.
	function openPopup() {
		<c:forEach var="item" items="${noticePopupList}" varStatus="status">
			if(notice_getCookie("Notice_${item.board_seq}") != "done") {
				window.open('<c:url value="/ko/board/notice_view_popup.do?board_seq=${item.board_seq}"/>', 'notice${item.board_seq}', 'width=400, height=415, status=no, menubar=no, toolbar=no, scrollbars=no');
			}
		</c:forEach>
	}
	
	//통보문 다운로드
	function downloadReport(seq){
		var url = "<c:url value="/ko/download_report/[seq].do"/>";
		url = url.replace('[seq]', seq);
		hiddenframe.location.href = url;
	}
	
	$(function() {
		$('.report a').on('click', function(event){
			event.preventDefault();
			downloadReport($(this).attr('seq'));			
		});
		
		openPopup();
	});
</script>
	
</head>
<body>
<jsp:include page="/WEB-INF/views/include/topMenu.jsp"/>
<div id="wrap_main">
	<div class="wrap_alert">
    	<p class="main_tit">
    		<a href="<c:url value="/ko/alerts.do"/>"><img src="<c:url value="/resources/ko/images/main_title_alert.png"/>" class="imgbtn" alt="우주기상 예특보" /></a>
        </p>        
        <!-- 메인 예특보 최대 3개 까지 -->
        <ul class="report">
        	<c:forEach items="${forecastList}" var="item">
            	<li><a href="#" <c:if test="${item.rpt_type=='WRN'}"> class="areport"</c:if> target="_blank" seq="${item.rpt_seq_n}"><fmt:formatDate value="${item.publish_dt}" pattern="yyyy. MM. dd HH:mm"/> 발표</a></li>
            </c:forEach>
    	</ul>
    	<p class="main_notice_tit">
    		<a href="<c:url value="/ko/board/notice_list.do"/>"><img src="<c:url value="/resources/ko/images/main_title_notice.png"/>" class="imgbtn" alt="공지사항" /></a>
        </p>        
        <ul class="notice">
        	<c:forEach items="${noticeList}" var="item">
        		<c:set var="title"><spring:escapeBody htmlEscape="true" >${item.title}</spring:escapeBody></c:set>
            	<li><a href="<c:url value="/ko/board/notice_view.do?board_seq=${item.board_seq}"/>">
            	<c:choose>
               		<c:when test="${ fn:length(title) >  20}">${fn:substring(title, 0, 20)}..</c:when>
               		<c:otherwise>${title}</c:otherwise>
               	</c:choose>
               <c:if test="${ item.is_new  eq 'Y'}"><span class="new">New</span></c:if>
            	</a>
            	<span class="date">${item.create_date }</span>
            	</li>
            </c:forEach>
            <c:if test="${ fn:length(noticeList) < 1 }">
            	<li><a>등록된 공지사항이 없습니다.</a></li>
            </c:if>
    	</ul>
    </div>
    <!-- END 우주기상 예특보 -->
    
    <div class="wrap_current">
    	<p class="main_tit">
    		<a href="<c:url value="/ko/current.do"/>"><img src="<c:url value="/resources/ko/images/main_title_current.png"/>" class="imgbtn" alt="우주기상실황" /></a>
    		<a href="<c:url value="/ko/intro.do?tab=alert#newsflashHelp1"/>" title="관련 도움말 페이지 이동" class="manual"><span>도움말</span></a>
        </p>
        <!--<p class="help">
        	<img src="<c:url value="/images/btn_help.png"/>" class="imgbtn" />
        </p>-->
        <div class="sum">
            <div class="sign sat <custom:CodeSign notice="${summary.notice1}"/>">
                <p><c:if test="${summary.notice1 != null}">${summary.notice1.code}</c:if></p>
            </div>
            <div class="sign pol <custom:CodeSign notice="${summary.notice2}"/>">
                <p><c:if test="${summary.notice2 != null}">${summary.notice2.code}</c:if></p>
            </div>
            <div class="sign ion <custom:CodeSign notice="${summary.notice3}"/>">
                <p><c:if test="${summary.notice3 != null}">${summary.notice3.code}</c:if></p>
            </div>
        </div>
        
        <div class="group" style="margin-left:25px;">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_rad.png"/>" alt="태양복사폭풍" />
            	<!-- 
            	<a href="/" title="도움말 페이지 이동" class="manual size16"><span>도움말</span></a>
            	 -->
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.XRAY_H3}"/>">
					<p>${summary.XRAY_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.XRAY_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<div class="infotext">
					<p class="message fw">${summary.XRAY_H3.gradeText}</p> 
					<p>현재 : ${summary.XRAY_NOW.val} (W/m2)</p>
					<p>
					<c:choose>
						<c:when test="${summary.XRAY_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : ${summary.XRAY_H3.val} (W/m2)</p>
					<p><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></p>
				</div>
			</div>
        </div>
        <!-- END 태양복사폭풍 -->
        <div class="group">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_par.png"/>" alt="태양복사폭풍" />
            	<!-- 
            	<a href="/" title="도움말 페이지 이동" class="manual size16"><span>도움말</span></a>
            	 -->
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.PROTON_H3}"/>">
					<p>${summary.PROTON_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.PROTON_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<div class="infotext">
					<p class="message fw">${summary.PROTON_H3.gradeText}</p> 
					<p>현재 : ${summary.PROTON_NOW.val} (pfu)</p>
					<p>
					<c:choose>
						<c:when test="${summary.PROTON_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : ${summary.PROTON_H3.val} (pfu)</p>
					<p><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></p>
				</div>
			</div>            
        </div>
        <!-- END 태양입자폭풍 -->
        <div class="group"  style="margin-left:25px;">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_ter.png"/>" alt="지자기폭풍" />
            	<!-- 
            	<a href="/" title="도움말 페이지 이동" class="manual size16"><span>도움말</span></a>
            	 -->
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.KP_H3}"/>">
					<p>${summary.KP_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.KP_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<div class="infotext">
					<p class="message fw">${summary.KP_H3.gradeText}</p> 
					<p>현재 : ${summary.KP_NOW.val}</p>
					<p>
					<c:choose>
						<c:when test="${summary.KP_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : ${summary.KP_H3.val}</p>
					<p><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></p>
				</div>
			</div>            
        </div>
        <!-- END 지자기폭풍 -->
        <div class="group">
            <p class="title">
            	<img src="<c:url value="/resources/ko/images/main_title_mag.png"/>" alt="자기권계면" />
            	<!-- 
            	<a href="/" title="도움말 페이지 이동" class="manual size16"><span>도움말</span></a>
            	 -->
            </p>
			<div class="info">
				<div class="sign <custom:CodeSign notice="${summary.MP_H3}"/>">
					<p>${summary.MP_H3.grade}</p>
				</div>
				<fmt:parseDate value="${summary.MP_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
				<div class="infotext">
					<p class="message fw">${summary.MP_H3.gradeText}</p> 
					<p>현재 : ${summary.MP_NOW.val} (RE)</p>
					<p>
					<c:choose>
						<c:when test="${summary.MP_H3.dataType=='MP'}">최소값</c:when>
						<c:otherwise>최대값</c:otherwise>
					</c:choose> : ${summary.MP_H3.val} (RE)</p>
					<p><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></p>
				</div>
			</div>            
        </div>
        <!-- END 자기권계면 -->
    </div>
    <!-- END 우주기상 예특보 -->
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>