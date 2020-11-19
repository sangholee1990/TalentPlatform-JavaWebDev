/*! @license Copyright 2011 Dan Vanderkam (danvdk@gmail.com) MIT-licensed (http://opensource.org/licenses/MIT) */
/**
 * dygraph-combined.js
 * Overriding Method
 * Modifier : Park J.C (chrysesevil@nate.com)
 * Date : 2014-10
 * 
 */
Dygraph.Plugins.Legend.prototype.select = function(){};	//범례 박스 이벤트 제거
Dygraph.prototype.resetZoom = function() {};
Dygraph.Circles.TWOCIRCLELINE = function(f, e, c, b, h, d, a, k, l) {	//포인트 디자인 O----O
	c.strokeStyle = d;
	c.fillStyle = d;
	c.beginPath();
	c.arc(b, h, a, 0, 2 * Math.PI, false);
	c.moveTo(b, h);
	c.lineTo(l, h);
	c.arc(l, h, a, 0, 2 * Math.PI, false);
	c.fill();
	c.stroke();
	c.closePath();
};
Dygraph.prototype.parseArray_ = function(c) {	//Data 패턴 수정   [[[시작, 종료], y, y2]],[[시작, 종료], y, y2]],.......]
	if (c.length === 0) {
		this.error("Can't plot empty data set");
		return null;
	}
	if (c[0].length === 0) {
		this.error("Data set cannot contain an empty row");
		return null;
	}
	var a;
	if (this.attr_("labels") === null) {
		this.warn("Using default labels. Set labels explicitly via 'labels' in the options parameter");
		this.attrs_.labels = ["X"];
		for ( a = 1; a < c[0].length; a++) {
			this.attrs_.labels.push("Y" + a);
		}
		this.attributes_.reparseSeries();
	} else {
		var b = this.attr_("labels");
		if (b.length != c[0].length) {
			this.error("Mismatch between number of labels (" + b + ") and number of columns in array (" + c[0].length + ")");
			b=null;
			return null;
		}
	}
	//<----수정
	if (Dygraph.isDateLike(c[0][0][0])) {	
		this.attrs_.axes.x.valueFormatter = Dygraph.dateString_;
		this.attrs_.axes.x.ticker = Dygraph.dateTicker;
		this.attrs_.axes.x.axisLabelFormatter = Dygraph.dateAxisFormatter;
		var d = Dygraph.clone(c);
		for ( a = 0; a < c.length; a++) {
			d[a][0][0] = c[a][0][0].getTime();		//시작 시간(기준)
			d[a][0][1] = c[a][0][1].getTime();	//종료 시간
		}
		return d;
	//------>
	} else {
		this.attrs_.axes.x.valueFormatter = function(e) {
			return e;
		};
		this.attrs_.axes.x.ticker = Dygraph.numericLinearTicks;
		this.attrs_.axes.x.axisLabelFormatter = Dygraph.numberAxisLabelFormatter;
		return c;
	}
};

DygraphLayout.prototype._evaluateLineCharts = function() {	//라인 데이터 변경
	var c = this.attr_("connectSeparatedPoints");
	var k = this.attr_("stackedGraph");
	var e = this.attr_("errorBars") || this.attr_("customBars");
	var a,d;
	for (a = 0; a < this.points.length; a++) {
		var l = this.points[a];
		var f = this.setNames[a];
		var b = this.dygraph_.axisPropertiesForSeries(f);
		var g = this.dygraph_.attributes_.getForSeries("logscale", f);
		for (d = 0; d < l.length; d++) {
			var i = l[d];
			i.x = (i.xval - this.minxval) * this.xscale;
			//<----추가
			i.x2 = (i.xval2 - this.minxval) * this.xscale;	//종료시간 저장
			//----->
			var h = i.yval;
			if (k) {
				i.y_stacked = DygraphLayout._calcYNormal(b, i.yval_stacked, g);
				if (h !== null && !isNaN(h)) {
					h = i.yval_stacked;
				}
			}
			if (h === null) {
				h = NaN;
				if (!c) {
					i.yval = NaN;
				}
			}
			i.y = DygraphLayout._calcYNormal(b, h, g);
			if (e) {
				i.y_top = DygraphLayout._calcYNormal(b, h - i.yval_minus, g);
				i.y_bottom = DygraphLayout._calcYNormal(b, h + i.yval_plus, g);
			}
			u=null;h=null;
		}
		l=null;f=null;b=null;g=null;
	}
	a=null;d=null;
};

Dygraph.seriesToPoints_ = function(b, j, d, f) {	//포인트 지점 
	var h = [];
	for (var c = 0; c < b.length; ++c) {
		var k = b[c];
		var a = j ? k[1][0] : k[1];
		var e = a === null ? null : DygraphLayout.parseFloat_(a);
		var g = {
			x : NaN,
			x2 : NaN,
			y : NaN,
			//<----추가/수정
			xval : DygraphLayout.parseFloat_(k[0][0]),	//시작 시간
			xval2 : DygraphLayout.parseFloat_(k[0][1]),	//종료 시간
			//---->
			yval : e,
			name : d,
			fileName : k[0][2],
			idx : c + f
		};
		if (j) {
			g.y_top = NaN;
			g.y_bottom = NaN;
			g.yval_minus = DygraphLayout.parseFloat_(k[1][1]);
			g.yval_plus = DygraphLayout.parseFloat_(k[1][2]);
		}
		h.push(g);
		k=null;a=null;e=null;g=null;
	}
	return h;
};

DygraphCanvasRenderer.prototype._updatePoints = function() {	//포인트 업데이트
	var e = this.layout.points;
	var c, b;
	for (c = e.length; c--; ) {
		var d = e[c];
		for (b = d.length; b--; ) {
			var a = d[b];
			a.canvasx = this.area.w * a.x + this.area.x;
			//<----추가
			a.canvasx2 = this.area.w * a.x2 + this.area.x;	//종료 시간 지점
			//----->
			a.canvasy = this.area.h * a.y + this.area.y;
			a=null;
		}
		d=null;
	}
	e=null;c=null;b=null;
};

Dygraph.prototype.updateSelection_ = function(d) {	//포인트 선택
	this.cascadeEvents_("select", {
		selectedX : this.lastx_,
		selectedPoints : this.selPoints_
	});
	var h;
	var n = this.canvas_ctx_;
	if (this.attr_("highlightSeriesOpts")) {
		n.clearRect(0, 0, this.width_, this.height_);
		var f = 1 - this.attr_("highlightSeriesBackgroundAlpha");
		if (f) {
			var g = true;
			if (g) {
				if (d === undefined) {
					this.animateSelection_(1);
					return
				}
				f *= d;
			}
			n.fillStyle = "rgba(255,255,255," + f + ")";
			n.fillRect(0, 0, this.width_, this.height_);
			g=null;
		}
		this.plotter_._renderLineChart(this.highlightSet_, n);
		f=null;
	} else {
		if (this.previousVerticalX_ >= 0) {
			var j = 0;
			var k = this.attr_("labels");
			for ( h = 1; h < k.length; h++) {
				var c = this.attr_("highlightCircleSize", k[h]);
				if (c > j) {
					j = c;
				}
				c=null;
			}
			var l = this.previousVerticalX_;
			n.clearRect(l - j - 1, 0, 2 * j + 2, this.height_);
			j=null;k=null;l=null;
		}
	}
	if (this.isUsingExcanvas_ && this.currentZoomRectArgs_) {
		Dygraph.prototype.drawZoomRect_.apply(this, this.currentZoomRectArgs_);
	}
	if (this.selPoints_.length > 0) {
		var b = this.selPoints_[0].canvasx;
		var k = this.selPoints_[0].canvasx2;
		n.save();
		for ( h = 0; h < this.selPoints_.length; h++) {
			var o = this.selPoints_[h];
			if (!Dygraph.isOK(o.canvasy)) {
				continue;
			}
			var a = this.attr_("highlightCircleSize", o.name);
			var m = this.attr_("drawHighlightPointCallback", o.name);
			var e = this.plotter_.colors[o.name];
			if (!m) {
				m = Dygraph.Circles.DEFAULT;
			}
			n.lineWidth = this.attr_("strokeWidth", o.name);
			n.strokeStyle = e;
			n.fillStyle = e;
			//<--- 수정
			m(this.g, o.name, n, b, o.canvasy, e, a, o.idx, k);	//종료지점 추가
			//---->
			o=null;a=null;m=null;e=null;
		}
		n.restore();
		this.previousVerticalX_ = b;
	}
	h=null;
	n=null;
};

DygraphCanvasRenderer._drawSeries = function(v, t, m, h, p, s, g, q) {	//포인트 지점 설정
	var b = null;
	var w = null;
	var k = null;
	var j;
	var o;
	var l = [];
	var f = true;
	var n = v.drawingContext;
	n.beginPath();
	n.strokeStyle = q;
	n.lineWidth = m;
	var c = t.array_;
	var u = t.end_;
	var a = t.predicate_;
	var r;
	for (r = t.start_; r < u; r++) {
		o = c[r];
		if (a) {
			while (r < u && !a(c, r)) {
				r++;
			}
			if (r == u) {
				break;
			}
			o = c[r];
		}
		if (o.canvasy === null || o.canvasy != o.canvasy) {
			if (g && b !== null) {
				n.moveTo(b, w);
				n.lineTo(o.canvasx, w);
			}
			b = w = null;
		} else {
			j = false;
			if (s || !b) {
				t.nextIdx_ = r;
				t.next();
				k = t.hasNext ? t.peek.canvasy : null;
				var d = k === null || k != k;
				j = (!b && d);
				if (s) {
					if ((!f && !b) || (t.hasNext && d)) {
						j = true;
					}
				}
				d=null;
			}
			if (b !== null) {
				if (m) {
					if (g) {
						n.moveTo(b, w);
						n.lineTo(o.canvasx, w);
					}
					n.lineTo(o.canvasx, o.canvasy);
				}
			} else {
				n.moveTo(o.canvasx, o.canvasy);
			}
			if (p || j) {
				//<--- 수정
				l.push([o.canvasx, o.canvasy, o.idx,o.canvasx2]);		//종료시간 지점 추가
				//----->
			}
			b = o.canvasx;
			w = o.canvasy;
		}
		f = false;
	}
	n.stroke();
	b=null;w=null;k=null;j=null;o=null;f=null;n=null;c=null;u=null;a=null;r=null;
	return l;
};

DygraphCanvasRenderer._drawPointsOnLine = function(h, i, f, d, g) {	//포인트 그리기
	var c = h.drawingContext;
	var b;
	for (b = 0; b < i.length; b++) {
		var a = i[b];
		c.save();
		//<--- 수정
		f(h.dygraph, h.setName, c, a[0], a[1], d, g, a[2], a[3]);	//종료 지점 추가
		//----->
		c.restore();
		a=null;
	}
	c=null;b=null;
};

Dygraph.Plugins.Annotations.prototype.didDrawChart = function(v){	//어노 테이션 그리기
	var t = v.dygraph;
	var r = t.layout_.annotated_points;
	
	if (!r || r.length === 0) {
		t=null;r=null;
		return
	}
	var h = v.canvas.parentNode;
	var x = {
		position : "absolute",
		fontSize : t.getOption("axisLabelFontSize") + "px",
		zIndex : 0, 
		overflow : "hidden"
	};
	var b = function(e, g, i) {
		return function(y) {
			var p = i.annotation;
			if (p.hasOwnProperty(e)) {
				p[e](p, i, t, y);
			} else {
				if (t.getOption(g)) {
					t.getOption(g)(p, i, t, y);
				}
			}
			p=null;
		};
	}; 
	var u = v.dygraph.plotter_.area;
	var q = {};
	
	for (var s = 0; s < r.length; s++) {
		var l = r[s];
		if (l.canvasx < u.x || l.canvasx > u.x + u.w || l.canvasy < u.y || l.canvasy > u.y + u.h) {
			continue;
		}
		var w = l.annotation;
		var n = 6;
		if (w.hasOwnProperty("tickHeight")) {
			n = w.tickHeight;
		}
		var j = document.createElement("div");
		for (var A in x) {
			if (x.hasOwnProperty(A)) {
				j.style[A] = x[A];
			}
		}
		//<---추가
		if (w.hasOwnProperty("info")) {		//정보 출력
			w.info.children(".date, .fileName").css({"color":t.colorsMap_[l.name],"text-align":"center"});
			j.appendChild(w.info[0]);
		}
		//----->
		if (!w.hasOwnProperty("icon")) {
			j.className = "dygraphDefaultAnnotation";
		}
		if (w.hasOwnProperty("cssClass")) {
			j.className += " " + w.cssClass;
		}
		var m = w.hasOwnProperty("width") ? w.width : 16;
		var k = w.hasOwnProperty("height") ? w.height : 16;
		if (w.hasOwnProperty("icon")) {
			var z = document.createElement("img");
			z.src = w.icon;
			z.width = m;
			z.height = k;
			j.appendChild(z);
			z=null;
		} else {
			if (l.annotation.hasOwnProperty("shortText")) {
				var p = document.createElement("span");
				p.innerHTML = l.annotation.shortText;
				j.appendChild(p);
				p=null;
			}
		}
		//<---수정
		var c = (l.canvasx + (l.canvasx2 - l.canvasx)/2) - m / 2;	//x 좌표값 수정
		//---->
		j.style.left = c + "px";
		var f = 0;
		if (w.attachAtBottom) {
			var d = (u.y + u.h - k - n);
			if (q[c]) {
				d -= q[c];
			} else {
				q[c] = 0;
			}
			q[c] += (n + k);
			f = d;
			d=null;
		} else {
			//<--- 수정
			f = l.canvasy - 43;	//y 좌표값 
			//----->
		}
		j.style.top = f + "px";
		j.style.width = m + "px";
		//j.style.height = k + "px";	//높이 auto
		j.title = l.annotation.text;
		j.style.color = t.colorsMap_[l.name];
		j.style.borderColor = t.colorsMap_[l.name];
		w.div = j;
		t.addAndTrackEvent(j, "click", b("clickHandler", "annotationClickHandler", l, this));
		t.addAndTrackEvent(j, "mouseover", b("mouseOverHandler", "annotationMouseOverHandler", l, this));
		t.addAndTrackEvent(j, "mouseout", b("mouseOutHandler", "annotationMouseOutHandler", l, this));
		t.addAndTrackEvent(j, "dblclick", b("dblClickHandler", "annotationDblClickHandler", l, this));
		h.appendChild(j);
		this.annotations_.push(j);
//		var o = v.drawingContext;
//		o.save();
		//<----삭제
//		o.strokeStyle = t.colorsMap_[l.name];
//		o.beginPath();
//		if (!w.attachAtBottom) {
//			o.moveTo((l.canvasx + (l.canvasx2 - l.canvasx)/2), l.canvasy);
//			o.lineTo((l.canvasx + (l.canvasx2 - l.canvasx)/2), l.canvasy - 2 - n - 5);
//		} else {
//			var d = f + k;
//			o.moveTo((l.canvasx + (l.canvasx2 - l.canvasx)/2), d);
//			o.lineTo((l.canvasx + (l.canvasx2 - l.canvasx)/2), d + n + 5);
//		}
//		o.closePath();
//		o.stroke();
		//----->
//		o.restore();
		l=null;w=null;n=null;j=null;m=null;k=null;c=null;f=null;
	}
	r=null;h=null;x=null;b=null;u=null;q=null;
};

DygraphLayout.prototype._evaluateAnnotations = function() {	//어노테이션 Data 값 비교
	var d;
	var g = {};
	for ( d = 0; d < this.annotations.length; d++) {
		var b = this.annotations[d];
		//<----- 수정
		g[b.fileName + "," + b.series] = b;	////파일명으로 비교 
		//----->
		b=null;
	}
	this.annotated_points = [];
	if (!this.annotations || !this.annotations.length) {
		d=null;g=null;
		return
	}
	for (var h = 0; h < this.points.length; h++) {
		var e = this.points[h];
		for ( d = 0; d < e.length; d++) {
			var f = e[d];
			//<--- 수정
			var c = f.fileName + "," + f.name;		//파일명으로 비교 
			//----->
			if ( c in g) {
				f.annotation = g[c];
				this.annotated_points.push(f);
			}
			f=null;c=null;
		}
		e=null;
	}
	d=null;g=null;
};

//x축 시간 Format 변경
Date.ext.locales.ko = {
	a : ["일", "월", "화", "수", "목", "금", "토"],
	A : ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
	b : ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"],
	B : ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
	c : "%Y/%b/%d %R",
	p : ["오전", "오후"],
	P : ["AM", "PM"],
	x : "%Y/%b/%d",
	X : "%Y/%b"
};
Date.prototype.locale = "ko-KR";
Date.ext.locales["ko-KR"] = Date.ext.locales.ko;


Dygraph.dateAxisFormatter = function(b, c) {
	if (c >= Dygraph.DECADAL) {
		return b.strftime("%Y");
	} else {
		if (c >= Dygraph.MONTHLY) {
			return b.strftime("%X");	
		} else {
			var a = b.getHours() * 3600 + b.getMinutes() * 60 + b.getSeconds() + b.getMilliseconds();
			if (a === 0 || c >= Dygraph.DAILY) {
				return new Date(b.getTime() + 3600 * 1000).strftime("%x"); //수정
			} else {
				return new Date(b.getTime() + 3600 * 1000).strftime("%c");	//수정
			}
		}
	}
};

Dygraph.Plugins.Legend.prototype.activate = function(j) {	//범례스타일
	var m;
	var f = j.getOption("labelsDivWidth");
	var l = j.getOption("labelsDiv");
	if (l && null !== l) {
		if ( typeof (l) == "string" || l instanceof String) {
			m = document.getElementById(l);
		} else {
			m = l;
		}
	} else {
		var i = {
			position : "absolute",
			fontSize : "14px",
			zIndex : 0,	//수정 부분
			width : f + "px",
			top : "0px",
			left : (j.size().width - f - 2) + "px",
			background : "white",
			lineHeight : "normal",
			textAlign : "left",
			overflow : "hidden"
		};
		Dygraph.update(i, j.getOption("labelsDivStyles"));
		m = document.createElement("div");
		m.className = "dygraph-legend";
		for (var h in i) {
			if (!i.hasOwnProperty(h)) {
				continue;
			}
			try {
				m.style[h] = i[h];
			} catch(k) {
				this.warn("You are using unsupported css properties for your browser in labelsDivStyles");
			}
		}
		j.graphDiv.appendChild(m);
		this.is_generated_div_ = true;
		i=null;
	}
	this.legend_div_ = m;
	this.one_em_width_ = 10;
	m=null;f=null;l=null;
	return {
		select : this.select,
		deselect : this.deselect,
		predraw : this.predraw,
		didDrawChart : this.didDrawChart
	};
};

Dygraph.Plugins.Axes.prototype.willDrawChart = function(H) {	//라벨 스타일
	var F = H.dygraph;
	if (!F.getOption("drawXAxis") && !F.getOption("drawYAxis")) {
		F=null;
		return
	}
	function B(e) {
		return Math.round(e) + 0.5;
	}

	function A(e) {
		return Math.round(e) - 0.5;
	}

	var j = H.drawingContext;
	var v = H.canvas.parentNode;
	var J = H.canvas.width;
	var d = H.canvas.height;
	var s, u, t, E, D;
	var C = function(e) {
		return {
			position : "absolute",
			fontSize : F.getOptionForAxis("axisLabelFontSize", e) + "px",
			zIndex :0,	//수정 부분
			color : F.getOptionForAxis("axisLabelColor", e),
			width : F.getOption("axisLabelWidth") + "px",
			lineHeight : "normal",
			overflow : "hidden"
		};
	};
	var p = {
		x : C("x"),
		y : C("y"),
		y2 : C("y2")
	};
	var m = function(g, x, y) {
		var K = document.createElement("div");
		var e = p[y == "y2" ? "y2" : x];
		for (var r in e) {
			if (e.hasOwnProperty(r)) {
				K.style[r] = e[r];
			}
		}
		var i = document.createElement("div");
		i.className = "dygraph-axis-label dygraph-axis-label-" + x + ( y ? " dygraph-axis-label-" + y : "");
		i.innerHTML = g;
		K.appendChild(i);
		e=null;i=null;
		return K;
	};
	j.save();
	var I = F.layout_;
	var G = H.dygraph.plotter_.area;
	if (F.getOption("drawYAxis")) {
		if (I.yticks && I.yticks.length > 0) {
			var h = F.numAxes();
			for ( D = 0; D < I.yticks.length; D++) {
				E = I.yticks[D];
				if ( typeof (E) == "function") {
					return
				}
				u = G.x;
				//var o = 1;
				var f = "y1";
				if (E[0] == 1) {
					u = G.x + G.w;
					o = -1;
					f = "y2";
				}
				var k = F.getOptionForAxis("axisLabelFontSize", f);
				t = G.y + E[1] * G.h;
				s = m(E[2], "y", h == 2 ? f : null);
				var z = (t - k / 2);
				if (z < 0) {
					z = 0;
				}
				if (z + k + 3 > d) {
					s.style.bottom = "0px";
				} else {
					s.style.top = z + "px";
				}
				if (E[0] === 0) {
					s.style.left = (G.x - F.getOption("yAxisLabelWidth") - F.getOption("axisTickSize")) + "px";
					s.style.textAlign = "right";
				} else {
					if (E[0] == 1) {
						s.style.left = (G.x + G.w + F.getOption("axisTickSize")) + "px";
						s.style.textAlign = "left";
					}
				}
				s.style.width = F.getOption("yAxisLabelWidth") + "px";
				v.appendChild(s);
				this.ylabels_.push(s);
				f=null;k=null;z=null;
			}
			var n = this.ylabels_[0];
			var k = F.getOptionForAxis("axisLabelFontSize", "y");
			var q = parseInt(n.style.top, 10) + k;
			if (q > d - k) {
				n.style.top = (parseInt(n.style.top, 10) - k / 2) + "px";
			}
			h=null;n=null;k=null;q=null;
		}
		var c;
		if (F.getOption("drawAxesAtZero")) {
			var w = F.toPercentXCoord(0);
			if (w > 1 || w < 0 || isNaN(w)) {
				w = 0;
			}
			c = B(G.x + w * G.w);
			w=null;
		} else {
			c = B(G.x);
		}
		j.strokeStyle = F.getOptionForAxis("axisLineColor", "y");
		j.lineWidth = F.getOptionForAxis("axisLineWidth", "y");
		j.beginPath();
		j.moveTo(c, A(G.y));
		j.lineTo(c, A(G.y + G.h));
		j.closePath();
		j.stroke();
		if (F.numAxes() == 2) {
			j.strokeStyle = F.getOptionForAxis("axisLineColor", "y2");
			j.lineWidth = F.getOptionForAxis("axisLineWidth", "y2");
			j.beginPath();
			j.moveTo(A(G.x + G.w), A(G.y));
			j.lineTo(A(G.x + G.w), A(G.y + G.h));
			j.closePath();
			j.stroke();
		}
		c=null;
	}
	if (F.getOption("drawXAxis")) {
		if (I.xticks) {
			for ( D = 0; D < I.xticks.length; D++) {
				E = I.xticks[D];
				u = G.x + E[0] * G.w;
				t = G.y + G.h;
				s = m(E[1], "x");
				s.style.textAlign = "center";
				s.style.top = (t + F.getOption("axisTickSize")) + "px";
				var l = (u - F.getOption("axisLabelWidth") / 2);
				if (l + F.getOption("axisLabelWidth") > J) {
					l = J - F.getOption("xAxisLabelWidth");
					s.style.textAlign = "right";
				}
				if (l < 0) {
					l = 0;
					s.style.textAlign = "left";
				}
				s.style.left = l + "px";
				s.style.width = F.getOption("xAxisLabelWidth") + "px";
				v.appendChild(s);
				this.xlabels_.push(s);
				l=null;
			}
		}
		j.strokeStyle = F.getOptionForAxis("axisLineColor", "x");
		j.lineWidth = F.getOptionForAxis("axisLineWidth", "x");
		j.beginPath();
		var b;
		if (F.getOption("drawAxesAtZero")) {
			var w = F.toPercentYCoord(0, 0);
			if (w > 1 || w < 0) {
				w = 1;
			}
			b = A(G.y + w * G.h);
			w=null;
		} else {
			b = A(G.y + G.h);
		}
		j.moveTo(B(G.x), b);
		j.lineTo(B(G.x + G.w), b);
		j.closePath();
		j.stroke();
	}
	j.restore();
	F=null; j = null;v = null;J = null;d = null;s= null; u= null; t= null; E= null; D= null;C=null;p=null;m=null;I=null;G=null;
}; 


/**
 * @license
 * Copyright 2011 Juan Manuel Caicedo Carvajal (juan@cavorite.com)
 * MIT-licensed (http://opensource.org/licenses/MIT)
 * 
 * dygraph-extra.js
 * Overriding Method
 * Modifier : Park J.C (chrysesevil@nate.com)
 * Date : 2014-10
 */
/**
 * Adds the plot and the axes to a canvas context.
 */
Dygraph.Export.drawPlot = function (canvas, dygraph, options) {
    var ctx = canvas.getContext("2d");

    // Add user defined background
    ctx.fillStyle = options.backgroundColor;
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    // Copy the plot canvas into the context of the new image.
    var plotCanvas = dygraph.hidden_;
    
    var i = 0;
    
    ctx.drawImage(plotCanvas, 0, 0);

    // Add the x and y axes
    var axesPluginDict = Dygraph.Export.getPlugin(dygraph, 'Axes Plugin');
    if (axesPluginDict) {
        var axesPlugin = axesPluginDict.plugin;
        for (i = 0; i < axesPlugin.ylabels_.length; i++) {
            Dygraph.Export.putLabel(ctx, axesPlugin.ylabels_[i], options,
                options.labelFont, options.labelFontColor);
        }
        
        for (i = 0; i < axesPlugin.xlabels_.length; i++) {
            Dygraph.Export.putLabel(ctx, axesPlugin.xlabels_[i], options,
                options.labelFont, options.labelFontColor);
        }
        axesPlugin=null;
    }

    // Title and axis labels

    var labelsPluginDict = Dygraph.Export.getPlugin(dygraph, 'ChartLabels Plugin');
    if (labelsPluginDict) {
        var labelsPlugin = labelsPluginDict.plugin;

        Dygraph.Export.putLabel(ctx, labelsPlugin.title_div_, options, 
            options.titleFont, options.titleFontColor);

        Dygraph.Export.putLabel(ctx, labelsPlugin.xlabel_div_, options, 
            options.axisLabelFont, options.axisLabelFontColor);

        Dygraph.Export.putVerticalLabelY1(ctx, labelsPlugin.ylabel_div_, options, 
            options.axisLabelFont, options.axisLabelFontColor, "center");

        Dygraph.Export.putVerticalLabelY2(ctx, labelsPlugin.y2label_div_, options, 
            options.axisLabelFont, options.axisLabelFontColor, "center");
        labelsPlugin=null;
    }
    var u = dygraph.plotter_.area;	//수정부분
    var r = dygraph.layout_.annotated_points;
	for (i = 0; i < r.length; i++) {
		var l = r[i];
		if (l.canvasx < u.x || l.canvasx > u.x + u.w || l.canvasy < u.y || l.canvasy > u.y + u.h) {
			continue;
		}
        Dygraph.Export.putLabelAnn(ctx, l.annotation, options, 
                options.labelFont, options.labelColor);
        l=null;
    }
	
	ctx=null;plotCanvas=null;i=null;axesPluginDict=null;labelsPluginDict=null;u=null;r=null;
};


/**
 * Draws the text contained in 'divLabel' at the specified position.
 */
Dygraph.Export.putText = function (ctx, left, top, divLabel, font, color) {
    "use strict";
    var textAlign = divLabel.style.textAlign || "left";    
    var text = divLabel.innerText.split(" ") || divLabel.textContent.split(" ");
    var date = text[0];
    var time = text[1] || "";
    ctx.fillStyle = color;
    ctx.font = font;
    ctx.textAlign = textAlign;
    ctx.textBaseline = "middle";
    ctx.fillText(date, left, top);
    ctx.fillText(time, left, top +12);
    textAlign= null;text=null;date=null;time=null;
};

/**
 * Draws a Annotation at the same position 
 * where the div containing the text is located.
 */
Dygraph.Export.putLabelAnn = function (ctx, divLabel, options, font, color) {
    "use strict";
    divLabel = divLabel.div;
    if (!divLabel || !divLabel.style) {
        return;
    }

    var top = parseInt(divLabel.style.top, 10);
    var left = parseInt(divLabel.style.left, 10);

    if (!divLabel.style.top.length) {
        var bottom = parseInt(divLabel.style.bottom, 10);
        var height = parseInt(divLabel.style.height, 10);

        top = ctx.canvas.height - options.legendHeight - bottom - height;
       bottom=null;height=null;
    }

    // FIXME: Remove this 'magic' number needed to get the line-height. 
    top = top + options.magicNumbertop + 20;
    
    var width = parseInt(divLabel.style.width, 10);

    switch (divLabel.style.textAlign) {
    case "center":
        left = left + Math.ceil(width / 2);
        break;
    case "right":
        left = left + width;
        break;
    }

    Dygraph.Export.putTextAnnotation(ctx, left, top, divLabel, font, color, width);
    top=null;left=null;width=null;
};



/**
 * Annotation
 * Draws the text contained in 'divAnnotation' at the specified position.
 */
Dygraph.Export.putTextAnnotation = function (ctx, left, top, divLabel, font, color, width) {
    var date = $(divLabel).find(".date").text();
    var name = $(divLabel).find(".fileName").text();
    color = divLabel.style.color;
    ctx.fillStyle = color;
    ctx.strokeStyle = color;
    ctx.strokeRect(left,top - 22, width,30);
    ctx.font = font;
    ctx.textAlign = "center";
    ctx.textBaseline = "middle";
    ctx.fillText(date, left + width/2, top);
    ctx.fillText(name, left + width/2, top - 12);
    ctx.stroke();
    text=null;text2=null;
};

/**
 * Draws the legend of a dygraph
 *
 */
Dygraph.Export.drawLegend = function (canvas, dygraph, options) {
    var ctx = canvas.getContext("2d");

    // Margin from the plot
    //var labelTopMargin = 10;

    // Margin between labels
    var labelMargin = 5;
    
    var colors = dygraph.getColors();
    // Drop the first element, which is the label for the time dimension
    var labels = dygraph.attr_("labels").slice(1);
    
    // 1. Compute the width of the labels:
    var labelsWidth = 0;
    
    var i;
    for (i = 0; i < labels.length; i++) {
        labelsWidth = labelsWidth + ctx.measureText("- " + labels[i]).width + labelMargin;
    }

    var labelsX = Math.floor((canvas.width - labelsWidth) - 15);
    var labelsY = 10;


    var labelVisibility=dygraph.attr_("visibility");

    ctx.font = options.legendFont;
    ctx.textAlign = "left";
    ctx.textBaseline = "middle";

    var usedColorCount=0;
    for (i = 0; i < labels.length; i++) {
        if (labelVisibility[i]) {
            //TODO Replace the minus sign by a proper dash, although there is a
            //     problem when the page encoding is different than the encoding 
            //     of this file (UTF-8).
            var txt = "- " + labels[i];
            ctx.fillStyle = colors[usedColorCount];
            usedColorCount++;
            ctx.fillText(txt, labelsX, labelsY);
            labelsX = labelsX + ctx.measureText(txt).width + labelMargin;
            txt = null;
        }
    }
    ctx=null;labelMargin=null;colors=null;labels=null;labelsWidth=null;i=null;labelsX=null;labelsY=null;labelVisibility=null;usedColorCount=null;
};