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
<link rel="stylesheet" type="text/css" href="../css/jquery.bxslider.css"  />
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<!--[if lt IE 9]>
<script src="<c:url value="/js/html5shiv.js"/>"></script>
<![endif]-->
<script type="text/javascript" src="<c:url value="/js/jquery.paging.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.bxslider.min.js"/>"></script>
<script type="text/javascript">
var bxslider_SDO__01001;
var bxslider_SDO__01002;
var bxslider_SDO__01003;
var bxslider_SDO__01004;
var bxslider_SDO__01005;
var bxslider_SDO__01006;
var bxslider_SOHO_01001;
var bxslider_SOHO_01002;
var bxslider_STEREO_A;
var bxslider_STEREO_B;

var viewMode = "list";
var checkedList = new Array();

$(function() {
	var datepickerOption = {
			changeYear:true,
			showOn: "button",
			buttonImage: '../images/btn_calendar.png', 
			buttonImageOnly: true
	};
	$("#sd").datepicker(datepickerOption);
	$("#ed").datepicker(datepickerOption);
	
	$("#contents .search_wrap :button").click(function(ev) {
		var hour = parseInt($(this).val());
		if(!isNaN(hour)) {
			var newDate = new Date();
			var startHour = parseInt($("#eh").val(), 10) - hour + 1;
			if(startHour >= 0) {
				newDate.setDate($("#ed").datepicker("getDate").getDate());
				$("#sd").datepicker("setDate", newDate);
				$("#sh").val(pad(startHour));
			} else {
				newDate.setDate($("#ed").datepicker("getDate").getDate() - 1);
				$("#sd").datepicker("setDate", newDate);
				$("#sh").val(pad(24 + startHour));
			}
		}
		search();
		return false;
	});
	
	
	$("#search_result").on("click", "input:checkbox", function(e) {
		var checkedList = $("#search_result input:checked");
		if(checkedList.length > 1) {
			e.preventDefault();
			var item1 = checkedList.filter(":first").val();
			var item2 =  checkedList.filter(":last").val();
			window.open('view_compare.do?id=' + item1 + "&id2=" + item2, '_blank','width=1024,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
		}
	});
	
	$('#search_result').on('click', '.imgbtn', function() {
		var id = $(this).attr("id");
		viewPopup(id);
		e.preventDefault();
	});
	
	
	var bxSliderParam = {
			infiniteLoop: false,
			pager: true,
			controls: false,
			maxSlides: 100,
			slideMargin: 2,
			slideWidth:160
	};
	bxslider_SDO__01001 = $("#bxslider_SDO__01001").bxSlider(bxSliderParam);
	bxslider_SDO__01002 = $("#bxslider_SDO__01002").bxSlider(bxSliderParam);
	bxslider_SDO__01003 = $("#bxslider_SDO__01003").bxSlider(bxSliderParam);
	bxslider_SDO__01004 = $("#bxslider_SDO__01004").bxSlider(bxSliderParam);
	bxslider_SDO__01005 = $("#bxslider_SDO__01005").bxSlider(bxSliderParam);
	bxslider_SDO__01006 = $("#bxslider_SDO__01006").bxSlider(bxSliderParam);
	bxslider_SOHO_01001 = $("#bxslider_SOHO_01001").bxSlider(bxSliderParam);
	bxslider_SOHO_01002 = $("#bxslider_SOHO_01002").bxSlider(bxSliderParam);
	bxslider_STEREO_A = $("#bxslider_STEREO_A").bxSlider(bxSliderParam);
	bxslider_STEREO_B = $("#bxslider_STEREO_B").bxSlider(bxSliderParam);
	
	search();
});

function viewPopup(metaId) {
	var win = window.open('view_popup.do?id=' + metaId, '_blank','width=1024,height=1150,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
	win.focus();
}

function pad(val, len) {
	var valString = String(val);
	len = len || 2;
	while (valString.length < len) valString = "0" + valString;
	return valString;
};

function search() {
	var startDate = $("#sd").datepicker('getDate');
	var endDate = $("#ed").datepicker('getDate');
	var sd = $.datepicker.formatDate("yymmdd", startDate) + $("#sh").val() + "0000";
	var ed = $.datepicker.formatDate("yymmdd", endDate) + $("#eh").val() + "0000";
	var dataString = "sd=" + sd + "&ed=" + ed;
	$.ajax({
		url: "search.do",
		data: dataString,
		dataType: "json"
		}).success(function(data) {
			var bxslider_SDO__01001_html = '';
			var bxslider_SDO__01002_html = '';
			var bxslider_SDO__01003_html = '';
			var bxslider_SDO__01004_html = '';
			var bxslider_SDO__01005_html = '';
			var bxslider_SDO__01006_html = '';
			var bxslider_SOHO_01001_html = '';
			var bxslider_SOHO_01002_html = '';
			var bxslider_STEREO_A_html = '';
			var bxslider_STEREO_B_html = '';
			
			$.each(data, function(key, val) {
				var createDate = new Date(val.createDate);
				var title = createDate.getFullYear() + "-" + (pad(createDate.getMonth() + 1, 2)) + "-" + pad(createDate.getDate(), 2) + " " + pad(createDate.getHours(), 2) + ":" + pad(createDate.getMinutes(), 2) + ":" + pad(createDate.getSeconds(), 2);
				var html = '<li><label><input type="checkbox" value="'+val.id+'"/>' + title + '</label><img id="' + val.id + '" src="view_image.do?c=' + val.code + '&ft=1&f=' + val.filePath + '" class="imgbtn" width="160" height="160" title="' + title + '"/></li>';
				switch(val.code) {
				case "SDO__01001":
					bxslider_SDO__01001_html += html;
					break;
				case "SDO__01002":
					bxslider_SDO__01002_html += html;
					break;
				case "SDO__01003":
					bxslider_SDO__01003_html += html;
					break;
				case "SDO__01004":
					bxslider_SDO__01004_html += html;
					break;
				case "SDO__01005":
					bxslider_SDO__01005_html += html;
					break;
				case "SDO__01006":
					bxslider_SDO__01006_html += html;
					break;
				case "SOHO_01001":
					bxslider_SOHO_01001_html += html;
					break;
				case "SOHO_01002":
					bxslider_SOHO_01002_html += html;
					break;
				case "STA__01001":
				case "STA__01002":
					bxslider_STEREO_A_html += html;
					break;
				case "STB__01001":
				case "STB__01002":
					bxslider_STEREO_B_html += html;
					break;
				}
			});
			$('#bxslider_SDO__01001').empty().append(bxslider_SDO__01001_html);
			$('#bxslider_SDO__01002').empty().append(bxslider_SDO__01002_html);
			$('#bxslider_SDO__01003').empty().append(bxslider_SDO__01003_html);
			$('#bxslider_SDO__01004').empty().append(bxslider_SDO__01004_html);
			$('#bxslider_SDO__01005').empty().append(bxslider_SDO__01005_html);
			$('#bxslider_SDO__01006').empty().append(bxslider_SDO__01006_html);
			$('#bxslider_SOHO_01001').empty().append(bxslider_SOHO_01001_html);
			$('#bxslider_SOHO_01002').empty().append(bxslider_SOHO_01002_html);
			$('#bxslider_STEREO_A').empty().append(bxslider_STEREO_A_html);
			$('#bxslider_STEREO_B').empty().append(bxslider_STEREO_B_html);
			
			bxslider_SDO__01001.reloadSlider();
			bxslider_SDO__01002.reloadSlider();
			bxslider_SDO__01003.reloadSlider();
			bxslider_SDO__01004.reloadSlider();
			bxslider_SDO__01005.reloadSlider();
			bxslider_SDO__01006.reloadSlider();
			bxslider_SOHO_01001.reloadSlider();
			bxslider_SOHO_01002.reloadSlider();
			bxslider_STEREO_A.reloadSlider();
			
			bxslider_STEREO_B.destroySlider();
			bxslider_STEREO_B.reloadSlider();
			/*
			var html = "";
			$.each(data, function(time, val) {
				html += "<tr>";
				html += "<th>" + time + "</th>";
				var columnInfos = new Array(10);
				$.each(val, function(typeId, val2) {
					
					var columnIndex = 0;
					switch(typeId) {
						case "SDO__01001": columnIndex = 0; break;
						case "SDO__01002": columnIndex = 1; break;
						case "SDO__01003": columnIndex = 2; break;
						case "SDO__01004": columnIndex = 3; break;
						case "SDO__01005": columnIndex = 4; break;
						case "SDO__01006": columnIndex = 5; break;
						case "SOHO_01001": columnIndex = 6; break;
						case "STA__01001": 
						case "STA__01002":
							columnIndex = 8; 
							break;
						case "STB__01001": 
						case "STB__01002":
							columnIndex = 9; 
							break;
					}
					var columnData = ''; 
					
					$.each(val2,function(index, metaInfo){
						var minute =  parseInt(((metaInfo.createDate/1000) % (60*60))/ (60));
						if(index > 0)
							columnData += '<br/>';
						columnData += '<a href="#" alt="' + metaInfo.id +'">' + minute + '분' + '</a>';
						columnData += '<input name="chkMeta" type="checkbox" value="' + metaInfo.id + '" ' + ((checkedList[metaInfo.id] == true)?'checked="checked"':'') + ' />';
						columnData += '<img src="view_image.do?c=' + metaInfo.code + '&ft=1&f=' + metaInfo.filePath + '" class="imgbtn" alt="' + metaInfo.id +'" ' + ((viewMode != "image")?'style="display:none;"':'') +'/>';
					});
					columnInfos[columnIndex] = columnData;
				});
				html += "<td>" + columnInfos.join("</td><td>") + "</td>";
				html += "</tr>";
			});
			$("#search_result").html(html);
				*/
		}).error(function(request, status, error) {
	        alert(request.responseText);
		});
}
</script>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->

<div id="contents">
    <h2>태양영상</h2>    
    <!-- SEARCH -->
    <div class="search_wrap">    
        <div class="search">
            <label class="type_tit sun">검색(UTC)</label>
			<custom:DateTimeRangeSelector offset="1"/>
            <span class="mg">
                <input type="button" title="1시간" value="1시간" class="btn" />
                <input type="button" title="3시간" value="3시간" class="btn" />
                <input type="button" title="6시간" value="6시간" class="btn" />
                <input type="button" title="12시간" value="12시간" class="btn" />
                <input type="button" title="24시간" value="24시간" class="btn" />
            </span>
            
            <div class="searchbtns">           
                <input type="button" title="검색" value="검색" class="btnsearch" />
            </div>               
        </div>
    </div>
    
    <div class="board_list">
    	<table>
        	<thead>
            	<tr>
                	<th class="min" style="width:80px;">영상 종류</th>
                	<th>영상 리스트</th>
                </tr>
           	</thead>
           	<tbody id="search_result">
                <tr>
                	<th><img src="<custom:MetaImageIconConverter value="SDO__01001"/>" /></th>
                	<td><ul id="bxslider_SDO__01001"></ul></td>
                </tr>
                <tr>
                	<th><img src="<custom:MetaImageIconConverter value="SDO__01002"/>" /></th>
                	<td><ul id="bxslider_SDO__01002"></ul></td>
                </tr>
                <tr>
                	<th><img src="<custom:MetaImageIconConverter value="SDO__01003"/>" /></th>
                	<td><ul id="bxslider_SDO__01003"></ul></td>
                </tr>
                <tr>
                	<th><img src="<custom:MetaImageIconConverter value="SDO__01004"/>" /></th>
                	<td><ul id="bxslider_SDO__01004"></ul></td>
                </tr>
                <tr>
                	<th><img src="<custom:MetaImageIconConverter value="SDO__01005"/>" /></th>
                	<td><ul id="bxslider_SDO__01005"></ul></td>
                </tr>
                <tr>
                	<th><img src="<custom:MetaImageIconConverter value="SDO__01006"/>" /></th>
                	<td><ul id="bxslider_SDO__01006"></ul></td>
                </tr>
                <tr>
                	<th><img src="<custom:MetaImageIconConverter value="SOHO_01001"/>" /></th>
                	<td><ul id="bxslider_SOHO_01001"></ul></td>
                </tr>
                <tr>
                	<th><img src="<custom:MetaImageIconConverter value="SOHO_01002"/>" /></th>
                	<td><ul id="bxslider_SOHO_01002"></ul></td>
                </tr>
                <tr>
                	<th><img src="<custom:MetaImageIconConverter value="STA_01001"/>" /></th>
                	<td><ul id="bxslider_STEREO_A"></ul></td>
                </tr>
                <tr>
                	<th><img src="<custom:MetaImageIconConverter value="STB_01001"/>" /></th>
                	<td style="text-align:left"><ul id="bxslider_STEREO_B"></ul></td>
                </tr>
            </tbody>
        </table>
	</div>      
</div>
<!-- END CONTENTS -->

<jsp:include page="../footer.jsp" />

</body>
</html>
