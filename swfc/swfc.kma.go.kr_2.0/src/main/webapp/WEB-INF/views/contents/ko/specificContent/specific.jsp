<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="<c:url value="/favicon.ico"/>" type="image/x-icon" >
<link rel="icon" href="<c:url value="/favicon.ico"/>" type="image/x-icon" >
<title>우주기상 예특보 서비스 :: 국가기상위성센터</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/ko/css/specific.css"/>"  />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/js/themes/base/jquery.ui.resizable.css"/>"  />
<jsp:include page="/WEB-INF/views/include/jquery.jsp" />
</head>
<body>
<div id="wrap_main">
	<div id="wrap_top">
		<p class="navi">마우스를 이용하여 크기를 조절하거나 위치를 변경하십시오.</p>
		<p class="btnBox"><button class="btn initBtn" title="초기화"><span>초기화</span></button><button class="btn sortBtn" title="정리"><span>정리</span></button><button class="btn saveBtn" title="설정을 저장합니다."><span>설정 저장</span></button></p>
		<ul class="menuBox">
			<c:forEach items="${contentList}" var="menu">
				<c:set var="userUse" scope="page">${menu.userUse }</c:set>
				<li class="<c:if test="${userUse eq 'Y' }">checked</c:if>"  data-seq="<c:out  value="${menu.spcfSeq}"/>"  data-info="<c:if test="${menu.cssInfo!= null}">${menu.cssInfo}</c:if>" data-order="<c:if test="${menu.orderNum!= null}">${menu.orderNum}</c:if>">
			   		<em class="title"><c:out  value="${menu.title}"/></em>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div id="wrap_sub" class="">
		<div class="contentBox">
			<c:forEach items="${contentList}" var="menu">
				<c:set var="userUse" scope="page">${menu.userUse }</c:set>
				<div class="content unSelected ui-widget-">
					<p class="header">
						<!-- button type="button" class="hideBtn" title="최소화"></button --> 
						<button type="button" class="closeBtn" title="닫기"></button> 
				   		<em class="title" title="<c:out  value="${menu.title}"/>"><c:out  value="${menu.title}"/></em>
					</p>
			 		<iframe src="<c:out  value="${menu.uri}"/>" class="viewBox" scrolling="no" frameborder="0" title="<c:out  value="${menu.title}"/>" ></iframe>
				 	<div class="blind"></div>
			 	</div>
			</c:forEach>
		</div>
	</div> 
	<div id="loading"></div>  
</div>
<script type="text/javascript" src="<c:url value="/resources/common/js/jquery.slimscroll.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/common/js/jquery-ui.min.js"/>"></script>
<script type="text/javascript">
var update = false;

$(function(){
	
	$.ui.plugin.add('draggable', 'zindexOnmousedown',{
		create:function(){	
			this.mousedown(function(e){
				var inst = $(this).data("uiDraggable");
				inst._mouseStart(e);
				inst._trigger('start',e);
				inst._trigger('stop',e);
				inst._clear();
			});
		}
	});
	
	//
	$(".contentBox").hide();//로딩 시작
	bindEventContent();	//컨텐츠 이벤트
	bindEventMenu();	//메뉴 이벤트
	$("#loading").remove();
	$(".contentBox").show();	//로딩끝
	init();	//초기 설정

	//Scroll
	$("#wrap_sub").slimScroll({alwaysVisible:true,color:"#fff", opacity: .6, height: $(window).height() - $("#wrap_top").innerHeight()});
	
	//Window Resize
	$(window).resize(resizePage).resize();
	
});

//초기 설정
function init(){
	//초기 컨텐츠
	var top = 0;
	var left = 0;
	var startNum = 1;
	$.each($(".menuBox li"),function(index){
		var li = $(this);
		var content = $(".content").eq(index);
		var order = li.attr("data-order") == "" ? startNum++ : li.attr("data-order");
		var info = li.attr("data-info") == "" ? "top:" + top + "px;left:" + left +"px;height:320px;width:380px" : li.attr("data-info");
		if(li.attr("data-info") == ""){
			top = top + 25;
			left = left + 25;
		}
		li.data("spcfSeq", li.attr("data-seq"));
		li.removeAttr("data-seq");
		li.data("orderNum", order);
		li.removeAttr("data-order");
		li.removeAttr("data-info");
		content.attr("style", info + "z-index:" + order);
		content.children(".viewBox").height(content.height() - content.children(".header").outerHeight() );
		content.find(".title").width(content.children(".header").width());
		content.children(".blind").height(content.height() - content.children(".header").outerHeight() + 4);
		if(!li.hasClass("checked")){
			content.css("display","none");
		}
		if(content.offset().left + content.width() > $(window).width()){
			var maxLeft = $(window).width() -  content.width() > 0 ?$(window).width() -  content.width() -30 : 0;
			content.css("left", maxLeft);
			maxLeft=null;
		}
		li=null;content=null;order=null;info=null;
	});
}

//메뉴 이벤트
function bindEventMenu(){
	//메뉴 버튼
	$(".menuBox li").on("click",function(e){
		e.preventDefault();
		update = true;
		var select = $(this);
		var content = $(".content").eq(select.index());
		$(".selected").removeClass("selected");
		$(".content:not(.minMax)").addClass("unSelected");
		select.addClass("checked selected");
		content.removeClass("unSelected");
		if(content.hasClass("minMax")){
			content.removeClass("minMax").animate({"height":content.children(".header").outerHeight() + content.children(".viewBox").height()}, 100);
			content.children(".blind").height(content.height() - content.children(".header").outerHeight() + 4);
		}
		content.removeClass("unSelected").addClass("selected").css({"display":"block","z-index": maxIndex()});
		select=null;content=null;
	});
	//초기화
	$(".initBtn").on("click",function(e){
		e.preventDefault();
		update = true;
		var top = 25 * ($(".menuBox li.checked").length - 1);
		var left = 25 * ($(".menuBox li.checked").length - 1);
		var startNum = $(".menuBox li.checked").length;
		var endNum = startNum;
		var unTop = 25 * (endNum);
		var unLeft = 25 * (endNum);
		$(".content").addClass("unSelected").removeClass("minMax");
		$(".selected").removeClass("selected");
		$.each($(".menuBox li"),function(index){
			var li = $(this);
			var content = $(".content").eq(index);
			
			if(li.hasClass("checked")){
				content.css({"z-index": startNum , "top":top,"left":left,"width":"380px","height":"320px"});
				startNum = startNum -1;
				top = top - 25;
				left = left - 25;
			}else{
				content.css({"z-index": endNum , "top":unTop,"left":unLeft,"width":"380px","height":"320px"});
				endNum = endNum +1;
				unTop = unTop + 25;
				unLeft = unLeft + 25;
			}
			content.children(".viewBox").height(294);
			content.find(".title").width(content.children(".header").width());
			content.children(".blind").height(298);
			li=null;content=null;
		});
		top=null;left=null;startNum=null;unTop=null;unLeft=null;endNum=null;
	});
	
	//정리
	$(".sortBtn").on("click",function(e){
		e.preventDefault();
		update = true;
		var top = 25 * ($(".menuBox li.checked").length - 1);
		var left = 25 * ($(".menuBox li.checked").length -1);
		var startNum = $(".menuBox li.checked").length + 1;
		var contents = $(".content");
		contents.sort(function(a,b){	
			var zIndexA = parseFloat($(a).css("z-index"));
			$(a).data("realIndex", $(a).index());
			var zIndexB = parseFloat($(b).css("z-index"));
			$(b).data("realIndex", $(b).index());
			if(zIndexA < zIndexB) return 1;
			if(zIndexA > zIndexB) return -1;
			return 0;
		});
		$.each(contents,function(index){
			var content = $(this);
			var li = $(".menuBox li").eq(content.data("realIndex"));
			if(li.hasClass("checked")){
				content.css({"z-index": startNum , "top":top,"left":left});	
				startNum = startNum -1;
				top = top - 25;
				left = left - 25;
			}
			content=null;li=null;
		});
		top=null;left=null;startNum=null;contents=null;
	});
	
	//저장
	$(".saveBtn").on("click",function(e){
		e.preventDefault();
		if(update){
			var data = setData();
			updateData(data);
			data = null;
		}
	});
}



//컨텐츠 이벤트
function bindEventContent(){
	//컨텐츠 마우스 이벤트
	$(".content").draggable({		//드래그
		start: function(e, ui){
			$(".content:not(.minMax)").addClass("move");
			var select = $(ui.helper);
			$(".selected").removeClass("selected");
			$(".content:not(.minMax)").addClass("unSelected");
			select.removeClass("unSelected").addClass("selected");
			$(".menuBox li").eq(select.index()).addClass("selected");
		},
		stop:function(e, ui){
			$(".content:not(.minMax)").removeClass("move");
			update = true;
		},
		stack:".content",
		zindexOnmousedown : true,
		handle:".header",
		containment:".contentBox"
	}).resizable({		//리사이즈
		minWidth:380,
		minHeight:320,
		start : function(e, ui){	
			$(ui.element).addClass("selected");
			$(".content").addClass("move");
		},
		resize:function(e, ui){
			var div = $(ui.element);
			div.children(".viewBox").height(ui.size.height - div.children(".header").outerHeight());
			div.children(".blind").height(ui.size.height - div.children(".header").outerHeight() + 4);
			div.find(".title").width(div.children(".header").width());
		},
		stop : function(e, ui){
			$(".content").removeClass("move");
			update = true;
		},
		containment:".contentBox"
	});
	
	//최소화
	$(".hideBtn").on("click",function(e){
		e.preventDefault();
		var select = $(this);
		var content = select.parent().parent();
		var headerH = content.children(".header").innerHeight() - 2;
		content.toggleClass("minMax");
		if(content.height() == headerH){
			content.stop().animate({"height" : content.children(".header").outerHeight() + content.children(".viewBox").height()}, 100);
		}else{
			content.stop().animate({"height":content.children(".header").innerHeight() - 2},100);
		}
		select=null;content=null;headerH=null;
	});
	
	//닫기 버튼
	$(".closeBtn").on("click",function(e){
		e.preventDefault();
		update = true;
		var select = $(this);
		var content = select.parent().parent();
		var menu = $(".menuBox li").eq(content.index());
		content.removeClass("selected").css({"display":"none","z-index": 0});
		menu.removeClass("checked");
		select=null;content=null;menu=null;
	});
}

//최상위 값
function maxIndex(){
	var maxZIndex = 0;
	$.each($(".content"),function(){
		var zIndex = parseFloat($(this).css("z-index"));
		maxZIndex = zIndex > maxZIndex ? zIndex : maxZIndex;
	});
	return maxZIndex + 1;
}

//Window Resize
function resizePage(){
	$(".slimScrollDiv, #wrap_sub").css({height: $(window).height() - $("#wrap_top").innerHeight()});
}

//Ajax 설정 저장
function updateData(data){
	$.ajax({
		url:"updateUserMapping.do",
		data : {"updateData" : JSON.stringify(data)},
		dataType: 'json',
		method : "post",
		success : function(data){
			update = false;
		},
		error : function(xhr, error){	//에러
			console.log(error);
		}
	});
}

//Data 세팅
function setData(){
	var data ={};
	var list = [];
	$.each($(".menuBox li"),function(index){
		var info = {};
		var target = $(this);
		var content =  $(".content").eq(index);
		var height = content.children(".header").outerHeight() + content.children(".viewBox").height();
		var css = "top:" + content.css("top") + ";left:"+ content.css("left") + ";width:" + content.css("width") +";height:"+ height + "px;";
		var use = target.hasClass("checked") ? 'Y':'N';
		
		info["spcfSeq"] = target.data("spcfSeq");
		info["cssInfo"] = css;
		info["userUse"] = use;
		info["orderNum"] = content.css("z-index");
		list.push(info);
		info = null;target=null;seq=null;css=null;use=null;
	});
	data["updateData"] = list;
	return data;
}
</script>
</body>
</html>