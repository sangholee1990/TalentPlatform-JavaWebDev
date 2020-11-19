<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!doctype html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />
</head>
<body>
<div class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	
	<!--  -->
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">통계 정보</h4>
			<nav class="navbar navbar-default" role="navigation">
					<div class="collapse navbar-collapse navbar-ex1-collapse text-right">
				    	<form class="navbar-form navbar-right" role="search" action="<c:url value="/admin/stats/stat_list.do"/>" method="post" name="frm" id="frm" target="_self" >
				    	<input type="hidden" name="statXrayData" id="statXrayData"/>
				    	<input type="hidden" name="statProtonData" id="statProtonData"/>
				    	<input type="hidden" name="statKpData" id="statKpData"/>
				    	<input type="hidden" name="statMpData" id="statMpData"/>
				    	<input type="hidden" name="statBtData" id="statBtData"/>
				    	<input type="hidden" name="statBulk_spdData" id="statBulk_spdData"/>
				    	<input type="hidden" name="statPro_densData" id="statPro_densData"/>
				    	<input type="hidden" name="statIon_tempData" id="statIon_tempData"/>
				    	<input type="hidden" name="enablePDF" id="enablePDF" value="${searchInfo.enablePDF}" default="N"/>
				    	
				    	<div class="form-group">
				    		<label for="search_kind" class="control-label">표출형태</label>
				    		<select class="form-control input-sm" name="search_kind" id="search_kind">
								<option value=""<c:if test="${searchInfo.search_kind eq ''}">selected="selected"</c:if>>전체</option>
								<option value="graph" <c:if test="${searchInfo.search_kind eq 'graph'}">selected="selected"</c:if>>그래프</option>
								<option value="grid" <c:if test="${searchInfo.search_kind eq 'grid'}">selected="selected"</c:if>>표</option>
				    		</select>
				      	</div>
				      	<div class="form-group">
				    		<label for="search_current" class="control-label">요소</label>
				    		<select class="form-control input-sm" name="search_current" id="search_current">
				    			<option value=""<c:if test="${param.search_current eq ''}">selected="selected"</c:if>>전체</option>
								<option value="XRAY"<c:if test="${param.search_current eq 'XRAY'}">selected="selected"</c:if>>태양복사폭풍</option>
								<option value="PROTON"<c:if test="${param.search_current eq 'PROTON'}">selected="selected"</c:if>>태양입자폭풍</option>
								<option value="KP"<c:if test="${param.search_current eq 'KP'}">selected="selected"</c:if>>지자기폭풍</option>
								<option value="MP"<c:if test="${param.search_current eq 'MP'}">selected="selected"</c:if>>자기권계면</option>
								<option value="BT"<c:if test="${param.search_current eq 'BT'}">selected="selected"</c:if>>IMF 자기장</option>
								<option value="BULK_SPD"<c:if test="${param.search_current eq 'BULK_SPD'}">selected="selected"</c:if>>태양풍 속도</option>
								<option value="PRO_DENS"<c:if test="${param.search_current eq 'PRO_DENS'}">selected="selected"</c:if>>태양풍 밀도</option>
								<option value="ION_TEMP"<c:if test="${param.search_current eq 'ION_TEMP'}">selected="selected"</c:if>>태양풍 온도</option>
				    		</select>
				      	</div>&nbsp;&nbsp;
				      	<div class="form-group">
				    		<label for="startYear" class="control-label">년도</label>
				    			<c:set var="now" value="<%= new Date() %>"/>
			      				<fmt:formatDate value="${now}" pattern="yyyy" var="year"/> 
			      				<fmt:parseNumber var="endYear" type="number" value="${year}" />
			      			<select class="form-control input-sm" id="startYear" name="startYear">
								<c:forEach begin="2011" end="${endYear}" varStatus="loop" var="i" step="1">
									<option	value="${loop.end - i + loop.begin}" <c:if test="${searchInfo.startYear == loop.end - i + loop.begin}">selected="selected"</c:if>>${loop.end - i + loop.begin}</option>
								</c:forEach>
							</select>
						</div>
				      	<div class="form-group">
				    		<label for="startMonth" class="control-label">월</label>
							<select class="form-control input-sm" id="startMonth" name="startMonth">
								<c:forEach begin="1" end="12" varStatus="loop" var="i">
									<c:set var="o" ><fmt:formatNumber minIntegerDigits="2" value="${i}"/></c:set>
									<option	value="${o}" <c:if test="${searchInfo.startMonth == o}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${i}" /></option>
								</c:forEach>
							</select>
						</div>
				     	<button type="button" class="btn btn-primary btn-sm searchBtn">검색</button>
				     	<button type="button" class="btn btn-primary btn-sm downloadPdf">PDF저장</button>
				    	</form>
				  	</div>
				</nav>
			
				<div id="XRAY" <c:if test="${param.search_current eq 'PROTON' or param.search_current eq 'KP' or param.search_current eq 'MP' or param.search_current eq 'BT' or param.search_current eq 'BULK_SPD' or param.search_current eq 'PRO_DENS' or param.search_current eq 'ION_TEMP'}">style="display:none"</c:if>>
				<div class="graph" <c:if test="${searchInfo.search_kind eq 'grid'}">style="display:none"</c:if>>
		    		<h4>태양복사폭풍</h4><br>
		    		<div id="STAT_XRAY_DIV" style="height:300px;"></div>
		    	</div>
		    	<br>
		    	<div class="grid" <c:choose><c:when test="${searchInfo.search_kind eq 'graph'}">style="display:none"</c:when><c:otherwise>style="display:inline"</c:otherwise></c:choose>>
					<h4>태양복사폭풍</h4>
					<table class="table table-striped">
		        	<colgroup>
						<col width="80" />
						<col width="100" />
						<col width="100" />
					</colgroup>
		        	<thead>
		            	<tr>
		            		<th>날짜</th>
		                	<th>평균</th>
		                	<th>최대</th>
		                </tr>
		            </thead>                    
				    <c:forEach var="o" items="${xrayList}" varStatus="status">     
					    <tr>
					        <td><spring:escapeBody>${o.tm}</spring:escapeBody></td>
					        <td>${o.avg_long_flux}</td>
					        <td>${o.max_long_flux}</td>
					    </tr>
				    </c:forEach>
		        </table>
		       </div>
		    </div>
		    
		    <div id="PROTON" <c:if test="${param.search_current eq 'XRAY' or param.search_current eq 'KP' or param.search_current eq 'MP' or param.search_current eq 'BT' or param.search_current eq 'BULK_SPD' or param.search_current eq 'PRO_DENS' or param.search_current eq 'ION_TEMP' }">style="display:none"</c:if>>
		     <div class="graph" <c:if test="${searchInfo.search_kind eq 'grid'}">style="display:none"</c:if>>
		      	<h4>태양입자폭풍</h4><br>
		      	<div id="STAT_PROTON_DIV" style="height:300px;"></div>
		     </div>
		     <br>
		     <div class="grid" <c:choose><c:when test="${searchInfo.search_kind eq 'graph'}">style="display:none"</c:when><c:otherwise>style="display:inline"</c:otherwise></c:choose>>   
		        <h4>태양입자폭풍</h4><br>
		        <table class="table table-striped">
		        	<colgroup>
		        		<col width="80" />
		        		<col width="100" />
		        		<col width="100" />
		        	</colgroup>
		        	<thead>
		            	<tr>
		            		<th>날짜</th>
		                	<th>평균</th>
		                	<th>최대</th>
		                </tr>
		            </thead>          
		        	<c:forEach var="o" items="${protonList}" varStatus="status">
			        	<tr>
			        		<td><spring:escapeBody>${o.tm}</spring:escapeBody></td>
			        		<td>${o.avg_p5}</td>
			        		<td>${o.max_p5}</td>
			        	</tr>
		        	</c:forEach>	
		        </table>
		        </div> 
		      </div>
		      
		      <div id="KP" <c:if test="${param.search_current eq 'XRAY' or param.search_current eq 'PROTON' or param.search_current eq 'MP' or param.search_current eq 'BT' or param.search_current eq 'BULK_SPD' or param.search_current eq 'PRO_DENS' or param.search_current eq 'ION_TEMP'}">style="display:none"</c:if>>
		     <div class="graph" <c:if test="${searchInfo.search_kind eq 'grid'}">style="display:none"</c:if>>
		      	<h4>지자기폭풍</h4><br>
		      	<div id="STAT_KP_DIV" style="height:300px;"></div>
		     </div>
		     <br>
		     <div class="grid" <c:choose><c:when test="${searchInfo.search_kind eq 'graph'}">style="display:none"</c:when><c:otherwise>style="display:inline"</c:otherwise></c:choose>>   
		        <h4>지자기폭풍</h4><br>
		        <table class="table table-striped">
		        	<colgroup>
		        		<col width="80" />
		        		<col width="100" />
		        		<col width="100" />
		        	</colgroup>
		        	<thead>
		            	<tr>
		            		<th>날짜</th>
		                	<th>평균</th>
		                	<th>최대</th>
		                </tr>
		            </thead>          
		        	<c:forEach var="o" items="${kpList}" varStatus="status">
			        	<tr>
			        		<td><spring:escapeBody>${o.tm}</spring:escapeBody></td>
			        		<td>${o.avg_value}</td>
			        		<td>${o.max_value}</td>
			        	</tr>
		        	</c:forEach>	
		        </table>
		        </div> 
		      </div>
		      
		       <div id="MP" <c:if test="${param.search_current eq 'XRAY' or param.search_current eq 'PROTON' or param.search_current eq 'KP' or param.search_current eq 'BT' or param.search_current eq 'BULK_SPD' or param.search_current eq 'PRO_DENS' or param.search_current eq 'ION_TEMP'}">style="display:none"</c:if>>
		       	 <div class="graph" <c:if test="${searchInfo.search_kind eq 'grid'}">style="display:none"</c:if>>
		       		<h4>자기권계면</h4><br>
		       		<div id="STAT_MAGNETOPAUSE_RADIUS_DIV" style="height:300px;"></div>
		       	 </div>
		        <br>
		         <div class="grid" <c:choose><c:when test="${searchInfo.search_kind eq 'graph'}">style="display:none"</c:when><c:otherwise>style="display:inline"</c:otherwise></c:choose>>
		        <h4>자기권계면</h4>
		        <table class="table table-striped">
		        	<colgroup>
		        		<col width="80" />
		        		<col width="100" />
		        		<col width="100" />
		        	</colgroup>
		        	<thead>
		        		<tr>
		        			<th>날짜</th>
		        			<th>평균</th>
		        			<th>최대</th>
		        		</tr>
		        	</thead>
		        	<c:forEach var="o" items="${mpList}" varStatus="status">
		        		<tr>
		        			<td><spring:escapeBody>${o.tm}</spring:escapeBody></td>
		        			<td>${o.avg_value}</td>
		        			<td>${o.max_value}</td>
		        		</tr>
		        	</c:forEach>
		        </table>
		       </div>
		       </div>
		       
		       <div id="BT" <c:if test="${param.search_current eq 'XRAY' or param.search_current eq 'PROTON' or param.search_current eq 'KP' or param.search_current eq 'MP' or param.search_current eq 'BULK_SPD' or param.search_current eq 'PRO_DENS' or param.search_current eq 'ION_TEMP'}">style="display:none"</c:if>>
		       	 <div class="graph" <c:if test="${searchInfo.search_kind eq 'grid'}">style="display:none"</c:if>>
		       		<h4>IMF 자기장</h4><br>
		       		<div id="STAT_BT_DIV" style="height:300px;"></div>
		       	 </div>
		        <br>
		         <div class="grid" <c:choose><c:when test="${searchInfo.search_kind eq 'graph'}">style="display:none"</c:when><c:otherwise>style="display:inline"</c:otherwise></c:choose>>
		        <h4>IMF 자기장</h4>
		        <table class="table table-striped">
		        	<colgroup>
		        		<col width="80" />
		        		<col width="100" />
		        		<col width="100" />
		        	</colgroup>
		        	<thead>
		        		<tr>
		        			<th>날짜</th>
		        			<th>평균</th>
		        			<th>최대</th>
		        		</tr>
		        	</thead>
		        	<c:forEach var="o" items="${btList}" varStatus="status">
		        		<tr>
		        			<td><spring:escapeBody>${o.tm}</spring:escapeBody></td>
		        			<td>${o.avg_bt}</td>
		        			<td>${o.max_bt}</td>
		        		</tr>
		        	</c:forEach>
		        </table>
		       </div>
		       </div>
		       
		        <div id="BULK_SPD" <c:if test="${param.search_current eq 'XRAY' or param.search_current eq 'PROTON' or param.search_current eq 'KP' or param.search_current eq 'MP' or param.search_current eq 'BT' or param.search_current eq 'PRO_DENS' or param.search_current eq 'ION_TEMP'}">style="display:none"</c:if>>
		       	 <div class="graph" <c:if test="${searchInfo.search_kind eq 'grid'}">style="display:none"</c:if>>
		       		<h4>태양풍 속도</h4><br>
		       		<div id="STAT_BULK_SPD_DIV" style="height:300px;"></div>
		       	 </div>
		        <br>
		        <div class="grid" <c:choose><c:when test="${searchInfo.search_kind eq 'graph'}">style="display:none"</c:when><c:otherwise>style="display:inline"</c:otherwise></c:choose>>
		        <h4>태양풍 속도</h4>
		        <table class="table table-striped">
		        	<colgroup>
		        		<col width="80" />
		        		<col width="100" />
		        		<col width="100" />
		        	</colgroup>
		        	<thead>
		        		<tr>
		        			<th>날짜</th>
		        			<th>평균</th>
		        			<th>최대</th>
		        		</tr>
		        	</thead>
		        	<c:forEach var="o" items="${bulk_spdList}" varStatus="status">
		        		<tr>
		        			<td><spring:escapeBody>${o.tm}</spring:escapeBody></td>
		        			<td>${o.avg_value}</td>
		        			<td>${o.max_value}</td>
		        		</tr>
		        	</c:forEach>
		        </table>
		       </div>
		       </div>
		       
		        <div id="PRO_DENS" <c:if test="${param.search_current eq 'XRAY' or param.search_current eq 'PROTON' or param.search_current eq 'KP' or param.search_current eq 'MP' or param.search_current eq 'BT' or param.search_current eq 'BULK_SPD' or param.search_current eq 'ION_TEMP'}">style="display:none"</c:if>>
		       	 <div class="graph" <c:if test="${searchInfo.search_kind eq 'grid'}">style="display:none"</c:if>>
		       		<h4>태양풍 밀도</h4><br>
		       		<div id="STAT_PRO_DENS_DIV" style="height:300px;"></div>
		       	 </div>
		        <br>
		        <div class="grid" <c:choose><c:when test="${searchInfo.search_kind eq 'graph'}">style="display:none"</c:when><c:otherwise>style="display:inline"</c:otherwise></c:choose>>
		        <h4>태양풍 밀도</h4>
		        <table class="table table-striped">
		        	<colgroup>
		        		<col width="80" />
		        		<col width="100" />
		        		<col width="100" />
		        	</colgroup>
		        	<thead>
		        		<tr>
		        			<th>날짜</th>
		        			<th>평균</th>
		        			<th>최대</th>
		        		</tr>
		        	</thead>
		        	<c:forEach var="o" items="${pro_densList}" varStatus="status">
		        		<tr>
		        			<td><spring:escapeBody>${o.tm}</spring:escapeBody></td>
		        			<td>${o.avg_value}</td>
		        			<td>${o.max_value}</td>
		        		</tr>
		        	</c:forEach>
		        </table>
		       </div>
		       </div>
		       
		       <div id="ION_TEMP" <c:if test="${param.search_current eq 'XRAY' or param.search_current eq 'PROTON' or param.search_current eq 'KP' or param.search_current eq 'MP' or param.search_current eq 'BT' or param.search_current eq 'BULK_SPD' or param.search_current eq 'PRO_DENS'}">style="display:none"</c:if>>
		       	 <div class="graph" <c:if test="${searchInfo.search_kind eq 'grid'}">style="display:none"</c:if>>
		       		<h4>태양풍 온도</h4><br>
		       		<div id="STAT_ION_TEMP_DIV" style="height:300px;"></div>
		       	 </div>
		        <br>
		        <div class="grid" <c:choose><c:when test="${searchInfo.search_kind eq 'graph'}">style="display:none"</c:when><c:otherwise>style="display:inline"</c:otherwise></c:choose>>
		        <h4>태양풍 온도</h4>
		        <table class="table table-striped">
		        	<colgroup>
		        		<col width="80" />
		        		<col width="100" />
		        		<col width="100" />
		        	</colgroup>
		        	<thead>
		        		<tr>
		        			<th>날짜</th>
		        			<th>평균</th>
		        			<th>최대</th>
		        		</tr>
		        	</thead>
		        	<c:forEach var="o" items="${ion_tempList}" varStatus="status">
		        		<tr>
		        			<td><spring:escapeBody>${o.tm}</spring:escapeBody></td>
		        			<td>${o.avg_value}</td>
		        			<td>${o.max_value}</td>
		        		</tr>
		        	</c:forEach>
		        </table>
		       </div>
			</div>
			
			 <!-- footer start -->
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		    <!-- footer end -->
			
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript" src="<c:url value="/js/dygraph-combined.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/dygraph-extra.js"/>"></script>
<script type="text/javascript">

/**
 * 
 * 그래프 객체
 */
 var statXray = null;			
 var statProton = null;			  
 var statKp = null;
 var statRadius = null;
 var statBt = null;
 var statBulk_spd = null;
 var statPro_dens = null;
 var statIon_temp = null;
 
 /**
 *
 * 데이터
 */
 
 var xrayData = [];
 var protonData = [];
 var kpData = [];
 var radiusData = [];
 var btData = [];
 var bulk_SpdData = [];
 var pro_DensData = [];
 var ion_TempData = [];
 
 
 /**
 *
 * 평균, 최대값 데이터
 */
 
 var avg = null;
 var max = null;
 
 
 // 태양복사폭풍 차트
 function statXrayChart() {
	 <c:forEach var="o" items="${xrayList}" varStatus="status">   
		 var x = new Date('${o.tm}');
		 xrayData.push([x, '${o.avg_long_flux}', '${o.max_long_flux}']);
		</c:forEach>
		
		statXray = new Dygraph (
			document.getElementById("STAT_XRAY_DIV"),
			xrayData,
			{
				labels: ['Date', "avg", "max"],
				ylabel: 'W/m<sup>2</sup>',
				yAxisLabelWidth:60,
				strokeWidth:2,
				labelsKMB: true,
				highlightCircleSize:4,
				axes: {
		              y: {
		                valueRange: [0.0000000001, 0.002],
		                valueFormatter: function(val) {
		                	return new Number(val).toExponential(0);
		                },
					  
					  	axisLabelFormatter: function(val) {
		                	return val.toExponential(0);
		                }
		              }
				},
				logscale:true,
				underlayCallback: function(ctx, area, g) {
					ctx.installPattern([10, 5]);
					drawDottedLine(ctx, g, 0.00001, 'gray');
					drawDottedLine(ctx, g, 0.00005, 'blue');
					drawDottedLine(ctx, g, 0.0001, 'yellow');
					drawDottedLine(ctx, g, 0.001, 'orange');
					drawDottedLine(ctx, g, 0.002, 'red');
		            ctx.uninstallPattern();	            
				}
				}
			);
	}
 
 // 태양입자폭풍 차트
 function statProtonChart() {
		<c:forEach var="o" items="${protonList}" varStatus="status">
		 var x = new Date('${o.tm}');
		 protonData.push([x, '${o.avg_p5}', '${o.max_p5}']);
		</c:forEach>
		
		statProton = new Dygraph (
			document.getElementById("STAT_PROTON_DIV"),
			protonData,
			{
				labels: ['Date', "avg", "max"],
				ylabel: 'cm<sup>-2</sup>s<sup>-2</sup>sr<sup>-2</sup>',
				yAxisLabelWidth:60,
				strokeWidth:2,
				labelsKMB:true,
				highlightCircleSize:4,
				axes: {
		              y: {
		                valueRange: [0.01, 100000]
		              }
				},
				logscale:true,
				underlayCallback: function(ctx, area, g) {
					ctx.installPattern([10, 5]);
					drawDottedLine(ctx, g, 10, 'gray');
					drawDottedLine(ctx, g, 100, 'blue');
					drawDottedLine(ctx, g, 1000, 'yellow');
					drawDottedLine(ctx, g, 10000, 'orange');
					drawDottedLine(ctx, g, 100000, 'red');
		            ctx.uninstallPattern();
				}			
			}
		);
	}

 	// 지자기폭풍 차트
	function statKpChart() {
		// 그래프 생성
		<c:forEach var="o" items="${kpList}" varStatus="status">
		 var x = new Date('${o.tm}');
		 kpData.push([x, '${o.avg_value}', '${o.max_value}']);
		 </c:forEach>
		 
		 statKp = new Dygraph (
			document.getElementById("STAT_KP_DIV"),
			kpData,
			{
				labels: ['Date', "avg", "max"],
				yAxisLabelWidth:60,
				strokeWidth:2,
				connectSeparatedPoints:true,
				highlightCircleSize:4,
				axes: {
		              y: {
		            	  valueRange: [0.01, 100000]
		              }
				},
				xValueParser: function(x) { return alert(x); 1000*parseInt(x); },
				logscale:true,
				underlayCallback: function(ctx, area, g) {
					ctx.installPattern([10, 5]);
					drawDottedLine(ctx, g, 10, 'gray');
					drawDottedLine(ctx, g, 100, 'blue');
					drawDottedLine(ctx, g, 1000, 'yellow');
					drawDottedLine(ctx, g, 10000, 'orange');
					drawDottedLine(ctx, g, 100000, 'red');
		            ctx.uninstallPattern();
				}			
			}
		 ); 
	}

 	// 자기권계면 차트
	function statMpChart() {
		 // 그래프 생성
		 <c:forEach var="o" items="${mpList}" varStatus="status">
		  var x = new Date('${o.tm}');
		  radiusData.push([x, '${o.avg_value}', '${o.max_value}']);
		 </c:forEach>
		 
		 statRadius = new Dygraph (
	    	document.getElementById("STAT_MAGNETOPAUSE_RADIUS_DIV"),
			radiusData,
			{
	    		labels: ['Date', "avg", "max"],
	    		yAxisLabelWidth:60,
	    		strokeWidth:2,
	    		highlightCircleSize:4,
	    		ylabel: 'R<sub>E</sub>',
	    		axes: {
	    			y: {
	    				 valueRange: [18, 4]
	    			}
	    		},
	    		logscale:true,
	    		underlayCallback: function(ctx, area, g) {
					ctx.installPattern([10, 5]);
					drawDottedLine(ctx, g, 4.6, 'red');
					drawDottedLine(ctx, g, 5.6, 'orange');
					drawDottedLine(ctx, g, 6.6, 'yellow');
					drawDottedLine(ctx, g, 8.6, 'blue');
					drawDottedLine(ctx, g, 10.6, 'gray');
		            ctx.uninstallPattern();
				}			
			}				 
		 );
	}

	// IMF자기장 차트
	function statBtChart() {
		 // 그래프 생성
		 <c:forEach var="o" items="${btList}" varStatus="status">
		  var x = new Date('${o.tm}');
		  avg = '${o.avg_bt}';	
		  max = '${o.max_bt}';	
		  btData.push([x, (avg == '') ? null :  avg , (max == '') ? null :  max]);
		  </c:forEach>

		statBt = new Dygraph (
	   	document.getElementById("STAT_BT_DIV"),
	   	btData,
			{
	   		labels: ['Date', "avg", "max"],
	   		ylabel: 'nT',
	   		yAxisLabelWidth:60,
	   		strokeWidth:2,
	   		highlightCircleSize:4,
	   		axes: {
	   			y: {
	   				valueRange: [-50, 100],
	   			}
	   		}
			}
		 );
	}

	// 태양풍 속도 차트
	function statBulk_spdChart() {
		// 그래프 생성
		<c:forEach var="o" items="${bulk_spdList}" varStatus="status">
		  var x = new Date('${o.tm}');
		  avg = '${o.avg_value}';
		  max = '${o.max_value}';
		  bulk_SpdData.push([x, (avg == '') ? null :  avg , (max == '') ? null :  max]);
		 </c:forEach>
		 
		 statBulk_spd = new Dygraph (
		 document.getElementById("STAT_BULK_SPD_DIV"),
		 bulk_SpdData,
		 	{
			labels: ['Date', "avg", "max"],
			ylabel: 'km/s',
			yAxisLabelWidth:60,
			strokeWidth:2,
			highlightCircleSize:4,
			axes: {
    			y: {
    				 valueRange: [-1000.0, 1500]
    			}
    		}
		 	}
		 );
	}

	// 태양풍 밀도 차트
	function statPro_densChart() {
		// 그래프 생성
		<c:forEach var="o" items="${pro_densList}" varStatus="status">
		  var x = new Date('${o.tm}');
		  avg = '${o.avg_value}';
		  max = '${o.max_value}';
		  pro_DensData.push([x, (avg == '') ? null :  avg , (max == '') ? null :  max]);
		 </c:forEach>
		 
		 statPro_dens = new Dygraph (
		 document.getElementById("STAT_PRO_DENS_DIV"),
		 pro_DensData,
		 	{
			labels: ['Date', "avg", "max"],
			ylabel: 'cm<sub>-3</sub>',
			strokeWidth:2,
			yAxisLabelWidth:60,
			highlightCircleSize:4,
			axes: {
    			y: {
    				 valueRange: [-800.0, 600]
    			}
    		}
		 	}
		 );
	}

	// 태양풍온도 차트
	function statIon_tempChart() {
		// 그래프 생성
		<c:forEach var="o" items="${ion_tempList}" varStatus="status">
		  var x = new Date('${o.tm}');
		  avg = '${o.avg_value}';
		  max = '${o.max_value}';
		  ion_TempData.push([x, (avg == '') ? null :  avg , (max == '') ? null :  max]);
		 </c:forEach>
		 
		 statIon_temp = new Dygraph (
		 document.getElementById("STAT_ION_TEMP_DIV"),
		 ion_TempData,
		 	{
			labels: ['Date', "avg", "max"],
			strokeWidth:2,
			ylabel: 'K',
			yAxisLabelWidth:60,
			highlightCircleSize:4,
			axes: {
    			y: {
    				 valueRange: [-1000.0, 2000000]
    			}
    		}
		 	}
		 );
	}
	
	function drawDottedLine(ctx, dygraph, yvalue, strokeStyle) {
		var xRange = dygraph.xAxisRange();
	    var xl= dygraph.toDomCoords(xRange[0],yvalue);
	    var xr= dygraph.toDomCoords(xRange[1],yvalue);
	    ctx.strokeStyle= strokeStyle;
	    ctx.beginPath();
	    ctx.moveTo(xl[0],xl[1]);
	    ctx.lineTo(xr[0],xr[1]);
	    ctx.closePath();
	    ctx.stroke();              
	}
	
 $(function() {
	// 검색 버튼을 누르면 해당하는 조건으로 검색한다.
	$(".searchBtn").on('click', function(e) {
		$('#enablePDF').val("N");
		document.frm.target = "_self";
		document.frm.action = "stat_list.do";
		document.frm.submit();
	});
	
	 // Pdf다운로드 버튼을 누르면 pdf를 다운로드한다.
	 $('.downloadPdf').on('click', function(e){
		$('#enablePDF').val("Y");
		document.frm.target = "_self";
		document.frm.action = "stat_list.do";
		document.frm.submit();
	 });
	 
	 statXrayChart();
	 statProtonChart();
	 statKpChart();
	 statMpChart();
	 statBtChart();
	 statBulk_spdChart();
	 statPro_densChart();
	 statIon_tempChart();
	 
	 
	 if($('#enablePDF').val() == 'Y') {
		 savePDF();
	 }
  });
 
 // PDF저장
 function savePDF(){
	 var currentType = $('#search_current').val();
	 
	 if($('#search_kind').val() != 'grid'){ // 그리드가 아닐경우
		 if(currentType == '' || currentType == 'XRAY'){
			var canvas = Dygraph.Export.asCanvas(statXray);
			$("input[name=statXrayData]").val(canvas.toDataURL());
		 } 
		
		
		 if(currentType == '' || currentType == 'PROTON'){
			var canvas2 = Dygraph.Export.asCanvas(statProton);
			$("input[name=statProtonData]").val(canvas2.toDataURL());
		 }
		 
		 if(currentType == '' || currentType == 'KP'){
			var canvas3 = Dygraph.Export.asCanvas(statKp);
			$("input[name=statKpData]").val(canvas3.toDataURL());
		 }
		
		 if(currentType == '' || currentType == 'MP'){
			var canvas4 = Dygraph.Export.asCanvas(statRadius);
			$("input[name=statMpData]").val(canvas4.toDataURL());
		 }		
		 if(currentType == '' || currentType == 'BT'){
			var canvas5 = Dygraph.Export.asCanvas(statBt);
			$("input[name=statBtData]").val(canvas5.toDataURL());
		 }		
		
		 if(currentType == '' || currentType == 'BULK_SPD'){
			var canvas6 = Dygraph.Export.asCanvas(statBulk_spd);
			$("input[name=statBulk_spdData]").val(canvas6.toDataURL());
		 }		
		
		 if(currentType == '' || currentType == 'PRO_DENS'){
			var canvas7 = Dygraph.Export.asCanvas(statPro_dens);
			$("input[name=statPro_densData]").val(canvas7.toDataURL());
		 }		
		
		 if(currentType == '' || currentType == 'ION_TEMP'){
			var canvas8 = Dygraph.Export.asCanvas(statIon_temp);
			$("input[name=statIon_tempData]").val(canvas8.toDataURL());
	 	}
	 }
	 
	 document.frm.action = "stat_download_pdf.do";
	 document.frm.target = "pdf";
	 document.frm.method = "post";
	 document.frm.submit();
 }
</script>
</body>
</html>