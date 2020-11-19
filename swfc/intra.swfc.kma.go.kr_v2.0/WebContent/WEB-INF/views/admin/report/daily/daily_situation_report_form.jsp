<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@page import="com.itextpdf.text.log.SysoCounter"%>
<%@page import="com.gaia3d.web.dto.ChartSummaryDTO"%>
<%@page import="org.joda.time.LocalDate"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!doctype html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />
<style type="text/css">
.table > thead > tr > th,
.table > tbody > tr > th,
.table > tfoot > tr > th,
.table > thead > tr > td,
.table > tbody > tr > td,
.table > tfoot > tr > td {
	vertical-align: middle;
}

.table input {
	text-align: center;
}

.slash {
	background-image: url('<c:url value="/images/report/slash.png"/>');
	background-size: 100% 100%;
}

.backslash {
	background-image: url('<c:url value="/images/report/backslash.png"/>');
	background-size: 100% 100%;
}

</style>
</head>
<body>
<div class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-md-10">
			<h4 class="page-header">일일상황보고</h4>
			
			<div class="col-sm-12 col-md-12 text-right">
		        	<button type="button" class="btn btn-default listDailySituationReportBtn">목록</button>
				<c:choose>
		        	<c:when test="${empty report}">
		        	<button type="button" class="btn btn-default addDailySituationReportBtn">등록</button>
		        	</c:when>
		        	<c:otherwise>
		        	<button type="button" class="btn btn-default editDailySituationReportBtn">수정</button>
		        	<button type="button" class="btn btn-default deleteDailySituationReportBtn">삭제</button>
		        	<a href="daily_situation_report_download_pdf.do?rpt_seq_n=${ report.RPT_SEQ_N }" class="btn btn-default downloadDailySituationReportBtn">PDF 다운로드</a>
		        	</c:otherwise>
				</c:choose>
	        </div><br/><br/>
	        
	        <form name="frm" id="frm" method="post" class="form-horizontal" role="form">
	        	<input type="hidden" name="rpt_type" value="DSR"/>
	        	<input type="hidden" name="fontName" value="BATANG.TTC"/>
	        	<input type="hidden" name="fontIndex" value="0"/>
	        	<input type="hidden" name="title" value="우주기상 일일상황보고"/>
	        	<input type="hidden" name="rpt_file_path" value="${report.RPT_FILE_PATH}"/>
	        	<input type="hidden" name="rpt_file_org_nm" value="${report.RPT_FILE_ORG_NM}"/>
	        	<input type="hidden" name="rpt_file_nm" value="${report.RPT_FILE_NM}"/>
	        	<input type="hidden" name="rpt_seq_n" value="${ report.RPT_SEQ_N }"/>
	        	<input type="hidden" name="file_nm1" value="${ report.FILE_NM1 }"/>
	        	<input type="hidden" name="file_path1" value="${ report.FILE_PATH1 }"/>
	        	<input type="hidden" name="file_nm2" value="${ report.FILE_NM2 }"/>
	        	<input type="hidden" name="file_path2" value="${ report.FILE_PATH2}"/>
	        	<input type="hidden" name="file_nm3" value="${ report.FILE_NM3 }"/>
	        	<input type="hidden" name="file_path3" value="${ report.FILE_PATH3 }"/>
	        	<input type="hidden" name="file_nm4" value="${ report.FILE_NM4 }"/>
	        	<input type="hidden" name="file_path4" value="${ report.FILE_PATH4 }"/>
	        	<table class="table table-bordered" style="width:100%; border: solid 1px gray;">
	        		<tr style="border-bottom-style: hidden;">
	        			<td width="100%" class="text-center" style="height: 30px; padding-top: 10px;"><font style="font-size: 18px; font-weight: bold;"><u>우주기상 일일상황보고</u></font></td>
	        		</tr>
	        		<tr style="border-bottom-style: hidden;">
	        			<td width="100%" class="text-right" style="height: 30px; padding-right: 20px; vertical-align: middle;">
	        				<input type="text" id="publish_dt" name="publish_dt" readonly="readonly" size="12" value="${report.PUBLISH_DATE}"/>
	        				일&nbsp; ${report.PUBLISH_HOUR}
	        				<span class="dayName"></span>
	        				<select id="publishHour" name="publish_hour">
	        					<!-- 
	        					<option value="10" selected="selected">10</option>
	        					 -->
	        					<c:forEach begin="0" end="23" var="item">
	        					<c:set var="val"><fmt:formatNumber minIntegerDigits="2" value="${item}" /></c:set>
	        					<option value="<fmt:formatNumber minIntegerDigits="2" value="${item}" />" <c:if test="${report.PUBLISH_HOUR == val}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${item}"/></option></c:forEach>
	                		</select>
	                		시 
	                		<select id="publishMin" name="publish_min">
	        					<c:forEach begin="0" end="50" var="item" step="10">
	        					<c:set var="val"><fmt:formatNumber minIntegerDigits="2" value="${item}" /></c:set>
	        					<option value="<fmt:formatNumber minIntegerDigits="2" value="${item}" />" <c:if test="${report.PUBLISH_MIN == val}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${item}"/></option></c:forEach>
	                		</select>
	                		분 
	                		<button type="button" class="btn btn-default btn-xs glyphicon glyphicon-refresh refreshBtn"></button>
	        				</td>
	        		</tr>
	        		<tr>
	        			<td width="100%" class="text-right" style="height: 30px; padding-right: 20px;"><font style="font-size: 15px; font-weight: bold;">보고자 : <input type="text" name="writer" value="<c:out value="${report.WRITER}" default="허철운"/>" /></font></td>
	        		</tr>
	        	</table>
	        	<br/>
				<table class="table table-bordered">
					<tr>
						<th colspan="9" class="text-center" style="border-bottom-style: solid; border-bottom-width: 2px; background-color: gray;" >우주폭풍 일일 자료 상황</th>
					</tr>
					<tr>
						<td width="10"></td>
						<th colspan="2" class="text-center">태양복사폭풍<br/>(X-선 유속)</th>
						<th colspan="2" class="text-center">태양입자폭풍<br/>(10MeV이상 입자량)</th>
						<th colspan="2" class="text-center">지자기폭풍<br/>(Kp 지수)</th>
						<th colspan="2" class="text-center">자기권계면<br/>(자지권계면 위치)</th>
					</tr>
					<tr>
						<td class="text-center">그래프</td>
						<c:choose>
							<c:when test="${empty report}">
								<td colspan="2" style="height: 200px;" class="text-center"><img alt="태양복사폭풍" id="xfluxImg" src="<c:url value="/images/report/noimg250.gif" />" width="180px"></td>
								<td colspan="2"  class="text-center"><img alt="태양복사폭풍" id="protonImg" src="<c:url value="/images/report/noimg250.gif" />" width="180px"></td>
								<td colspan="2"  class="text-center"><img alt="지자기폭풍" id="kpImg" src="<c:url value="/images/report/noimg250.gif" />" width="180px"></td>
								<td colspan="2"  class="text-center"><img alt="자기권계면" id="geomagImg" src="<c:url value="/images/report/noimg250.gif" />" width="180px"></td>
							</c:when>
							<c:otherwise>
								<td colspan="2" style="height: 200px;" class="text-center"><img alt="태양복사폭풍" id="xfluxImg" src="view_browseimage.do?type=xflux&date=<custom:DailyReportImagePath path="${ report.FILE_PATH1 }" />" width="180px"></td>
								<td colspan="2"  class="text-center"><img alt="태양복사폭풍" id="protonImg" src="view_browseimage.do?type=proton&date=<custom:DailyReportImagePath path="${ report.FILE_PATH2 }" />" width="180px"></td>
								<td colspan="2"  class="text-center"><img alt="지자기폭풍" id="kpImg" src="view_browseimage.do?type=kp&date=<custom:DailyReportImagePath path="${ report.FILE_PATH3 }" />" width="180px"></td>
								<td colspan="2"  class="text-center"><img alt="자기권계면" id="geomagImg" src="view_browseimage.do?type=geomag&date=<custom:DailyReportImagePath path="${ report.FILE_PATH4 }" />" width="180px"></td>
							</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<td rowspan="2" class="text-center">일일최대값</td>
						<td class="text-center" style="width:100px;">최대등급<br/>(W/m<sup>2</sup>)</td>
						<td class="text-center"><input type="text" name="not1_desc" value="${ report.NOT1_DESC }" style="width: 80%;" /></td>
						<td class="text-center" style="width:100px;">최대치<br/>(cm<sup>-2</sup>s<sup>-2</sup>sr<sup>-2</sup>)</td>
						<td class="text-center"><input type="text" name="not2_desc" value="${ report.NOT2_DESC }" style="width: 80%;" /></td>
						<td class="text-center" style="width:100px;">최대치</td>
						<td class="text-center"><input type="text" name="not3_desc" value="${ report.NOT3_DESC }" style="width: 80%;" /></td>
						<td class="text-center" style="width:100px;">최소값<br/>(R<sub>E</sub>)</td>
						<td class="text-center"><input type="text" name="not4_desc" value="${ report.NOT4_DESC }" style="width: 80%;" /></td>
					</tr>
					<tr>
						<td class="text-center">시간<br/>(UTC)</td>
						<td class="text-center"><input type="text" name="xray_tm" value="${ report.XRAY_TM }" style="width: 80%;" maxlength="12"/></td>
						<td class="text-center">시간<br/>(UTC)</td>
						<td class="text-center"><input type="text" name="proton_tm" value="${ report.PROTON_TM }" style="width: 80%;" maxlength="12"/></td>
						<td class="text-center">시간<br/>(UTC)</td>
						<td class="text-center"><input type="text" name="kp_tm" value="${ report.KP_TM }" style="width: 80%;" maxlength="12"/></td>
						<td class="text-center">시간<br/>(UTC)</td>
						<td class="text-center"><input type="text" name="geomag_tm" value="${ report.GEOMAG_TM }" style="width: 80%;" maxlength="12"/></td>
					</tr>
					<tr>
						<th colspan="9" class="text-center" style="border-bottom-style: solid; border-bottom-width: 2px; background-color: gray;">우주기상 정보 및 기타 전달사항</th>
					</tr>
					<tr>
						<td rowspan="5" colspan="2" class="text-center" style="border-right-style: double; border-right-width: 3px;">우주기상특보</td>
						<td colspan="2" class="text-center backslash" style="border-right-style: double; border-right-width: 3px;"></td>
						<td colspan="2" class="text-center">기상위성운영</td>
						<td colspan="2" class="text-center">극항로 항공기상</td>
						<td colspan="2" class="text-center">전리권 기상</td>
					</tr>
					<tr>
						<td colspan="2" class="text-center" style="border-right-style: double; border-right-width: 3px;">등급</td>
						<td colspan="2" class="text-center"><input type="text" name="not1_type" value="${ report.NOT1_TYPE }" /></td>
						<td colspan="2" class="text-center"><input type="text" name="not2_type" value="${ report.NOT2_TYPE }" /></td>
						<td colspan="2" class="text-center"><input type="text" name="not3_type" value="${ report.NOT3_TYPE }" /></td>
					</tr>
					<tr>
						<td colspan="2" class="text-center" style="border-right-style: double; border-right-width: 3px;">발령시각</td>
						<td colspan="2" class="text-center"><input type="text" name="not1_publish" value="${ report.NOT1_PUBLISH }" /></td>
						<td colspan="2" class="text-center"><input type="text" name="not2_publish" value="${ report.NOT2_PUBLISH }" /></td>
						<td colspan="2" class="text-center"><input type="text" name="not3_publish" value="${ report.NOT3_PUBLISH }" /></td>
					</tr>
					<tr>
						<td colspan="2" class="text-center" style="border-right-style: double; border-right-width: 3px;">해제시각</td>
						<td colspan="2" class="text-center"><input type="text" name="not1_finish" value="${ report.NOT1_FINISH }" /></td>
						<td colspan="2" class="text-center"><input type="text" name="not2_finish" value="${ report.NOT2_FINISH }" /></td>
						<td colspan="2" class="text-center"><input type="text" name="not3_finish" value="${ report.NOT3_FINISH }" /></td>
					</tr>
					<tr>
						<td colspan="2" class="text-center" style="border-right-style: double; border-right-width: 3px;">발생규모(최대치)</td>
						<td colspan="2" class="text-center"><input type="text" name="not1_tar" value="${ report.NOT1_TAR }" /></td>
						<td colspan="2" class="text-center"><input type="text" name="not2_tar" value="${ report.NOT2_TAR }" /></td>
						<td colspan="2" class="text-center"><input type="text" name="not3_tar" value="${ report.NOT3_TAR }" /></td>
					</tr>
					<tr>
						<td colspan="2" class="text-center contentsTxt" style="border-right-style: double; border-right-width: 3px;">우주기상정보</td>
						<td colspan="8" class="text-center"><textarea style="width:100%; height: 150px" name="contents" id="contents">${ report.CONTENTS }</textarea></td>
					</tr>
					<tr>
						<td colspan="2" class="text-center doubleLine rmk1Txt" style="border-right-style: double; border-right-width: 3px;">향후 3일 전망</td>
						<td colspan="8" class="text-center"><textarea style="width:100%;height: 70px;" name="rmk1" id="rmk1">${ report.RMK1 }</textarea></td>
					</tr>
					<tr>
						<td rowspan="2" colspan="2" class="text-center doubleLine" style="border-right-style: double; border-right-width: 3px;" >자료 미 수신 현황</td>
						<td colspan="2" class="text-center">자료명</td>
						<td colspan="2" class="text-center">장애시각</td>
						<td colspan="2" class="text-center">복구시각</td>
						<td colspan="2" class="text-center">내용</td>
					</tr>
					<tr>
						<td colspan="2" class="text-center"><input type="text" name="info1" value="${report.INFO1}"/></td>
						<td colspan="2" class="text-center"><input type="text" name="info2" value="${report.INFO2}"/></td>
						<td colspan="2" class="text-center"><input type="text" name="info3" value="${report.INFO3}"/></td>
						<td colspan="2" class="text-center"><input type="text" name="info4" value="${report.INFO4}"/></td>
					</tr>
					<tr>
						<td colspan="2" class="text-center doubleLine" style="border-right-style: double; border-right-width: 3px;">기타</td>
						<td colspan="8" class="text-center"><textarea style="width:100%;height: 50px;" name="rmk2">${ report.RMK2 }</textarea></td>
					</tr>
					<!-- 
					<tr>
						<td colspan="2" class="doubleLine"></td>
						<td colspan="8"><input type="text" name="footerText2" class="col-sm-8 text-left" value="□ 연락처 070-7850-5735 / 홈페이지 http://swfc.kma.go.kr" />	</td>
					</tr>
					<tr>
						<td colspan="2" class="doubleLine"></td>
						<td colspan="8">
							<input type="text" name="footerText1" class="col-sm-11 text-left" value="※ 태양복사, 태양고에너지 입자, 지구자기장 교란에 관한 예경보는 미래창조과학부 우주전파센터에서 제공" />
						</td>
					</tr>
					 -->
				</table>
			</form>
		  	
		  <div class="col-sm-12 col-md-12 text-right">
		        	<button type="button" class="btn btn-default listDailySituationReportBtn">목록</button>
				<c:choose>
		        	<c:when test="${empty report}">
		        	<button type="button" class="btn btn-default addDailySituationReportBtn">등록</button>
		        	</c:when>
		        	<c:otherwise>
		        	<button type="button" class="btn btn-default editDailySituationReportBtn">수정</button>
		        	<button type="button" class="btn btn-default deleteDailySituationReportBtn">삭제</button>
		        	<a href="daily_situation_report_download_pdf.do?rpt_seq_n=${ report.RPT_SEQ_N }" class="btn btn-default downloadDailySituationReportBtn">PDF 다운로드</a>
		        	</c:otherwise>
				</c:choose>
	        </div><br/><br/>
	        <br/><br/>
			<!-- content area end -->
    		<jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<!-- 
<script type="text/javascript" src="<c:url value="/resources/bootstrap/js/jquery.fileDownload.js"/>"></script>
 -->
<script type="text/javascript">
    var dayNames = ['일', '월', '화', '수', '목', '금', '토'];
    var monthNames = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
	var datepickerOption = {
		changeYear : true,
		showOn : "button",
		dayNames: dayNames,
		dayNamesMin: dayNames,
		dayNamesShort: dayNames,
		monthNames : monthNames,
		monthNamesShort : monthNames,
		buttonImage : '<c:url value="/images/btn_calendar.png"/>',
		buttonImageOnly : true,
		dateFormat: "yy-mm-dd",
		defaultDate: new Date(),
		onSelect: function(dateText, inst){
			//var date = $(this).datepicker('getDate');
			//alert($.datepicker.formatDate('DD', date));
			initTitle();
		}
	};
    
	var currentDate = new Date();
	$(function() {
		$("#publish_dt").datepicker(datepickerOption);
		
		
		$(".refreshBtn").on('click', function(){
			initImageData();
			initDailyMaxData();
		});
		
		$(".listDailySituationReportBtn").on('click', listDailySiturationReport);
		
		
		//레포트가 없을 경우 기본값 셋팅
		<c:if test="${empty report}">
		
		$(".addDailySituationReportBtn").on('click', insertDailySiturationReport);
		//초기화
		$('#publish_dt').val($.datepicker.formatDate('yy-mm-dd', currentDate));
		//$('#publishHour').val(getHour());
		$('#publishHour').val("10");
		$('#publishMin').val("30");
		initDailyMaxData();
		initReceiveData();
		initNextThirdDay();
		initEtc();
		//initDailyWrnData();
		initImageData();
		</c:if>
		
		<c:if test="${!empty report}">
		$(".editDailySituationReportBtn").on('click', editDailySiturationReport);
		$(".deleteDailySituationReportBtn").on('click', deleteDailySiturationReport);
		/*
		$(".downloadDailySituationReportBtn").on('click', function(e){
			//downloadDailySituationReport(e);
		});*/
		</c:if>
		
		initTitle();
	});
	
	//타이틀 및 이미지 파일명은 생성일 기준으로 변경하도록 한다.
	function initTitle(){
		var date = $("#publish_dt").datepicker('getDate');
		
		var dayTxt = "우주기상정보<br/>(KST)<br/>([preDay] 9시<br/>~<br/>[toDay] 9시)";
		var nextDayTxt = "향후 3일 전망<br/>(KST)<br/>([toDay]<br/>~<br/>[nextDay])";
		var filePattern = "[date]([dayNm])_우주기상_일일상황보고.pdf";
		filePattern = filePattern.replace("[date]", $.datepicker.formatDate('yymmdd', date));
		filePattern = filePattern.replace("[dayNm]", dayNames[date.getDay()]);
		
		$("input[name='rpt_file_path']").val("/" + $.datepicker.formatDate('yy', date));
		$("input[name='rpt_file_org_nm']").val(filePattern);
		$('.dayName').text("(" + dayNames[date.getDay()]  +")");
		
		dayTxt = dayTxt.replace("[toDay]", $.datepicker.formatDate('mm월 dd일', date));
		nextDayTxt = nextDayTxt.replace("[toDay]", $.datepicker.formatDate('mm월 dd일', date));
		
		date.setDate( date.getDate() - 1 );
		dayTxt = dayTxt.replace("[preDay]", $.datepicker.formatDate('mm월 dd일', date));
		
		date.setDate(date.getDate() + 3 );
		nextDayTxt = nextDayTxt.replace("[nextDay]", $.datepicker.formatDate('mm월 dd일', date));
		
		$('.contentsTxt').html(dayTxt);
		$('.rmk1Txt').html(nextDayTxt);
	}
	
	//우주기상 영역 콘텐츠 초기값 셋팅
	function initContent(data){
		var tempContent = "- 태양 활동은 '[grade1]([grade2]-class)' 수준\n";
		tempContent += "- 태양활동영역 ?에서 [xrayGradeVal]급 태양복사폭풍 발생\n";
		tempContent += "- 현재 태양 영상 디스크에 ?개의 흑점 지역 존재\n";
		tempContent += "- 지자기활동은 '[kp1](Kp=[kp2])'수준\n";
		tempContent += "- 태양풍 순간최대속도 [bulk_spd] km/s, IMF Bz성분(남북방향) 순간최대세기 [bz] nT\n";
		tempContent += "- 2MeV이상의 전자가 정지궤도 위치에서 순간최고 [2MeV] pfu 수준\n";
		tempContent += "- 10MeV이상의 양성자가 정지궤도 위치에서 순간최고 [10MeV] pfu 수준\n";
		tempContent += "- 자기권계면 위치는 약 [GEOMAG] RE으로 기상위성운영에 영향 없음";
		
		
		$(data).each(function(index, element){
			var val = element.VAL;
			var grade = element.GRADE;
			if(element.NM == 'XRAY'){
				var grade1 = "";
				if(grade == 'B') grade1 = "매우낮음";
				else if(grade == 'A') grade1 = "매우낮음";                  
				else if(grade == 'C') grade1 = "낮음";                  
				else if(grade == 'M') grade1 = "보통";                  
				else if(grade == 'X') grade1 = "높음";                 
				
				tempContent = tempContent.replace("[grade1]", grade1);
				tempContent = tempContent.replace("[grade2]", element.GRADE);
				tempContent = tempContent.replace("[xrayGradeVal]", element.GRADE + xRayValue(val));
			}else if(element.NM == 'KP'){
				var grade1 = "";
				if(val >= 8) grade1 = "강한 지구자기폭풍";
				else if(val == 7)  grade1 = '대규모지자기폭풍';
				else if(val == 6)  grade1 = '중규모지자기폭풍';
				else if(val == 5)  grade1 = '소규모지자기폭풍';
				else if(val == 4)  grade1 = '활발';
				else if(val == 3) grade1 = '불안정'; 					
				else grade1 = '안정';
				
				tempContent = tempContent.replace("[kp1]", grade1);
				tempContent = tempContent.replace("[kp2]", val);
			}else if(element.NM == 'bulk_spd'){
				tempContent = tempContent.replace("[bulk_spd]", val);
			}else if(element.NM == 'bz'){
				tempContent = tempContent.replace("[bz]", val);
			}else if(element.NM == '2MeV'){
				tempContent = tempContent.replace("[2MeV]", val);
			}else if(element.NM == '10MeV'){
				tempContent = tempContent.replace("[10MeV]", val);
			}else if(element.NM == 'GEOMAG'){
				tempContent = tempContent.replace("[GEOMAG]", val.toFixed(2));
			}
		});
		
		
		$('#contents').text(tempContent);
	}
	
	//향후 3일 전망
	function initNextThirdDay(){
		var today = $("#publish_dt").datepicker('getDate');
		//var title = "향후 3일 전망<br/>(KST)<br/>([toDay]<br/>~<br/>[thirdDay])";
		
		var tempContent = "- [toDay]~[thirdDay] 동안 태양활동은 대체로 '?(?-class)'~'?(?-class)' 수준일 것으로 예상\n";
		tempContent += "- [toDay]~[thirdDay] 지자기 활동은  '?(Kp=?)'~'?(Kp=?)' 수준일 것으로 예상";
		
		//title = title.split("[toDay]").join($.datepicker.formatDate('mm월 dd일', today));
		tempContent = tempContent.split("[toDay]").join($.datepicker.formatDate('dd일', today));
		
		today.setDate(today.getDate() + 1 );
		tempContent = tempContent.split("[secondDay]").join($.datepicker.formatDate('dd일', today));
		
		today.setDate(today.getDate() + 1 );
		//title = title.split("[thirdDay]").join($.datepicker.formatDate('mm월 dd일', today));
		tempContent = tempContent.split("[thirdDay]").join($.datepicker.formatDate('dd일', today));
		
		//$('.rmk1Txt').html(title);
		$('#rmk1').text(tempContent);
	}
	
	
	function insertDailySiturationReport(){
		if(confirm('등록하시겠습니까?')){
			document.frm.action="daily_situation_report_insert.do";
			document.frm.submit();	
		}
	}
	
	function editDailySiturationReport(){
		if(confirm('수정하시겠습니까?')){
			document.frm.action="daily_situation_report_update.do";
			document.frm.submit();	
		}
	}
	
	function deleteDailySiturationReport(){
		if(confirm('삭제하시겠습니까?')){
			$.getJSON( "daily_situation_report_delete.do", {
				rpt_seq_n : $("input[name='rpt_seq_n']").val()
			}, function(data){
				location.href = "report_list.do";
				if(data.result > 0){
				}
			});
		}
	}
	
	function downloadDailySituationReport(e){
		$.fileDownload($(e).prop("href"), {
			preparingMessageHtml : "",
			failMessageHtml : ""
		});
		return false;
	}
	
	function listDailySiturationReport(){
		location.href = "report_list.do";
	}
	
	function initImageData(){
		
		var dt = $('#publish_dt').val().split("-");
		var hour = $("#publishHour").val();
		var date = new Date(dt[0], dt[1] - 1, dt[2], hour);
		var year = date.getUTCFullYear();
		var month = date.getUTCMonth() + 1;
		var day = date.getUTCDate();
		var hour = date.getUTCHours();
		
		if(month < 10) month = "0" + month;
		if(day < 10) day = "0" + day;
		if(hour < 10) hour = "0" + hour;
		
		var convertDate = year + "-" + month + "-" + day;
		
		var url = "view_browseimage.do?date=" + convertDate + "&hour=" + hour + "&type=";
		
		$('#xfluxImg').attr("src", url + "xflux");
		$('#protonImg').attr("src", url + "proton");
		$('#kpImg').attr("src", url + "kp");
		$('#geomagImg').attr("src", url + "geomag");
		
		
		/*
		var xfluxImgPattern = '<c:url value='/swfc_resource/Figure/yyyy/mm/dd/hh/yyyymmddhh_xflux_5m.png'/>';
		var kpImgPattern = '<c:url value='/swfc_resource/Figure/yyyy/mm/dd/hh/yyyymmddhh_kp_index.png'/>';
		var protonImgPattern = '<c:url value='/swfc_resource/Figure/yyyy/mm/hh/dd/yyyymmddhh_goes13_proton.png'/>';
		var geomagImgPattern = '<c:url value='/swfc_resource/Figure/yyyy/mm/hh/dd/yyyymmddhh_geomag_B.png'/>';
		*/
		var xfluxImgPattern = 'yyyymmddhh_xflux_5m.png';
		var protonImgPattern = 'yyyymmddhh_goes13_proton.png';
		var kpImgPattern = 'yyyymmddhh_kp_index.png';
		var geomagImgPattern = 'yyyymmddhh_geomag_B.png';
		
		//이미지 경로 지정
		var imagePath = "/" + year + "/" + month + "/" + day + "/" + hour;
		$("input[name=file_path1]").val(imagePath);
		$("input[name=file_path2]").val(imagePath);
		$("input[name=file_path3]").val(imagePath);
		$("input[name=file_path4]").val(imagePath);
		
		$("input[name=file_nm1]").val(getImage(xfluxImgPattern, date));
		$("input[name=file_nm2]").val(getImage(protonImgPattern, date));
		$("input[name=file_nm3]").val(getImage(kpImgPattern, date));
		$("input[name=file_nm4]").val(getImage(geomagImgPattern, date));
		
		
	}
	
	function getImage(pattern, date){
		var hour = $("#publishHour").val();
		
		date.setHours(hour);
		
		var year = date.getUTCFullYear();
		var month = date.getUTCMonth() + 1;
		var day = date.getUTCDate();
		var hour = date.getUTCHours();
		
		if(month < 10) month = "0" + month;
		if(day < 10) day = "0" + day;
		if(hour < 10) hour = "0" + hour;
		
		pattern = pattern.replace(/yyyy/g, year);
		pattern = pattern.replace(/mm/g, month);
		pattern = pattern.replace(/dd/g, day);
		pattern = pattern.replace(/hh/g, hour);
		
		return pattern;
	}
	
	//기상요소 인자(R,S,G,MP)
	
	
	function xRayValue(val){
		var log = Math.abs(Math.ceil(Math.log(val) / Math.log(10)));
		if(log > 0) log += 1;
		log = Math.pow(10, log);
		return (val * log).toFixed(2);
	}
	
	//일일 최대값 정보를 가져온다.
	function initDailyMaxData(){
		
		
		$.getJSON( "daily_situation_max_val.do", {
			publish_dt : $("#publish_dt").val()
			,publish_hour : $("#publishHour").val()
		}, function( data ) {
			if(data.maxValue){
				$(data.maxValue).each(function(index, element){
					var val = element.VAL;
					if(element.NM == 'XRAY'){
						$("input[name='not1_desc']").val( element.GRADE + xRayValue(val));
						$("input[name='xray_tm']").val(element.DISPLAY_DT);
					}else if(element.NM == 'PROTON'){
						/*var a = element.A;
						var flag = "";
						//if(log != 0) log = log + 1;
						if(val < 1){
							flag = "-";
							a = a + 1;
						}
						$("input[name='not2_desc']").val((val * Math.pow(10, a)).toFixed(2) + " 10 ^ " + flag + a);*/
						$("input[name='not2_desc']").val(val.toFixed(2));
						$("input[name='proton_tm']").val(element.DISPLAY_DT);
					}else if(element.NM == 'KP'){
						$("input[name='not3_desc']").val(val);
						$("input[name='kp_tm']").val(element.DISPLAY_DT);
					}else if(element.NM == 'GEOMAG'){
						$("input[name='not4_desc']").val(val.toFixed(2));
						$("input[name='geomag_tm']").val(element.DISPLAY_DT);
					}
				});
				initContent(data.maxValue);
				initWrnGradeData(data.maxValue);//특보 기상인자 요소 셋팅
			}
		});
	}
	
	
	//우주기상 특보 기상요소 셋팅
	function initWrnGradeData(data){
		
		if(!data) return;
		
		var RSGMP = []; //기상위성운영
		var RSG = []; //극항로 항공기상
		var RG = []; //전리권 기상
		
		$(data).each(function(index, element){
			
			if(element != null){
				if(element.NM == 'XRAY' || element.NM == 'PROTON' || element.NM == 'KP' || element.NM == 'GEOMAG'){
					if(element.NM == 'XRAY'){
						element.KEY = "R";
						RSG.push(element);
						RG.push(element);
					}
					if(element.NM == 'PROTON'){
						element.KEY = "S";
						RSG.push(element);
					}
					if(element.NM == 'KP'){
						element.KEY = "G";
						RSG.push(element);
						RG.push(element);
					}
					if(element.NM == 'GEOMAG'){
						element.KEY = "MP";
					}
					RSGMP.push(element);
				}
			}
		});
		
		
		if(RSGMP != null){
			//console.log(RSGMP);
			var grade = "";
			var grade2 = "";
			var key = null;
			var val = "";
			var lastIdx = 0;
			if(RSGMP.length > 0){
				RSGMP.sort(customSort); //정렬
				
				lastIdx = RSGMP.length - 1;
				grade = RSGMP[lastIdx].B;
				key = RSGMP[lastIdx].KEY;
				val = RSGMP[lastIdx].VAL;
				//if(grad >= 3){
					$("input[name='not1_type']").val( grade );
					
					if(key == 'R'){
						val = xRayValue(val);
						grade2 = RSGMP[lastIdx].GRADE;
					}else if(key == 'S' || key == 'MP'){
						val = val.toFixed(2);
					}
					
					$("input[name='not1_tar']").val( key + grade + "("+grade2 + val+")" );
				//}
			}
		}
		
		
		grade = "";
		grade2 = "";
		key = null;
		val = "";
		lastIdx = 0;
		//console.log(RSG);
		
		if(RSG != null){
			if(RSG.length > 0){
				RSG.sort(customSort);
				lastIdx = RSG.length - 1;
				grade = RSG[lastIdx].B;
				key = RSG[lastIdx].KEY;
				val = RSG[lastIdx].VAL;
				//if(grad >= 3){
					$("input[name='not2_type']").val( grade );
					
					if(key == 'R'){
						val = xRayValue(val);
						grade2 = RSG[lastIdx].GRADE;
					}else if(key == 'S' || key == 'MP'){
						val = val.toFixed(2);
					}
					
					$("input[name='not2_tar']").val( key + grade + "("+grade2 + val+")" );
				//}
			}
		}
		
		
		grade = "";
		grade2 = "";
		key = null;
		val = "";
		lastIdx = 0;
		//console.log(RG);
		if(RG != null){
			if(RG.length > 0){
				RG.sort(customSort);
				lastIdx = RG.length - 1;
				grade = RG[lastIdx].B;
				key = RG[lastIdx].KEY;
				val = RG[lastIdx].VAL;
				//if(grad >= 3){
					$("input[name='not3_type']").val( grade );
					
					
					if(key == 'R'){
						val = xRayValue(val);
						grade2 = RG[lastIdx].GRADE;
					}else if(key == 'S' || key == 'MP'){
						val = val.toFixed(2);
					}
					
					$("input[name='not3_tar']").val( key + grade + "("+grade2 + val+")" );
				//}
			}
		}
		
		initDailyWrnData();
		
	}
	
	function customSort(a, b){
		if(a.B == b.B){
			return 0;
		}
		
		return a.B > b.B ? 1 : -1;
	}
	
	//특보 정보를 가져온다.
	function initDailyWrnData(){
		$.getJSON( "daily_situation_wrn_val.do", {
			publish_dt : $("#publish_dt").val()
			,publish_hour : $("#publishHour").val()
		}, function( data ) {
			
			if(data.wrnList == null || data.wrnList.length == 0){
				initDailyWrnDataEmpty();
				return;
			}
			
			if(data.wrnList){
				$(data.wrnList).each(function(index, element){
					var flag = element.WRN_FLAG;
					//if(index == 0){
					if(flag == 'E'){
						$("input[name='not1_publish']").val(element.NOT1_PUBLISH);
						$("input[name='not2_publish']").val(element.NOT2_PUBLISH);
						$("input[name='not3_publish']").val(element.NOT3_PUBLISH);
						$("input[name='not1_finish']").val("-");
						$("input[name='not2_finish']").val("-");
						$("input[name='not3_finish']").val("-");
					}else if(flag == 'S'){
						//alert(element.NOT1_PUBLISH);
						$("input[name='not1_publish']").val(element.NOT1_PUBLISH);
						$("input[name='not2_publish']").val(element.NOT2_PUBLISH);
						$("input[name='not3_publish']").val(element.NOT3_PUBLISH);
						$("input[name='not1_finish']").val(element.NOT1_FINISH);
						$("input[name='not2_finish']").val(element.NOT2_FINISH);
						$("input[name='not3_finish']").val(element.NOT3_FINISH);
					}
				});
				//initContent(data.maxValue);
			}
		});
	}
	
	function initDailyWrnDataEmpty(){
		$("input[name='not1_type']").val('-');
		$("input[name='not2_type']").val('-');
		$("input[name='not3_type']").val('-');
		$("input[name='not1_publish']").val('-');
		$("input[name='not2_publish']").val('-');
		$("input[name='not3_publish']").val('-');
		$("input[name='not1_finish']").val('-');
		$("input[name='not2_finish']").val('-');
		$("input[name='not3_finish']").val('-');
		$("input[name='not1_tar']").val('-');
		$("input[name='not2_tar']").val('-');
		$("input[name='not3_tar']").val('-');
	}
	
	function initReceiveData(){
		$("input[name='info1']").val('-');
		$("input[name='info2']").val('-');
		$("input[name='info3']").val('-');
		$("input[name='info4']").val('-');
	}
	
	function initEtc(){
		$("textarea[name='rmk2']").val('없음');
	}
	
	function getHour(dt){
		var date = dt;
		if(date == null) date = new Date();
		var hour = date.getHours();
		if(hour < 10) return '0' + hour;
		return hour;
	}
	
</script>
</body>
</html>