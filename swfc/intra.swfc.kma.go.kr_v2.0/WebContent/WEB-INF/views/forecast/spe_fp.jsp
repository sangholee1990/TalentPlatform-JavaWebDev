<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 우주기상인트라넷</title>
<link rel="stylesheet" type="text/css" href="../css/default.css"  />
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<jsp:include page="../include/dygraph.jsp" />
<script type="text/javascript" src="<c:url value="/js/date.format.js"/>"></script>
<script type="text/javascript">
	function search() {
		var startDate = $("#sd").datepicker('getDate');
		var endDate = $("#ed").datepicker('getDate');

		var sd = $.datepicker.formatDate("yymmdd", startDate) + $("#sh").val() + "0000";
		var ed = $.datepicker.formatDate("yymmdd", endDate) + $("#eh").val() + "0000";
		
		var dataString = "sd=" + sd + "&ed=" + ed;
		$.ajax({
			url: "searchSPE.do",
			data: dataString,
			dataType: "json"
		}).success(function(data) {
			$("#speTable tbody").empty();
			var tableString = "";
			if(data.spe.length == 0) {
				tableString += "<tr><td colspan='7'>검색 결과가 없습니다.</td></tr>";
			} else {
				$.each(data.spe, function(index, line) {
					tableString += "<tr><td>" + line.spot + "</td><td>" + line.position + "</td><td>" + line.gcls + "</td><td>" + new Date(line.peak_date).format("yyyy/mm/dd HH:MM:ss") + "</td><td>" + line.probab + "</td><td>" + line.pkflux + "</td><td>" + (line.arr_date != null?new Date(line.arr_date).format("yyyy/mm/dd HH:MM:ss"):"") + "</td></tr>"; 
				});
			}
			$("#speTable tbody").append(tableString);
			
			$("#flareTables").empty();
			if(data.flare.length == 0) {
				var flareTable = '<table><thead><tr><th><h3>태양 플레어</h3></th></tr></thead><tbody><tr><td>검색 결과가 없습니다.</td></tr></tbody></table>';
				$("#flareTables").append(flareTable);
			} else {
				$.each(data.flare, function(index, flare) {
					var flareDate = new Date(flare.create_date).format("yyyy/mm/dd HH:MM:ss");
					var searchDt = new Date(flare.create_date).format("yyyy/mm/ddHH:MM:ss");
					var rowspan = flare.details.length + 1;
					var flareTable = 
						'<table>' +
						//'	<thead>'+
						' 		<tr><th colspan="7" style="text-align:center;"<h3>태양 플레어<br/>(' + flareDate + ')</h3></th></tr>' +
						'		<tr><th style="text-align:center;">태양영상</th><th style="text-align:center;">흑점군 분류</th><th style="text-align:center;">흑점번호</th><th style="text-align:center;">흑점 크기변화</th><th style="text-align:center;">C급 발생확률</th><th style="text-align:center;">M급 발생확률</th><th style="text-align:center;">X급 발생확률</th></tr>' +
						'		<tr><th width="200" rowspan="'+rowspan +'"><img class="flareImage" width="180" name="'+searchDt+'" onclick="imagePopup(this)" style="cursor:pointer;"/></th><th colspan="3" style="text-align:center;">총 발생확률</th><td>' + Math.round(flare.total_c*10000)/100 + '%</td><td>' + Math.round(flare.total_m*10000)/100 + '%</td><td>' + Math.round(flare.total_x*10000)/100 + '%</td></tr>' +
						//'	</thead>' +
						//'<tbody>';
						'';
					$.each(flare.details, function(detail_idx, detail) {
						flareTable += '<tr><td>' + detail.cls + '</td><td>' + detail.ar + '</td><td>' + detail.phase + '</td><td>' + Math.round(detail.c*10000)/100 + '</td><td>' + Math.round(detail.m*10000)/100 + '</td><td>' + Math.round(detail.x*10000)/100 + '</td></tr>'; 
					});
					//flareTable += '</tbody></table>';
					flareTable += '</table>';
					$("#flareTables").append(flareTable);
				});
			}
			
			setTimeout(flareImageLoad, 1000);
			//flareImageLoad();
			
		}).error(function() {
				alert("error");
		});						
	}

	$(function() {
		var datepickerOption = {
			changeYear : true,
			showOn : "button",
			buttonImage : '../images/btn_calendar.png',
			buttonImageOnly : true
		};
		$("#sd").datepicker(datepickerOption);
		$("#ed").datepicker(datepickerOption);

		$("#contents .search_wrap :button").click(function(ev) {
			var day = parseInt($(this).val());
			if(!isNaN(day)) {
				var newDate = new Date();
				newDate.setDate($("#ed").datepicker("getDate").getDate() - day);
				$("#sd").datepicker("setDate", newDate);
				$("#sh").val($("#eh").val());
			}
			search();
			return false;
		});
		
		search();
	});
	
	function imagePopup(obj){
		var url = "spe_image_popup.do?tm=" + obj.name;
		window.open(url, '_blank','width=800,height=800,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
	}
	
	function flareImageLoad(){
		$("#flareTables").find("img").each(function(element){
			//element.src = "getSpeImage.do?tm=" + element.name;
			var obj = this;
			setTimeout(function(){
				imageload(obj);
			}, 300);
		});
	}
	
	function imageload(ele){
		ele.src = "getSpeImage.do?tm=" + ele.name + "&dummy=" + new Date().getMilliseconds();
		ele.setAttribute("loadCnt", "0");
		ele.onerror = function(e){
			var _loadCnt = ele.getAttribute("loadCnt");
			if(_loadCnt == '0'){
				ele.src = "getSpeImage.do?tm=" + ele.name + "&dummy=" + new Date().getMilliseconds();
				ele.setAttribute("loadCnt", "1");
			}
		}
	}
</script>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->

<div id="contents">
    <h2>태양 양성자, 태양 플레어</h2>
    <!-- SEARCH -->
    <div class="search_wrap">
        <div class="search">
            <label class="type_tit sun">검색(UTC)</label>
            <custom:DateTimeRangeSelector/>                  
            <span class="mg">
                <input type="button" title="1일" value="1일" class="btn" />
                <input type="button" title="2일" value="2일" class="btn" />
                <input type="button" title="3일" value="3일" class="btn" />
                <input type="button" title="7일" value="7일" class="btn" />
            </span>
            
            <div class="searchbtns">           
                <input type="button" title="검색" value="검색" class="btnsearch" />
            </div>               
        </div>
    </div>

    <div class="hour">
    	<h6>태양 양성자</h6>
    </div>	    

    <div class="board_list">
	    <table id="speTable">
	    	<thead>
	    		<tr>
			    	<th>흑점번호</th>
			    	<th>위치</th>
			    	<th>플레어 등급</th>
			    	<th>플레어 최대등급 시각</th>
			    	<th>양성자 발생확률</th>
			    	<th>양성자 최대 플럭스</th>
			    	<th>양성자 현상 도달 예측시각</th>
		    	</tr>
	    	</thead>
	    	<tbody>
	    	</tbody>
	    </table>
    </div>
    
    <div class="hour">
    	<h6>태양 플레어</h6>
    </div>
    <div class="board_list" id="flareTables"></div>
</div>
<!-- END CONTENTS -->

<jsp:include page="../footer.jsp" />

</body>
</html>
