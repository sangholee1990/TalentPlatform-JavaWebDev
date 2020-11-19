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
	
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">등급별 발현 횟수</h4>
			<!-- content area start -->

			<nav class="navbar navbar-default" role="navigation">
				<div class="collapse navbar-collapse navbar-ex1-collapse text-right">
			    	<form class="navbar-form navbar-right" role="search" action="grade_list.do" method="post" name="listForm" id="listForm">
				      	<div class="form-group">
				        	시작일 : <input type="text" name="startDate" id="startDate" class="form-control input-sm" placeholder="검색시작일" value="${ params.startDate }" >
				      	</div>~
				      	<div class="form-group">
				        	종료일 : <input type="text" name="endDate" id="endDate" class="form-control input-sm" placeholder="검색종료일" value="${ params.endDate }">
				      	</div>
				     	<button type="button" id="currentMonthBtn" class="btn btn-primary btn-sm">현재월</button>
				     	<button type="button" id="prevMonthBtn" class="btn btn-primary btn-sm">이전월</button>
				     	<button type="button" id="nextMonthBtn" class="btn btn-primary btn-sm">다음월</button>
				     	<button type="button" id="searchBtn" class="btn btn-primary btn-sm">검색</button>
			    	</form>
			  	</div>
			</nav>
			
			
			<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
			<br/>
	        <table class="table table-striped">
	        	<thead>
	            	<tr>
	                	<th>기상요소</th>
	                	<th>1등급</th>
	                    <th>2등급</th>
	                    <th>3등급</th>
	                    <th>4등급</th>
	                    <th>5등급</th>
	                </tr>
	            </thead>
				<c:forEach var="o" items="${list}" varStatus="status">            
	            <tr>
	            	<td>${o.TYPE_NM}</td>
	            	<td>${o.COLUMN1}</td>
	            	<td>${o.COLUMN2}</td>
	            	<td>${o.COLUMN3}</td>
	            	<td>${o.COLUMN4}</td>
	            	<td>${o.COLUMN5}</td>
	            </tr>
	            </c:forEach>
	            <c:forEach var="x" items="${xra}" varStatus="status">            
	            <tr>
	            	<td>${x.TYPE_NM}</td>
	            	<td>${x.COLUMN1}</td>
	            	<td>${x.COLUMN2}</td>
	            	<td>${x.COLUMN3}</td>
	            	<td>${x.COLUMN4}</td>
	            	<td>${x.COLUMN5}</td>
	            </tr>
	            </c:forEach>
	            <c:if test="${empty list && empty xra}">
	            <tr>
	            	<td colspan="6">등록된 컨텐츠가 존재하지 않습니다.</td>
	            </tr>
	            </c:if>
	        </table>
			<!-- content area end -->
			
			 <!-- footer start -->
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		    <!-- footer end -->
		</div>		
	</div>
		
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script src="<c:url value="/resources/Highcharts-4.0.1/js/highcharts.js"/>"></script>
<script src="<c:url value="/resources/Highcharts-4.0.1/js/modules/exporting.js"/>"></script>
<script type="text/javascript">
var dayNames = ['일', '월', '화', '수', '목', '금', '토'];
var monthNames = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
var datepickerOption = {
		hangeYear : true,
		showOn : "button",
		dayNames: dayNames,
		dayNamesMin: dayNames,
		dayNamesShort: dayNames,
		monthNames : monthNames,
		monthNamesShort : monthNames,
		buttonImage : '<c:url value="/images/btn_calendar.png"/>',
		buttonImageOnly : true,
		dateFormat: "yymmdd"
};
	
$(function(){
	$("#startDate").datepicker(datepickerOption);
	$("#endDate").datepicker(datepickerOption);
	
	$('#searchBtn').on('click', function(){
		search();
	});
	
	$('#currentMonthBtn').on('click', function(){
		monthSelector('current');
		search();
	});
	
	$('#nextMonthBtn').on('click', function(){
		monthSelector('next');
		search();
	});
	$('#prevMonthBtn').on('click', function(){
		monthSelector('prev');
		search();
	});
	
	
	chartDraw();
});	


function chartDraw(){
	$('#container').highcharts({
        chart: {
            type: 'column'
        },
        credits : {
        	enabled : false
        },
        title: {
            text: ''
        },
        subtitle: {
            text: '기상요소 등급별 발현 횟수'
        },
        exporting: {
        	enabled : false
        },
        xAxis: {
            categories: [
                '1등급',
                '2등급',
                '3등급',
                '4등급',
                '5등급'
            ]
        },
        yAxis: {
            min: 0,
            title: {
                text: '횟수'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                		 '<td style="padding:0"><b>{point.y}</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [
		<c:forEach var="o" items="${list}" varStatus="status">
	        {
	            name: '${o.TYPE_NM}',
	            data: [${o.COLUMN1}, ${o.COLUMN2}, ${o.COLUMN3}, ${o.COLUMN4}, ${o.COLUMN5}]
	        }
	        <c:if test="${ !status.last }">,</c:if>
		</c:forEach>
		<c:forEach var="x" items="${xra}" varStatus="status">
			<c:if test="${ status.first }">,</c:if>
         	{
         		name: '${x.TYPE_NM}',
         		data: [${x.COLUMN1},${x.COLUMN2},${x.COLUMN3},${x.COLUMN4},${x.COLUMN5}]
         	}
	        <c:if test="${ !status.last }">,</c:if>
        </c:forEach>
       ]
    });
	
}


function monthSelector(flag){
	
	
	//var date = $("#endDate").datepicker('getDate');
	//alert($.datepicker.formatDate('yymmdd', date));
	var endDate = $("#endDate").val();
	var year = parseInt( endDate.substring(0, 4) );
	var mm = parseInt(endDate.substring(4, 6) );
	var dd = 1;
	
	mm = mm - 1;
	
	//alert(year + "" + mm + "" + dd);
	
	var date = new Date(year, mm, dd);
	//date = $.datepicker.parseDate('yymmdd', $("#endDate").val());
	//alert(date);
	if(flag == 'next'){
		//alert(date.getMonth());
		date.setMonth(date.getMonth() + 1);
	}else if(flag == 'prev'){
		date.setMonth(date.getMonth() - 1);
	}else{
		date = new Date();
	}
	//var lastDayOfMonth = new Date(date.getFullYear(), date.getMonth(), 0);
	
	//alert(date.getFullYear() + "" + (date.getMonth() + 1) + date.getDate());
	//alert(lastDayOfMonth);
	
	//console.log(date.getFullYear() + "" + (date.getMonth() + 1) + date.getDate());
	
	var sDate = new Date(date.getFullYear(), date.getMonth(), 1);
	var eDate = new Date(date.getFullYear(), date.getMonth(), daysIsMonth(date.getFullYear(), date.getMonth()));
	
	
	//alert(daysIsMonth(date.getFullYear(), date.getMonth()));
	
	$("#startDate").val($.datepicker.formatDate('yymmdd', sDate));
	$("#endDate").val($.datepicker.formatDate('yymmdd', eDate));
	
	//$("#startDate").datepicker( 'setDate',   sDate);
	//$("#endDate").datepicker( 'setDate',lastDayOfMonth );
	
	
	//$("#endDate").datepicker( 'setDate',$.datepicker.formatDate('yymmdd', lastDayOfMonth) );
	
	
	//alert($.datepicker.formatDate('yymmdd', sDate));
	
	search();
}

function daysIsMonth(year, month){
	return 32 - new Date(year, month, 32).getDate();
}
function search(){
	$('#listForm').submit();
}
</script>
</body>
</html>