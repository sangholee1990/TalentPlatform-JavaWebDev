<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- header -->
<div id='header'>
	<div id='gnavw'>
		<ul class='gnav'>
			<li><a href='<c:url value="/en/index.do"/>'><img src="<c:url value="/resources/en/images/common/gnav_home.png"/>" alt='HOME'></a></li>
			<li class='fin'><a href='<c:url value="/ko/index.do"/>'><img src="<c:url value="/resources/en/images/common/gnav_korean.png"/>" alt='KOREAN'></a></li>
		</ul>
	</div>
	<!-- navi -->
	<div id="TopMenu">
		<div class="TopMenuSubWrap">
			<div id="TopMenuSub">
				<ul>
					<li><a href="<c:url value="/en/current.do"/>" role="<c:url value="/en/current.do"/>"><img class="m" src="<c:url value="/resources/en/images/common/menua_off.png"/>" alt="Current Space Weather Conditions" /></a></li>
					<li><a href="<c:url value="/en/intro.do?tab=sun"/>" role="<c:url value="/en/intro.do?tab=sun"/>"><img class="m" src="<c:url value="/resources/en/images/common/menub_off.png"/>" alt="Introduction to Space Weather" /></a></li>
					<li><a href="<c:url value="/en/ksem.do"/>" role="<c:url value="/en/ksem.do"/>"><img class="m" src="<c:url value="/resources/en/images/common/menuc_off.png"/>" alt="Korean Space Environment Monitor" /></a></li>
					<li><a href="<c:url value="/en/links.do"/>" role="<c:url value="/en/links.do"/>"><img class="m" src="<c:url value="/resources/en/images/common/menud_off.png"/>" alt="Related Links" /></a></li>
				</ul>
			</div>
			<div class="TopSubMenu">
				<dl class="menu1">
					<dd><a href="<c:url value="/en/current.do"/>" role="<c:url value="/en/current.do"/>">· Current Space Weather Conditions</a></dd>
				</dl>
				<dl class="menu2">
					<dd><a href="<c:url value="/en/intro.do?tab=sun"/>" role="<c:url value="/en/intro.do?tab=sun"/>">· Solar Activity</a></dd>
					<dd><a href="<c:url value="/en/intro.do?tab=mag"/>" role="<c:url value="/en/intro.do?tab=mag"/>">· Geomagnetic Activity</a></dd>
					<dd><a href="<c:url value="/en/intro.do?tab=weather"/>" role="<c:url value="/en/intro.do?tab=weather"/>">· Space Weather Observations</a></dd>
					<dd><a href="<c:url value="/en/intro.do?tab=alert"/>" role="<c:url value="/en/intro.do?tab=alert"/>">· Space Weather Forecast &<br/>Newsflash from KMA</a></dd>
				</dl>				
				<dl class="menu3">
					<dd><a href="<c:url value="/en/ksem.do"/>" role="<c:url value="/en/ksem.do"/>">· Korean Space Environment Monitor</a></dd>
				</dl>
				<dl class="menu4"> 
					<dd><a href="<c:url value="/en/links.do"/>" role="<c:url value="/en/links.do"/>">· Related Links</a></dd>
				</dl>
			</div>
		</div>
	</div><!-- //navi -->
	<div class='visual'>
		<h2 class='txt_space'><a href="<c:url value="/en/index.do"/>"><img src="<c:url value="/resources/en/images//main/txt_space.png"/>" alt='weather weather'></a></h2>
	</div>
</div><!-- //header -->