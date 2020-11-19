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
	<!-- Introducing Korean Space Environment Monitor  -->
	<h3 class='title_sub'><img src='<c:url value="/resources/en/images/sub/title_sub03.png"/>' alt='Introducing Korean Space Environment Monitor'></h3>
	<p>Korea Meteorological Administration (KMA) has succeed to convert the operation of the first domestic geostationary meteorological satellite, Chollian (launched in 2010), into regular operation in 2011. In order to ensure stable execution of its duties, the necessity for space weather observation and forecast of its surroundings was on the rise and KMA is going to support its weather observation duties to be successful by mounting a space weather observation sensor on the following geostationary meteorological satellite that is scheduled to be launched in 2018. Although a hazardous change of space weather does not occur frequently, when it occurs, it can cause a highly dangerous situation in space weather. Therefore, in order to prepare for a potential disaster, it is necessary to secure early detection and analysis technology and disaster prediction techniques with establishing the foundation of a permanent monitoring system.</p><br/>

	<p>To this purpose, KMA has been developing the Korean Space Environment Monitor (KSEM).</p><br/>

	<p>KSEM is comprised of Energetic Particle Detector, Magnetometer, and Satellite Charging Monitor. It is planned to observe near-Earth environment on a geostationary orbit.</p><br/>

	<p>The energetic particle detector will provide information on the high energy particle environment of the geostationary orbit by detecting electrons with energy bandwidth of 100KeV - 2MeV and protons with energy bandwidth of 100KeV - 20MeV in each 6 directions.</p><br/>

	<p>The magnetometer is the equipment to measure the Earth's magnetic field. It will measure variation of geomagnetic field caused by a geomagnetic storm.</p><br/>

	<p>The satellite charging monitor is the equipment to measure the amount of charged electric current between -3pA/cm<sub>2</sub> and 3pA/cm<sub>2</sub>. It will be used to analyze electrification phenomena that affect satellite system.</p><br/>

	<p>KSEM will be mounted on the next generation Korean multi-purpose satellite (Geo-KOMSAT-2A) that is scheduled to be launched in 2018, and will perform the mission of the space weather observation in a geostationary orbit for the first time in Korea.</p>
	<!-- //Introducing Korean Space Environment Monitor  -->
</div><!-- //content -->

<jsp:include page="/WEB-INF/views/include/engCommonFooter.jsp"/>


</body>
</html>