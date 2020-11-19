<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/WEB-INF/views/include/engCommonHeader.jsp"/>
<!-- tab -->
<script type="text/javascript">
$(function() {
	var tabItems = $("#tab a"); 
	tabItems.click(function() {
		var tabContents = $("#tb_solar,#tb_geomagnetic,#tb_spaceob,#tb_spacenew");
		tabContents.hide();
		tabItems.removeClass("on");
		var index = tabItems.index(this);
		tabContents.eq(index).show();
		$(this).addClass("on");
		return false;
	});
});
</script><!-- //tab -->
</head>
<body>
<jsp:include page="/WEB-INF/views/include/engCommonNavi.jsp"/>
<!-- content -->
<div class='content_sub'>	
	<!-- Related Links -->
	<h3 class='title_sub'><img src='<c:url value="/resources/en/images/sub/title_sub04.png"/>' alt='Related Links'></h3>
	<ul class='relatedlist'>
	<!-- 
		<li>
			<div class='relatedlist_box'><img class='txt_overseas' src='<c:url value="/resources/en/images/sub/txt_overseas.png"/>' alt='Overseas Space Weather Agencies'></div>
			<div class='bt_link'><a href='http://www.swpc.noaa.gov/'><img class='' src='<c:url value="/resources/en/images/sub/bt_link.png"/>' alt='Link'></a></div>		
		</li>
	 -->
		<li>
			<div class='relatedlist_box'><br/>Space Weather Prediction Center of<br/> National Oceanic and<br/> Atmospheric Administration,<br/> U.S.A.</div>
			<div class='bt_link'><a href='http://www.swpc.noaa.gov/' target="_blank"><img class='' src='<c:url value="/resources/en/images/sub/bt_link.png"/>' alt='Link'></a></div>		
		</li>
		<li>
			<div class='relatedlist_box'><br/>Bureau of Meteorology's<br/> Ionospheric rediction Service,<br/> Australia</div>
			<div class='bt_link'><a href='http://www.ips.gov.au/' target="_blank"><img class='' src='<c:url value="/resources/en/images/sub/bt_link.png"/>' alt='Link'></a></div>		
		</li>
		<li>
			<div class='relatedlist_box'><br/>ACE Science Center at California<br/> Institute of Technology,<br/> U.S.A.</div>
			<div class='bt_link'><a href='http://www.srl.caltech.edu/ACE/' target="_blank"><img class='' src='<c:url value="/resources/en/images/sub/bt_link.png"/>' alt='Link'></a></div>		
		</li>		
		<li class='fin'>
			<div class='relatedlist_box'><br/>The SDO Mission of<br/> National Aeronautics and<br/> Space Administration,<br/> U.S.A.</div>
			<div class='bt_link'><a href='http://sdo.gsfc.nasa.gov/' target="_blank"><img class='' src='<c:url value="/resources/en/images/sub/bt_link.png"/>' alt='Link'></a></div>		
		</li>
		<li>
			<div class='relatedlist_box'><br/>The SOHO Mission of<br/> National Aeronautics and<br/> Space Administration,<br/> U.S.A.</div>
			<div class='bt_link'><a href='http://sohowww.nascom.nasa.gov/' target="_blank"><img class='' src='<c:url value="/resources/en/images/sub/bt_link.png"/>' alt='Link'></a></div>		
		</li>
		<li>
			<div class='relatedlist_box'><br/>The STREO Mission of<br/> National Aeronautics and<br/> Space Administration,<br/>U.S.A.</div>
			<div class='bt_link'><a href='http://stereo-ssc.nascom.nasa.gov/' target="_blank"><img class='' src='<c:url value="/resources/en/images/sub/bt_link.png"/>' alt='Link'></a></div>		
		</li>
		<li>
			<div class='relatedlist_box'><br/>Space Weather Research Center of<br/> National Aeronautics and<br/> Space Administration,<br/>U.S.A.</div>
			<div class='bt_link'><a href='http://swc.gsfc.nasa.gov/main/' target="_blank"><img class='' src='<c:url value="/resources/en/images/sub/bt_link.png"/>' alt='Link'></a></div>		
		</li>
		<li class='fin'>
			<div class='relatedlist_box'><br/>Technical University of Denmark,<br/>Denmark</div>
			<div class='bt_link'><a href='http://www.space.dtu.dk/english/Research/Universe_and_Solar_System/Space_weather' target="_blank"><img class='' src='<c:url value="/resources/en/images/sub/bt_link.png"/>' alt='Link'></a></div>		
		</li>
	</ul>
	<!-- //Related Links -->
</div><!-- //content -->

<jsp:include page="/WEB-INF/views/include/engCommonFooter.jsp"/>


</body>
</html>