<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--[if lt IE 9]><script type="text/javascript" src="<c:url value="/js/flashcanvas.js"/>"></script><![endif]-->
<script type="text/javascript" src="<c:url value="/js/dygraph-combined.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/dygraph-extra.js"/>"></script>
<script type="text/javascript">
Dygraph.prototype.loadChartData = function(type, sd, ed) {
	var chart = this;
	$.ajax({
		url : "<c:url value="/chart/chartData.do"/>",
		cache:false,
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

var chartGraphManager = new function() {
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
	
	this.resetZoom = function(chartType) {
		$.each(this.chartList, function(key, val) {
			if(val.type == chartType){
				val.chart.resetZoom();
			}
		});
	};
	
	this.exportImage = function(chartType) {
		$.each(this.chartList, function(key, val) {
			if(val.type == chartType){
				var _canvas = Dygraph.Export.asCanvas(val.chart);
				//if(_canvas != null){
					$('<form>', {
						"id" : "frm",
						"html" : "<input type='hidden' id='chartImage', name='chartImage' value='"+ _canvas.toDataURL()  +"' /><input type='hidden' id='chartType', name='chartType' value='"+ chartType  +"' />",
						"action" : "<c:url value="/chart/exportChartImage.do"/>",
						"method" : "post",
						"target" : "commonIframe",
					}).appendTo(document.body).submit().remove();
				//}
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
			/* 추가 */
			if(val.duplication != null){
				if(val.duplication == chartType) {
					val.autoRefresh = autoRefresh;
				}
		   /*********** 추가 */
			}else{
				if(val.type == chartType) {
					val.autoRefresh = autoRefresh;
				}
			}
			
		});
	};
	//*****추가
	this.remove = function(chartType,param){
		var list = this.chartList;
		$.each(list, function(key, val) {
			if(val.duplication == chartType) {
				list.splice(key,1);
				return false;
			}
		});
	};
	//추가*****
	this.add = function(type, param) {
		//*****추가
		var box = $("#"+type).get(0);
		var dup = type;
		if(param.box !=null){
			box = param.box.get(0);
			param.labelsDiv = param.div.attr("id");
			dup = param.box.attr("id");
		}
		// 차트 넓이 고정해야하면 주석 풀어주세요.
// 		param.width = $(box).width();
// 		param.height = $(box).height();
		//*****추가
		this.chartList.push( {
			chart: new Dygraph(box, [],  param),	//수정
			type: type,
			autoRefresh: true,
			duplication: dup
		});
	};
	
	this.load = function(param) {
		if(param.type) {
			$.each(this.chartList, function(key, val) {
				//*****추가
				if(val.duplication != null){
					if(param.type == val.duplication) {
						//val.autoRefresh = false;
						val.chart.loadChartData(val.type, param.sd, param.ed);
					}
				//**** 추가
				}else{
					if(param.type == val.type) {
						//val.autoRefresh = false;
						val.chart.loadChartData(val.type, param.sd, param.ed);
					}
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
		//console.log("HM");
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
	
	this.addXRayFlux = function(param) {
		this.add('XRAY_FLUX',$.extend({}, {
			labels: [ "Date", "Short Wave", "Long Wave"],
			labelsDiv: "XRAY_FLUX_LABELS_DIV",
			//colors: ['black', 'blue'],
			colors: ['cyan', 'red'],
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
				drawDottedLine(ctx, g, 0.0001, 'yellow');
				drawDottedLine(ctx, g, 0.001, 'orange');
				drawDottedLine(ctx, g, 0.002, 'red');
	            ctx.uninstallPattern();	            
			}
		}, param));
	};
	
	this.addProtonFlux = function(param) {
		this.add('PROTON_FLUX',$.extend({}, {
			labels: [ "Date", "P1", "P5", "P10", "P30", "P50","P100"],
			labelsDiv: "PROTON_FLUX_LABELS_DIV",
			colors: ['blue', 'black', 'red', 'green', 'orange', 'cyan'],
			ylabel: 'cm<sup>-2</sup>s<sup>-1</sup>sr<sup>-1</sup>',
			yAxisLabelWidth:60,
			strokeWidth:2,
			labelsKMB: true,			
			highlightCircleSize:4,
			axes: {
	              y: {
	                valueRange: [0.01, 100000]
	              }
			},
			logscale:true,
			underlayCallback: function(ctx, area, g) {
				ctx.installPattern([10, 5]);
				drawDottedLine(ctx, g, 10, 'gray');
				drawDottedLine(ctx, g, 100, 'blue');
				drawDottedLine(ctx, g, 1000, 'yellow');
				drawDottedLine(ctx, g, 10000, 'orange');
				drawDottedLine(ctx, g, 100000, 'red');
	            ctx.uninstallPattern();
			}			
		}, param));
	};
	
	this.addElectronFluxSWAA = function(param) {
		this.add('ELECTRON_FLUX_SWAA',$.extend({}, {
			labels: [ "Date", "E_40keV"],
			labelsDiv: "ELECTRON_FLUX_SWAA_LABELS_DIV",
			colors: ['green'],
			ylabel: 'cm<sup>-2</sup>s<sup>-1</sup>sr<sup>-1</sup>',
			yAxisLabelWidth:60,
			strokeWidth:2,
			highlightCircleSize:4,
			logscale:true,
			axes: {
	              y: {
	                valueRange: [500, 1000000]
	              }
			},
			underlayCallback: function(ctx, area, g) {
				ctx.installPattern([10, 5]);
				drawDottedLine(ctx, g, 52000, 'blue');
				drawDottedLine(ctx, g, 120000, 'yellow');
				drawDottedLine(ctx, g, 290000, 'orange');
				drawDottedLine(ctx, g, 450000, 'red');
	            ctx.uninstallPattern();
			}			
		}, param));
	};
	
	this.addElectronFluxSWAA2 = function(param) {
		this.add('ELECTRON_FLUX_SWAA_2',$.extend({}, {
			labels: [ "Date", "E_2MeV"],
			labelsDiv: "ELECTRON_FLUX_SWAA_2_LABELS_DIV",
			colors: ['red'],
			ylabel: 'cm<sup>-2</sup>s<sup>-1</sup>sr<sup>-1</sup>',
			yAxisLabelWidth:60,
			strokeWidth:2,
			highlightCircleSize:4,
			logscale:true,
			axes: {
	              y: {
	                valueRange: [1000, 10000000000]
	              }
			},
			underlayCallback: function(ctx, area, g) {
				ctx.installPattern([10, 5]);
				drawDottedLine(ctx, g, 7500000, 'blue');
				drawDottedLine(ctx, g, 57000000, 'yellow');
				drawDottedLine(ctx, g, 440000000, 'orange');
				drawDottedLine(ctx, g, 1200000000, 'red');
	            ctx.uninstallPattern();
			}			
		}, param));
	};
	
	this.addGoesMagSWAA = function(param) {
		this.add('GOES_MAG_SWAA',$.extend({}, {
			labels: [ "Date", "GOES13_HP", "GOES15_HP"],
			labelsDiv: "GOES_MAG_SWAA_LABELS_DIV",
			colors: ['red', 'green'],
			ylabel: 'nT',
			yAxisLabelWidth:60,
			strokeWidth:2,
			highlightCircleSize:4,
			logscale:true,
			underlayCallback: function(ctx, area, g) {
				ctx.installPattern([10, 5]);
	            ctx.uninstallPattern();
			}			
		}, param));
	};
	
	this.addElectronFlux = function(param) {
		this.add('ELECTRON_FLUX',$.extend({}, {
			labels: [ "Date", "E8", "E20", "E40"],
			labelsDiv: "ELECTRON_FLUX_LABELS_DIV",
			colors: ['blue', 'black', 'cyan'],
			ylabel: 'cm<sup>-2</sup>s<sup>-1</sup>sr<sup>-1</sup>',
			yAxisLabelWidth:60,
			strokeWidth:2,
			highlightCircleSize:4,
			logscale:true,
			underlayCallback: function(ctx, area, g) {
				ctx.installPattern([10, 5]);
				drawDottedLine(ctx, g, 10, 'gray');
				drawDottedLine(ctx, g, 100, 'blue');
				drawDottedLine(ctx, g, 1000, 'yellow');
				drawDottedLine(ctx, g, 10000, 'orange');
				drawDottedLine(ctx, g, 100000, 'red');
	            ctx.uninstallPattern();
			}			
		}, param));
	};
	
	this.addElectronFluxAll = function(param) {
		this.add('ELECTRON_FLUX_ALL',$.extend({}, {
			labels: [ "Date", "GOES13_E8", "GOES13_E20", "GOES13_E40", "GOES15_E8", "GOES15_E20", "GOES15_E40"],
			labelsDiv: "ELECTRON_FLUX_ALL_LABELS_DIV",
			colors: ['blue', 'black', 'cyan','green', 'orange', 'red' ],
			ylabel: 'cm<sup>-2</sup>s<sup>-1</sup>sr<sup>-1</sup>',
			yAxisLabelWidth:60,
			strokeWidth:2,
			highlightCircleSize:4,
			logscale:true,
			underlayCallback: function(ctx, area, g) {
				ctx.installPattern([10, 5]);
				drawDottedLine(ctx, g, 10, 'gray');
				drawDottedLine(ctx, g, 100, 'blue');
				drawDottedLine(ctx, g, 1000, 'yellow');
				drawDottedLine(ctx, g, 10000, 'orange');
				drawDottedLine(ctx, g, 100000, 'red');
	            ctx.uninstallPattern();
			}			
		}, param));
	};
	
	this.addKpIndexKhu = function(param) {
		
		this.add('KP_INDEX_KHU',$.extend({}, {
			labels: [ "Date", "KHU","SWPC"],
			labelsDiv: "KP_INDEX_KHU_LABELS_DIV",
			colors: ['cyan', 'orange', 'red'],
			yAxisLabelWidth:60,
			strokeWidth:2,
			connectSeparatedPoints:true,
			highlightCircleSize:4,
			animatedZoom: true,
			drawXGrid : true,
			//legend: 'always',
			//showRangeSelector: true,
			axes: {
	              y: {
	                valueRange: [0, 10]
	              }
			},
			"SWPC": {
				plotter: barChartPlotter
			},
			underlayCallback: function(ctx, area, g) {
				ctx.installPattern([10, 5]);
				drawDottedLine(ctx, g, 5, 'gray');
				drawDottedLine(ctx, g, 6, 'blue');
				drawDottedLine(ctx, g, 7, 'yellow');
				drawDottedLine(ctx, g, 8, 'orange');
				drawDottedLine(ctx, g, 9, 'red');
	            ctx.uninstallPattern();
			}			
		}, param));
	};
	
	this.addDstIndexKhu = function(param) {
		this.add('DST_INDEX_KHU',$.extend({}, {
			labels: [ "Date", "KYOTO", "KHU"],
			labelsDiv: "DST_INDEX_KHU_LABELS_DIV",
			colors: ['red','cyan'],
			yAxisLabelWidth:60,
			strokeWidth:2,
			highlightCircleSize:4
		}, param));
	};

	
	this.addKpIndexSwpc = function(param) {
		this.add('KP_INDEX_SWPC', $.extend({}, {
			labels: [ "Date", "KP"],
			labelsDiv: "KP_INDEX_SWPC_LABELS_DIV",
			colors: ['orange'],
			yAxisLabelWidth:60,
			axes: {
	              y: {
	                valueRange: [0, 10]
	              }
			},
			xValueParser: function(x) { return alert(x); 1000*parseInt(x); },
			strokeWidth:2,
			highlightCircleSize:4,
			plotter: barChartPlotter,
			underlayCallback: function(ctx, area, g) {
				ctx.installPattern([10, 5]);
				drawDottedLine(ctx, g, 5, 'gray');
				drawDottedLine(ctx, g, 6, 'blue');
				drawDottedLine(ctx, g, 7, 'yellow');
				drawDottedLine(ctx, g, 8, 'orange');
				drawDottedLine(ctx, g, 9, 'red');
	            ctx.uninstallPattern();
			}				
		}, param));
	};
	
	this.addMagnetopauseRadius = function(param) {
		this.add('MAGNETOPAUSE_RADIUS',$.extend({}, {
			labels: [ "Date", "Value"],
			labelsDiv: "MAGNETOPAUSE_RADIUS_LABELS_DIV",
			colors: ['red'],
			yAxisLabelWidth:60,
			strokeWidth:2,
			highlightCircleSize:4,
			ylabel: 'R<sub><font size="1em">E</font</sub>',
			axes: {
	              y: {
	                valueRange: [18, 4],
	              	valueFormatter: function(y){
	              		return y.toFixed(2);
	              	}
	              }
			},
			underlayCallback: function(ctx, area, g) {
				ctx.installPattern([10, 5]);
				drawDottedLine(ctx, g, 4.6, 'red');
				drawDottedLine(ctx, g, 5.6, 'orange');
				drawDottedLine(ctx, g, 6.6, 'yellow');
				drawDottedLine(ctx, g, 8.6, 'blue');
				drawDottedLine(ctx, g, 10.6, 'gray');
	            ctx.uninstallPattern();
			}				
		}, param));		
	};
	
	this.addDstIndexKyoto = function(param) {
		this.add('DST_INDEX_KYOTO',$.extend({}, {
			labels: [ "Date", "Dst"],
			labelsDiv: "DST_INDEX_KYOTO_LABELS_DIV",
			colors: ['red'],
			yAxisLabelWidth:60,
			strokeWidth:2,
			highlightCircleSize:4,
			ylabel: 'nT'
		}, param));		
	};
	
	this.addAceMag = function(param) {
		this.add('ACE_MAG',$.extend({}, {
			labels: [ "Date", "B<sub>X</sub>", "B<sub>Y</sub>", "B<sub>Z</sub>", "B<sub>T</sub>"],
			labelsDiv: "ACE_MAG_LABELS_DIV",
			colors: ['black', 'blue', 'red', 'green'],
			yAxisLabelWidth:60,
			strokeWidth:2,
			highlightCircleSize:4,
			ylabel: 'nT'
		}, param));		
	};
	
	this.addAceSolarWindSpeed = function(param) {
		this.add('ACE_SOLARWIND_SPD',$.extend({}, {
			labels: [ "Date", "V<sub>x</sub>(km/s)"],
			labelsDiv: "ACE_SOLARWIND_SPD_LABELS_DIV",
			colors: ['red'],
			yAxisLabelWidth:60,
			strokeWidth:2,
			highlightCircleSize:4,
			ylabel: 'km/s'
		}, param));		
	};
	
	this.addAceSolarWindDens= function(param) {
		this.add('ACE_SOLARWIND_DENS',$.extend({}, {
			labels: [ "Date", "N(cm<sup>-3</sup>)"],
			labelsDiv: "ACE_SOLARWIND_DENS_LABELS_DIV",
			colors: ['red'],
			yAxisLabelWidth:60,
			strokeWidth:2,
			highlightCircleSize:4,
			ylabel: 'cm<sub>-3</sub>'
		}, param));		
	};
	
	this.addAceSolarWindTemp = function(param) {
		this.add('ACE_SOLARWIND_TEMP',$.extend({}, {
			labels: [ "Date", "T(K)"],
			labelsDiv: "ACE_SOLARWIND_TEMP_LABELS_DIV",
			colors: ['red'],
			yAxisLabelWidth:60,
			strokeWidth:2,
			highlightCircleSize:4,
			ylabel: 'K'
		}, param));		
	};	
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

    var strokeColor = new RGBColorParser(e.color);
    strokeColor.r = 255;
    strokeColor.g = 0;
    strokeColor.b = 0;
	ctx.strokeStyle = strokeColor.toRGB();
    
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
</script>	
