<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"
%><div id="header_wrap">
	<div class="header">
    	<h1><a href="<c:url value="/"/>"><img src="<c:url value="/images/logo.png"/>" alt="국가기상위성센터 우주기상인트라넷" class="imgbtn" /></a></h1>
        <div class="login">
        	<security:authorize ifAnyGranted="ROLE_USER">
            <a href="<c:url value="/j_spring_security_logout" />"><security:authentication property="name"/> 로그아웃</a>
            <security:authorize ifAnyGranted="ROLE_ADMIN">
            | <a href="<c:url value="/admin/user/user_list.do" />">관리자</a>
            </security:authorize>
            <security:authorize ifNotGranted="ROLE_ADMIN">
            | <a href="<c:url value="/admin/report/report_list.do" />">관리자</a>
            </security:authorize>
            </security:authorize>            
        </div>
        <div class="menu" id="menu">
        	<a href="<c:url value="/observe/observe_list.do"/>" <custom:MenuConverter value="observe">class="on"</custom:MenuConverter>>우주기상감시</a>
        		<custom:MenuConverter value="observe">
        		<div class="menusub" style="left:0px;">
        			<a href="<c:url value="/observe/observe_list.do"/>" <custom:MenuConverter value="observe_list">class="on"</custom:MenuConverter>>우주기상감시</a>
                    <a href="<c:url value="/observe/guidence_list.do"/>" <custom:MenuConverter value="guidence_list">class="on"</custom:MenuConverter>>예보가이던스</a>
                </div>
                </custom:MenuConverter>
            <a href="<c:url value="/element/sun_list.do"/>" <custom:MenuConverter value="element">class="on"</custom:MenuConverter>>우주기상인자</a>
            	<custom:MenuConverter value="element">
            	<div class="menusub" style="left:0px;" >
                    <a href="<c:url value="/element/sun_list.do"/>" <custom:MenuConverter value="sun_list">class="on"</custom:MenuConverter>>태양</a>
                    <a href="<c:url value="/element/interplanetary_list.do"/>" <custom:MenuConverter value="interplanetary_list">class="on"</custom:MenuConverter>>행성간공간</a>
                    <a href="<c:url value="/element/magnetosphere_list.do"/>" <custom:MenuConverter value="magnetosphere_list">class="on"</custom:MenuConverter>>지구자기권</a>
                    <a href="<c:url value="/element/ionsphere_list.do"/>" <custom:MenuConverter value="ionsphere_list">class="on"</custom:MenuConverter>>전리권</a>
                    <a href="<c:url value="/elementSWAA/north_route.do"/>" <custom:MenuConverter value="/elementSWAA/north_route">class="on"</custom:MenuConverter>>극항로 항공기상</a>
                    <a href="<c:url value="/elementSWAA/weather_satellite.do"/>" <custom:MenuConverter value="/elementSWAA/weather_satellite">class="on"</custom:MenuConverter>>기상위성운영</a>
              		<a href="<c:url value="/element/solar_event_report.do"/>" <custom:MenuConverter value="solar_event_report">class="on"</custom:MenuConverter>>태양 이벤트 보고서</a>
                </div>
                </custom:MenuConverter>
            <a href="<c:url value="/forecast/spe_fp.do"/>" <custom:MenuConverter value="/forecast/">class="on"</custom:MenuConverter>>예측모델</a>
            	<custom:MenuConverter value="/forecast/">
            	<div class="menusub" style="left:120px;">
                    <a href="<c:url value="/forecast/spe_fp.do"/>" <custom:MenuConverter value="spe_fp">class="on"</custom:MenuConverter>>태양 양성자, 태양 플레어</a>
                    <a href="<c:url value="/forecast/dst_kp_sm.do"/>" <custom:MenuConverter value="dst_kp_sm">class="on"</custom:MenuConverter>>Dst 지수, Kp 지수, 태양 극대기</a>
                    <a href="<c:url value="/forecast/three_day_frct.do"/>" <custom:MenuConverter value="three_day_frct">class="on"</custom:MenuConverter>>NOAA 3일 예보</a>
                </div>
                </custom:MenuConverter>
            <a href="<c:url value="/reportdata/cme_list.do"/>" <custom:MenuConverter value="/reportdata/cme">class="on"</custom:MenuConverter>>CME분석</a>
            	<custom:MenuConverter value="/reportdata/cme">
            		<div class="menusub" style="left:280px">
            			<a href="<c:url value="/reportdata/cme_list.do"/>" <custom:MenuConverter value="cme_list">class="on"</custom:MenuConverter>>CME 분석 자료</a>
            			<a href="<c:url value="/reportdata/cme_model.do"/>" <custom:MenuConverter value="model">class="on"</custom:MenuConverter>>STOA CME 모델 분석 표출</a>
            		</div>
            	</custom:MenuConverter>
            <a href="<c:url value="/report/forecast_list.do"/>" <custom:MenuConverter value="/report/">class="on"</custom:MenuConverter>>예특보 및 보고서</a>
            	<custom:MenuConverter value="/report/">
            		<div class="menusub" style="left:480px">
            			<a href="<c:url value="/report/forecast_list.do"/>" <custom:MenuConverter value="/report/forecast">class="on"</custom:MenuConverter>>예보 및 특보</a>
            			<a href="<c:url value="/report/daily_situation_rpt_list.do"/>" <custom:MenuConverter value="/report/daily_situation">class="on"</custom:MenuConverter>>일일상황보고</a>
            		</div>
            	</custom:MenuConverter>
            <a href="<c:url value="/board/notice_list.do"/>" <custom:MenuConverter value="/board/">class="on"</custom:MenuConverter>>정보마당</a>
            	<custom:MenuConverter value="/board/">
            	<div class="menusub" style="left:480px;">
                    <a href="<c:url value="/board/notice_list.do"/>" <custom:MenuConverter value="/board/notice_">class="on"</custom:MenuConverter>>공지사항</a>
                    <a href="<c:url value="/board/archives_list.do"/>" <custom:MenuConverter value="/board/archives_">class="on"</custom:MenuConverter>>자료실</a>
                    <a href="<c:url value="/board/faq_list.do"/>" <custom:MenuConverter value="/board/faq_">class="on"</custom:MenuConverter>>FAQ</a>
                </div>
                </custom:MenuConverter>
                <!-- 
            <security:authorize ifAllGranted="ROLE_ADMIN">
            <a href="<c:url value="/admin/user_list.do"/>" <custom:MenuConverter value="admin">class="on"</custom:MenuConverter>>관리자</a>
            </security:authorize>
                 -->
        </div>
    </div>   
</div>