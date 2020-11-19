var _url_suffix = ".do"; 

function MenuSelector(){
	this.suffix = ".do";
	this.title = "title";
	this.pattern = "pattern";
	this.menu = null;
	this.url=null;
	this.matchPattern = null;
}

MenuSelector.prototype.init = function(){
	this.url = document.location.href;
	this.menu = value;
	var value = this.url.substring(this.url.lastIndexOf('/') + 1);
	var value = value.substring(0, value.indexOf(this.suffix) + this.suffix.length);
};

MenuSelector.prototype.show = function(menuUrl){
	parentObj = this;
	var active = false;
	$('#leftMenuArea a').each(function(index, value){
		if($(this).attr('href').indexOf(menuUrl) != -1){
			$(this).parent().addClass("active").parent().show();
			$('#subMenuTitle').text($(this).parent().parent().attr(parentObj.title));
			active = true;
			parentObj.matchPattern = $(this).parent().attr(parentObj.pattern);
			return false;
		}
	});
	return active;
};

MenuSelector.prototype.selectPattern = function(){
	parentObj = this;
	$('#leftMenuArea li').each(function(){
		if($(this).hasClass("active")){
			return $(this).attr(parentObj.pattern);
		}
	});
};

MenuSelector.prototype.activeTop = function(){
	parentObj = this;
	$('#topMenuList li').each(function(){
		if($(this).attr(parentObj.pattern) == parentObj.matchPattern){
			$(this).addClass("active");
			return false;
		}
	});
};

$(function() {
	
	var menuSelector = new MenuSelector();
	menuSelector.init();
	isShow = menuSelector.show(menuSelector.menu);
	if(!isShow){
		$('#leftMenuArea li').each(function(){
			pattern = $(this).attr(menuSelector.pattern);
			if(menuSelector.url.indexOf(pattern) != -1){
				$(this).parent().show();
				$('#subMenuTitle').text($(this).parent().attr("title"));
				$(this).addClass("active");
				menuSelector.matchPattern = pattern;
				return false;
			}
		});
	}
	menuSelector.activeTop();
});

function showLeftMenu(menuURL){
	$('#leftMenuArea a').each(function(index, value){
		if($(this).attr('href').indexOf(menuURL) != -1){
			$(this).parent().addClass("active").parent().show();
			$('#subMenuTitle').text($(this).parent().parent().attr("title"));
		}
	});
}