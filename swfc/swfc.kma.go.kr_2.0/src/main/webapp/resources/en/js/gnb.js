$(function(){
	$("#TopMenu #TopMenuSub > ul > li").on("mouseover focus", function(){
		$(this).find(".m").prop("src", function(){ return $(this).prop("src").replace("_off.png", "_on.png"); });
	}).on("mouseout blur", function(){
		$(this).find(".m").prop("src", function(){ return $(this).prop("src").replace("_on.png", "_off.png"); });
	});

	$("#TopMenu ul,.TopSubMenu").hover(function(){
		$(".TopSubMenu").stop().animate({"height":140},300);		
	},function(){
		$(".TopSubMenu").stop().animate({"height":0},300);
	});
	
	$("#TopMenu ul li").mouseover(function(){
		i = $(this).index();
		$(".TopSubMenu dl").hide();
		$(".TopSubMenu dl").show();
	});

});



/*
$(function(){
	$("#TopMenu .TopSubMenu").hide();
	$("#TopMenu #TopMenuSub > ul > li").on("mouseover focus", function(){
		$(this).find(".m").prop("src", function(){ return $(this).prop("src").replace("_off.png", "_on.png"); });
		if($(this).find(".TopSubMenu").length > 0) $(this).find(".TopSubMenu").show();
	}).on("mouseout blur", function(){
		$(this).find(".m").prop("src", function(){ return $(this).prop("src").replace("_on.png", "_off.png"); });
		if($(this).find(".TopSubMenu").length > 0) $(this).find(".TopSubMenu").hide();
	});
	$("#TopMenu .TopSubMenu li").on("mouseover focus", function(){
		$(this).find("img").prop("src", function(){ return $(this).prop("src").replace("_off.png", "_on.png"); });
	}).on("mouseout blur", function(){
		$(this).find("img").prop("src", function(){ return $(this).prop("src").replace("_on.png", "_off.png"); });
	});
});
*/