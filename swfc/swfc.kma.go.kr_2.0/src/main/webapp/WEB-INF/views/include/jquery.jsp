<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="<c:url value="/resources/common/js/jquery-1.10.2.min.js"/>"></script>
<script type="text/javascript">
var _requestUrl = null;
var _TopMenuSubIndex = 0;
$(function() {
	_requestUrl = $(location).attr('href');
	$('#TopMenuSub a').each(function(e){
		var thisUrl = $(this).attr('role');
		if(_requestUrl.indexOf(thisUrl) != -1){
			//alert($(this).find("img").attr("src").replace("off", "on"));
			$(this).find("img").attr("src", $(this).find("img").attr("src").replace("_off", "_on")).attr("select", "true");
		}
	});
	
	
	//서브 메뉴 선택 
	$('.TopSubMenu a').each(function(){
		var thisUrl = $(this).attr('role');
		if(_requestUrl.indexOf(thisUrl) != -1){
			$(this).css('color', '#fffc13');
		}
	});
	
	$("#TopMenuSub > ul > li").on("mouseover focus", function(){
		$(this).find(".m").prop("src", function(){ 
			return $(this).prop("src").replace("_off.png", "_on.png"); 
		});
	}).on("mouseout blur", function(){
		$(this).find(".m").prop("src", function(){ 
			if($(this).attr('select') != undefined){ //선택된 메뉴는 계속 활성
				return $(this).prop("src"); 
			}else{
				return $(this).prop("src").replace("_on.png", "_off.png"); 
			}
		});
	});

	$("#TopMenu ul,.TopSubMenu").hover(function(){
		$(".TopSubMenu").stop().animate({"height":160},300);		
	},function(){
		$(".TopSubMenu").stop().animate({"height":0},300);
	});
	
	$("#TopMenu ul li").mouseover(function(){
		i = $(this).index();
		$(".TopSubMenu dl").hide();
		$(".TopSubMenu dl").show();
	});
	
	//특정 수요자 팝업 버튼
	$(".bt_spcfPop").on("click",function(e){
		e.preventDefault();
		window.open("<c:url value='/ko/specificContent/specific.do'/>", 'spcf','left=0,top=0,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
	});
});

</script>
<!-- 
<script type="text/javascript" src="<c:url value="/resources/common/js/gnb.js"/>"></script><!-- //gnb -->
