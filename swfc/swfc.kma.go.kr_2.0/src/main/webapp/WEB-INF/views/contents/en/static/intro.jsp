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
/*
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
});*/
</script><!-- //tab -->
</head>
<body>
<jsp:include page="/WEB-INF/views/include/engCommonNavi.jsp"/>
<!-- content -->
<div class='content_sub'>
	<h3 class='title_sub'><img src='<c:url value="/resources/en/images/sub/title_sub02.png"/>' alt='Introduction to Space Weather'></h3>
	
	<!-- Introduction to Space Weather  -->
    <div id="tab" class="tab3">
    	<a href="<c:url value="/en/intro.do?tab=sun"/>" class="tb_solar <c:if test="${ param.tab eq 'sun' }">on</c:if>"><span>Solar Activity</span></a>
        <a href="<c:url value="/en/intro.do?tab=mag"/>" class="tb_geomagnetic <c:if test="${ param.tab eq 'mag' }">on</c:if>"><span>Geomagnetic Activity</span></a>
        <a href="<c:url value="/en/intro.do?tab=weather"/>" class="tb_spaceob <c:if test="${ param.tab eq 'weather' }">on</c:if>"><span>Space Weather Observations</span></a>
        <a href="<c:url value="/en/intro.do?tab=alert"/>" class="tb_spacenew <c:if test="${ param.tab eq 'alert' }">on</c:if>"><span>Space Weather Forecast & Newsflash from KMA</span></a>
    </div>
    
    <c:if test="${ param.tab eq 'sun' }">
    <!-- Solar Activity -->
    <div id="tb_solar">
        <h4 class="tb_solar">
			<img src='<c:url value="/resources/en/images/sub/txt_sub02_subj1.png"/>' alt='Solar Activity'>
        </h4>
		<img class='img_solarf' src='<c:url value="/resources/en/images/sub/img_solarf.png"/>' alt='Solar Flare'>
		<img src='<c:url value="/resources/en/images/sub/img_coronalme.png"/>' alt='Coronal Mass Ejection '>
		<dl class='solarlist sub02list'>
			<dt>1. Solar Flare</dt>
				<dd>A solar flare is a sudden release of the magnetic energy from the solar surface which is stored in magnetic lines of force of the solar atmosphere. Flares mainly occur at the sunspots. As the magnetic field in active regions around sunspots gets unstable, the structure of the magnetic field is collapsed and it is presumed that this causes the solar flare. Flares are often followed by a high energy proton emission and a coronal mass ejection. They produce a broad range of electromagnetic waves from radio waves to gamma rays, and X-rays are primarily used for observational data to classify the intensity of flares. Because flares emit electromagnetic waves, the primary hazard to space weather can be communications interference such as satellite communications disruption, aeronautical operational communications disruption, GPS signal reception interruption, and the like.</dd>
			<dt>2. Solar Proton Event</dt>
				<dd>When a solar flare occurs, high energy protons in the solar atmosphere can reach the Earth in several hours at a very high velocity. This is called âsolar proton eventâ. A part of protons which is ejected during solar flares presumably causes the solar proton event. An unusually strong solar flare tends to be accompanied by it. The primary hazard to space weather due to solar proton event can be the increase of radiation dose. When high energy protons are injected into polar regions through the Earth's upper atmosphere, it increases radiation dose in the vicinity of polar airways and can affect flight crew who mostly operate an aircraft to polar regions. Also, the polar orbiting satellite can be in danger of radiation exposure.</dd>
			<dt>3. Coronal Mass Ejection (CME)</dt>
				<dd>A coronal mass ejection is a massive release of solar material from the Sunâs surface in a short amount of time. The ejected solar material is the plasma that consists of electric charged particles including electrons and protons. A high speed coronal mass ejection can produce a shock wave at the front of it. The cause of this coronal mass ejection is thought to be originated from the unstable magnetic field and plasma above the solar surface. It has a larger variety of hazards to space weather than a solar flare does. For example, the shock wave created by coronal mass ejections affects the orbit of a satellite, making the satellite to malfunction, increases radiation dose in the vicinity of polar airways, and causes a magnetic storm.</dd>
		</dl>

    </div>
    <!-- //Solar Activity -->
    </c:if>
    
    <c:if test="${ param.tab eq 'mag' }">
    <!-- Geomagnetic Activity -->
    <div id="tb_geomagnetic" >
        <h4 class="">
            <img src='<c:url value="/resources/en/images/sub/txt_sub02_subj2.png"/>' alt='Geomagnetic Activity'>
        </h4>
		<img class='img_geomagnetic' src='<c:url value="/resources/en/images/sub/img_geomagnetic.png"/>' alt='Geomagnetic Activity images'>
		<dl class='geomagneticlist sub02list'>
			<dt>1. Earth's Magnetosphere</dt>
				<dd>The Earth's magnetic field, which is generated by convection of liquid metals in the outer core of the Earth, plays a pivotal role in shielding the Earth from risks of space weather such as electromagnetic waves and plasma flowing out of the Sun and cosmic rays scattered in space. The boundary between solar wind and the Earth's magnetosphere is called âmagnetopauseâ and, from that boundary toward the interior, the Earth is being protected against dangers of space weather. The shape of the Earth's magnetosphere is not a round dipole due to plasma and interplanetary magnetic field flowing out of the Sun. Instead, it has the shape that the part near the Sun is compressed and the opposite part is long loosened. Because of this, the shape of the Earth's magnetosphere is incredibly variable depending on the status of solar wind. The Earth's magnetosphere is disturbed by space weather conditions. Magnetopause compression and magnetic storms are the two main interruptions.</dd>
			<dt>2. Magnetopause Compression</dt>
				<dd class='geomagneticlist_mb20'>When a colossal coronal mass ejection and high speed solar wind develop from the Sun, the Earth's magnetic field to shield the Earth from risks of space weather gets more compressed than usual. If the magnetopause gets more compressed than a geostationary orbit does, the geostationary orbit satellite will be exposed to the danger of solar wind, not being able to be protected by the Earth's magnetic field. Also, if a satellite is positioned outside of the magnetopause, the overall operation of the satellite can be affected by communications disruption and damages on the satellite itself by the solar high energy particles.</dd>
		</dl>
		<dl class='sub02list'>
			<dt>3. Geomagnetic Storm</dt>
				<dd>A geomagnetic storm is a temporary disturbance of the Earth's magnetism on a large scale all over the world. This disturbance can be for some hours or for some days depending on its scale. The direct cause of the geomagnetic storm is an electric current produced by enormous quantities of plasma injected from the Sun. The electric current is called âring currentâ and it drastically decreases the strength of the horizontal component of the Earth's magnetic field. The Kp Index and the Dst Index monitor this strength change. When a geomagnetic storm occurs and significantly decreases the strength of the Earth's magnetic field, it makes a change in electromagnetism of satellite orbits and affects the satellites themselves and their operation. It also causes injection of radiation into the vicinity of polar airways. If this change in the Earth's magnetic field has an impact on the ionosphere, it will disturb GPS signal receptions and telecommunications which can cause interruptions in satellite communications and aeronautical operational communications.</dd>
		</dl>
    </div>
    <!-- //Geomagnetic Activity -->
    
    </c:if>
    <!-- END 지자기활동 -->
    
    <!-- 우주기상감시 -->
    <c:if test="${ param.tab eq 'weather' }">
    
    <!-- Space Weather Observations -->
    <div id="tb_spaceob">
        <h4 class="">
            <img src='<c:url value="/resources/en/images/sub/txt_sub02_subj3.png"/>' alt='Space Weather Observations'>
        </h4>
		<img class='img_spaceob' src='<c:url value="/resources/en/images/sub/img_spaceob.png"/>' alt='Space Weather Observations images'>
		<dl class='sub02list'>
			<dt>Space Weather Change Observations</dt>
				<dd>To monitor changes of space weather, Korea Meteorological Administration (KMA) is observing changes in solar activities and the Earth's magnetic field. Typical solar activities that affect space weather are solar flares and coronal mass ejections. The monitoring of solar activities are conducted mostly by space satellite observation. The main satellites to observe solar flares are GOES-13 and GOES-15. The main satellites to observe coronal mass ejections are STEREO-A, STEREO-B, and SOHO. The ACE satellite observes solar wind and interplanetary magnetic field in order to monitor changes in solar wind caused by coronal mass ejections and high speed solar wind. The observation of changes in the Earth's magnetic field requires both satellite observation and ground magnetic field observation. KMA uses data from GOES-13 and GOES-15 to monitor changes in geostationary orbits. As to changes in ground magnetic field, KMA uses Kp Index and Dst Index, the global geomagnetic storm indexes.</dd>
		</dl>
    </div>
    <!-- //Space Weather Observations -->
    
    </c:if>
    
     <!-- 기상청의 우주기상예특보 -->
     <c:if test="${ param.tab eq 'alert' }">
     
    <!-- Space Weather Observations -->
    <div id="tb_spacenew">
        <h4 class="">
            <img src='<c:url value="/resources/en/images/sub/txt_sub02_subj4.png"/>' alt='Space Weather Observations'>
        </h4>
		<img class='img_spacenew' src='<c:url value="/resources/en/images/sub/img_spacenew.png"/>' alt='Space Weather Observations images'>
		<p class='txt_spacenew'>Korea Meteorological Administration (KMA) prepares for risks from space weather effects by observing solar activities and changes in the Earth's magnetic field at all times. KMA particularly monitors meteorological satellites operation, aviation weather in polar airways, and ionospheric weather </p>
		<dl class='sub02list'>
			<dt>1. Meteorological Satellites Operation</dt>
				<dd>The meteorological satellites operation is a source of the space weather forecast and newsflash that enables KMA to support stable operations of Chollian satellite and the following meteorological satellite against space weather effects. The space weather factors that influence on the meteorological satellites operation are the solar flare which causes communications disruption, and the geomagnetic storms and magnetopause positions which have an impact on satellite orbits. When issuing a space weather newsflash, KMA monitors and adjusts satellite orbits, modifies the operating angle of the solar photovoltaic modules, and monitors satellite transmission failures.</dd>
			<dt>2. Aviation Weather Observation in Polar Airways</dt>
				<dd>The aviation weather observation in polar airways is a source of the space weather forecast and newsflash that enables KMA to support space weather service decisions of World Meteorological Organization (WMO) and space weather administrative standards of International Civil Aviation Organization (ICAO). The space weather factors that influence on the aviation weather conditions are the solar flare which causes aviation communications disruption, and the high-energy particles from the sun and the geomagnetic storms which increase the level of radiation in the vicinity of polar airways. When issuing a space weather newsflash, KMA adjusts cruising altitude of an aircraft, advises flight crew to bypass the Arctic passage, and monitors GPS signal reception errors and communications interruption.</dd>
			<dt>3. Ionospheric Weather Observation</dt>
				<dd>The ionospheric weather observation is a source of the space weather facorecast and newsflash that enables KMA to support calculating electron density and perceptible water by using observational data from the global navigation satellite system (GNSS). When a solar flare and a geomagnetic storm occur, the electron density of the ionosphere that is super upper atmosphere of the Earth gets increases. KMA utilizes the GNSS to calculate electron density and monitor any changes in the ionosphere. It also calculates perceptible water for its mathematical forecasting. When issuing a space weather newsflash related to the ionospheric weather conditions, KMA monitors changes of meteorological elements and numerical model results which can affect weather and climate prediction.</dd>
		</dl>
		
		<a name="newsflashHelp1"></a>
		<!-- Standards of KMAâs Space Weather Forecast & Newsflash -->
		<table summary='Standards of KMA’s Space Weather Forecast & Newsflash' class="infotable">
			<caption class=''>&lt;Standards of KMA’s Space Weather Forecast & Newsflash&gt;</caption>
			<colgroup>
				<col width='20%'/>
				<col width='20%'/>
				<col width='20%'/>
				<col width='20%'/>
				<col width='20%'/>
			</colgroup>
			<tbody>
			<tr>
				<th rowspan='2'>Item</th>
				<th colspan='3'>Standards of Situation</th>
				<th rowspan='2'>Situation Dismissal</th>
			</tr>
			<tr>
				<th width='20%' class='bg_blue'>Minor</th>
				<th width='20%' class='bg_gray'>Caution</th>
				<th width='20%' class='bg_puple'>Alert</th>
			</tr>
			<tr>
				<td rowspan='4'>Meteorological<br/>Satellite<br/>Operation</td>
				<td class='bg_blue'>R2 and below</td>
				<td class='bg_gray'>R3</td>
				<td class='bg_puple'>R4 and above</td>
				<td rowspan='9'>Retaining stabilized situation for<br/>at least 3 hrs.<br/><br/>
					(Retaining the situation<br/>
					under category 2 <br/>
					of NOAA scale for 3 hrs.)
				</td>
			</tr>
			<tr>
				<td class='bg_blue'>S2 and below</td>
				<td class='bg_gray'>S3</td>
				<td class='bg_puple'>S4 and above</td>
			</tr>
			<tr>
				<td class='bg_blue'>G2 and below</td>
				<td class='bg_gray'>G3</td>
				<td class='bg_puple'>G4 and above</td>
			</tr>
			<tr>
				<td class='bg_blue'>Magnetopause Position<br/>Geostationary Orbit</td>
				<td class='bg_gray'>Magnetopause Position<br/>&#61;&lt; Geostationary Orbit</td>
				<td class='bg_puple'>Magnetopause Position<br/>&#61;&lt; Geostationary Orbit</td>
			</tr>
			<tr>
				<td rowspan='3'>Meteorological<br/>Satellite<br/>Operation</td>
				<td class='bg_blue'>R2 and below</td>
				<td class='bg_gray'>R3</td>
				<td class='bg_puple'>R4 and above</td>
			</tr>
			<tr>
				<td class='bg_blue'>S2 and below</td>
				<td class='bg_gray'>S3</td>
				<td class='bg_puple'>S4 and above</td>
			</tr>
			<tr>
				<td class='bg_blue'>G2 and below</td>
				<td class='bg_gray'>G3</td>
				<td class='bg_puple'>G4 and above</td>
			</tr>
			<tr>
				<td rowspan='3'>Ionospheric<br/>Weather</td>
				<td class='bg_blue'>R2 and below</td>
				<td class='bg_gray'>R3</td>
				<td class='bg_puple'>R4 and above</td>
			</tr>
			<tr>
				<td class='bg_blue'>G2 and below</td>
				<td class='bg_gray'>G3</td>
				<td class='bg_puple'>G4 and above</td>
			</tr>
			</tbody>
		</table>
		<p class='info_reference'>* R=Radio Blackouts, S=Solar Radiation Storms, G=Geomagnetic Storms</p>
		<!-- //Standards of KMAâs Space Weather Forecast & Newsflash -->

		<a name="newsflashHelp2"></a>
		<!-- Expected Damage from Space Weather Changes -->
		<table summary='Standards of KMA’s Space Weather Forecast & Newsflash' class="infotable">
			<caption class=''>&lt;Standards of KMA’s Space Weather Forecast & Newsflash&gt;</caption>
			<colgroup>
				<col width='11%'/>
				<col width='11%'/>
				<col width='26%'/>
				<col width='26%'/>
				<col width='26%'/>
			</colgroup>
			<tbody>
			<tr>
				<th rowspan='2'>Situation<br/>Category</th>
				<th rowspan='2'>Scale<br/>Descriptor</th>
				<th colspan='3'>Expected Damage</th>
			</tr>
			<tr>
				<th>Meteorological Satellite Operation</th>
				<th>Polar Airways Aviation Weather</th>
				<th>Ionospheric Weather</th>
			</tr>
			<tr>
				<td rowspan='3' class='bg_blue'>Minor</td>
				<td class='bg_blue'>0 (Low)</td>
				<td rowspan='2' class='bg_blue'>- None</td>
				<td rowspan='2' class='bg_blue'>- None</td>
				<td rowspan='2' class='bg_blue'>- None</td>
			</tr>
			<tr>
				<td class='bg_blue'>1 (Minor)</td>
			</tr>
			<tr>
				<td class='bg_blue'>2 (Moderate)</td>
				<td class='bg_blue txt_alignl'>
					- Satellite operation needs to be adjusted from ground station.<br/>
					- Changes in orbit of low earth orbit satellites can happen.
				</td>
				<td class='bg_blue txt_alignl'>
					- Flight crew and passengers in polar airways are exposed to radiation.<br/>
					- HF radio communications and cruising in polar regions are affected.
				</td>
				<td class='bg_blue txt_alignl'>
					- Flight crew and passengers in polar airways are exposed to radiation.<br/>
					- HF radio communications and cruising in polar regions are affected.
				</td>
			</tr>
			<tr>
				<td class='bg_gray'>Caution</td>
				<td class='bg_gray'>3 (Strong)</td>
				<td class='bg_gray txt_alignl'>
					- Errors in satellite orbits increase.<br/>
					- Satellite communication signals attenuate.<br/>
					- Orbit attraction of low earth orbit satellites occurs.
				</td>
				<td class='bg_gray txt_alignl'>
					- Efficiency of HF radio communications in 
					  polar regions declines.<br/>
					- Aircrafts navigating through polar airways 
					  are exposed to radiation.
				</td>
				<td class='bg_gray'>
					- GPS signals attenuate.
				</td>
			</tr>
			<tr>
				<td rowspan='2' class='bg_puple'>Alert</td>
				<td class='bg_puple'>4 (Severe)</td>
				<td class='bg_puple txt_alignl'>
					- Problems on surface charging and location 
					  tracking of satellite occur.<br/>
					- Orbit attraction of low earth orbit satellites 
					  occurs.<br/>
					- Error value in observed images occurs due 
					  to memory device failure.<br/>
					- Damages to satellites themselves.<br/>
					- Satellite communications and location 
					  tracking are interrupted.
				</td>
				<td class='bg_puple txt_alignl'>
					- HF radio communications in polar regions are 
					  disturbed.<br/>
					- Aircrafts navigating through polar airways are 
					  exposed to radiation.
				</td>
				<td class='bg_puple'>
					- GPS communications are disturbed
				</td>
			</tr>
			<tr>
				<td class='bg_puple'>5 (Extreme)</td>
				<td class='bg_puple txt_alignl'>
					- Problems on surface charging and location 
					  tracking of satellite occur.<br/>
					- Orbit attraction of low earth orbit satellites 
					  occurs.<br/>
					- Error value in observed images occurs due 
					  to memory device failure.<br/>
					- Damages to satellites themselves.<br/>
					- Satellite communications and locations 
					  tracking are interrupted.
				</td>
				<td class='bg_puple txt_alignl'>
					- HF radio communications are impossible in 
					  the hemisphere toward the Sun for several 
					  hours.<br/>
					- Aircrafts navigating through polar airways 
					  are exposed to radiation.
				</td>
				<td class='bg_puple'>
					- GPS communications are disturbed
				</td>
			</tr>
			</tbody>
		</table>
		<p class='info_reference'>*HF=High frequency, LF=Low frequency</p>
		<!-- //Expected Damage from Space Weather Changes -->
    </div>
    </c:if>
    <!-- //Space Weather Observations -->
	<!-- //Introduction to Space Weather  -->
</div><!-- //content -->

<jsp:include page="/WEB-INF/views/include/engCommonFooter.jsp"/>

</body>
</html>