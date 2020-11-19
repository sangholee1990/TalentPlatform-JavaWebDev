<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--[if lt IE 9]><script type="text/javascript" src="<c:url value="/js/flashcanvas.js"/>"></script><![endif]-->
<script type="text/javascript" src="<c:url value="/js/dygraph-combined.js"/>"></script>
<script type="text/javascript">
Dygraph.prototype.loadChartData = function(type, sd, ed) {
	var chart = this;
	$.ajax({
		url : "<c:url value="/chart/chartData.do"/>",
		data : {
			type : type,
			sd : sd,
			ed : ed
		}
	}).done(function(data) {
		$.each(data, function(key, val) {
			val[0] = new Date(val[0].substring(0, 4), val[0].substring(4, 6)-1, val[0].substring(6, 8), val[0].substring(8, 10), val[0].substring(10, 12), val[0].substring(12, 14));
		});
		
		chart.updateOptions({
			file:data
		});
	}).fail(function() {
		//alert('load chart data Error');
	}).always(function() {
		
	});
};

var statchartGraphManager = new function() {
	var defaultOption = {
		autoRefresh: false,
		autoRefreshNow: true,
		autoRefreshInterval:1000*60*5
	};
	var currentOption = defaultOption;
	
	this.timer = null;
	this.chartList = [];
	
	this.resize = function(width, height) {
		$.each(this.chartList, function(key, val) {
			val.chart.resize(width, height);
		});
	};
	
	this.autoRefresh = function() {
		var date = new Date();
		var ed = this.getUTCDateString(date);
		date.setDate(date.getDate() -1);
		var sd = this.getUTCDateString(date);
		var param = {
			sd: sd,
			ed: ed
		};
		$.each(this.chartList, function(key, val) {
			if(val.autoRefresh) {
				val.chart.loadChartData(val.type, param.sd, param.ed);
			}
		});
	};
	
	this.updateOptions = function(option) {
		var settings = $.extend(true, {}, currentOption, option);
		if(settings.autoRefresh != currentOption.autoRefresh) {
			if(settings.autoRefresh) {
				if(this.timer != null) {
					clearInterval(this.timer);
				}
				this.timer = setInterval("chartGraphManager.autoRefresh()", settings.autoRefreshInterval);
				if(settings.autoRefreshNow) {
					this.autoRefresh();
				}
			} else {
				clearInterval(this.timer);
				this.timer = null;
			}
		}
		currentOption = settings;
	};
	
	this.setAutoRefreshLayer = function(chartType, autoRefresh) {
		$.each(this.chartList, function(key, val) {
			if(val.type == chartType) {
				val.autoRefresh = autoRefresh;
			}
		});
	};
	
	this.add = function(type, param) {
		this.chartList.push( {
			chart: new Dygraph($("#"+type).get(0), [],  param),
			type: type,
			autoRefresh: true
		});
	};
	
	this.load = function(param) {
		if(param.type) {
			$.each(this.chartList, function(key, val) {
				if(param.type == val.type) {
					val.autoRefresh = false;
					val.chart.loadChartData(val.type, param.sd, param.ed);
				}
			});
		} else {
			$.each(this.chartList, function(key, val) {
				val.chart.loadChartData(val.type, param.sd, param.ed);
			});
		}
	};
	
	this.pad = function (val, len) {
		val = String(val);
		len = len || 2;
		while (val.length < len) val = "0" + val;
		return val;
	};
	
	this.getUTCDateString = function(date) {
		return date.getUTCFullYear() + this.pad(date.getUTCMonth()+1,2) + this.pad(date.getUTCDate(),2) + this.pad(date.getUTCHours(),2) + this.pad(date.getUTCMinutes(),2) + this.pad(date.getUTCSeconds(),2);	
	}
	
	this.loadOneDayFromNow = function() {
		var date = new Date();
		var ed = this.getUTCDateString(date);
		date.setDate(date.getDate() -1);
		var sd = this.getUTCDateString(date);
		for(var type in this.chartList) {
			if(this.chartList[type].autoLoad)
				this.chartList[type].loadChartData(sd, ed);
		}
	};
	
	this.setAutoRefresh = function(param) {
		var param = $.extend(defaultParam, param);
		/*
		var defaultParam = {
			enable: false,
			interval: 1000*60*5 
		};
		*/
		if(param.enable) {
			console.log(param.enable);
		}
		console.log("HM");
		/*
		if(isNaN(delay)) {
			clearInterval(this.timer);
			this.timer = null;
		} else {
			if(this.timer != null) {
				clearInterval(this.timer);
			}
			this.timer = setInterval("chartGraphManager.loadOneDayFromNow()", delay);
		}
		*/
	};
	
	this.XRayStat = function(param) {
		this.add('XRAY_FLUX_STAT',$.extend({}, {
			labels: [ "Date", "max_long_flux", "avg_long_flux"],
			labelsDiv: "XRAY_FLUX_LABELS_DIV",
			colors: ['gray', 'blue'],
			ylabel: 'W/m<sup>2</sup>',
			yAxisLabelWidth:60,
			strokeWidth:2,
			labelsKMB: true,
			highlightCircleSize:4,
			axes: {
	              y: {
	                valueRange: [0.0000000001, 0.002],
	                axisLabelFormatter: function(val) {
	                	return val.toExponential(0);
	                }
	              }
			},
			logscale:true,
			underlayCallback: function(ctx, area, g) {
				ctx.installPattern([10, 5]);
				drawDottedLine(ctx, g, 0.00001, 'gray');
				drawDottedLine(ctx, g, 0.00005, 'blue');
	            ctx.uninstallPattern();	            
			}
		}, param));
	};
	
function drawDottedLine(ctx, dygraph, yvalue, strokeStyle) {
	var xRange = dygraph.xAxisRange();
    var xl= dygraph.toDomCoords(xRange[0],yvalue);
    var xr= dygraph.toDomCoords(xRange[1],yvalue);
    ctx.strokeStyle= strokeStyle;
    ctx.beginPath();
    ctx.moveTo(xl[0],xl[1]);
    ctx.lineTo(xr[0],xr[1]);
    ctx.closePath();
    ctx.stroke();              
}

function barChartPlotter(e) {
    var ctx = e.drawingContext;
    var points = e.points;
    var y_bottom = e.dygraph.toDomYCoord(0);

    // The RGBColorParser class is provided by rgbcolor.js, which is
    // packed in with dygraphs.
    var color = new RGBColorParser(e.color);
    color.r = Math.floor((255 + color.r) / 2);
    color.g = Math.floor((255 + color.g) / 2);
    color.b = Math.floor((255 + color.b) / 2);
    ctx.fillStyle = color.toRGB();

    // Find the minimum separation between x-values.
    // This determines the bar width.
    var min_sep = Infinity;
    for (var i = 1; i < points.length; i++) {
      var sep = points[i].canvasx - points[i - 1].canvasx;
      if (sep < min_sep) min_sep = sep;
    }
    var bar_width = Math.floor(2.0 / 3 * min_sep);
    bar_width = Math.min(bar_width, 20);

    // Do the actual plotting.
    for (var i = 0; i < points.length; i++) {
      var p = points[i];
      var center_x = p.canvasx;

      ctx.fillRect(center_x - bar_width / 2, p.canvasy,
          bar_width, y_bottom - p.canvasy);

      ctx.strokeRect(center_x - bar_width / 2, p.canvasy,
          bar_width, y_bottom - p.canvasy);
    }
}
};

</script>