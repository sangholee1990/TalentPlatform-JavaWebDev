<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
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
		report.setTitle("우주기상 특보");		
	}
	
	if(StringUtils.isEmpty(report.getContents())) {
		report.setContents("");
	}
	
	Date publishDate = report.getPublish_dt();
	SimpleDateFormat df = new SimpleDateFormat("MM.dd HH:mm");
	String noticePublish = df.format(publishDate);
	String noticeFinish = "진행 중";
	if(StringUtils.isEmpty(report.getNot1_publish())) {
		report.setNot1_publish(noticePublish);
	}
	if(StringUtils.isEmpty(report.getNot2_publish())) {
		report.setNot2_publish(noticePublish);
	}
	if(StringUtils.isEmpty(report.getNot3_publish())) {
		report.setNot3_publish(noticePublish);
	}
	if(StringUtils.isEmpty(report.getNot1_finish())) {
		report.setNot1_finish(noticeFinish);
	}
	if(StringUtils.isEmpty(report.getNot2_finish())) {
		report.setNot2_finish(noticeFinish);
	}
	if(StringUtils.isEmpty(report.getNot3_finish())) {
		report.setNot3_finish(noticeFinish);
	}
	
	Calendar cal = Calendar.getInstance();
	cal.setTime(publishDate);
	pageContext.setAttribute("publishHour", cal.get(Calendar.HOUR_OF_DAY));
	pageContext.setAttribute("publishMinute", cal.get(Calendar.MINUTE));
	
	List<String> noticeTypeList = new ArrayList<String>();
	noticeTypeList.add("주의보");
	noticeTypeList.add("경보");
	pageContext.setAttribute("noticeTypeList", noticeTypeList);
	
	List<String> noticeTargetList = new ArrayList<String>();
	noticeTargetList.add("기상위성");
	noticeTargetList.add("극항로 항공기 운항");
	noticeTargetList.add("위성항법시스템(GNSS)");
	pageContext.setAttribute("noticeTargetList", noticeTargetList);
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
	width: 80%;
	margin-left: 10px;
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
			<h4 class="page-header">특보문 작성</h4>
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
	        	<input type="hidden" name="file_path1" id="file_path1" value="${report.file_path1}" />
	        	<input type="hidden" name="file_path2" id="file_path2" value="${report.file_path2}" />
	        	<!-- 
	        	<input type="hidden" name="publish_seq_n" id="publish_seq_n" value="${report.publish_seq_n }"/>
	        	-->
				<table class="table table-bordered">
					<tr>
						<th class="active col-sm-2"><label for="title">제목</label></th>
						<td>
							<input type="text" class="col-sm-3" id="title" name="title" value="${report.title }" />
							<select class="col-sm-1" id="wrn_flag" name="wrn_flag">
								<option value="S" <c:if test="${report.wrn_flag == 'S' }">selected="selected"</c:if>>발령</option>
								<option value="E" <c:if test="${report.wrn_flag == 'E' }">selected="selected"</c:if>>해제</option>
							</select>
							(제 <fmt:formatDate value="${report.publish_dt}" pattern="MM"/> -<input type="text" class="col-sm-4" id="rmk1" name="rmk1" maxlength="2" value="${report.rmk1 }"/>&nbsp;호)
						</td>
					</tr>
					<tr>
						<th class="active col-sm-2"><label for="publish_seq_n">발행번호</label></th>
						<td>
							<input type="text" class="col-sm-4" id="publish_seq_n" name="publish_seq_n" maxlength="2" value="${report.publish_seq_n }"/> * 발행번호는 파일명에 적용되는 번호입니다.
						</td>
					</tr>
					<tr>
						<th class="active col-sm-2"><label for="publishDay">발표일시</label></th>
						<td>
							<input type="hidden" id="publish_dt" name="publish_dt" />
							<input type="text" class="col-sm-2" id="publishDay" value="<fmt:formatDate type="date" value="${report.publish_dt}" pattern="yyyy-MM-dd"/>" style="margin-left: 10px;"/>
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
							<div>
								<table class="table table-bordered table-in-table4">
									<colgroup>
										<col width="15%"/>
										<col width="25%"/>
										<col width="25%"/>
										<col width="25%"/>
									</colgroup>
									<tr>
										<th class="active text-center">구분</th>
										<th class="active text-center">기상위성운영</th>
										<th class="active text-center">극항로 항공기상</th>
										<th class="active text-center">전리권기상</th>
									</tr>
									<tr>
										<th class="active text-center">특보종류</th>
										<td class="text-left">
											<select id="not1_type" name="not1_type" style="width: 148px; padding:2px 1px;">
						                	<c:forEach items="${noticeTypeList}" var="item">
						                		<option value="${item }" <c:if test="${item eq report.not1_type }">selected="selected"</c:if>>${item }</option>
						                	</c:forEach>
						                	</select>
										</td>
										<td class="text-left">
											<select id="not2_type" name="not2_type" style="width: 148px; padding:2px 1px;">
						                	<c:forEach items="${noticeTypeList}" var="item">
						                		<option value="${item }" <c:if test="${item eq report.not2_type }">selected="selected"</c:if>>${item }</option>
						                	</c:forEach>
						                	</select>
										</td>
										<td class="text-left">
											<select id="not3_type" name="not3_type" style="width: 148px; padding:2px 1px;">
						                	<c:forEach items="${noticeTypeList}" var="item">
						                		<option value="${item }" <c:if test="${item eq report.not3_type }">selected="selected"</c:if>>${item }</option>
						                	</c:forEach>
						                	</select>
										</td>
									</tr>
									<tr>
										<th class="active text-center">발표시각</th>
										<td class="text-left">
											<input type="text" id="not1_publish" name="not1_publish" value="${report.not1_publish }" />
										</td>
										<td class="text-left">
											<input type="text" id="not2_publish" name="not2_publish" value="${report.not2_publish }" />
										</td>
										<td class="text-left">
											<input type="text" id="not3_publish" name="not3_publish" value="${report.not3_publish }" />
										</td>
									</tr>
									<tr>
										<th class="active text-center">종료시각</th>
										<td class="text-left">
											<input type="text" id="not1_finish" name="not1_finish" value="${report.not1_finish }" />
										</td>
										<td class="text-left">
											<input type="text" id="not2_finish" name="not2_finish" value="${report.not2_finish }" />
										</td>
										<td class="text-left">
											<input type="text" id="not3_finish" name="not3_finish" value="${report.not3_finish }" />
										</td>
									</tr>
									<tr>
										<th class="active text-center">대상</th>
										<td class="text-left">
											<select id="not1_tar" name="not1_tar" style="width: 148px; padding:2px 1px;">
						                	<c:forEach items="${noticeTargetList}" var="item">
						                		<option value="${item }" <c:if test="${item eq report.not1_tar }">selected="selected"</c:if>>${item }</option>
						                	</c:forEach>
						                	</select>
										</td>
										<td class="text-left">
											<select id="not2_tar" name="not2_tar" style="width: 148px; padding:2px 1px;">
						                	<c:forEach items="${noticeTargetList}" var="item">
						                		<option value="${item }" <c:if test="${item eq report.not2_tar }">selected="selected"</c:if>>${item }</option>
						                	</c:forEach>
						                	</select>
										</td>
										<td class="text-left">
											<select id="not3_tar" name="not3_tar" style="width: 148px; padding:2px 1px;">
						                	<c:forEach items="${noticeTargetList}" var="item">
						                		<option value="${item }" <c:if test="${item eq report.not3_tar }">selected="selected"</c:if>>${item }</option>
						                	</c:forEach>
						                	</select>
										</td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<th class="active col-sm-2"><label for="test">주의사항</label></th>
						<td>
							<table class="table table-bordered table-in-table4">
								<colgroup>
									<col width="15%"/>
									<col width="25%"/>
									<col width="25%"/>
									<col width="25%"/>
								</colgroup>
								<tr>
									<th class="active text-center">종류</th>
									<th class="active text-center">기상위성운영</th>
									<th class="active text-center">극항로 항공기상</th>
									<th class="active text-center">전리권기상</th>
								</tr>
								<tr>
									<th class="active text-center">주의사항</th>
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
							<table class="table table-bordered table-in-table4">
								<colgroup>
									<col width="20%"/>
									<col width="40%"/>
									<col width="40%"/>
								</colgroup>
								<tr>
									<th class="active text-center">구분</th>
									<th class="active text-center">첨부파일1</th>
									<th class="active text-center">첨부파일2</th>
								</tr>
								<tr>
									<th class="active text-center">File Title</th>
									<td class="text-left">
										<select id="file_title1" name="file_title1">
										<c:forEach items="${file_title }" var="item">
											<option value="${item }" <c:if test="${report.file_title1 eq item }">selected="selected"</c:if>>${item }</option>
										</c:forEach>
										</select>
									</td>
									<td class="text-left">
										<select id="file_title2" name="file_title2">
										<c:forEach items="${file_title }" var="item">
											<option value="${item }" <c:if test="${report.file_title2 eq item }">selected="selected"</c:if>>${item }</option>
										</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th class="active text-center">첨부파일</th>
									<td class="text-left">
										<input type="file" id="file1_data" name="file1_data" />
									</td>
									<td id="file2_area" class="text-left">
										<input type="file" id="file2_data" name="file2_data" />
									</td>
								</tr>
								<tr>
									<th class="active text-center">이미지</th>
									<td class="text-center">
										<span><img id="file1_data_preview" width="250px" height="250px" src="<c:url value="/images/report/noimg250.gif" />" /></span>
									</td>
									<td class="text-center">
										<span><img id="file2_data_preview" width="250px" height="250px" src="<c:url value="/images/report/noimg250.gif" />" /></span>
									</td>
								</tr>
							</table>
							<div class="sub_title1" style="width: 100%; padding-top: 5px;">
								<input type="text" name="footerText1" class="col-sm-11" value="<spring:message code='forecast.report.wrn.o.footer1'/>" />
							</div>
						</td>
					</tr>
					<tr>
						<td class="active col-sm-2"></td>
						<td><input type="text" name="footerText2" class="col-sm-8" value="<spring:message code='forecast.report.wrn.o.footer2'/>" />	</td>
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
	$(function() {
		var datepickerOption = {
			changeYear : true,
			showOn : "button",
			buttonImage : '<c:url value="/images/btn_calendar.png"/>',
			buttonImageOnly : true,
			dateFormat: "yy-mm-dd"
		};
		
		var opt1 = {
			img: $("#file1_data_preview"),	
			w: 250,
			h: 250			
		};
		
		var opt2 = {
			img: $("#file2_data_preview"),	
			w: 250,
			h: 250
		};
			
		$("#file1_data").setPreview(opt1);
		$("#file2_data").setPreview(opt2);
		
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
		
		$("input[type=file]").css("display", "inline");
		
		if($("#rpt_seq_n").val() != "") {
			if("${report.file_path1}" != "") {
				initImageData("file1_data_preview", $("#file_path1").val());
			}
			if("${report.file_path2}" != "") {
				initImageData("file2_data_preview", $("#file_path2").val());
			}
		}
		
		if("${report.submit_dt}" != null && "${report.submit_dt}" != "") {
			$("input, select, textarea").attr("disabled", "disabled");
		}
	});
	
	/**
	 *  미리보기 이미지를 만든다.
	 */
	$.fn.setPreview = function(opt) {
		"use strict";
		var defaultOpt = {
			inputFile: $(this),
			img: null,
			w: 250,
			h: 250
		};
		$.extend(defaultOpt, opt);
		
		// 미리보기 이미지를 만든다.
		var previewImage = function() {
			if(!defaultOpt.inputFile || !defaultOpt.img) return;
			
			var inputFile = defaultOpt.inputFile.get(0);
			var img = defaultOpt.img.get(0);

			// 브라우저가 FileReader를 지원하는 경우
			// IE10 이상, chrome, firefox 등...
			if(window.FileReader) {
				if(!inputFile.files[0].type.match(/image\//))
				{
					alert("이미지 파일만 업로드 가능합니다."); 
					return;
				}
				
				try {
					var reader = new FileReader();
					reader.onload = function(e) {
						img.src = e.target.result;
						img.style.width = defaultOpt.w+"px";
						img.style.heigth = defaultOpt.h+"px";
						img.style.display = "";
					}; 
					reader.readAsDataURL(inputFile.files[0]);
				} catch(e) {
					// Nothing to do.
				}
			// IE 9 이하... 
			} else if(img.filters) {
				if(!inputFile.type.match(/image\//))
				{
					alert("이미지 파일만 업로드 가능합니다.");
					return;
				}
				inputFile.select();
				inputFile.blur();
				var imgSrc = document.selection.createRange().text;
				
				img.src = "";
				img.style.width = defaultOpt.w+"px";
				img.style.height = defaultOpt.h+"px";
				img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true', sizingMethod='scale', src='"+imgSrc+"')";
				img.style.display = "";
			// 미리보기 미지원 브라우저...
			} else {
				// no support
				// Safari5, ...
			}
		};
		
 		// change 이벤트
		$(this).change(function() {
			previewImage();
		});
	};
	
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
		}*/
		if($("#contents").val() == null || $("#contents").val() == ""){
			alert("개요를 확인바랍니다.");
			
			$("#contents").focus();
			
			return false;
		}
		
		if($("#not1_publish").val() == null || $("#not1_publish").val() == "") {
			alert("기상위성운영 발표시각을 확인바랍니다.");
			
			$("#not1_publish").focus();
			
			return false;
		}
		if($("#not2_publish").val() == null || $("#not2_publish").val() == "") {
			alert("극항로 항공기상 발표시각을 확인바랍니다.");
			
			$("#not2_publish").focus();
			
			return false;
		}
		if($("#not3_publish").val() == null || $("#not3_publish").val() == "") {
			alert("전리권기상 발표시각을 확인바랍니다.");
			
			$("#not3_publish").focus();
			
			return false;
		}
		
		if($("#not1_finish").val() == null || $("#not1_finish").val() == "") {
			alert("기상위성운영 종료시각을 확인바랍니다.");
			
			$("#not1_finish").focus();
			
			return false;
		}
		if($("#not2_finish").val() == null || $("#not2_finish").val() == "") {
			alert("극항로 항공기상 종료시각을 확인바랍니다.");
			
			$("#not2_finish").focus();
			
			return false;
		}
		if($("#not3_finish").val() == null || $("#not3_finish").val() == "") {
			alert("전리권기상 종료시각을 확인바랍니다.");
			
			$("#not3_finish").focus();
			
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
	
	function initImageData(str, file_path){
		
		var url = "view_browseimage2.do?file_path=" + file_path;
		
		$("#" + str).attr("src", url);
	}
</script>	
</body>
</html>