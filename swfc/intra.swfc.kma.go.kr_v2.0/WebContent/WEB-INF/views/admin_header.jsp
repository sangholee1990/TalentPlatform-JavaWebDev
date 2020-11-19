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
            </security:authorize>            
        </div>
        <div class="menu" id="menu">
            <security:authorize ifAllGranted="ROLE_ADMIN">
        	<a href="<c:url value="/satmetamng/sensor_list.do"/>" <custom:MenuConverter value="metamng">class="on"</custom:MenuConverter>>위성 메타 관리</a>
        		<custom:MenuConverter value="metamng">
        		<div class="menusub" style="left:0px;">
        			<a href="<c:url value="/satmetamng/sat_grp_list.do"/>" <custom:MenuConverter value="sat_grp_list">class="on"</custom:MenuConverter>>위성그룹 리스트</a>
                    <a href="<c:url value="/satmetamng/sensor_list.do"/>" <custom:MenuConverter value="sensor_list">class="on"</custom:MenuConverter>>센서 관리</a>
                    <a href="<c:url value="/satmetamng/band_grp_list.do"/>" <custom:MenuConverter value="band_grp_list">class="on"</custom:MenuConverter>>밴드그룹 관리</a>
                    <a href="<c:url value="/satmetamng/band_list.do"/>" <custom:MenuConverter value="band_list">class="on"</custom:MenuConverter>>밴드 관리</a>
                </div>
                </custom:MenuConverter>
                
            <a href="<c:url value="/admin/user_list.do"/>" <custom:MenuConverter value="admin">class="on"</custom:MenuConverter>>관리자</a>
            	<custom:MenuConverter value="admin">
            	<div class="menusub" style="left:500px;">
                    <a href="<c:url value="/admin/user_list.do"/>" <custom:MenuConverter value="/admin/user">class="on"</custom:MenuConverter>>사용자관리</a>
                    <a href="<c:url value="/admin/program_list.do"/>" <custom:MenuConverter value="program_list">class="on"</custom:MenuConverter>>프로그램 관리</a>
                    <a href="<c:url value="/admin/dbinfo_list.do"/>" <custom:MenuConverter value="dbinfo_list">class="on"</custom:MenuConverter>>DB정보 관리</a>
                </div>            
                </custom:MenuConverter>
            </security:authorize>
        </div>
    </div>   
</div>