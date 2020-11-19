<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%
Calendar calendar = java.util.Calendar.getInstance(TimeZone.getTimeZone("UTC"));
Date now = calendar.getTime();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><spring:message code="title"/></title>
<link rel="stylesheet" type="text/css" href="../css/default.css"  />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/perfect-scrollbar.css"/>"/>
<link href="<c:url value="/resources/jquery.fileTree-1.01/jqueryFileTree.css"/>" rel="stylesheet" type="text/css" media="screen" />
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<jsp:include page="../include/dygraph.jsp" />
</head>
<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->
<div id="contents">
    <div>
    	<h2>STOA &amp; CME 모델 분석 표출</h2>
    	
    	<div class="search_wrap">    
	        <div class="search">
	       	 	<!--  button class="reset">UnZoom</button -->
	        	<button class="hideName btnsearch an">라벨 숨기기</button><!-- 
	         --><button class="layerBtn btnsearch fp" data-type="stoa">파일 추가</button>     
	        <!-- button class="layerBtn btnsearch fp" data-type="cme">CME 모델 추가</button -->          
	         <!--button class="btnimg model"><span class="hide">이미지</span></button-->
	        </div>
	    </div>
    	<div class="graphBox">
	    	<div id="graphs" style="width:100%"></div>
    	</div>
    	<div class="fileBox">
    		<h4>추가된 파일</h4>
    		<ul class="addFiles"></ul>
	    	
    	</div>
    	<div class="layer">
	    	<div class="fileBox">
	    		<p class="title">파일 추가</p>
	    		<div class="fileList">
	    			<h4>CME</h4>
	    			<div class="scroll">
		    			<div id="fileTree" class=""></div>
		    		</div>
		    	</div>
		    	<div class="fileList">
		    		<h4>STOA</h4>
		    		<div class="scroll">
		    			<div id="fileTree2" class=""></div>
		    		</div>
		    	</div>
		    	<p class="btnBox"><button class="cancel btnsearch an">닫기</button></p>
		    	<div class="popup"></div>
	    	</div>
	    	<div class="setDate">
	    		<p class="selectName"></p>
	            <label for="sd" class="type_tit sun">시작시간 : </label>
	            <c:set scope="page" var="startDate" value="<%=now%>"/>
				<input type="text" size="12" id="sd" value="<fmt:formatDate type="date" value="${startDate}" pattern="yyyy-MM-dd" timeZone="UTC"/>"/>    
	           	<input id="spinHour" name="spinHour" value="0" class="spinner"/>시 
	           	<input id="spinMin" name="spinMin" value="0" class="spinner"/>분 
	           	<input id="spinSec" name="spinSec" value="0" class="spinner"/>초
	            <div class="searchbtns">           
	                <button class="btnsearch selectDate">선택</button>
	            </div>               
	        </div>
    	</div>
    </div>
    <!-- END PAGER -->
</div>
<!-- END CONTENTS -->
<form action="imageExport.do" method="post" class="forms" enctype="application/x-www-form-urlencoded">
  <input type="hidden" value="" name="data" class="data"/>
</form>

<jsp:include page="../footer.jsp" />
<script type="text/javascript" src="<c:url value="/js/date.format.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/dygraph-extra.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/dygraph-model.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.mousewheel.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/perfect-scrollbar.js"/>"></script>
<script src="<c:url value="/resources/jquery.fileTree-1.01/jqueryFileTree.js"/>"></script>
<script src="<c:url value="/resources/jquery.fileTree-1.01/jquery.easing.js"/>"></script>
<script>
	var graph;
	var dateRange = 1000*60*60*24*30;
   	$(function(){
   		
   		$("#spinHour").spinner({
   			min:0,
   			max:23,
   			step:1,
   			start:0,
   			numberFormat:"C"
   		});
   		$("#spinMin").spinner({
   			min:0,
   			max:59,
   			step:1,
   			start:0
   		});
   		$("#spinSec").spinner({
   			min:0,
   			max:59,
   			step:1,
   			start:0
   		});
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
   		
		//File Tree
   		$('#fileTree').fileTree({ root: '/data/home/gnss/CME_Analysis/model_export', script: '<c:url value="/reportdata/jqueryFileTree.do"/>', folderEvent: 'click', multiFolder:false, expandSpeed: 100, collapseSpeed: 100 }, function(path) { 
   			addFile(path);	//파일 추가 이벤트
		});
   		$('#fileTree2').fileTree({ root: '/data/home/gnss/KASI_STOA/stoa2-web/data/txt', script: '<c:url value="/reportdata/jqueryFileTree.do"/>', folderEvent: 'click', multiFolder:false, expandSpeed: 100, collapseSpeed: 100 }, function(path) { 
   			addFile(path);	//파일 추가 이벤트
		});
   		
		//Scroll
   		$(".scroll, .scroll").perfectScrollbar();
   		
   		graph = new Dygraph(	//그래프 생성
			    document.getElementById("graphs"),	//DOM
			    [[[new Date(), new Date(), null], null,null ]],	//DATA
   			    {
   			   		labels:["DATE","STOA","CME"],	//라벨
		    		colors:["#DC2389","#3170f7"],	//색상
		    		legend:'always', //범례 표시
		    		labelsDivWidth :115 ,	//범례 너비
		    		labelsDivStyles:{	//범례 스타일
		    			fontSize : "13px",
		    		},
		    		strokeWidth:0,	//라인 너비
		    		drawPoints:true,	//포인트 항상 보기
		    		pointSize:1,	//기본 포인트 사이즈
		    		drawPointCallback:Dygraph.Circles.TWOCIRCLELINE,	//포인트
		    		highlightSeriesOpts:{	//하이라이트 포인트 사이즈
		    			highlightCircleSize: 2
		    		},
		    		drawHighlightPointCallback:Dygraph.Circles.TWOCIRCLELINE,	//하이라이트 포인트
		    		xAxisLabelWidth:68,	//x축 하벨
		    		axisLabelFontSize:12, //라벨 폰트 사이즈
		    		yAxisLabelWidth:0,	//y축 라벨
		    		drawYGrid:false,	//y 축 라인 
	   			   	series:{	
		   			   	'STOA':{
		    				axis:'y'
		    			},
	   			   		'CME':{
		    				axis:'y2'//y2 축 사용
		    			}
		    		},
		    		axes : {
		    			y:{valueRange:[0, 50]},	//y 값 범위
		    			y2:{valueRange:[0, 50]}	//y2 값 범위
		    		},
		    		dateWindow:[new Date().getTime() - dateRange , new Date().getTime() + dateRange]	//범위
   				}
   		  	);
   		
   		//초기화
   		$(".reset").on("click",function(e){ 
   			if($(".addFiles li").length != 0 ){
	   			graph.updateOptions({
		    		dateWindow:[data[0][0][1].getTime() - dateRange, data[data.length-1][0][1].getTime() + dateRange]	//범위
	   			});	//그래프 갱신
   			}
   			e.preventDefault();
   		});
   		
   		//라벨 숨기기
   		$(".hideName").on("click",function(e){
			$("#graphs").toggleClass("hide");
			if($("#graphs").hasClass("hide")){
				$(".hideName").text("라벨 보이기");
			}else{
				$(".hideName").text("라벨 숨기기");
			}
			
   			e.preventDefault();
   		});
   		
   		//파일 추가 레이어
   		$(".layerBtn").on("click",function(e){	
   			$(".layer").show();
   			e.preventDefault();
   		});
	
   		//파일 선택 취소 버튼
   		$(".btnBox .cancel").on("click",function(e){	
   			$(".layer").hide();
   			e.preventDefault();
   		});
   	});
	
   	var data;//그래프 사용 데이터
   	var dataList = {};	//페이지 사용 데이터
  	//데이터 가져오기
   	function getData(filePath, fileName){
   		$.ajax({
   			url:"modelData.do",
   			data:{"filePath" : filePath},	//파일명 모델 타입
   			method:"post",
   			dataType:"json",
   			success:function(data){
   				//정보 저장
   				if(fileName.indexOf("CME") > -1){
   					var endDate = data[15].substring(data[15].indexOf("=") + 1, data[15].length);
   					dateArr =  endDate.split(/[- :T]/);
   					dataList[fileName].endDate = new Date(dateArr[0], dateArr[1]-1, dateArr[2],dateArr[3],dateArr[4],00);
   					setCMEStartDate(data, fileName);
   					endDate = null;dateArr=null;
   					return;
   				}else{
   					var startDate = data[1].substring(data[1].indexOf(':') + 1, data[1].length);
   					dataList[fileName].startDate = new Date(startDate.substring(1,5), startDate.substring(6,8), startDate.substring(9,11),startDate.substring(12,14),startDate.substring(15,17),startDate.substring(18,20));
   					var endDate = data[7].substring(data[7].indexOf(':') + 1, data[7].length);
   					dataList[fileName].endDate = new Date(endDate.substring(1,5), endDate.substring(6,8), endDate.substring(9,11),endDate.substring(12,14),endDate.substring(15,17),endDate.substring(18,20));
   					dataList[fileName].info = stoaLine(data, fileName);	//정보 
   					startDate = null;endDate = null;
   				}
   				dataList[fileName].y = Math.random() * 29 + 10;	//y 값	지정
   				var li = $("<li>").attr({"data-file":fileName}).text(fileName).bind("click", removeAddFile).data("startDate",dataList[fileName].startDate);
   				$(".addFiles").append(li);
   				$(".layer").hide();
   				updataData();
   				li=null;
   			},
   			error : function(xhr, error){
   				console.log(xhr, error);
   			}
   		});
   	}//getData end
   	
   	//CME 모델 시작 시간 입력
   	function setCMEStartDate(data, fileName){
   		$(".selectName").text("종료시간 : " + dataList[fileName].endDate.format("yyyy-mm-dd HH:MM:ss"));
   		$(".layer .fileBox").hide();
   		$(".setDate").show();
   		var ed = new Date(dataList[fileName].endDate.getTime());
   		ed = new Date(ed.setDate(ed.getDate() - 1));
   		$("#sd").datepicker("option","maxDate", ed);
   		$("#sd").val(ed.format("yyyy-mm-dd"));
   		$(".selectDate").bind("click",function(e){
   			e.preventDefault();
   			var startDate = $("#sd").datepicker('getDate');
   			startDate.setHours($("#spinHour").val());
   			startDate.setMinutes($("#spinMin").val());
   			startDate.setSeconds($("#spinSec").val());
   			dataList[fileName].startDate = startDate;
   			dataList[fileName].info = cmeLine(data, fileName);
   			dataList[fileName].y = Math.random() * 29 + 10;	//y 값	지정
   			var li = $("<li>").attr({"data-file":fileName}).text(fileName).bind("click", removeAddFile).data("startDate",dataList[fileName].startDate);
   			$(".addFiles").append(li);
   			updataData();
   			$(".layer").hide();
   			$(".layer .fileBox").show();
   			$(".setDate").hide();
   			$(".selectDate").unbind("click");
   		});		
   	}
   	
   	
    //갱신
   	function updataData(){	
   		data = [];	//초기화
   		var annotations = [];	//어노테이션 배열
		var lis = $(".addFiles li");	//추가할 파일들
		//파일 정렬 시간 별(정보)
		lis.sort(function(a,b){	
			var textA = $(a).data("startDate").getTime();
			var textB = $(b).data("startDate").getTime();
			if(textA < textB) return -1;
			if(textA > textB) return 1;
			return 0;
		});
		//파일 반복
		$.each(lis,function(index){	
			var li = $(this);
			var fileName = li.text();	//파일명
			var liData =  dataList[fileName];	//파일 데이터
			var type = fileName.indexOf("CME") > -1? false : true;	//파일 타입
			var y =  type ? liData.y : null;
			var y2 = type ? null : liData.y;
   			data.push([[liData.startDate, liData.endDate, fileName], y , y2]);	//그래프 데이터 입력
   			annotations.push({		//어노테이션 입력
    			series: type ? "STOA" : "CME",	
    			x : liData.startDate.getTime(),
    			text : fileName,
    			width:290,
    			fileName : fileName,
    			info : liData.info,	//정보 저장
    			cssClass:"annotation"
    		});
   			li=null;fileName=null;liData=null;type=null;y=null;y2=null;
		});    	
		
		var dateWindows;	//범위
		if(lis.length == 0 ){	//데이터 없음
			dateWindows = [new Date().getTime() - dateRange, new Date().getTime() + dateRange];
		}else{	//있음
			dateWindows = [data[0][0][0].getTime() - dateRange, data[data.length-1][0][1].getTime() + dateRange];
		}
    	graph.setAnnotations(annotations);	//어노테이션 넣기
   		graph.updateOptions({	//그래프 업데이트
			'file':data,	//업데이트 데이터
  			dateWindow: dateWindows,	//범위 업데이트
    		annotationMouseOverHandler : function(ann, point, dg, event){	//어노테이션 마우스 오버
   				$(ann.div).css({"z-index":"30"});	//상위로
   			},
   			annotationMouseOutHandler : function(ann, point, dg, event){	//어노테이션 마우스 아웃
   				$(ann.div).css({"z-index":"10"});	//하위로
   			},
   			annotationClickHandler : function(ann, point, dg, event){	//어노테이션 클릭
   				$(".annotation .show").removeClass("show");
   				var now = $(ann.div).children(".info");	
   				now.addClass("show");	//정보 보기
   				now.mouseleave(function(e){	//마우스 아웃
   					now.removeClass("show");	//정보 감추기
   					e.preventDefault();
   				});
   			}
   		});	//그래프 갱신
   		annotations = null;
		lis = null;
		dateWindows = null;
   	}//updateData end
   	
   	
  	//파일 추가
   	function addFile(filePath){	
   		var pathArr = filePath.split("/");
   		var fileName = pathArr[pathArr.length - 1];
		if(dataList[fileName] == null){
			dataList[fileName] = {};
			getData(filePath, fileName);
		}else{
			if($(".addFiles li[data-file='"+fileName+"']").length == 0){
				var li = $("<li>").attr({"data-file":fileName}).text(fileName).bind("click", removeAddFile).data("startDate",dataList[fileName].startDate);
				$(".addFiles").append(li);
				$(".layer").hide();
				updataData();
				li = null;
			}else{
				$(".layer .popup").text("이미 추가 되었습니다.").fadeIn(500).delay(800).fadeOut(800);				
			}
		}
		
		pathArr=null;fileName=null;
	}//fileAdd end
	
	 //파일 삭제
   	function removeAddFile(e){	
   		var now = $(this);
		now.remove();
		updataData();	//그래프 갱신	
		now = null;
   	}//fileRemove end
	
	
	//STOA 정보 
   	function stoaLine(txtArry, fileName){
   		var div = $("<div class='info'>");
   		var name = $("<p class='fileName'>").text(fileName);
   		name.appendTo(div);
   		var date = $("<p class='date'>").text(dataList[fileName].startDate.format("yyyy-mm-dd HH:MM:ss") + " ~ " + dataList[fileName].endDate.format("yyyy-mm-dd HH:MM:ss"));
   		date.appendTo(div);
   		for(var i = 0; i < txtArry.length;i++){
   			var p = $("<p>");
   			p.text(txtArry[i]);
   			p.appendTo(div);
   			p=null;
   		}
 		name=null;date=null;
   		return div;
   	}
   	
    //CME 정보
   	function cmeLine(txtArry, fileName){
   		var div = $("<div class='info'>");
   		var name = $("<p class='fileName'>").text(fileName);
   		name.appendTo(div);
   		var date = $("<p class='date'>").text(dataList[fileName].startDate.format("yyyy-mm-dd HH:MM:ss") + " ~ " + dataList[fileName].endDate.format("yyyy-mm-dd HH:MM:ss"));
   		date.appendTo(div);
   		var ncmes = $("<p>").text(txtArry[4]);
   		ncmes.appendTo(div);
   		for(var i = 16; i < 24;i++){
   			var p = $("<p>");
   			p.text(txtArry[i]);
   			p.appendTo(div);
   			p=null;
   		}
   		name=null;date=nullncmes=null;
   		return div;
   	}
   	
</script>
</body>
</html>