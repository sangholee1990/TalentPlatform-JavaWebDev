<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/jquery.jsp" />
<script type="text/javascript">
$(function() {
	/*
	var tabItems = $("#tab a"); 
	tabItems.click(function() {
		var tabContents = $("#tabitem1,#tabitem2,#tabitem3");
		tabContents.hide();
		tabItems.removeClass("on");
		var index = tabItems.index(this);
		tabContents.eq(index).show();
		$(this).addClass("on");
		if(index == 0) {
			$("#tab1_sub").show();
		} else {
			$("#tab1_sub").hide();
		}
		
		return false;
	});
	*/
	var tab1SubItems = $("#tab1_sub a"); 
	tab1SubItems.click(function() {
		var tabContents = $("#tabitem1_sub1,#tabitem1_sub2,#tabitem1_sub3");
		tabContents.hide();
		tab1SubItems.removeClass("on");
		var index = tab1SubItems.index(this);
		tabContents.eq(index).show();
		$(this).addClass("on");
		switch(index) {
		case 0:
			$("#tabitem1").height("1850px");
			break;
		case 1:
			$("#tabitem1").height("930px");
			break;
			
		case 2:
			$("#tabitem1").height("460px");
			break;
		}
		return false;
	});
});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/topMenu.jsp"/>
<div id="wrap_sub">
	<h2 class="link">
    	<span>해외 우주기상 정보</span>
    </h2>
    <div id="tab" class="tab2">
    	<a href="<c:url value="/ko/links.do?tab=sub1"/>" class="pola <c:if test="${ param.tab eq 'sub1' }">on</c:if>"><span>극항로 항공기상</span></a>
        <a href="<c:url value="/ko/links.do?tab=sub2"/>" class="sate <c:if test="${ param.tab eq 'sub2' }">on</c:if>"><span>위성운영</span></a>
        <a href="<c:url value="/ko/links.do?tab=sub3"/>" class="rela <c:if test="${ param.tab eq 'sub3' }">on</c:if>"><span>해외관련기관</span></a>
    </div>
    
    <c:if test="${ param.tab eq 'sub1' }">
    <div id="tab1_sub" class="tab_sub">
    	<a href="#" class="pola on"><span>방사선량 정보</span></a>
        <a href="#" class="sate"><span>통신환경 정보</span></a>
        <a href="#" class="rela"><span>극지방 오로라 정보</span></a>
    </div>
    
    <div id="tabitem1" class="wrap_link" style="height:1865px">
	    <div id="tabitem1_sub1">
	    	<table>
				<tr>
					<td colspan=2>
						<a href="http://terra2.spacenvironment.net/~raps_ops/current_files/FlightPath.html" target="_blank"><b>Space Environment Technologies사 NAIRAS모델<br>(Space Environment Technologies NAIRAS Model)</b></a>
					</td>
				</tr>
	    		<tr>
	    			<td>
			        	<a href="http://terra2.spacenvironment.net/~raps_ops/current_files/index.html" target="_blank">
			            	<img src="http://sol.spacenvironment.net/raps_ops/current_files/rtimg/table.png" alt="" class="imgbtn"/>
			            </a>
	    			</td>
	    			<td>
			        	<a href="http://terra2.spacenvironment.net/~raps_ops/current_files/index.html" target="_blank">
			            	<img src="http://sol.spacenvironment.net/raps_ops/current_files/rtimg/dose.5km.png" alt="" class="imgbtn"/>
			            </a>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>
			        	<a href="http://terra2.spacenvironment.net/~raps_ops/current_files/index.html" target="_blank">
			            	<img src="http://sol.spacenvironment.net/raps_ops/current_files/rtimg/dose.11km.png" alt="" class="imgbtn"/>
			            </a>
	    			</td>
	    			<td>
			        	<a href="http://terra2.spacenvironment.net/~raps_ops/current_files/index.html" target="_blank">
			            	<img src="http://sol.spacenvironment.net/raps_ops/current_files/rtimg/dose.15km.png" alt="" class="imgbtn"/>
			            </a>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>
			        	<a href="http://terra2.spacenvironment.net/~raps_ops/current_files/FlightPath.html" target="_blank">
			            	<img src="http://sol.spacenvironment.net/raps_ops/current_files/rtimg/NY-UK.track.png" alt="" class="imgbtn"/>
			            </a>
	    			</td>
	    			<td>
			        	<a href="http://terra2.spacenvironment.net/~raps_ops/current_files/FlightPath.html" target="_blank">
			            	<img src="http://sol.spacenvironment.net/raps_ops/current_files/rtimg/IL-SW.track.png" alt="" class="imgbtn"/>
			            </a>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>
			        	<a href="http://terra2.spacenvironment.net/~raps_ops/current_files/FlightPath.html" target="_blank">
			            	<img src="http://sol.spacenvironment.net/raps_ops/current_files/rtimg/IL-GE.track.png" alt="" class="imgbtn"/>
			            </a>
	    			</td>
	    			<td>
			        	<a href="http://terra2.spacenvironment.net/~raps_ops/current_files/FlightPath.html" target="_blank">
			            	<img src="http://sol.spacenvironment.net/raps_ops/current_files/rtimg/IL-BJ.track.png" alt="" class="imgbtn"/>
			            </a>
	    			</td>
	    		</tr>
			</table>
		</div>
		
	    <div id="tabitem1_sub2" style="display:none;">
	    	<table>
				<tr>
					<td colspan=2>
						<a href="http://www.swpc.noaa.gov/drap/index.html" target="_blank"><b>미국 해양대기청 우주기상 예측센터 이온권 D층 전파흡수 예측모델<br>(NOAA SWPC D Region Absorption Predictions (D-RAP))</b></a>
					</td>
				</tr>
	    		<tr>
	    			<td colspan="2">
			        	<a href="http://www.swpc.noaa.gov/drap/index.html" target="_blank">
			            	<img src="http://services.swpc.noaa.gov/images/drap_f05_global.png" alt="" class="imgbtn" style="width:900px"/>
			            </a>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>
			        	<a href="http://www.swpc.noaa.gov/drap/index.html" target="_blank">
			            	<img src="http://services.swpc.noaa.gov/images/drap_f05_n-pole.png" alt="" class="imgbtn"/>
			            </a>
	    			</td>
	    			<td>
			        	<a href="http://www.swpc.noaa.gov/drap/index.html" target="_blank">
			            	<img src="http://services.swpc.noaa.gov/images/drap_f05_s-pole.png" alt="" class="imgbtn"/>
			            </a>
	    			</td>
	    		</tr>
	    	</table>
	    </div> 
	    
	    <div id="tabitem1_sub3" style="display:none;">
	    	<table>
				<tr>
					<td colspan=2>
						<a href="http://www.swpc.noaa.gov/drap/index.html" target="_blank"><b>미국 해양대기청 우주기상 예측센터 OVATION 오로라 모델<br>(NOAA SWPC OVATION Aurora Model)</b></a>
					</td>
				</tr>
	    		<tr>
	    			<td>
			        	<a href="http://www.swpc.noaa.gov/ovation/" target="_blank">
			            	<img src="http://services.swpc.noaa.gov/images/animations/ovation-north/latest.png" alt="" class="imgbtn"/>
			            </a>
	    			</td>
	    			<td>
			        	<a href="http://www.swpc.noaa.gov/ovation/" target="_blank">
			            	<img src="http://services.swpc.noaa.gov/images/animations/ovation-south/latest.png" alt="" class="imgbtn"/>
			            </a>
	    			</td>
	    		</tr>
	    	</table>
	    </div>
    </div>
    </c:if>
    
    <c:if test="${ param.tab eq 'sub2' }">
	<div id="tabitem2" class="wrap_link" style="height:480px;">
    	<div>
			<table>
				<tr>
					<td>
						<a href="http://www.swpc.noaa.gov/rt_plots/satenv.html" target="_blank"><b>미국 해양대기청 위성환경 차트 (GOES위성 측정자료)<br>(NOAA SWPC Satellite Environments Plot)</b></a>
					</td>
					<td>
						<a href="http://ccmc.gsfc.nasa.gov/models/modelinfo.php?model=SWMF/BATS-R-US%20with%20RCM" target="_blank"><b>미국 항공우주국 BATSRUS 모델<br>(NASA CCMC BATSRUS Model)</b></a>
					</td>
				</tr>
				<tr>
					<td>
						<a href="http://www.swpc.noaa.gov/rt_plots/satenv.html" target="_blank">
							<!--<img src="http://www.swpc.noaa.gov/rt_plots/SatEnv.gif" alt="" class="imgbtn" style="width:640px"/>-->
							<img src="http://services.swpc.noaa.gov/images/satellite-env.gif" alt="" class="imgbtn"/>
						</a>	
					</td>
					<td>
						<a href="http://ccmc.gsfc.nasa.gov/models/modelinfo.php?model=SWMF/BATS-R-US%20with%20RCM" target="_blank">
							<img src="http://iswa.ccmc.gsfc.nasa.gov/IswaSystemWebApp/StreamArgumentServlet?cygnetInstanceId=16418862952&argumentId=1&width=800" alt="" class="imgbtn"/>
						</a>	
					</td>
				</tr>
			</table>			
        </div>
        <!-- NOAA 우주기상 예측센터 위성환경 차트 -->
    </div>
    <!-- END 위성운영 -->    
    </c:if>
    
    <c:if test="${ param.tab eq 'sub3' }">
	<div id="tabitem3" class="wrap_link" style="height:800px;">
	   	<div>
			<table>
				<tr>
					<td>
						<a href="http://www.swpc.noaa.gov/" target="_blank">
							<b>미국 해양대기청 우주기상 예측센터<br>(NOAA SWPC)</b>
						</a>
					</td>
					<td>
						<a href="http://www.ips.gov.au" target="_blank">
							<b>호주 기상청 우주기상 서비스<br>(BOM IPS)</b>
						</a>
					</td>
					<td>
						<a href="http://www.srl.caltech.edu/ACE/" target="_blank">
							<b>캘리포니아 공과대학 ACE위성 연구팀<br>(CALTECH ACE Science Center)</b>
						</a>
					</td>
				</tr>
				<tr>
					<td>
						<a href="http://www.swpc.noaa.gov/" target="_blank">
							<img src="<c:url value="/resources/ko/images/link_img_noaaswpc.png"/>" alt="" class="imgbtn" style="width:290px"/>
						</a>
					</td>
					<td>
						<a href="http://www.ips.gov.au" target="_blank">
							<img src="<c:url value="/resources/ko/images/link_img_ips.png"/>" alt="" class="imgbtn" style="width:290px"/>
						</a>
					</td>
					<td>
						<a href="http://www.srl.caltech.edu/ACE/" target="_blank">
							<img src="<c:url value="/resources/ko/images/link_img_ace.png"/>" alt="" class="imgbtn" style="width:290px"/>
						</a>
					</td>
				</tr>
				<tr>
					<td>
						<a href="http://sdo.gsfc.nasa.gov/" target="_blank">
							<b>미국 항공우주국 SDO위성 미션<br>(NASA SDO Satellite)</b>
						</a>
					</td>
					<td>
						<a href="http://sohowww.nascom.nasa.gov/" target="_blank">
							<b>미국 항공우주국 SOHO위성 미션<br>(NASA SOHO Satellite)</b>
						</a>
					</td>
					<td>
						<a href="http://stereo-ssc.nascom.nasa.gov/" target="_blank">
							<b>미국 항공우주국 STEREO 위성 미션<br>(NASA STEREO Satellite)</b>
						</a>
					</td>
				</tr>
				<tr>
					<td>
						<a href="http://sdo.gsfc.nasa.gov/" target="_blank">
							<img src="<c:url value="/resources/ko/images/link_img_sdo.png"/>" alt="" class="imgbtn" style="width:290px"/>
						</a>
					</td>
					<td>
						<a href="http://sohowww.nascom.nasa.gov/" target="_blank">
							<img src="<c:url value="/resources/ko/images/link_img_soho.png"/>" alt="" class="imgbtn" style="width:290px"/>
						</a>
					</td>
					<td>
						<a href="http://stereo-ssc.nascom.nasa.gov/" target="_blank">
							<img src="<c:url value="/resources/ko/images/link_img_stereo.png"/>" alt="" class="imgbtn" style="width:290px"/>
						</a>
					</td>
				</tr>
				<tr>
					<td>
						<a href="http://swc.gsfc.nasa.gov/main/" target="_blank">
							<b>미국 항공우주국 우주기상 연구센터<br>(NASA SWRC)</b>
						</a>
					</td>
					<td>
						<a href="http://www.space.dtu.dk/english/Research/Universe_and_Solar_System/Space_weather" target="_blank">
							<b>덴마크 공과대학<br>(Technical University of Denmark)</b>
						</a>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>
						<a href="http://swc.gsfc.nasa.gov/main/" target="_blank">
							<img src="<c:url value="/resources/ko/images/link_img_dtu.png"/>" alt="" class="imgbtn" style="width:290px"/>
						</a>
					</td>
					<td>
						<a href="http://www.space.dtu.dk/english/Research/Universe_and_Solar_System/Space_weather" target="_blank">
							<img src="<c:url value="/resources/ko/images/link_img_swrc.png"/>" alt="" class="imgbtn" style="width:290px"/>
						</a>
					</td>
					<td>&nbsp;
					</td>
				</tr>
			</table>
		</div>
	</div>
	</c:if>
	
</div>    
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
