<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%
Calendar calendar = java.util.Calendar.getInstance(TimeZone.getTimeZone("UTC"));
Date now = calendar.getTime();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 우주기상인트라넷</title>
<link rel="stylesheet" type="text/css" href="../css/default.css"  />
<style>
	.hide{width:0;height:0;margin:0;padding:0;font-size:0;line-height:0;visibility:hidden;overflow:hidden}
	.none{display: none;}
	#type{padding:0;background: #EBEFF4;color: #444;text-align: center;font-weight: bold;}
</style>
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<script type="text/javascript">
var selectType;
var change = false;
	$(function(){
		var datepickerOption = {
			changeYear : true,
			showOn : "button",
			buttonImage : '../images/btn_calendar.png',
			buttonImageOnly : true,
			onSelect:function(){
				change = true;
			}			
		};
		$("#sd").datepicker(datepickerOption);
		
		$(".btnsearch").on("click",function(e){
			if(change){
				search();		
			}
			e.preventDefault();
		});
		search();
		
		//타입 선택
		$("#type").on("change",function(e){
			var select = $(this).val();
			selectType = select;
			$("tr.none").removeClass();
			if(selectType != ""){
				sortChangeType();
			}
			select=null;
			e.preventDefault();
		});
	});
	
	//타입 변경 정보 보이기
	function sortChangeType(){
		$.each($(".report_list tbody .type"), function(index){
			if(selectType != $(this).text()){
				$(this).parent().addClass("none");
			}
		});
	}
	
	//파일 검색
	function search() {
		$.ajax({
			url:"search_event_report.do",
			dataType:"json",
			method:"post",
			data : {"searchDate" : $.datepicker.formatDate("yymmdd", $("#sd").datepicker('getDate'))},
			success:function(data){
				change = false;
				$("tbody").empty();
				$("#type option:not(.default)").remove();
				if(data != null && data.searchList.length > 0 ){
					$.each(data.searchList ,function(key, val){
						var tr = $("<tr>");
						$("<td>").text(val.eventTime + val.eventSign).appendTo(tr);
						$("<td>").text(val.beginCode + val.beginTime).appendTo(tr);
						$("<td>").text(val.maxCode + val.maxTime).appendTo(tr);
						$("<td>").text(val.endCode + val.endTime).appendTo(tr);
						$("<td>").text(val.observatory).appendTo(tr);
						$("<td>").text(val.quality).appendTo(tr);
						$("<td class='type'>").text(val.type).appendTo(tr);
						$("<td>").text(val.locOrfrq).appendTo(tr);
						$("<td>").text(val.particulars).appendTo(tr);
						$("<td>").text(val.particularsEtc).appendTo(tr);
						$("<td>").text(val.regTime).appendTo(tr);
						tr.appendTo("tbody");
						tr=null;
					});
					var typeSet = false;
					$.each(data.searchType, function(key, val){
						var type = val["TYPE"];
						var option = $("<option>").val(type).text(type);
						if(selectType == type){
							option.attr("selected","selected");
							sortChangeType();
							type=true;
						}
						$("#type").append(option);
						type=null;option=null;
					});
					if(!typeSet){
						selectType = "";
					}
					typeSet=null;
				}else{
					$("tbody").append($("<tr><td colspan='11'>등록된 정보가 없습니다.</td></tr>"));
				}
			},
			error:function(xhr, error){
				console.log(error);
			}
		});
	}
</script>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->

<div id="contents">
	<h2>태양 이벤트 보고서</h2>
		<!-- SEARCH -->
    <div class="search_wrap">
        <div class="search">
            <label for="sd" class="type_tit sun">검색(UTC)</label>
            <c:set scope="page" var="startDate" value="<%=now%>"/>
			<input type="text" size="12" id="sd" value="<fmt:formatDate type="date" value="${startDate}" pattern="yyyy-MM-dd" timeZone="UTC"/>"/>    
            <div class="searchbtns">           
                <input type="button" title="검색" value="검색" class="btnsearch" />
            </div>               
        </div>
    </div>
    <div class="report_list">
        <table>
        	<colgroup>
        		<col width="6%"/>
        		<col width="8%"/>
        		<col width="8%"/>
        		<col width="8%"/>
        		<col width="6%"/>
        		<col width="6%"/>
        		<col width="18%"/>
        		<col width="11%"/>
        		<col width="11%"/>
        		<col width="10%"/>
        		<col width="8%"/>
        	</colgroup>
        	<thead>
            	<tr>
            		<th>번호</th>
                	<th>시작 시간</th>
                    <th>최대 시간</th>
                    <th>종료 시간</th>
                    <th>관측지</th>
                    <th>품질</th>
                    <th> 
                    	<label for="type">보고서 종류 </label>
		            	<select id="type">
		            		<option value="" class="default">All</option>
		            	</select>    
            		</th>
                    <th>위치/주파수</th>
                    <th colspan="2">상세</th>
                    <th>태양 지역</th>
                </tr>
            </thead>
            <tbody>
            	<tr><td colspan="11">등록된 정보가 없습니다.</td></tr>
            </tbody>
        </table>
    </div>
</div>
 * http://www.swpc.noaa.gov/ftpmenu/indices/events.html
<!-- END CONTENTS -->

<jsp:include page="../footer.jsp" />

</body>
</html>