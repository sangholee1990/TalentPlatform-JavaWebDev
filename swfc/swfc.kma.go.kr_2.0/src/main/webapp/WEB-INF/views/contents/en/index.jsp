<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/WEB-INF/views/include/engCommonHeader.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/engCommonNavi.jsp"/>
<!-- content -->
<div class='content'>
	<div class='c_row1'>
		<div class='box_current'>
			<h3 class='txt_current'><img src="<c:url value="/resources/en/images//main/txt_current.png"/>" alt='Current Space Weather Conditions'><a href="<c:url value="/en/intro.do?tab=alert#newsflashHelp1"/>" title="Help Page" class="help"><span>Help</span></a></h3>
			<ul class='list_conditions'>
				<li>
					<div class='bg_cir <custom:CodeSign notice="${summary.notice1}"/>'><p><c:if test="${summary.notice1 != null}">${summary.notice1.code}</c:if></p></div>
					<img class='txt_conditions' src="<c:url value="/resources/en/images//main/txt_satellites.png"/>" alt='Satellites Operation'>
				</li>
				<li>
					<div class='bg_cir <custom:CodeSign notice="${summary.notice2}"/>'><p><c:if test="${summary.notice2 != null}">${summary.notice2.code}</c:if></p></div>
					<img class='txt_conditions' src="<c:url value="/resources/en/images//main/txt_polar.png"/>" alt='Polar Airways Weather Conditions'>
				</li>
				<li class='fin'>
					<div class='bg_cir <custom:CodeSign notice="${summary.notice3}"/>'><p><c:if test="${summary.notice3 != null}">${summary.notice3.code}</c:if></p></div>
					<img class='txt_conditions' src="<c:url value="/resources/en/images//main/txt_ionospheric.png"/>" alt='Ionospheric Weather Conditions'>
				</li>
			</ul>
		</div>
			<div class='list_storms_w'>
				<ul class='list_storms'>
					<li>
					<!-- 
						<p><img class='' src="<c:url value="/resources/en/images//main/txt_radiation.png"/>" alt='Solar Radiation Storms'><a href="/" title="Help Page" class="help"><span>Help</span></a></p>
					 -->
						<div class='bg_cir2 <custom:CodeSign notice="${summary.XRAY_H3}"/>'><p class='bg_cir2t'>${summary.XRAY_H3.grade}</p></div>
						<p class='txt_storms'>${summary.XRAY_H3.gradeTextEng}</p>
						<ul class='list_detail'>
							<li>· Current : ${summary.XRAY_NOW.val} (W/m2)</li>
							<li>· 
							<c:choose>
								<c:when test="${summary.XRAY_H3.dataType=='MP'}">Min </c:when>
								<c:otherwise>Max </c:otherwise>
							</c:choose> : ${summary.XRAY_H3.val} (W/m2)
							<fmt:parseDate value="${summary.XRAY_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
							<br/>&nbsp;&nbsp;<fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></li>
						</ul>
					</li>
					<li>
					<!-- 
						<p><img class='' src="<c:url value="/resources/en/images//main/txt_proton.png"/>" alt='Solar Proton Storms'><a href="/" title="Help Page" class="help"><span>Help</span></a></p>
					 -->
						<div class='bg_cir2 <custom:CodeSign notice="${summary.PROTON_H3}"/>'><p class='bg_cir2t'>${summary.PROTON_H3.grade}</p></div>
						<p class='txt_storms'>${summary.PROTON_H3.gradeTextEng}</p>
						<ul class='list_detail'>
							<li>· Current : ${summary.PROTON_NOW.val} (pfu)</li>
							<li>· <c:choose>
								<c:when test="${summary.PROTON_H3.dataType=='MP'}">Min</c:when>
								<c:otherwise>Max</c:otherwise>
							</c:choose> : ${summary.PROTON_H3.val} (pfu)
							<fmt:parseDate value="${summary.PROTON_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
							<br/>&nbsp;&nbsp;<fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></li>
						</ul>
					</li>
					<li>
						<!-- 
						<p><img class='' src="<c:url value="/resources/en/images//main/txt_geomagnetic.png"/>" alt='Geomagnetic Storms'><a href="/" title="Help Page" class="help"><span>Help</span></a></p>
						 -->
						<div class='bg_cir2 <custom:CodeSign notice="${summary.KP_H3}"/>'><p class='bg_cir2t'>${summary.KP_H3.grade}</p></div>
						<p class='txt_storms'>${summary.KP_H3.gradeTextEng}</p>
						<ul class='list_detail'>
							<li>· Current : ${summary.KP_NOW.val}</li>
							<li>· <c:choose>
								<c:when test="${summary.KP_H3.dataType=='MP'}">Min</c:when>
								<c:otherwise>Max</c:otherwise>
							</c:choose> : ${summary.KP_H3.val}
							<fmt:parseDate value="${summary.KP_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
							<br/>&nbsp;&nbsp;<fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></li>
						</ul>
					</li>
				</ul>
				<p class='liststorms_group'>We use NOAA Space Weather Scales for R, S, G.</p>
			</div>
			<ul class='list_storms list_storms2'>		
				<li class='fin'>
					<!-- 
					<p><img class='' src="<c:url value="/resources/en/images//main/txt_magnetopause.png"/>" alt='Magnetopause'><a href="/" title="Help Page" class="help"><span>Help</span></a></p>
					 -->
					<div class='bg_cir2 <custom:CodeSign notice="${summary.MP_H3}"/>'><p class='bg_cir2t2'>${summary.MP_H3.grade}</p></div>
					<p class='txt_storms'>${summary.MP_H3.gradeTextEng}</p>
					<ul class='list_detail'>
						<li>· Current : ${summary.MP_NOW.val} (RE)</li>
						<li>· <c:choose>
							<c:when test="${summary.MP_H3.dataType=='MP'}">Min</c:when>
							<c:otherwise>Max</c:otherwise>
						</c:choose> : ${summary.MP_H3.val} (RE)
						<fmt:parseDate value="${summary.MP_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
						<br/>&nbsp;&nbsp;<fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></li>
					</ul>
				</li>
			</ul>
	</div>

	<div class='c_row2'>
		<h3 class='txt_about'><img src="<c:url value="/resources/en/images//main/txt_about.png"/>" alt='About Space weather'></h3>
		<div class='about_column'>
			<div class='about_column1'>
				<p><img src="<c:url value="/resources/en/images//main/img_about.png"/>" alt='img'></p>
				<h4 class='txt_wisw'>What is Space Weather?</h4>
				<p>Space weather refers to physical phenomena in the outer space which can affect human activities in the space or on the surface of the Earth. Space weather are mainly caused by explosive activities of the sun that have significant impact on human activities bringing about satellite operation errors, communication disturbance, degrading credibility of surface observation instruments, radiation exposure and changes in earth’s temperature and climate.<br/>
				When electromagnetic and particle radiations are released or the magnetic field environment changed, ionosphere disturbance, radio interference and geomagnetic storm occur in a few minutes to several days.</p>
			</div>
			<div class='about_column2'>
				<h4 class='txt_nmsc'>NMSC Space Weather Monitoring Office</h4>
				<p class='txt_space'>Space Weather Monitoring System <br/>– Current Space Weather</p>
				<p>The System monitors real-time solar images from Solar Dynamic Observatory (SDO), GOES X-ray flux, high energy particle flux, ACE interplanetary magnetic field, Kp index, Dst index and the location of magnetopause.</p>
				<br/><br/>
				<p class='txt_tnmsc'>The NMSC conducts various research projects to lay a foundation for space weather forecast/warning service for the public in preparation for solar activities. It operates a space weather test bed system and monitoring system to constantly monitor and analyze the current space weather in order to support the stable operation of Korean satellites including COMS and to prevent national damage which may result from solar activities.</p>
				<img class='img_earth' src="<c:url value="/resources/en/images/main/img_earth.png"/>" alt='img'>
			</div>
		</div>
	</div>	

</div><!-- //content -->

<jsp:include page="/WEB-INF/views/include/engCommonFooter.jsp"/>


</body>
</html>