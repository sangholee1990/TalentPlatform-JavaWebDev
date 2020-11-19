<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%
	Calendar cal = Calendar.getInstance();
	pageContext.setAttribute("endDate", cal.getTime());
	cal.add(Calendar.DATE, -1);
	pageContext.setAttribute("startDate", cal.getTime());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/WEB-INF/views/include/engCommonHeader.jsp"/>
<link rel="stylesheet" href="<c:url value="/resources/common/js/themes/base/jquery-ui.css"/>" />
<jsp:include page="/WEB-INF/views/include/dygraph.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/engCommonNavi.jsp"/>
<!-- content -->
<div class='content_sub'>
	<!-- Current Space Weather Conditions -->
	<h3 class='title_sub'><img src='<c:url value="/resources/en/images/sub/title_sub01.png"/>' alt='Current Space Weather Conditions' /></h3>
	<p class="refresh">
		<label class="refresh_btn" for="refresh_time">Data Update : 
		<select id="refresh_time">
			<option value="0">Stop</option>
			<option value="0.5">30 Sec</option>
			<option value="1">1 Min</option>
			<option value="5" selected>5 Min</option>
			<option value="10">10 Min</option>
			<option value="30">30 Min</option>
			<option value="60">1 Hour</option>
		</select> 
		</label>
	</p>
	<div>
		<h4><img src='<c:url value="/resources/en/images/sub/txt_sub01_subj1.png"/>' alt='Solar Images'/></h4>
		<ul class='image_list'>
			<li class='solar_images'>
				<div class="imagelist_pbt">
					<p class='imagelist_p'>SDO/AIA 0131</p>
					<div class='imagelist_bt'>
						<span class="solar_time"></span>
						<a href='#' class="calendar_btn" title="Search Time Config"><img src='<c:url value="/resources/en/images/common/bt_mm.png"/>' alt='Calendar'/></a>
						<a href='#' class="video" title="Video Image"><span>Video</span></a>
					</div>					
				</div>
				<div class="contents" style="position: relative;">
					<div class="loading_mask" style="position:absolute; text-align:center; display:block; width: 243px; height: 243px;">
	            		<img src="<c:url value="/resources/ko/images/ajax-loader5.gif" />" style="width: 128px; height: 15px; margin-top:130px;" />
	            		<div style="position: absolute; top: 0px;  width: 100%; height: 100%; background-color: gray; opacity:0.4;"></div>
	            	</div>
					<img src='<c:url value="/resources/ko/images/noimg250.gif"/>' alt='noimg' class="solar_image" id="SDO__01001"/>
				</div>
				<div class="image_select select_list">
				 <ul>
					<li data-code="SDO__01001">SDO/AIA 0131</li>
					<li data-code="SDO__01002">SDO/AIA 0171</li>
					<li data-code="SDO__01003">SDO/AIA 0193</li>
					<li data-code="SDO__01004">SDO/AIA 0211</li>
					<li data-code="SDO__01005">SDO/AIA 0304</li>
					<li data-code="SDO__01006">SDO/AIA 1600</li>
					<li data-code="SOHO_01001">SOHO/LASCO C2</li>
					<li data-code="SOHO_01002">SOHO/LASCO C3</li>
					<li data-code="STA__01001">STA/COR1</li>
					<li data-code="STA__01002">STA/COR2</li>
					<li data-code="STB__01001">STB/COR1</li>
					<li data-code="STB__01002">STB/COR2</li>
			      </ul> 
			    </div>  
			</li>
			<li class='solar_images'>
				<div class="imagelist_pbt">
					<p class='imagelist_p'>SDO/AIA 0171</p>
					<div class='imagelist_bt'>
						<span class="solar_time"></span>
						<a href='#' class="calendar_btn" title="Search Time Config"><img src='<c:url value="/resources/en/images/common/bt_mm.png"/>' alt=''></a>
						<a href='#' class="video" title="Video Image"><span>Video</span></a>
					</div>
				</div>
				<div class="contents" style="position: relative;">
					<div class="loading_mask" style="position:absolute; text-align:center; display:block; width: 243px; height: 243px;">
	            		<img src="<c:url value="/resources/ko/images/ajax-loader5.gif" />" style="width: 128px; height: 15px; margin-top:130px;" />
	            		<div style="position: absolute; top: 0px;  width: 100%; height: 100%; background-color: gray; opacity:0.4;"></div>
	            	</div>
					<img src='<c:url value="/resources/ko/images/noimg250.gif"/>' alt='noimg' class="solar_image" id="SDO__01002" />
				</div>
				<div class="image_select select_list">
				 <ul>
					<li data-code="SDO__01001">SDO/AIA 0131</li>
					<li data-code="SDO__01002">SDO/AIA 0171</li>
					<li data-code="SDO__01003">SDO/AIA 0193</li>
					<li data-code="SDO__01004">SDO/AIA 0211</li>
					<li data-code="SDO__01005">SDO/AIA 0304</li>
					<li data-code="SDO__01006">SDO/AIA 1600</li>
					<li data-code="SOHO_01001">SOHO/LASCO C2</li>
					<li data-code="SOHO_01002">SOHO/LASCO C3</li>
					<li data-code="STA__01001">STA/COR1</li>
					<li data-code="STA__01002">STA/COR2</li>
					<li data-code="STB__01001">STB/COR1</li>
					<li data-code="STB__01002">STB/COR2</li>
			      </ul> 
			    </div>  
			</li>
			<li class='solar_images'>
				<div class="imagelist_pbt">
					<p class='imagelist_p'>SDO/AIA 0193</p>
					<div class='imagelist_bt'>
						<span class="solar_time"></span>
						<a href='#' class="calendar_btn" title="Search Time Config"><img src='<c:url value="/resources/en/images/common/bt_mm.png"/>' alt='' /></a>
						<a href='#' class="video" title="Video Image"><span>Video</span></a>
					</div>
				</div>
				<div class="contents" style="position: relative;">
					<div class="loading_mask" style="position:absolute; text-align:center; display:block; width: 243px; height: 243px;">
	            		<img src="<c:url value="/resources/ko/images/ajax-loader5.gif" />" style="width: 128px; height: 15px; margin-top:130px;" />
	            		<div style="position: absolute; top: 0px;  width: 100%; height: 100%; background-color: gray; opacity:0.4;"></div>
	            	</div>
					<img src='<c:url value="/resources/ko/images/noimg250.gif"/>' alt='noimg' class="solar_image" id="SDO__01003" />
				</div>
				<div class="image_select select_list">
				 <ul>
					<li data-code="SDO__01001">SDO/AIA 0131</li>
					<li data-code="SDO__01002">SDO/AIA 0171</li>
					<li data-code="SDO__01003">SDO/AIA 0193</li>
					<li data-code="SDO__01004">SDO/AIA 0211</li>
					<li data-code="SDO__01005">SDO/AIA 0304</li>
					<li data-code="SDO__01006">SDO/AIA 1600</li>
					<li data-code="SOHO_01001">SOHO/LASCO C2</li>
					<li data-code="SOHO_01002">SOHO/LASCO C3</li>
					<li data-code="STA__01001">STA/COR1</li>
					<li data-code="STA__01002">STA/COR2</li>
					<li data-code="STB__01001">STB/COR1</li>
					<li data-code="STB__01002">STB/COR2</li>
			      </ul> 
			    </div>  
			</li>
			<li class='fin solar_images'>
				<div class="imagelist_pbt">
					<p class='imagelist_p'>SDO/AIA 0211</p>
					<div class='imagelist_bt'>
						<span class="solar_time"></span>
						<a href='#' class="calendar_btn" title="Search Time Config"><img src='<c:url value="/resources/en/images/common/bt_mm.png"/>' alt='' /></a>
						<a href='#' class="video" title="Video Image"><span>Video</span></a>
					</div>
				</div>
				<div class="contents" style="position: relative;">
					<div class="loading_mask" style="position:absolute; text-align:center; display:block; width: 243px; height: 243px;">
	            		<img src="<c:url value="/resources/ko/images/ajax-loader5.gif" />" style="width: 128px; height: 15px; margin-top:130px;" />
	            		<div style="position: absolute; top: 0px;  width: 100%; height: 100%; background-color: gray; opacity:0.4;"></div>
	            	</div>
					<img src='<c:url value="/resources/ko/images/noimg250.gif"/>' alt='noimg' class="solar_image" id="SDO__01004" />
				</div>
				<div class="image_select select_list">
				 <ul>
					<li data-code="SDO__01001">SDO/AIA 0131</li>
					<li data-code="SDO__01002">SDO/AIA 0171</li>
					<li data-code="SDO__01003">SDO/AIA 0193</li>
					<li data-code="SDO__01004">SDO/AIA 0211</li>
					<li data-code="SDO__01005">SDO/AIA 0304</li>
					<li data-code="SDO__01006">SDO/AIA 1600</li>
					<li data-code="SOHO_01001">SOHO/LASCO C2</li>
					<li data-code="SOHO_01002">SOHO/LASCO C3</li>
					<li data-code="STA__01001">STA/COR1</li>
					<li data-code="STA__01002">STA/COR2</li>
					<li data-code="STB__01001">STB/COR1</li>
					<li data-code="STB__01002">STB/COR2</li>
			      </ul> 
			    </div>  
			</li>
		</ul>
	</div><!-- //Current Space Weather Conditions -->
	<!-- Newsflash Check -->
	<div class='newsflash_box'>
		<h4><img src='<c:url value="/resources/en/images/sub/txt_sub01_subj2.png"/>' alt='Newsflash Check'><a href="<c:url value="/en/intro.do?tab=alert#newsflashHelp1"/>" title="Help Page" class="help" /><span>Help</span></a></h4>
		<div class='box_current'>
			<ul class='list_conditions'>
				<li>
					<div class='bg_cir noti1 <custom:CodeSign notice="${summary.notice1}"/>'><p><c:if test="${summary.notice1 != null}">${summary.notice1.code}</c:if></p></div>
					<img class='txt_conditions' src="<c:url value="/resources/en/images/main/txt_satellites.png"/>" alt='Satellites Operation' />
				</li>
				<li>
					<div class='bg_cir noti2 <custom:CodeSign notice="${summary.notice2}"/>'><p><c:if test="${summary.notice2 != null}">${summary.notice2.code}</c:if></p></div>
					<img class='txt_conditions' src="<c:url value="/resources/en/images/main/txt_polar.png"/>" alt='Polar Airways Weather Conditions' />
				</li>
				<li class='fin'>
					<div class='bg_cir noti3 <custom:CodeSign notice="${summary.notice3}"/>'><p><c:if test="${summary.notice3 != null}">${summary.notice3.code}</c:if></p></div>
					<img class='txt_conditions' src="<c:url value="/resources/en/images/main/txt_ionospheric.png"/>" alt='Ionospheric Weather Conditions' />
				</li>
			</ul>
		</div>
		<ul class='list_storms'>
			<li class="xray_info">
				<p><img class='' src="<c:url value="/resources/en/images/main/txt_radiation.png"/>" alt='Solar Radiation Storms' /><!-- <a href="/" title="Help Page" class="help"><span>Help</span></a>  --></p>
				<div class='bg_cir2 <custom:CodeSign notice="${summary.XRAY_H3}"/>'><p class='bg_cir2t'>${summary.XRAY_H3.grade}</p></div>
				<p class='txt_storms'>${summary.XRAY_H3.gradeTextEng}</p>
				<ul class='list_detail'>
					<li>· Current : <span class="now">${summary.XRAY_NOW.val}</span> (W/m2)</li>
					<li>· 
					<c:choose>
						<c:when test="${summary.XRAY_H3.dataType=='MP'}">Min </c:when>
						<c:otherwise>Max </c:otherwise>
					</c:choose> : <span class="max">${summary.XRAY_H3.val}</span> (W/m2)
					<fmt:parseDate value="${summary.XRAY_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
					<br/>&nbsp;&nbsp;<span class="date"><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></span></li>
				</ul>
			</li>	 
			<li class="proton_info">
				<p><img class='' src="<c:url value="/resources/en/images/main/txt_proton.png"/>" alt='Solar Proton Storms' /><!-- <a href="/" title="Help Page" class="help"><span>Help</span></a>  --></p>
				<div class='bg_cir2 <custom:CodeSign notice="${summary.PROTON_H3}"/>'><p class='bg_cir2t'>${summary.PROTON_H3.grade}</p></div>
				<p class='txt_storms'>${summary.PROTON_H3.gradeTextEng}</p>
				<ul class='list_detail'>
					<li>· Current : ${summary.PROTON_NOW.val} (pfu)</li>
					<li>· <c:choose>
						<c:when test="${summary.PROTON_H3.dataType=='MP'}">Min</c:when>
						<c:otherwise>Max</c:otherwise>
					</c:choose> : ${summary.PROTON_H3.val} (pfu)
					<fmt:parseDate value="${summary.PROTON_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
					<br/>&nbsp;&nbsp;<span class="date"><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></span></li>
				</ul>
			</li>
			<li class="kp_index_info">
				<p><img class='' src="<c:url value="/resources/en/images/main/txt_geomagnetic.png"/>" alt='Geomagnetic Storms' /><!-- <a href="/" title="Help Page" class="help"><span>Help</span></a>  --></p>
				<div class='bg_cir2 <custom:CodeSign notice="${summary.KP_H3}"/>'><p class='bg_cir2t'>${summary.KP_H3.grade}</p></div>
				<p class='txt_storms'>${summary.KP_H3.gradeTextEng}</p>
				<ul class='list_detail'>
					<li>· Current : ${summary.KP_NOW.val}</li>
					<li>· <c:choose>
						<c:when test="${summary.KP_H3.dataType=='MP'}">Min</c:when>
						<c:otherwise>Max</c:otherwise>
					</c:choose> : ${summary.KP_H3.val}
					<fmt:parseDate value="${summary.KP_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
					<br/>&nbsp;&nbsp;<span class="date"><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></span></li>
				</ul>
			</li>
			<li class='fin magnetopause_radius_info'>
				<p><img class='' src="<c:url value="/resources/en/images/main/txt_magnetopause.png"/>" alt='Magnetopause' /><!-- <a href="/" title="Help Page" class="help"><span>Help</span></a>  --></p>
				<div class='bg_cir2 <custom:CodeSign notice="${summary.MP_H3}"/>'><p class='bg_cir2t2'>${summary.MP_H3.grade}</p></div>
				<p class='txt_storms'>${summary.MP_H3.gradeTextEng}</p>
				<ul class='list_detail'>
					<li>· Current : ${summary.MP_NOW.val} (RE)</li>
					<li>· <c:choose>
						<c:when test="${summary.MP_H3.dataType=='MP'}">Min</c:when>
						<c:otherwise>Max</c:otherwise>
					</c:choose> : ${summary.MP_H3.val} (RE)
					<fmt:parseDate value="${summary.MP_H3.tm}" pattern="yyyyMMddHHmmss" var="date"/>
					<br/>&nbsp;&nbsp;<span class="date"><fmt:formatDate value="${date}" pattern="(MM.dd HH:mm)"/></span></li>
				</ul>
			</li>
		</ul>
	</div><!-- //Newsflash Check -->
	<!-- Detailed Space Weather Conditions -->
	<div>
		<h4><img src='<c:url value="/resources/en/images/sub/txt_sub01_subj3.png"/>' alt='Detailed Space Weather Conditions' /></h4>
		<ul class='graph_list'>
			<li class='graph pdngb27'>
				<div class='graphlist_pbt'>
					<p class='graphlist_p'>GOES-15 Solar X-ray Flux [Radio Blackouts]</p>
					<div class='graphlist_bt'>
						<a href='#' class="calendar_btn" title="Search Time Config"><img src='<c:url value="/resources/en/images/common/bt_mm.png"/>' alt='' /></a>
						<a href='#' class="detail" title="Detail View"><img src='<c:url value="/resources/en/images/common/bt_detail.png"/>' alt='more' /></a>
					</div>
				</div>					
				<div id="XRAY_FLUX_LABELS_DIV" class="graph_info"></div>
				<div class="graphlist_t"><div id="XRAY_FLUX"></div></div>
			</li>
			<li class='graph fin pdngb27'>
				<div class='graphlist_pbt'>
					<p class='graphlist_p'>GOES-13 Solar Proton Flux [Solar Radiation Storm]</p>
					<div class='graphlist_bt'>
						<a href='#' class="calendar_btn" title="Search Time Config"><img src='<c:url value="/resources/en/images/common/bt_mm.png"/>' alt='' /></a>
						<a href='#' class="detail" title="Detail View"><img src='<c:url value="/resources/en/images/common/bt_detail.png"/>' alt='more' /></a>
					</div>
				</div>					
				<div id="PROTON_FLUX_LABELS_DIV" class="graph_info"></div>
            	<div class="graphlist_t"><div id="PROTON_FLUX"></div></div>
			</li>
			<li class="graph">
				<div class='graphlist_pbt'>
					<p class='graphlist_p'>KP INDEX [Geomagnetic Storms]</p>
					<div class='graphlist_bt'>
						<a href='#' class="calendar_btn" title="Search Time Config"><img src='<c:url value="/resources/en/images/common/bt_mm.png"/>' alt='' /></a>
						<a href='#' class="detail" title="Detail View"><img src='<c:url value="/resources/en/images/common/bt_detail.png"/>' alt='more' /></a>
					</div>
				</div>					
				<div id="KP_INDEX_SWPC_LABELS_DIV" class="graph_info"></div>
           		<div class="graphlist_t"><div id="KP_INDEX_SWPC"></div></div>
			</li>
			<li class='graph fin'>
				<div class='graphlist_pbt'>
					<p class='graphlist_p'>Magnetopause Radius [Magnetopause]</p>
					<div class='graphlist_bt'>
						<a href='#' class="calendar_btn" title="Search Time Config"><img src='<c:url value="/resources/en/images/common/bt_mm.png"/>' alt='' /></a>
						<a href='#' class="detail" title="Detail View"><img src='<c:url value="/resources/en/images/common/bt_detail.png"/>' alt='more' /></a>
					</div>
				</div>					
				<div id="MAGNETOPAUSE_RADIUS_LABELS_DIV" class="graph_info"></div>
            	<div class="graphlist_t"><div id="MAGNETOPAUSE_RADIUS"></div></div>
			</li>
		</ul>
		
		<p class='txt_reference'>· This page is optimized with chrome browser.</p>
		
	</div><!-- //Detailed Space Weather Conditions -->
	<div class="graph_select select_list">
	 <ul>
		<li data-code="ACE_MAG">ACE IMF Magnetopause</li>
		<li data-code="ACE_SOLARWIND_SPD">ACE Solar Wind Speed</li>
		<li data-code="ACE_SOLARWIND_DENS">ACE Solar Wind Density</li>
		<li data-code="ACE_SOLARWIND_TEMP">ACE Solar Wind Temperature</li>
		<li data-code="MAGNETOPAUSE_RADIUS">Magnetopause Radius [Magnetopause]</li>
		<li data-code="XRAY_FLUX">GOES-15 Solar X-ray Flux [Radio Blackouts]</li>
		<li data-code="PROTON_FLUX">GOES-13 Solar Proton Flux [Solar Radiation Storm]</li>
		<li data-code="ELECTRON_FLUX">GOES-13 ELECTRON FLUX</li>
		<li data-code="KP_INDEX_SWPC">KP INDEX [Geomagnetic Storms]</li>
		<li data-code="DST_INDEX_KYOTO">Kyoto DST Index </li>
      </ul> 
    </div>             
	<div class="graph_calendar calendar">
		<div class="layer_contents">
	    	<p>
	        	<label for="start_date">Started</label>
	        	<input type="text" size="12" id="start_date" class="start_date date" value=""/>      
	        </p>
	        <p>
	        	<label for="end_date">End</label>
	        	<input type="text" size="12" id="end_date" class="end_date date" value=""/>      
	        </p>
			<p class="btn_box">
				<button type="button" class="btn submit" title="Submit Date">Submit</button>
		    	<button type="button" class="close btn" title="Close Calendar">Close</button>
	    	</p>
	    </div>
	</div>
	
	<div class="image_calendar calendar" id="calendar_image">
		<div class="layer_contents">
	    	<p>
	        	<label for="calendar_image_date">Started</label>
	        	<input type="text" size="12" id="calendar_image_date" class="start_date date" value="" />      
	        </p>
	        <p>
	        	<label for="calendar_image_hour">Hour</label>
	        	<select name="imageHour" id="calendar_image_hour">
	        		<c:forEach begin="0" end="23" var="item">
	        		<option value="<fmt:formatNumber minIntegerDigits="2" value="${item}"/>"><fmt:formatNumber minIntegerDigits="2" value="${item}"/></option>
	        		</c:forEach>
	        	</select>
	        </p>
	        <p>
	        	<label for="calendar_image_minute">Minute</label>
	            <select name="imageMin" id="calendar_image_minute">
	                <option value="00">00</option>
	            </select>
	        </p>
			<p class="btn_box">
				<button type="button" class="btn submit" title="Submit Date">Submit</button>
		    	<button type="button" class="close btn" title="Close Calendar">Close</button>
	    	</p>
	    </div>
	</div>
	
	
</div><!-- //content -->
<jsp:include page="/WEB-INF/views/include/engCommonFooter.jsp"/>
<script type="text/javascript" src="<c:url value="/resources/common/js/jquery-ui.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/common/js/date.format.js"/>"></script>
<script type="text/javascript">
var imageManager1 = null;
var imageManager2 = null;
var imageManager3 = null;
var imageManager4 = null;

	var refreshTime = 5;
	
	var time = null;
	var timer = {
		start : function(){
			if(time == null){
				time = setInterval("timer.update()", 1000 * 60 * refreshTime);
			}
		},
		stop : function(){
			if(time != null){
				clearInterval(time);
				time = null;
			}
		},
		update : function(){
			timer.imageUpdate();
			timer.indicatorUpdate();
			chartGraphManager.autoRefresh();
		},
		imageUpdate : function(){
			imageManager1.load();
			imageManager2.load();
			imageManager3.load();
			imageManager4.load();
		},
		indicatorUpdate: function() {
			$.ajax({
				url : "<c:url value="/en/monitor/summary.do"/>"
			}).done(function(data) {
				var result = data.summary;
				setSummaryValue($(".noti1"), result.notice1);
				setSummaryValue($(".noti2"), result.notice2);
				setSummaryValue($(".noti3"), result.notice3);
			
				setElementInfo($(".xray_info"), result.XRAY_NOW, result.XRAY_H3);
				setElementInfo($(".proton_info"), result.PROTON_NOW, result.PROTON_H3);
				setElementInfo($(".kp_index_info"), result.KP_NOW, result.KP_H3);
				setElementInfo($(".magnetopause_radius_info"), result.MP_NOW, result.MP_H3);
			});	
		}
		
	};

	
	$(function(){
		
		timer.start();
		$("#refresh_time").change(function(){
			refreshTime = $(this).val();
			timer.stop();
			if(refreshTime != 0){
				timer.start();
			}
		});
		
		var date = new Date();
		var datepickerOption = {	//autoRefreshInterval 새로고침 시간
			dateFormat:"yy-mm-dd",
			changeYear:true,
			showOn: "button",
			buttonImage: '<c:url value="/resources/en/images/sub/bt_calendar.png"/>', 
			buttonImageOnly: true
		};		
		$(".graph_calendar .end_date").datepicker(datepickerOption).val(date.format("yyyy-mm-dd")).next(".ui-datepicker-trigger").addClass("imgbtn");
		date = date.setDate(date.getDate() - 1);
		$(".graph_calendar .start_date").datepicker(datepickerOption).val(new Date(date).format("yyyy-mm-dd")).next(".ui-datepicker-trigger").addClass("imgbtn");
		
		chartCalendar.initialize();
		imageSearchCalenar.initialize();
		//$(window).load(function(){
		//});
		
		
		var chartOption = {axisLabelColor:'black'};
		chartGraphManager.addXRayFlux({colors: ['cyan', 'red']});
		chartGraphManager.addProtonFlux(chartOption);
		chartGraphManager.addKpIndexSwpc({colors: ['orange']});
		chartGraphManager.addMagnetopauseRadius({colors: ['red']});
		chartGraphManager.autoRefresh();
		
		$(".solar_images").each(function() {
			$(this).children(".contents").children(".solar_image").on("load", function() {
				$(this).parent().children(".loading_mask").css("display", "none");
				$(this).parent().children(".loading_mask").children("img").css("margin-top", "117px");
			});
		});
		
		imageManager1 = new ImageManager();
		imageManager1.initialize($(".image_list > li").eq(0));
		imageManager1.load();
		
		imageManager2 = new ImageManager();
		imageManager2.initialize($(".image_list > li").eq(1));
		imageManager2.load();
	
		imageManager3 = new ImageManager();
		imageManager3.initialize($(".image_list > li").eq(2));
		imageManager3.load();
	
		imageManager4 = new ImageManager();
		imageManager4.initialize($(".image_list > li").eq(3));
		imageManager4.load();

		
		
		
		
		
	});
	//------------- Image ------------------------------------------------------------//
	var imageSearchCalenar = {
			imageManager: null,
			initialize: function() {		//캘린더 초기화
				var datepickerOption = {
					dateFormat:"yy-mm-dd",
					changeYear:true,
					showOn: "button",
					buttonImage: '<c:url value="/resources/en/images/sub/bt_calendar.png"/>', 
					buttonImageOnly: true,
					onSelect: function(dateText) {
						imageSearchCalenar.updateMinuteList();
					}
				};
				$("#calendar_image_date").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");
				
				$("#calendar_image_hour").change(function() {
					imageSearchCalenar.updateMinuteList();
				});
				
				$("#calendar_image .submit").click(function(e) {
					var data = $("#calendar_image_minute option:selected").data();
					if(data != null) {
						imageSearchCalenar.imageManager.setRealtime(false);
						imageSearchCalenar.imageManager.updateData(data);
						imageSearchCalenar.hide();
					} else {
						alert("Search the Image Does Not Exist!");
					}
					e.defaultPrevented = true;
					return false;
				});
				
				$("#calendar_image .close").click(function() {
					$("#calendar_image").hide();
				});
			},
			
			updateMinuteList: function() {
				var date = $("#calendar_image_date").val();
				var hour = $("#calendar_image_hour").val();
				var code = imageSearchCalenar.imageManager.currentData.code;
				var createDate = date.replace(/-/gi, '') + hour;
				$.getJSON("<c:url value="/ko/monitor/search_by_code.do"/>", {
					code : code,
					createDate: createDate
				}).success(function(resultData) {
					var data = resultData.data;
					var minuteObj = $("#calendar_image_minute");
					minuteObj.empty();
					//alert(data.data.length);
					$.each(data, function(key, val) {
						var date = new Date(val.createDate);
						//alert(date);
						var minute = date.format("MM");
						var option = $("<option>", {value:minute, text:minute, data:val});
						minuteObj.append(option);
					});
				});

			},
			
			show: function(manager, offset) {
				this.imageManager = manager;
				$("#calendar_image_date").val(manager.currentDate.format("yyyy-mm-dd"));
				$("#calendar_image_hour").val(manager.currentDate.format("HH"));
				var minuteObj = $("#calendar_image_minute");
				minuteObj.empty();
				if(manager.dataList != null) {
					$.each(manager.dataList, function(key, val) {
						var date = new Date(val.createDate);
						var minute = date.format("MM");
						var option = $("<option>", {value:minute, text:minute, data:val});
						minuteObj.append(option);
					});
				}
				minuteObj.val(manager.currentDate.format("MM"));
				var calenar = $("#calendar_image"); 
				calenar.css('top', offset.top+25);
				calenar.css('left', offset.left-139);
				calenar.show();
			},
			hide: function() {
				$("#calendar_image").hide();
			}
		};
		
	function ImageManager() {
		this.container = null;
		this.imageTypeList = null;
		this.title = null;
		this.currentDate = new Date();
		this.dateLabel = null;
		this.dataList = null;
		this.currentData = null;
		this.image = null;
		this.viewMovie = false;
		this.realtime = true;
	};

	ImageManager.prototype.initialize = function(container) {
		var manager = this;
		this.container = container;
		this.imageTypeList =  container.find(".image_select");
		this.title = container.find(".imagelist_p");
		this.dateLabel = container.find(".solar_time");
		this.image = container.find(".solar_image");
		var layer = this.imageTypeList;
		
		//위성 레이어 선택
		this.title.click(function(e) {
			imageSearchCalenar.hide();
			if(layer.css("display") == "none"){
				layer.show();
			}else{
				layer.hide();
			}
			e.defaultPrevented = true;
			return false;
		});
		
		this.imageTypeList.children().children("li").click(function(e) {
			manager.container.find(".video").removeClass("play");
			manager.viewMovie = false;
			
			var code = $(this).attr("data-code");
			var text = $(this).text();
			manager.container.find(".imagelist_p").text(text);
			manager.container.find(".solar_image").attr("id",code);
			manager.imageTypeList.hide();
			manager.load();
			e.defaultPrevented = true;
			return false;
		});
		
		this.container.find(".calendar_btn").click(function(e) {
			var buttonOffset = $(this).offset();
			imageSearchCalenar.show(manager, buttonOffset);

			e.defaultPrevented = true;
			return false;
		});
		
		this.container.find(".video").click(function(e) {
			$(this).parent().parent().parent().children(".contents").children(".loading_mask").css("display", "block");
			$(this).toggleClass("play");
			manager.viewMovie = $(this).hasClass("play");
			manager.load();
			e.defaultPrevented = true;
			return false;
		});
		
		this.setDate(new Date());
	};

	ImageManager.prototype.setDate = function(date) {
		this.currentDate = date;
		if(date != null) {
			this.dateLabel.text(date.format("yyyy.mm.dd HH:MM"));
		} else {
			this.dateLabel.text("");
		}
	};

	ImageManager.prototype.load = function(param) {
		var options = $.extend({createDate: null}, param);
		var manager = this;
		var code = this.title.parent().next().children(".solar_image").attr("id");
		if(this.isRealtime()) {
			$.getJSON("<c:url value="/en/monitor/search_by_code.do"/>", {
				code : code,
				createDate: options.createDate
			}).success(function(resultData) {
				var data = resultData.data;
				manager.dataList = data;
				if(data != null && data.length > 0) {
					manager.updateData(data[data.length-1]);	
				} else {
					manager.updateData(null);
				}
			}).error(function() {
				//alert("image manger load Error");
			});
		}
	};

	ImageManager.prototype.updateData = function(data) {
		this.currentData = data;
		if(data != null) {
			var date = new Date(data.createDate);
			this.setDate(date);
			/*
			if(this.viewMovie) {
				this.image.attr("src", "<c:url value="/monitor/view_movie.do"/>?id=" + data.id + "&size=512&frames=100");
				this.image.attr("alt", "<c:url value="/monitor/view_movie.do"/>?id=" + data.id + "&size=512&frames=100");
			} else {
				this.image.attr("src", "<c:url value="/monitor/view_browseimage.do"/>?id=" + data.id);
				this.image.attr("alt", "<c:url value="/monitor/view_browseimage.do"/>?id=" + data.id);
			}
			*/
			
			if(this.viewMovie) {
	 			this.image.attr("src", "<c:url value="/en/monitor/view_movie.do"/>?id=" + data.id + "&size=512&frames=100");
	 			this.image.attr("alt", "<c:url value="/en/monitor/view_movie.do"/>?id=" + data.id + "&size=512&frames=100");
				//this.image.attr("src", "<c:url value="http://swfc.kma.go.kr/monitor/view_movie.do"/>?id=" + data.id + "&size=512&frames=100");
				//this.image.attr("alt", "<c:url value="http://swfc.kma.go.kr/monitor/view_movie.do"/>?id=" + data.id + "&size=512&frames=100");
			} else {
				this.image.attr("src", "<c:url value="/en/monitor/view_browseimage.do"/>?id=" + data.id);
				this.image.attr("alt", "<c:url value="/en/monitor/view_browseimage.do"/>?id=" + data.id);
				//this.image.attr("src", "<c:url value="http://swfc.kma.go.kr/monitor/view_browseimage.do"/>?id=" + data.id);
				//this.image.attr("alt", "<c:url value="http://swfc.kma.go.kr/monitor/view_browseimage.do"/>?id=" + data.id);
			}
			
		} else {
			this.updateDate(null);
			this.image.attr("src", "");
		}
	}

	ImageManager.prototype.setRealtime = function(realtime) {
		if(realtime) {
			this.title.addClass("on");
		} else {
			this.title.removeClass("on");
		}
	};

	ImageManager.prototype.isRealtime = function() {
		return this.title.addClass("on");
	};

	
	//------------- Indicator ------------------------------------------------------------//
	
	function setSummaryValue(obj, data) {
		obj.removeClass("w g b y o r");
		var textObj = obj.children();
		if(data != null) {
			switch(data.code) {
			case 0:
				obj.addClass("w");
				break;
			case 1:
				obj.addClass("g");
				break;
			case 2:
				obj.addClass("b");
				break;
			case 3:
				obj.addClass("y");
				break;
			case 4:
				obj.addClass("o");
				break;
			case 5:
				obj.addClass("r");
				break;
			};
			textObj.text(data.code);
		} else {
			textObj.text("0"); 
		}
	}

	function setElementInfo(obj, now, h3) {
		var sign = obj.children(".bg_cir2");
		var message = sign.parent().find(".list_detail");
		sign.removeClass("w g b y o r");

		var signText = "";
		var messageText = "-";
		var current = "0";
		var max = "0";
		var date = "()";
		
		if(now != null) {
			if(now != null) {
				current = toExponential(now.val);
			}
			if(h3 != null) {
				switch(h3.code) {
				case 0:
					sign.addClass("w");
					break;
				case 1:
					sign.addClass("g");
					break;
				case 2:
					sign.addClass("b");
					break;
				case 3:
					sign.addClass("y");
					break;
				case 4:
					sign.addClass("o");
					break;
				case 5:
					sign.addClass("r");
					break;
				};		
				
				signText = h3.grade;
				messageText = h3.gradeTextEng;
				var month = h3.tm.substring(4, 6);
				var day = h3.tm.substring(6, 8);
				var hour = h3.tm.substring(8, 10);
				var minute = h3.tm.substring(10, 12);
				max = toExponential(h3.val);
				
				date = " (" + month + "." + day + " " + hour + ":" + minute + ")";
			}
			
		}
		sign.children().text(signText);
		sign.next().text(messageText);
		message.find(".now").text(current);
		message.find(".max").text(max);
		message.find(".date").text(date);
		
	}
	
	function toExponential(val) {
		return (val > 10000 || val < 0.0001)?val.toExponential():val;
	}
	
	//------------- Chart ------------------------------------------------------------//
	var chartCalendar = {
		initialize: function() {
			/*
			var now = new Date();
			var yes = new Date();
			yes.setDate(now.getDate() - 1);
			*/
			
			var sd = "<fmt:formatDate value="${startDate}" pattern="yyyyMMddHH" timeZone="UTC"/>";
			var ed = "<fmt:formatDate value="${endDate}" pattern="yyyyMMddHH" timeZone="UTC"/>";
			
			$(".graph_list .calendar_btn").each(function(){ //세팅
				var button = $(this);
				var type = button.parents(".graph").find(".graphlist_t > div").attr("id");
				button.data({
					"sd" :  sd,
					"ed" :  ed,
					"type" : type,
					"autoRefresh": true
				});
			});
			$(".graphlist_p").on("click",function(e){	//그래프 제목 클릭
				var title = $(this);
				var offset = title.offset();
				var layer = $(".graph_select").css({'top' : offset.top + 27, 'left' : offset.left}).data("nowSelect", title.parents(".graph").index());
				
				if(layer.css("display") == "none") layer.show();
				else layer.hide();
				
				e.defaultPrevented = true;
			});
			$(".graph_select li").on("click",function(e){	//그래프 리스트 클릭
				var selected = $(this);
				var type = selected.attr("data-code");
				var index = $(".graph_select").hide().data("nowSelect");
				var graph = $(".graph_list li").eq(index);
				var graphViewer =  graph.find(".graphlist_t > div");
				var removeId = graphViewer.attr("id");
				var data = graph.find(".calendar_btn").data();
				
				if(type  != removeId){
					data.type = type;
					data.popup = type;
					data.type = type + index;
					chartGraphManager.remove(removeId,"");
					
					graph.find(".graphlist_p").text(selected.text());
					var div = graph.find('.graph_info').attr({"id":type + "_LABELS_DIV" + index});
					var box = graphViewer.attr({"id":type + index}).empty();
					var chartOption = {axisLabelColor:'black', "div" : div, "box" : box};
					
					if(type == "ACE_MAG"){	//ACE IMF 자기장
						chartGraphManager.addAceMag({axisLabelColor:'black', colors: ['cyan', 'blue', 'red', 'yellow'], "div" : div, "box" : box});
					}else if(type == "ACE_SOLARWIND_SPD"){	//ACE 태양풍 속도
						chartGraphManager.addAceSolarWindSpeed(chartOption);
					}else if(type == "ACE_SOLARWIND_DENS"){	//ACE 태양풍 밀도
						chartGraphManager.addAceSolarWindDens({axisLabelColor:'black', colors: ['red'], "div" : div, "box" : box});
					}else if(type == "ACE_SOLARWIND_TEMP"){	//ACE 태양풍 온도
						chartGraphManager.addAceSolarWindTemp({axisLabelColor:'black', colors: ['red'], "div" : div, "box" : box});
					}else if(type == "MAGNETOPAUSE_RADIUS"){	//자기권계면
						chartGraphManager.addMagnetopauseRadius({axisLabelColor:'black', colors: ['red'], "div" : div, "box" : box});
					}else if(type == "XRAY_FLUX"){	//X-선 플럭스
						chartGraphManager.addXRayFlux({axisLabelColor:'black', colors: ['cyan', 'red'], "div" : div, "box" : box});
					}else if(type == "PROTON_FLUX"){	//양성자 플럭스
						chartGraphManager.addProtonFlux(chartOption);
					}else if(type == "ELECTRON_FLUX"){	//전자기 플럭스
						chartGraphManager.addElectronFlux({axisLabelColor:'black', colors: ['cyan', 'red'], "div" : div, "box" : box});
					}else if(type == "KP_INDEX_SWPC"){	//Kp 지수
						chartGraphManager.addKpIndexSwpc({axisLabelColor:'black', colors: ['orange'], "div" : div, "box" : box});
					}else if(type == "DST_INDEX_KYOTO"){ //Dst 지수
						chartGraphManager.addDstIndexKyoto({axisLabelColor:'black', colors: ['red'], "div" : div, "box" : box});
					}
				}
				/*
				var date = new Date();
				data.ed = date.format('yyyymmddhh', true);
				date = date.setDate(date.getDate() - 1);
				data.sd = new Date(date).format('yyyymmddhh', true);
				*/
				
				
				var date = new Date();
				date.setHours(date.getHours() + 1);
				var ed = chartGraphManager.getUTCDateString(date);
				date.setDate(date.getDate() -1);
				var sd = chartGraphManager.getUTCDateString(date);
				
				data.sd = sd.substring(0, 10);
				data.ed = ed.substring(0, 10);
				
				data.autoRefresh = true;
				//chartGraphManager.setAutoRefreshLayer(data.type, true);
				chartGraphManager.load(data);
				
				e.defaultPrevented = true;
			});
			
			$(".graph_list .detail").click(function(e) {	//팝업
				var button = $(this).prev();
				var data = button.data();
				var url = "<c:url value='/en/currentPop.do'/>";
				var sd = data.sd;
				var ed = data.ed;
				var param = "?type=" + data.type + "&sd=" + sd +"&ed=" + ed + "&autoRefresh=" + data.autoRefresh;
				if(data.popup != null){
					param = "?type=" + data.popup + "&sd=" + sd +"&ed=" + ed + "&autoRefresh=" + data.autoRefresh;
				}
				
				window.open(url + param, '_blank','width=1024,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
				e.defaultPrevented = true;
				return false;
			});
			
			$(".graph_list .calendar_btn").on("click",function(e) {	//그래프 캘린더 클릭
				var button = $(this);
				var data = button.data();
				var offset = button.offset();
				$(".graph_calendar").css({'top':offset.top+25, 'left':offset.left-139}).data("nowSelect", button.parents(".graph").index()).show();
				$(".graph_calendar .end_date").val(data.ed.substring(0,4)+"-"+data.ed.substring(4,6)+"-"+data.ed.substring(6,8));
				$(".graph_calendar .start_date").val(data.sd.substring(0,4)+"-"+data.sd.substring(4,6)+"-"+data.sd.substring(6,8));
			
				e.defaultPrevented = true;
				return false;
			});
			$(".graph_calendar .submit").on("click", function(e) {	//날짜 선택 완료
				var calendar = $(".graph_calendar");
				var index = calendar.data("nowSelect");
				var startDateVal = calendar.find(".start_date").val();
				var endDateVal = calendar.find(".end_date").val();
				var graph = $(".graph_list li").eq(index);
				var button = graph.find(".calendar_btn");
				var type = graph.find(".graphlist_t > div").attr("id");
				
				if(dateCheck(startDateVal, endDateVal)){
					var sd = startDateVal.replace(/-/gi, '')  + "00";
					var ed = endDateVal.replace(/-/gi, '') + "23";
					button.data({"sd" : sd,"ed" : ed,"autoRefresh": false});
					chartGraphManager.load({"sd" : sd,"ed" : ed,"type": type});
					calendar.hide();
				}
				e.defaultPrevented = true;
				return false;
			});
			
			$(".graph_calendar .close").on("click",function(e) {	//캘린더 닫기
				$(".graph_calendar").hide();
				e.defaultPrevented = true;
				return false;
			});

		}
		
	};
	
	
	//날짜 체크
	function dateCheck(startDateVal, endDateVal){
		if(startDateVal == "") {
			alert("Please Enter a Start Date!");
			return false; 
		}
		var startDate = Date.parse(startDateVal);
		if(isNaN(startDate)) {
			alert("Please Enter the Date Format!");
			return false;
		}
			
		if(endDateVal == "") {
			alert("Please Enter a End Date!");
			return false; 
		}
		var endDate = Date.parse(endDateVal);
		if(isNaN(endDate)) {
			alert("Please Enter the Date Format!");
			return false;
		}
		var diff = (endDate - startDate)/1000;
		if(diff > 86400*7) {
			alert("Please Specify a Period within a Week!");
			return false;
		}
		if(diff < 0) {
			alert("Less End Date!");
			return false;
		}
		return true;
	}

</script>
</body>
</html>