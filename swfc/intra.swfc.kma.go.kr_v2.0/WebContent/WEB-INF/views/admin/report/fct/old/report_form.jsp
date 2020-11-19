<%@page import="com.itextpdf.text.log.SysoCounter"%>
<%@page import="com.gaia3d.web.dto.ChartSummaryDTO"%>
<%@page import="org.joda.time.LocalDate"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="com.gaia3d.web.dto.ForecastReportDTO"%>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!doctype html>
<%
	ForecastReportDTO report = (ForecastReportDTO)request.getAttribute("report");
	if(StringUtils.isEmpty(report.getTitle())) {
		report.setTitle("우주기상 예보");
	}
	
	if(StringUtils.isEmpty(report.getContents())) {
		report.setContents("--태양복사, 태양고에너지입자 및 지구자기장 교란이 일반수준을 유지하고 있어 기상위성운영,  극항로 항공기상 및 전리권기상에 영향없음.\n\n--지구 자기권계면이 정상범위이므로 기상위성운영에 영향없음.");
	}
	
	Date publishDate = report.getPublish_dt();
	Calendar cal = Calendar.getInstance();
	cal.setTime(publishDate);
	
	org.joda.time.LocalDate localDate = new LocalDate(report.getWrite_dt());
	
	pageContext.setAttribute("chart1Date", localDate.minusDays(2).toString("MM월 dd일"));
	pageContext.setAttribute("chart2Date", localDate.minusDays(1).toString("MM월 dd일"));
	pageContext.setAttribute("chart3Date", localDate.toString("MM월 dd일"));
	pageContext.setAttribute("probability1Date", localDate.plusDays(1).toString("MM월 dd일"));
	pageContext.setAttribute("probability2Date", localDate.plusDays(2).toString("MM월 dd일"));
	
	pageContext.setAttribute("publishHour", cal.get(Calendar.HOUR_OF_DAY));
	pageContext.setAttribute("publishMinute", cal.get(Calendar.MINUTE));
%>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />
<style type="text/css">
.form-group-sm {
	padding-bottom:50px;
}
.table > thead > tr > th,
.table > tbody > tr > th,
.table > tfoot > tr > th,
.table > thead > tr > td,
.table > tbody > tr > td,
.table > tfoot > tr > td {
	vertical-align: middle;
}

.tit_warn {
	display:inline-block;
	font-weight:bold;
	width:120px;
}
span + span {
	margin-left: 10px;
}
input[type="checkbox"] + label {
	margin-left: 5px;
	font-weight: normal;
}
textarea {
	min-height: 250px !important;
	margin-bottom: 15px;
}
.col-sm-1 {
	width: 100px;
	margin-left: 10px;
	vertical-align: middle;
	float: none;
}
.col-sm-3 {
	width: 115px;
	margin-left: 10px;
	vertical-align: middle;
	float: none;
}
.col-sm-4 {
	width: 30px;
	margin-left: 10px;
	padding-left:0px;
	padding-right:0px;
	text-align:center;
	vertical-align: middle;
	float: none;
}
.col-sm-8 {
	margin-left: 10px;
	width: 80%;
	vertical-align: middle;
	float: none;
}
.table-in-table {
	width: 66.66%;
	margin-left: 10px;
	margin-bottom: 0;
}
.table-in-table2 {
	width: 55%;
	margin-left: 10px;
	margin-bottom: 0;
	float:left;
}
.table-in-table3 {
	width: 40%;
	height: 249px;
 	margin-right: 8px;
	margin-bottom: 0;
	float:right;
}
.table-in-table4 {
	width: 98%;
	margin-left: 10px;
	margin-right: 8px;
	margin-bottom: 0;
}
.sub_title1 {
	width: 55%;
	margin-left: 10px;
	margin-bottom: 0;
	float:left;
}
.sub_title2 {
	width: 40%;
 	margin-right: 8px;
	margin-bottom: 0;
	float:right;
}
.sub-title-box {
	display: block;
	float: left;
	height: 20px;
	width: 20px;
	margin-right: 8px;
	border: 1px solid #000;
	background-color: #fff;
}
.box-1 {
	margin-right: 8px;
	border: 1px solid #000;
	background-color: yellow;
}
.box-2 {
	margin-right: 8px;
	border: 1px solid #000;
	background-color: red;
}
.box-3 {
	margin-right: 8px;
	border: 1px solid #000;
	background-color: #00B050;
}
.graph {
 	padding: 0px !important;
	vertical-align: bottom !important;
}
.bar-chart {
	position: relative;
	float: left;
}
.bar-chart-area1 {
	position: absolute;
	width: 30px;
	background-color: yellow;
}
.bar-chart-area2 {
	position: absolute;
	width: 30px;
	background-color: red;
}
.bar-chart-area3 {
	position: absolute;
	width: 30px;
	background-color: #00B050;
}
</style>
</head>
<body>
<div class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-md-10">
			<h4 class="page-header">구통보문 작성</h4>
			<!-- content area start -->
			
			<!-- top button area start -->
		  	<div class="form-group-sm">
			    <div class="col-sm-12 text-right">
			    	<button type="button" class="btn btn-default listBtn">목록</button>
			    	<c:if test="${empty report.rpt_seq_n }">
			    	<button type="button" class="btn btn-default addBtn">등록</button>
			    	</c:if>
			    	<c:if test="${not empty report.rpt_seq_n && empty report.submit_dt }">
			    	<button type="button" class="btn btn-default editBtn">수정</button>
			    	<button type="button" class="btn btn-default deleteBtn">삭제</button>
			    	<button type="button" class="btn btn-default pdfBtn">미리보기</button>
			    	</c:if>
			    </div>
		  	</div>
		  	<!-- top button area end -->
			
	        <form name="frm" id="frm" method="post" enctype="multipart/form-data">
	        	<input type="hidden" name="page" id="page" value="${page }" />
	        	<input type="hidden" name="fontName" value="BATANG.TTC"/>
	        	<input type="hidden" name="fontIndex" value="0"/>
	        	<input type="hidden" name="rpt_seq_n" id="rpt_seq_n" value="${report.rpt_seq_n }" />
	        	<input type="hidden" name="write_dt" id="write_dt" value="<fmt:formatDate type="date" value="${report.write_dt}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
	        	<input type="hidden" name="rpt_type" id="rpt_type" value="${report.rpt_type }" />
	        	<input type="hidden" name="rpt_kind" id="rpt_kind" value="O" />
	        	<input type="hidden" name="not1_max_val1" id="not1_max_val1" value="${report.not1_max_val1 }" />
	        	<input type="hidden" name="not1_max_val2" id="not1_max_val2" value="${report.not1_max_val2 }" />
	        	<input type="hidden" name="not1_max_val3" id="not1_max_val3" value="${report.not1_max_val3 }" />
	        	<input type="hidden" name="not2_max_val1" id="not2_max_val1" value="${report.not2_max_val1 }" />
	        	<input type="hidden" name="not2_max_val2" id="not2_max_val2" value="${report.not2_max_val2 }" />
	        	<input type="hidden" name="not2_max_val3" id="not2_max_val3" value="${report.not2_max_val3 }" />
	        	<input type="hidden" name="not3_max_val1" id="not3_max_val1" value="${report.not3_max_val1 }" />
	        	<input type="hidden" name="not3_max_val2" id="not3_max_val2" value="${report.not3_max_val2 }" />
	        	<input type="hidden" name="not3_max_val3" id="not3_max_val3" value="${report.not3_max_val3 }" />
	        	<input type="hidden" name="file_nm1" id="file_nm1" value="${report.file_nm1 }" />
	        	<input type="hidden" name="file_path1" id="file_path1" value="${report.file_path1 }" />
			 	
				<table class="table table-bordered">
					<tr>
						<th class="active col-sm-2"><label for="title">제목</label></th>
						<td>
							<input type="text" class="col-sm-3" id="title" name="title" value="${report.title }" />
							(제 <fmt:formatDate value="${report.publish_dt}" pattern="MM"/> -<input type="text" class="col-sm-4" id="publish_seq_n" name="publish_seq_n" maxlength="2" value="${report.publish_seq_n }"/>&nbsp;호)
						</td>
					</tr>
					<tr>
						<th class="active col-sm-2"><label for="publishDay">발표일시</label></th>
						<td>
							<input type="hidden" id="publish_dt" name="publish_dt" />
							<input type="text" class="col-sm-2" id="publishDay" value="<fmt:formatDate type="date" value="${report.publish_dt}" pattern="yyyy-MM-dd"/>" />
							<select id="publishHour">
		                	<c:forEach begin="0" end="23" var="item">
		                		<option value="<fmt:formatNumber minIntegerDigits="2" value="${item}" />" <c:if test="${publishHour == item}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${item}"/></option>
		                	</c:forEach>
		                	</select>시
		                	<select id="publishMinute">
		                	<c:forEach begin="0" end="59" var="item">
		                		<option value="<fmt:formatNumber minIntegerDigits="2" value="${item}" />" <c:if test="${publishMinute == item}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${item}"/></option>
		                	</c:forEach>
		                	</select>분
						</td>
					</tr>
					<!-- 
					<tr>
						<th class="active col-sm-2"><label for="writer">발표자</label></th>
						<td>
							<input type="text" class="col-sm-8" id="writer" name="writer" value="${report.writer }" />
						</td>
					</tr>
					 -->
					<tr>
						<th class="active col-sm-2"><label for="contents">개요</label></th>
						<td>
							<div>
                                <p class="text-right col-sm-8">※ &#39;--&#39; 문자는 단락의 시작을 나타내며,  &#39;○&#39; 문자로 변환됩니다.</p>
								<textarea class="col-sm-8" id="contents" name="contents">${report.contents }</textarea>
							</div>
						</td>
					</tr>
					<tr>
						<th class="active col-sm-2"><label for="test">주의사항</label></th>
						<td>
							<table class="table table-bordered table-in-table4">
								<colgroup>
									<col width="10%"/>
									<col width="28%"/>
									<col width="28%"/>
									<col width="28%"/>
								</colgroup>
								<tr>
									<th class="active col-sm-2 text-center">종류</th>
									<th class="active col-sm-2 text-center">기상위성운영</th>
									<th class="active col-sm-2 text-center">극항로 항공기상</th>
									<th class="active col-sm-2 text-center">전리권기상</th>
								</tr>
								<tr>
									<th class="active col-sm-2 text-center">주의사항</th>
									<td class="text-center">
										<select id="not1_desc" name="not1_desc" multiple="multiple" size="2">
					                	<c:forEach items="${not1_desc}" var="item">
					                		<option value="${item }" <c:forEach items="${report.not1_desc }" var="rpt_item"><c:if test="${item eq rpt_item }">selected="selected"</c:if></c:forEach>>${item }</option>
					                	</c:forEach>
					                	</select>
									</td>
									<td class="text-center">
										<select id="not2_desc" name="not2_desc" multiple="multiple" size="2">
					                	<c:forEach items="${not2_desc}" var="item">
					                		<option value="${item }" <c:forEach items="${report.not2_desc }" var="rpt_item"><c:if test="${item eq rpt_item }">selected="selected"</c:if></c:forEach>>${item }</option>
					                	</c:forEach>
					                	</select>
									</td>
									<td class="text-center">
										<select id="not3_desc" name="not3_desc" multiple="multiple" size="2">
					                	<c:forEach items="${not3_desc}" var="item">
					                		<option value="${item }" <c:forEach items="${report.not3_desc }" var="rpt_item"><c:if test="${item eq rpt_item }">selected="selected"</c:if></c:forEach>>${item }</option>
					                	</c:forEach>
					                	</select>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<th class="active col-sm-2"><label>상세정보</label></th>
						<td>
							<div class="sub_title1 col-sm-2 text-center"><label>최근 3일 우주기상 정보&lt;일 최대값&gt;</label></div>
							<div class="sub_title2 col-sm-2 text-center"><label>지구자기권계면의 위치</label></div>
							<table class="table table-bordered table-in-table2">
								<colgroup>
									<col width="10%"/>
									<col width="25%"/>
									<col width="25%"/>
									<col width="25%"/>
								</colgroup>
								<tbody>
								<tr>
									<th colspan="4" class="active col-sm-2 text-center">
										<span class="box-1">&nbsp;&nbsp;&nbsp;&nbsp;</span>태양복사
										<span class="box-2">&nbsp;&nbsp;&nbsp;&nbsp;</span>태양고에너지입자
										<span class="box-3">&nbsp;&nbsp;&nbsp;&nbsp;</span>지구자기장 교란
									</th>
								</tr>
								<tr>
									<th class="active col-sm-2 text-center">심 각</th>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<th class="active col-sm-2 text-center">경 계</th>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<th class="active col-sm-2 text-center">주 의</th>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<th class="active col-sm-2 text-center">관 심</th>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<th class="active col-sm-2 text-center">일 반</th>
									<td class="text-center graph">
										<div class="bar-chart">
										<span class="bar-chart-area1"></span>
										</div>
										<div class="bar-chart">
										<span class="bar-chart-area2"></span>
										</div>
										<div class="bar-chart">
										<span class="bar-chart-area3"></span>
										</div>
									</td>
									<td class="text-center graph">
										<div class="bar-chart">
										<span class="bar-chart-area1"></span>
										</div>
										<div class="bar-chart">
										<span class="bar-chart-area2"></span>
										</div>
										<div class="bar-chart">
										<span class="bar-chart-area3"></span>
										</div>
									</td>
									<td class="text-center graph">
										<div class="bar-chart">
										<span class="bar-chart-area1"></span>
										</div>
										<div class="bar-chart">
										<span class="bar-chart-area2"></span>
										</div>
										<div class="bar-chart">
										<span class="bar-chart-area3"></span>
										</div>
									</td>
								</tr>
								<tr>
									<th class="active col-sm-2 text-center">기 준</th>
									<td class="text-center">${chart1Date }</td>
									<td class="text-center">${chart2Date }</td>
									<td class="text-center">${chart3Date }</td>
								</tr>
								</tbody>
							</table>
							<div class="table-in-table3" style="text-align:center;">
								<img id="geomagImg" src="http://swfc.kma.go.kr/alerts/img/geomag_B.png" width="250px" />
							</div>
							<div class="sub_title1" style="width: 100%; padding-top: 5px;">
								<input type="text" name="footerText1" class="col-sm-11" value="<spring:message code='forecast.report.fct.o.footer1'/>" />
							</div>
						</td>
					</tr>
					<tr>
						<td class="active col-sm-2"></td>
						<td><input type="text" name="footerText2" class="col-sm-8" value="<spring:message code='forecast.report.fct.o.footer2'/>"/></td>
					</tr>
				</table>
			  	
			</form>
			
			<!-- bottom button area start -->
		  	<div class="form-group form-group-sm">
			    <div class="col-sm-12 text-right">
			    	<button type="button" class="btn btn-default listBtn">목록</button>
			    	<c:if test="${empty report.rpt_seq_n }">
			    	<button type="button" class="btn btn-default addBtn">등록</button>
			    	</c:if>
			    	<c:if test="${not empty report.rpt_seq_n && empty report.submit_dt }">
			    	<button type="button" class="btn btn-default editBtn">수정</button>
			    	<button type="button" class="btn btn-default deleteBtn">삭제</button>
			    	<button type="button" class="btn btn-default pdfBtn">미리보기</button>
			    	</c:if>
			    </div>
		  	</div>
		  	<!-- bottom button area end -->
		  	
			<!-- content area end -->
			
			<jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript">
	var datepickerOption = {
		changeYear : true,
		showOn : "button",
		buttonImage : '<c:url value="/images/btn_calendar.png"/>',
		buttonImageOnly : true,
		dateFormat: "yy-mm-dd"
	};
	
	$(function() {
		
		$("#publishDay").datepicker(datepickerOption);
		
		// 등록버튼에 클릭이벤트 바인딩
		$(".addBtn").on("click", submitReport);
		
		// 수정버튼에 클릭이벤트 바인딩
		$(".editBtn").on("click", submitReport);
		
		// 목록버튼에 클릭이벤트 바인딩
		$(".listBtn").on("click", function(){
			location.href = "report_list.do?page=" + $("#page").val();
		});
		
		// 삭제버튼에 클릭이벤트 바인딩
		$(".deleteBtn").on("click", deleteAdminReport);
	
		$(".pdfBtn").on("click", convertToPDF);
		
		var max_val = [
				"${report.not1_max_val3}", //작은 날짜 2015-02-09
				"${report.not2_max_val3}",
				"${report.not3_max_val3}",
				"${report.not1_max_val2}",
				"${report.not2_max_val2}",
				"${report.not3_max_val2}",
				"${report.not1_max_val1}",
				"${report.not2_max_val1}",
				"${report.not3_max_val1}" //큰날짜 2015-02-11
		];
		
		var obj = $(".graph");
		
		var _height = null; 
		
		for(var i=0; i<$(obj).children().children("[class*=bar-chart-area]").length; i++) {
			_height = getHeight(max_val[i]);
			addStyle($(obj).children()[i], "bottom", _height);
			addStyle($(obj).children().children("[class*=bar-chart-area]")[i], "height", _height);		
			
			if(i%3 == 0) {
				addStyle($(obj).children().children("[class*=bar-chart-area]")[i], "margin-left", 12);
			}else if(i%3 == 1) {
				addStyle($(obj).children().children("[class*=bar-chart-area]")[i], "margin-left", 42);
			}else {
				addStyle($(obj).children().children("[class*=bar-chart-area]")[i], "margin-left", 72);
			}
		}
		
		if($("#rpt_seq_n").val() != "") {
			$("#publishDay").datepicker("disable");
			$("#publishHour option").not(":selected").attr("disabled", "disabled");
			$("#publishMinute option").not(":selected").attr("disabled", "disabled");
		}
		
		if("${report.submit_dt}" != null && "${report.submit_dt}" != "") {
			$("input, select, textarea").attr("disabled", "disabled");
		}
		
		initImageData();
	});
	
	function getHeight(max_val) {
		var height = parseFloat(max_val) * 176.85;
		if(height < 2.0) height += 2.0;
		//console.log(max_val + "=="+  height);
		return height;
	}
	
	function addStyle(obj, attr, value) {
		$(obj).css(attr, value);
	}
	
	// 유효성 체크	
	function validate() {
		
		if($("#title").val() == null || $("#title").val() == ""){
			alert("제목을 확인바랍니다.");
			
			$("#title").focus();
			
			return false;
		}
		if($("#publish_seq_n").val() == null || $("#publish_seq_n").val() == "") {
			alert("발행호수를 확인바랍니다.");
			
			$("#publish_seq_n").focus();
			
			return false;
		}
		if(!$.isNumeric($("#publish_seq_n").val())) {
			alert("발행호수는 숫자만 입력할 수 있습니다.");
			
			$("#publish_seq_n").focus();
			
			return false;
		}
		/*
		if($("#writer").val() == null || $("#writer").val() == ""){
			alert("발표자를 확인바랍니다.");
			
			$("#writer").focus();
			
			return false;
		}
		*/
		if($("#contents").val() == null || $("#contents").val() == ""){
			alert("개요를 확인바랍니다.");
			
			$("#contents").focus();
			
			return false;
		}
		if($("#not1_desc").val() == null || $("#not1_desc").val() == ""){
			alert("주의사항을 확인바랍니다.");
			
			$("#not1_desc").focus();
			
			return false;
		}
		if($("#not2_desc").val() == null || $("#not2_desc").val() == ""){
			alert("주의사항을 확인바랍니다.");
			
			$("#not2_desc").focus();
			
			return false;
		}
		if($("#not3_desc").val() == null || $("#not3_desc").val() == ""){
			alert("주의사항을 확인바랍니다.");
			
			$("#not3_desc").focus();
			
			return false;
		}
		
		return true;
	}
	
	// 관리자페이지 우주기상 신통보문 등록
	function submitReport() {
		// 유효성 체크
		if(!validate()){
			return false;
		}
		
		// 등록/수정을 구분하기 위한 변수
		var str;
		str = $("#rpt_seq_n").val() == "" ? "등록" : "수정";
		
		if(confirm(str + "하시겠습니까?")){
			var publishDay = $("#publishDay").val();
			var publishDate = publishDay + " " + $("#publishHour").val() + ":" + $("#publishMinute").val() + ":00";
			$("#publish_dt").val(publishDate);

			$("#frm").attr("action", "report_submit.do");
			$("#frm").submit();
		}
	}
	
	// 관리자 우주기상 신통보문 삭제
	function deleteAdminReport() {
		
		if(confirm("삭제하시겠습니까?")) {
			$("#frm").attr("action", "report_delete.do");
			frm.submit();
		}
	}
	
	function convertToPDF() {
		var submit_dt = "${report.submit_dt}";
		
		if(submit_dt == "")	{
			if(!confirm("저장하지 않은 보고서는 수정하기 이전 데이터로 PDF를 생성합니다.\n계속 하시겠습니까?"))
				return false;
		}
		
		window.open("covert_report_to_pdf.do?rpt_seq_n=" + $("#rpt_seq_n").val() + "&rpt_type=" + $("#rpt_type").val(), "_blank", "fullscreen=yes");
		return false;
	}
	
	function initImageData(){
		var dt = new Date();
		
		var year = dt.getFullYear();
		var month = dt.getUTCMonth() + 1;
		var day = dt.getUTCDate();
		var hour = dt.getUTCHours();
		
		if(month < 10) month = "0" + month;
		if(day < 10) day = "0" + day;
		if(hour < 10) hour = "0" + hour;
		
		var date = year + "-" + month + "-" + day;
		
		var url = "view_browseimage.do?date=" + date + "&hour=" + hour + "&type=";
		
		$("#geomagImg").attr("src", url + "geomag");
		
// 		var file_path1 = "/" + year + "/" + month + "/" + day + "/" + hour;
// 		var file_nm1 = year + month + day + hour + "_geomag_B.png";
		
// 		$("#file_path1").val(file_path1);
// 		$("#file_nm1").val(file_nm1);
	}
</script>	
</body>
</html>