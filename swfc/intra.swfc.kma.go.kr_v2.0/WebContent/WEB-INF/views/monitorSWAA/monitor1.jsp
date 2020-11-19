<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.code.*"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 극항로 항공기상 상황판</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/monitorSWAA.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/perfect-scrollbar.css"/>" />
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<script type="text/javascript"
	src="<c:url value="/js/jquery.layout-latest.min.js"/>"></script>
<style>
#ui-datepicker-div {
	z-index: 9999999 !important;
}

.dygraph-ylabel {
	font-weight: bold;
}
</style>
<script type="text/javascript" src="<c:url value="/js/date.format.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/js/jquery.mousewheel.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/js/perfect-scrollbar.js"/>"></script>

<jsp:include page="../include/dygraph.jsp" />
<script type="text/javascript">
	var imageManager1 = null;
	var imageManager2 = null;
	var imageManager3 = null;
	var imageManager4 = null;

	var searchTime = null;
	var i = 1;
	var ovationFirst = true;
	
	var xmlHttp;
	function srvTime() {
		if(window.XMLHttpRequest) {
			req = new XMLHttpRequest();
		} else if(window.ActiveXObject) {
			req = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlHttp = req;
		xmlHttp.open('HEAD', window.location.href.toString(), false);
		xmlHttp.setRequestHeader("Content-Type", "text/html");
		xmlHttp.send('');
		
		return xmlHttp.getResponseHeader("Date");
	}	

	
	
	var timer = {
		date : new Date(),
		clockTimer : setInterval("timer.clockUpdate()", 1000),
		imageTimer : setInterval("timer.imageUpdate()", 1000 * 60 * 5),
		indicatorTimer : setInterval("timer.indicatorUpdate()", 1000 * 60 * 5),

		clockUpdate : function() {
			//var now = new Date();
			var st = srvTime();
			var now = new Date(st);
			//alert(date2);
			
			$("#utc_date").text(now.format('yyyy.mm.dd', true));
			$("#utc_hour").text(now.format('HH', true));
			$("#utc_minute").text(now.format('MM', true));
			$("#utc_second").text(now.format('ss', true));

			$("#kst_date").text(now.format('yyyy.mm.dd', false));
			$("#kst_hour").text(now.format('HH', false));
			$("#kst_minute").text(now.format('MM', false));
			$("#kst_second").text(now.format('ss', false));

			$("#timeBar").text(
					"현재 상황 - " + now.format('yyyy.mm.dd', true) + "  UTC");

			searchTime = now.format('yyyy/mm/dd', true);

			var year = now.format('yyyy', true);
			var month = now.format('mm', true);
			var date = now.format('dd', true);
			var hour = now.format('HH', true);
			var mtimer = now.format('MM', true);
			var stimer = now.format('ss', true);

			var reloadTime = now.format('HH:MM:ss', true);
			if (reloadTime == '00:00:00')
				location.reload();

			//극항로 통신 두절 영역 5분 마다 이미지 변경 함수 호출
			if (mtimer % 5 == 0 && stimer == 00) {
				ovationImageRefresh(year, month, date, hour, mtimer);
			}
			//HF통신 전파 흡수 1분 마다 이미지 변경 함수 호출
			if (stimer == 00) {
				drapImageRefresh(year, month, date, hour, mtimer);
			}
		},
		imageUpdate : function() {

		},
		indicatorUpdate : function() {
			$.ajax({
				url : "<c:url value="/monitor/chart_indicator.do"/>"
			}).done(function(data) {
				 
				setElementInfo($("#proton_info1"), data.elements.PROTON);
				setElementInfo($("#proton_info2"), data.elements.PROTON);
				setSummaryValue($("#summary1"), data.notice1);
				setSummaryValue($("#summary2"), data.notice2);
				setSummaryValue($("#summary3"), data.notice3);
			});
		}
	};

	var imageType = null;
	var headerName = null;

	var imageSearchCalendar = {
		imageManager : null,
		initialize : function() {
			var datepickerOption = {
				changeYear : true,
				showOn : "button",
				buttonImage : '<c:url value="/images/monitor/btn_calendar.png"/>',
				buttonImageOnly : true,
				onSelect : function(dateText) {
					imageSearchCalendar.updateMinuteList();
				}
			};

			$("#calendar_image_date").datepicker(datepickerOption).next(".ui-datepicker-trigger").addClass("imgbtn");

			$("#calendar_image_hour").change(function() {
				imageSearchCalendar.updateMinuteList();
			});

			//날짜 선택 후 확인 이벤트 
			$("#calendar_image .btn")
					.click(
							function(e) { 
								var data = $("#calendar_image option:selected").data();
								
								var date = $("#calendar_image_date").val();
								var hour = $("#calendar_image_hour").val();
								var min = $("#calendar_image_min").val();

								var year = date.substring(0, 4);
								var month = date.substring(5, 7);
								var date = date.substring(8);

								//선택한 날짜 저장
								searchTime = year + "/" + month + "/" + date;

								var type = imageType;
								var fileName = null;
								var imageNum = null;
								var root = null;

								switch (imageType) {

								case "HCP_WORLD":
									clearTimeout(playimage);
									playimage = null;
									root = "SUNSPOT";
									imageNum = "image1";
									var calendar_alt = $("#sunspot_alt").val()

									var addr = "<c:url value='/monitorSWAA/loadImageSunspot.do?type=HCP_WORLD&year="
											+ year
											+ "&month="
											+ month
											+ "&date="
											+ date
											+ "&alt="
											+ calendar_alt + "'/>";

									$("#" + imageNum + " img")
											.attr("src", addr);

									break;

								case "HCP_AIRWAY":
									$("#airway_date_year").val(year);
									$("#airway_date_month").val(month);
									$("#airway_date_date").val(date);
									
									root = "SUNSPOT";
									imageNum = "image2";
									var calendar_airway = $("#sunspot_airway")
											.val()

									var addr = "<c:url value='/monitorSWAA/loadImageSunspot.do?type=HCP_AIRWAY&year="
											+ year
											+ "&month="
											+ month
											+ "&date="
											+ date
											+ "&airway="
											+ calendar_airway + "'/>";
									$("#" + imageNum + " img")
											.attr("src", addr);

									var dataString = calendar_airway + "/"
											+ year + "/" + month + "/" + date;
									var value = "value=" + dataString;

									$
											.ajax({
												url : "monitorA.do",
												data : value,
												dataType : "json"
											})
											.success(
													function(data) {

														var calc = data.calc;
														var text = new Array();
														text = calc.split(" ");

														var hr = (text[0] / 60)
																.toFixed(2);
														var uSv = (text[1] / 1000)
																.toFixed(4);
														var mSv = (text[2] / 1000)
																.toFixed(4);

														$("#hr").text(hr);
														$("#uSv").text(uSv);
														$("#mSv").text(mSv);
														
														var airway_text = "";
													
														switch (calendar_airway) {
														case "LAX-ICN":
															airway_text = "LA-인천"
															break;
														case "JFK-ICN":
															airway_text = "뉴욕-인천"
															break;
														case "JFK-ICN-polar":
															airway_text = "뉴욕-인천(polar)"
															break;
														case "DEL-ICN":
															airway_text = "댈러스-인천"
															break;
														case "MSC-ICN":
															airway_text = "모스크바-인천"
															break;
														case "SAT-ICN":
															airway_text = "시애틀-인천"
															break;
														case "IST-ICN":
															airway_text = "이스탄불-인천"
															break;
														case "ICN-LHR":
															airway_text = "인천-런던"
															break;
														case "PAR-ICN":
															airway_text = "파리-인천"
															break;
														}
														
														$("#table_airway").text(airway_text);
														
														var cabinValue = uSv * 800;

														//승무원 경보표시
														if (cabinValue <= 6.0) {
															var html = "<div class='info' id='proton_info'><div class='sign4'><span class='num'></span></div></div>"
															$("#cabin").html(
																	html);
														} else if (cabinValue <= 12.0) {
															var html = "<div class='info' id='proton_info'><div class='sign2'><span class='num'></span></div></div>"
															$("#cabin").html(
																	html);
														} else {
															var html = "<div class='info' id='proton_info'><div class='sign3'><span class='num'></span></div></div>"
															$("#cabin").html(
																	html);
														}

														//임산부 경보표시
														if (mSv <= 0.167) {
															var html = "<div class='info' id='proton_info'><div class='sign4'><span class='num'></span></div></div>"
															$("#pregnancy")
																	.html(html);
														} else if (mSv <= 0.333) {
															var html = "<div class='info' id='proton_info'><div class='sign2'><span class='num'></span></div></div>"
															$("#pregnancy")
																	.html(html);
														} else {
															var html = "<div class='info' id='proton_info'><div class='sign3'><span class='num'></span></div></div>"
															$("#pregnancy")
																	.html(html);
														}

														//일반인 경보표시
														if (mSv <= 0.33) {
															var html = "<div class='info' id='proton_info'><div class='sign4'><span class='num'></span></div></div>"
															$("#man")
																	.html(html);
														} else if (mSv <= 0.67) {
															var html = "<div class='info' id='proton_info'><div class='sign2'><span class='num'></span></div></div>"
															$("#man")
																	.html(html);
														} else {
															var html = "<div class='info' id='proton_info'><div class='sign3'><span class='num'></span></div></div>"
															$("#man")
																	.html(html);
														}

													});

									break;

								case "OVATION":
									root = "OVATION";
									imageNum = "image3";

									var addr = "<c:url value='/monitorSWAA/loadImageOvation.do?year="
											+ year
											+ "&month="
											+ month
											+ "&date="
											+ date
											+ "&hour="
											+ hour
											+ "&minute=" + min + "'/>";

									$("#image3 img").attr("src", addr);

									break;

								case "DRAP":
									root = "DRAP";
									imageNum = "image4";
									fileName = "drap.jpg";

									var addr = "<c:url value='/monitorSWAA/loadImageDrap.do?year="
											+ year
											+ "&month="
											+ month
											+ "&date="
											+ date
											+ "&hour="
											+ hour
											+ "&minute=" + min + "'/>";

									$("#image4 img").attr("src", addr);

									break;
								}
								
								$("#calendar_image").hide();

							});

			$("#calendar_image .close").click(function() {
				$("#calendar_image").hide();
			});
		},

		updateMinuteList : function() {
			
		},

		show : function(manager, offset) {
			 
			this.imageManager = manager;

			$("#calendar_image_date").val(manager.currentDate.format("yyyy-mm-dd"));
			$("#calendar_image_hour").val(manager.currentDate.format("HH"));

			if (manager.dataList != null) {
				$.each(manager.dataList, function(key, val) {
					var date = new Date(val.createDate);
					var minute = date.format("MM");
					var option = $("<option>", {
						value : minute,
						text : minute,
						data : val
					});
				});
			}

			var calendar = $("#calendar_image");

			calendar.css('top', offset.top + 24);
			calendar.css('left', offset.left - 80);
			calendar.show();

			//캘린더 버튼 실행 구분
			var width = $("#wrap_left").width();
			var standard = width / 4;

			if (offset.left < standard) {
				imageType = "HCP_WORLD";
				headerName = $("#imageText1").text();
			} else if (offset.left < standard * 2) {
				imageType = "HCP_AIRWAY";
				headerName = $("#imageText2").text();
			} else if (offset.left < standard * 3) {
				imageType = "OVATION";
				headerName = $("#imageText3").text();
			} else {
				imageType = "DRAP";
				headerName = $("#imageText4").text();
			}

		},
		hide : function() {
			$("#calendar_image").hide();
		}
	};

	var chartCalendar = {
		calendarButton : null,
		initialize : function() {
			var datepickerOption = {
				changeYear : true,
				showOn : "button",
				buttonImage : '<c:url value="/images/monitor/btn_calendar.png"/>',
				buttonImageOnly : true
			};

			$("#wrap_graph .calendar").click(function(e) {
				chartCalendar.show($(this));
				e.defaultPrevented = true;
				return false;
			});

			$("#calendar_chart_start_date").datepicker(datepickerOption).next(
					".ui-datepicker-trigger").addClass("imgbtn");
			$("#calendar_chart_end_date").datepicker(datepickerOption).next(
					".ui-datepicker-trigger").addClass("imgbtn");

			var now = timer.date;
			var yes = new Date();
			yes.setDate(now.getDate() - 1);

			$("#wrap_graph .calendar")
					.each(
							function() {
									
								var calendarButton = $(this);
								var chartType = calendarButton.parents(
										".gr_graph").children('.graph').attr(
										'id');
								$(this).data({
									type : chartType,
									sd : yes.format('yyyy-mm-dd', true),
									ed : now.format('yyyy-mm-dd', true),
									autoRefresh : true
								});

								calendarButton.parents(".header").find('h2 a')
										.click(
												function(e) {
													$(this).addClass("on");
													$(this).parents(".header")
															.find('.glist')
															.toggle();
													var data = calendarButton
															.data();

													calendarOn = true;

													//				data.autoRefresh = true;
													//				chartGraphManager.setAutoRefreshLayer(data.type, true);
													//				chartGraphManager.autoRefresh();

													e.defaultPrevented = true;
													return false;
												});
								//*****추가
								calendarButton
										.parents(".header")
										.find('.glist li')
										.click(
												function(e) {
													calendarOn = false;
													var selected = $(this);
													selected.parent().hide();
													var type = selected
															.children().val();

													var removeId = selected
															.parents(".header")
															.next().attr("id");
													var data = calendarButton
															.data();
													//중복 체크
													if (type != removeId) {
														data.type = type;
														data.popup = type;
														chartGraphManager
																.remove(
																		removeId,
																		"");
														var idx = "";
														if ($("#" + type).length > 0) {
															idx = selected
																	.parents(
																			".header")
																	.parent()
																	.index();
															data.type = type
																	+ idx;
														}
														selected
																.parents(
																		".header")
																.find(
																		'h2 a span')
																.text(
																		selected
																				.text());
														var div = selected
																.parents(
																		".header")
																.find('.ginfo')
																.attr(
																		{
																			"id" : type
																					+ "_LABELS_DIV"
																					+ idx
																		});
														var box = selected
																.parents(
																		".header")
																.next()
																.attr(
																		{
																			"id" : type
																					+ idx
																		})
																.empty();
														var chartOption = {
															axisLabelColor : 'white',
															"div" : div,
															"box" : box
														};

														if (type == "ACE_MAG") { //ACE IMF 자기장
															chartGraphManager
																	.addAceMag({
																		axisLabelColor : 'white',
																		colors : [
																				'cyan',
																				'blue',
																				'red',
																				'yellow' ],
																		"div" : div,
																		"box" : box
																	});
														} else if (type == "ACE_SOLARWIND_SPD") { //ACE 태양풍 속도
															chartGraphManager
																	.addAceSolarWindSpeed(chartOption);
														} else if (type == "ACE_SOLARWIND_DENS") { //ACE 태양풍 밀도
															chartGraphManager
																	.addAceSolarWindDens({
																		axisLabelColor : 'white',
																		colors : [ 'red' ],
																		"div" : div,
																		"box" : box
																	});
														} else if (type == "ACE_SOLARWIND_TEMP") { //ACE 태양풍 온도
															chartGraphManager
																	.addAceSolarWindTemp({
																		axisLabelColor : 'white',
																		colors : [ 'red' ],
																		"div" : div,
																		"box" : box
																	});
														} else if (type == "MAGNETOPAUSE_RADIUS") { //자기권계면
															chartGraphManager
																	.addMagnetopauseRadius(chartOption);
														} else if (type == "XRAY_FLUX") { //X-선 플럭스
															chartGraphManager
																	.addXRayFlux({
																		axisLabelColor : 'white',
																		colors : [
																				'cyan',
																				'red' ],
																		"div" : div,
																		"box" : box
																	});
														} else if (type == "PROTON_FLUX") { //양성자 플럭스
															chartGraphManager
																	.addProtonFlux(chartOption);
														} else if (type == "ELECTRON_FLUX") { //전자기 플럭스
															chartGraphManager
																	.addElectronFlux({
																		axisLabelColor : 'white',
																		colors : [
																				'cyan',
																				'red' ],
																		"div" : div,
																		"box" : box
																	});
														} else if (type == "KP_INDEX_SWPC") { //Kp 지수
															chartGraphManager
																	.addKpIndexSwpc(chartOption);
														} else if (type == "DST_INDEX_KYOTO") { //Dst 지수
															chartGraphManager
																	.addDstIndexKyoto(chartOption);
														}
														var now = timer.date;
														var yes = new Date();
														yes.setDate(now
																.getDate() - 1);
														data.sd = yes.format(
																'yyyy-mm-dd',
																true);
														data.ed = now.format(
																'yyyy-mm-dd',
																true);
														chartGraphManager
																.resize(
																		$(
																				"#wrap_graph .graph")
																				.width(),
																		$(
																				"#wrap_graph .graph")
																				.height());
													}
													data.autoRefresh = true;
													chartGraphManager
															.setAutoRefreshLayer(
																	data.type,
																	true);
													chartGraphManager
															.autoRefresh();
													e.defaultPrevented = true;
													return false;
												});
								//*****추가

							});

			$("#wrap_graph .detail").click(function(e) {
				var calendarButton = $(this).prev();
				var data = calendarButton.data();
				var url = "chart_popup.do?" + $.param(calendarButton.data());
				if(data.popup != null){	//중복되는 그래프면
					url = "chart_popup.do?type="  + data.popup + "&sd=" + data.sd +"&ed=" + data.ed + "&autoRefresh=" + data.autoRefresh;
				}
				window.open(url, '_blank','width=1024,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
				e.defaultPrevented = true;
				return false;
			});

			$("#calendar_chart .btn").click(
					function(e) {
						e.defaultPrevented = true;
						var calendarButton = chartCalendar.calendarButton;
						var chartType = calendarButton.data().type;
						var startDate = $("#calendar_chart_start_date").val();
						var endDate = $("#calendar_chart_end_date").val();
						if (startDate == "") {
							alert("시작일을 입력하세요!");
							return false;
						}

						if (endDate == "") {
							alert("종료일을 입력하세요!");
							return false;
						}

						calendarButton.data({
							sd : startDate,
							ed : endDate,
							autoRefresh : false
						});

						calendarButton.parents(".header").find('h2 a')
								.removeClass("on");
						chartGraphManager.load({
							sd : startDate.replace(/-/gi, '') + "000000",
							ed : endDate.replace(/-/gi, '') + "230000",
							type : chartType
						});

						chartCalendar.hide();
						return false;
					});

			$("#calendar_chart .close").click(function(e) {
				chartCalendar.hide();
				e.defaultPrevented = true;
				return false;
			});
		},

		show : function(calendarButton) {
			calendarOn = true;
			chartCalendar.calendarButton = calendarButton;

			var offset = calendarButton.offset();
			var calendarData = calendarButton.data();

			$("#calendar_chart_start_date").val(calendarData.sd);
			$("#calendar_chart_end_date").val(calendarData.ed);

			var calendar = $("#calendar_chart");
			calendar.css('top', offset.top + 25);
			calendar.css('left', offset.left - 139);
			$("#ui-datepicker-div").css("z-index", 20);
			calendar.show();
		},
		hide : function() {
			calendarOn = false;
			$("#calendar_chart").hide();
		}
	};

	function setSummaryValue(obj, data) {
		if (data != null) {
			obj.children(".num").text(data.code);
			var textObj = obj.children(".txt");
			textObj.text(data.gradeText);
			obj.removeClass("w g b y o r");
			textObj.removeClass("fw fg fb fy fo fr");
			switch (data.code) {
			case 0:
				obj.addClass("w");
				textObj.addClass("fw");
				break;
			case 1:
				obj.addClass("g");
				textObj.addClass("fg");
				break;
			case 2:
				obj.addClass("b");
				textObj.addClass("fb");
				break;
			case 3:
				obj.addClass("y");
				textObj.addClass("fy");
				break;
			case 4:
				obj.addClass("o");
				textObj.addClass("fo");
				break;
			case 5:
				obj.addClass("r");
				textObj.addClass("fr");
				break;
			}
			;
		} else {
			obj.children(".num").text("");
			var textObj = obj.children(".txt");
			textObj.text("없음");
			obj.removeClass("w g b y o r");
			textObj.removeClass("fw fg fb fy fo fr");
		}
	}

	function toExponential(val) {
		return (val > 10000 || val < 0.0001) ? val.toExponential() : val;
	}

	function setElementInfo(obj, data, prefix) {
		var sign = obj.children(".sign");
		var message = obj.find(".txt");
		var isKp = false;
		var emptyH3 = true;
		sign.removeClass("w g b y o r");
		message.removeClass("fw fg fb fy fo fr");

		var signText = "";
		var messageText = "없음";
		var H0Text = "";
		var H3Text = "";
		var H3Text2 = "";
		var H6Text = "";
		var H24Text = "";
		if (data != null) {
			if (data.NOW != null) {
				H0Text = toExponential(data.NOW.val) + " pfu";
			}

			if (data.H3 != null) {
				emptyH3 = false;
				switch (data.H3.code) {
				case 0:
					sign.addClass("w");
					message.addClass("fw");
					break;
				case 1:
					sign.addClass("g");
					message.addClass("fg");
					break;
				case 2:
					sign.addClass("b");
					message.addClass("fb");
					break;
				case 3:
					sign.addClass("y");
					message.addClass("fy");
					break;
				case 4:
					sign.addClass("o");
					message.addClass("fo");
					break;
				case 5:
					sign.addClass("r");
					message.addClass("fr");
					break;
				}
				; 
				
				signText = data.H3.grade;
				messageText = data.H3.gradeText;

				var month = data.H3.tm.substring(4, 6);
				var day = data.H3.tm.substring(6, 8);
				var hour = data.H3.tm.substring(8, 10);
				var minute = data.H3.tm.substring(10, 12);
				H3Text = toExponential(data.H3.val) + " pfu";
				H3Text2 = "(" + month + "." + day 	+ " " + hour + ":" + minute + ")";
			}

			var tmpSign = "";
			var tmpMsg = "";
			var tmpSignText = "";
			var tmpMessageText = "";
				
			if (data.H6 != null) {
				isKp = true;
				switch (data.H6.code) {
				case 0:
					tmpSign = "w";
					tmpMsg = "fw";
					break;
				case 1:
					tmpSign = "g";
					tmpMsg = "fg";
					break;
				case 2:
					tmpSign = "b";
					tmpMsg = "fb";
					break;
				case 3:
					tmpSign = "y";
					tmpMsg = "fy";
					break;
				case 4:
					tmpSign = "o";
					tmpMsg = "fo";
					break;
				case 5:
					tmpSign = "r";
					tmpMsg = "fr";
					break;
				}
				;

				tmpSignText = data.H6.grade;
				tmpMessageText = data.H6.gradeText;

				var month = data.H6.tm.substring(4, 6);
				var day = data.H6.tm.substring(6, 8);
				var hour = data.H6.tm.substring(8, 10);
				var minute = data.H6.tm.substring(10, 12);
				H6Text = toExponential(data.H6.val) + " (" + month + "." + day
						+ " " + hour + ":" + minute + ")";
			}
			if (data.D1 != null) {
				H24Text = toExponential(data.D1.val) + " pfu";
			}
		}
		
		if(signText != null) signText = signText.substring(1,2);
		sign.children(".num").text(signText);
		message.text(messageText);

		var now = obj.find("p span:first");
		now.text("현재: " + H0Text);
		if (isKp) {
			if (emptyH3) {
				sign.addClass(tmpSign);
				message.addClass(tmpMsg);

				sign.children(".num").text(tmpSignText);
				message.text(tmpMessageText);

				now.next().text("6시간 최대값: " + H6Text);
			} else {
				now.next().text("3시간 최대값: " + H3Text);
			}
		} else {
			now.next().text("3시간 최대값: " + H3Text);
			now.next().next().text(H3Text2);
		}
		now.next().next().next().html("24시간 최대값: " + H24Text);
	}

	function ImageManager() {
		this.container = null;
		this.imageTypeList = null;
		this.title = null;
		this.currentDate = new Date();
		this.dateLabel = null;
		this.dataList = null;
		this.currentData = null;
		this.image = null;
		this.viewMovie = false;
		this.realtime = true;
	};

	function pad(val, len) {
		var valString = String(val);
		len = len || 2;
		while (valString.length < len)
			valString = "0" + valString;
		return valString;
	};

	ImageManager.prototype.initialize = function(container) {
		var manager = this;
		this.container = container;
		this.imageTypeList = container.find(".header .alist");
		this.title = container.find(".header h2 a").last();
		this.dateLabel = container.find(".header .date span");
		this.image = container.find(".contents img");

		this.container.find(".header h2 a").click(function(e) {
			imageSearchCalendar.hide();
			manager.imageTypeList.toggle();
			e.defaultPrevented = true;
			return false;
		});

		this.imageTypeList.children("a").click(function(e) {
			manager.container.find(".date .vod").removeClass("on");
			manager.viewMovie = false;

			var code = $(this).attr("name");
			var text = $(this).text();
			manager.title.text(text);
			manager.title.attr("name", code);
			manager.imageTypeList.hide();
			e.defaultPrevented = true;
			return false;
		});

		//	this.title.click(function(e) {
		//		manager.realtime = true;
		//		manager.load();
		//	});

		this.container.find(".date .calendar").click(function(e) {
			var buttonOffset = $(this).offset();
			imageSearchCalendar.show(manager, buttonOffset);
			e.defaultPrevented = true;
			return false;
		});

		//이미지 회전 이벤트
		this.container.find(".date .vod").click(function(e) {

			var heightValue = $("#sunspot_alt").val();
			var heightAir = null;

			switch (heightValue) {
			case "0":
				heightAir = "LEV_0";
				break;
			case "50":
				heightAir = "LEV_50";
				break;
			case "75":
				heightAir = "LEV_75";
				break;
			case "100":
				heightAir = "LEV_100";
				break;
			}

			var playOnOff = $(this).attr("class");

			var onOff = null;
			if (playOnOff == "vod") {
				onOff = "on";
				playImage(onOff, heightAir);

			} else {
				onOff = "off";
				playImage(onOff, heightAir);
			}

			$(this).toggleClass("on");
			manager.viewMovie = $(this).hasClass("on");
			e.defaultPrevented = true;
			return false;

		});

		this.setDate(new Date());
	};

	ImageManager.prototype.setDate = function(date) {
		this.currentDate = date;
		if (date != null) {
			this.dateLabel.text(date.format("yyyy.mm.dd HH:MM"));
		} else {
			this.dateLabel.text("");
		}
	}

	ImageManager.prototype.setRealtime = function(realtime) {
		if (realtime) {
			this.title.addClass("on");
		} else {
			this.title.removeClass("on");
		}
	}

	ImageManager.prototype.isRealtime = function() {
		return this.title.addClass("on");
	}
	var setTime = null;
	$(window).resize(function() {
		clearTimeout(setTime);
		setTime = setTimeout(onResize, 200);
	});
	//resize

	function onResize() {
		clearTimeout(setTime);
		/* *
		 * Min 800 X ?
		 */
		var bodyWidth = $(window).width() < 1024 ? 1024 : $(window).width(); //너비
		var limiteHeight = 800; //최소 높이
		//최소 높이 조절
		if (bodyWidth < 1761) {
			limiteHeight = 700;
		}

		var bodyHeight = $(window).height() < limiteHeight ? limiteHeight : $(
				window).height(); //높이

		//WARP 리사이즈
		$("#wrap").width(bodyWidth);
		$("#wrap").height(bodyHeight);
		//alert($(".gr_img").width());
		
		 
		
		//너비 체크
		if (bodyWidth < 1761) {
			$("#wrap, #header").addClass("width1760");// 클래스 추가
			//alert("1700이하");
			if (bodyWidth < 1200) { 
				$("#wrap, #header").addClass("width1200");
				//$(".sign1, .sign2, .sign3, .sign4").addClass("width1200");
				 
			} else {
				$("#wrap, #header").addClass("width1760");
				$("#wrap, #header").removeClass("width1200");
				//$(".sign1, .sign2, .sign3, .sign4").addClass("width1760");
				 
			}
		} else {
			//alert("1700이상");
			$("#wrap, #header").removeClass();
			$(".sign1, .sign2, .sign3, .sign4").removeClass("width1200");
			$(".sign1, .sign2, .sign3, .sign4").removeClass("width1760");
			$("#wrap_left").removeAttr("style");
			 
		}
		
		//이미지 헤더 폰트 
		var imgHeadtxt = $(".gr_img").width();  
		if(imgHeadtxt>360){ 
			$(".addBr").addClass("show");
			$("#imageText1").width(imgHeadtxt);
			$("#imageText2").width(imgHeadtxt);
		}else{ 
			$(".addBr").removeClass("show");
			$("#imageText1").width(180);
			$("#imageText2").width(180);
		}
		 
		//Info 리사이즈

		var contentHeight = bodyHeight - $("#header").outerHeight();

		var imagesize = $(".gr_img").height();

		var infoHeight = imagesize * 0.38;
		var infoTHeight = imagesize * 0.50;
		var infoTConHeight = infoTHeight
				- $(".wrap_info .header").outerHeight();
		var infoConHeight = infoHeight - $(".wrap_info .header").outerHeight();

		var warp_dec1 = 30;
		var warp_dec2 = 60;
		var info_dec1 = 95;
		var info_dec2 = 40;
		if (bodyWidth < 1761) {
			warp_dec1 = 25;
			warp_dec2 = 40;
			info_dec1 = 65;
			info_dec2 = 30;
		}

		
		$(".wrap_info").height(infoHeight - warp_dec1); //우주기상 특보상황
		$(".wrap_info:first").height(infoTHeight - warp_dec2); //나머지
		$(".info_total").css({
			"height" : infoTConHeight,
			"line-height" : infoTConHeight - info_dec1 + "px"
		}); //우주기상 특보상황 내용
		$(".info").css({
			"padding-left" : "3%",
			"line-height" : infoConHeight - info_dec2 + "px"
		}); //나머지 내용
		$(".sign_wrap")
				.css(
						{
							"padding-left" : ($(".info_total").width() - $(
									".sign_wrap").width() * 3) / 8
						});

		//table 리사이즈 
		var bodysize = $("body").height();
		var tt1 = $(".contents").height();
		var contentH = $("#wrap").height();
	 
		var tableHeight = $("#wrap_left").height();
		var tableWidth = $("#wrap_left").width() * 0.99;
		var header = $(".header").height();
		$(".tableDiv").height(tableHeight); 

		var tableDiv = $(".wrap_right").height();
		var gr_img_table  = $(".gr_img_table ").height();
		var gr_graph_table = $(".gr_graph_table  ").height();
		var tableDiv = $(".tableDiv").height();
		var mtable = $(".mtable").height();
		var tableHeader = $("#tableHeader").height();
		  
		$(".mtable").height(contentH/2.5-header).width(tableWidth / 2);
		 
		var mtable2 = $(".mtable").height();  
		var wrap_right_height = $("#wrap_right").height();
		var wrap_right_width = $("#wrap_right").width(); 
		var test = $("#wrap").attr("class");
		
		var chartsize = $("#wrap_b_right ").height();
		var tablesize = $("#wrap_b_left ").height();
				
		var bodyheight = $("body");
		var wrap_b_left  = $("#wrap_b_left");
		var tableHeader = $("#tableHeader ");
		var gr_img_table = $(".gr_img_table");
		var gr_graph_table  = $(".gr_graph_table ");
		var tableDiv = $(".tableDiv ");
		var mtable = $(".mtable");
			
		var outerTable = $(".gr_img").outerHeight()+$("#header").outerHeight();
			
		var tableH= bodyheight.height() - outerTable;
		wrap_b_left.height(tableH);
		gr_img_table.height(tableH);
		gr_graph_table.height(tableH-tableHeader.height());
		tableDiv.height(tableH-tableHeader.height());
		mtable.height(tableH-tableHeader.height()*2.5);
		
		
		
	   if (wrap_right_width < 200) { 
			$(".signt").addClass("width99");// 클래스 추가
			$(".sign").addClass("width99");
			$(".info").addClass("width99"); 
		}else{
			$(".info").removeClass("width99"); 
			$(".signt").removeClass("width99"); 
			$(".sign").removeClass("width99"); 
		}  
	   
	   if (wrap_right_width < 150) { 
			$(".signt").addClass("widthMin");// 클래스 추가
			$(".sign").addClass("widthMin");
			$(".info").addClass("widthMin"); 
		}else{
			$(".info").removeClass("widthMin"); 
			$(".signt").removeClass("widthMin"); 
			$(".sign").removeClass("widthMin"); 
		}    
	 
	   
	   //alert($("#wrap").attr("class"));
	   //alert($(".signt").attr("class"));
	   
		//그래프 박스 리사이즈
		var graphHeight1 = ((bodyHeight - $("#header").outerHeight()) - $( "#wrap_img").outerHeight()) / 2;
		var graphHeight = graphHeight1 / 2 - 10; 
		if (slice) { 
			$("#wrap_graph .gr_graph").width($("#wrap_left").width() * 0.67)
					.height(graphHeight );
			$("#wrap_graph .graph").height(graphHeight - $(".gr_graph .header").outerHeight());
			$("#wrap_graph .graph").width($(".gr_graph").width() - 2).css("padding", "5px");
			$("#wrap_graph").width("100%").height(graphHeight / 4 - 2);
			 
			var chartH = tableH-tableHeader.height();
			$(".wrap_b_right").height(chartH);
			$(".wrap_graph").height(chartH);			
			$(".gr_graph").height(chartH/2);
			$(".graph").height(chartH/2-tableHeader.height());
			 
		} else { 
			 graphHeight = bodyHeight - $("#header").outerHeight()
					- $("#wrap_img").outerHeight();
			$("#wrap_graph .gr_graph").width($("#graph2").width()).height(
					graphHeight - 2);
			$("#wrap_graph .graph").height(
					graphHeight / 2 - $(".gr_graph .header").outerHeight());
			$("#wrap_graph .graph").width($(".gr_graph").width() - 2).css(
					"padding", "5px");
			$("#wrap_graph").width($("#wrap_graph .graph").outerWidth())
					.height(graphHeight - 2);  
		 	 
			$(".gr_graph").height($(".gr_graph").height()*5);
			  
			 $.each($("#wrap_graph .gr_graph"), function() {
				var now = $(this);   
				if (!now.hasClass("selected")) { 
					// now.css("left", $("#wrap_graph .graph").outerWidth());
					now.css("display", "none");  
				} else { 
					now.css("display", "block");  
					 //now.css("left", 0); 
				}
			});    
		}

		//그래프 리사이즈

		chartGraphManager.resize($("#wrap_graph .graph").width() - 10, $(
				"#wrap_graph .graph").height() - 10);

		//스크롤바 리사이즈
		$("#scrollBar").width($(window).width());
		$("#scrollBar").height($(window).height());
		$("#scrollBar").perfectScrollbar("update");
	};

	//방사선 순간 피폭량 이미지 변경
	function image1Change(imageNum, listNum) {
		i = 1;
		clearTimeout(playimage);
		playimage = null;

		switch (listNum) {
		case "list1":
			alt = "0";
			break;
		case "list2":
			alt = "50";
			break;
		case "list3":
			alt = "75";
			break;
		case "list4":
			alt = "100";
			break;
		}

		$("#sunspot_alt").val(alt);

		var year = $("#refresh_year").val();
		var month = $("#refresh_month").val();
		var date = $("#refresh_date").val();

		var addr = "<c:url value='/monitorSWAA/loadImageSunspot.do?type=HCP_WORLD&year="
				+ year
				+ "&month="
				+ month
				+ "&date="
				+ date
				+ "&alt="
				+ alt
				+ "'/>";

		$("#" + imageNum + " img").attr("src", addr);

	}

	//항공로별 순간 피폭량 이미지 변경
	function image2Change(imageNum, listNum) {

		var airway_text = "";
		
		switch (listNum) {
		case "list1":
			airway = "LAX-ICN";
			airway_text = "LA-인천"
			break;
		case "list2":
			airway = "JFK-ICN";
			airway_text = "뉴욕-인천"
			break;
		case "list3":
			airway = "JFK-ICN-polar";
			airway_text = "뉴욕-인천(polar)"
			break;
		case "list4":
			airway = "DEL-ICN";
			airway_text = "댈러스-인천"
			break;
		case "list5":
			airway = "MSC-ICN";
			airway_text = "모스크바-인천"
			break;
		case "list6":
			airway = "SAT-ICN";
			airway_text = "시애틀-인천"
			break;
		case "list7":
			airway = "IST-ICN";
			airway_text = "이스탄불-인천"
			break;
		case "list8":
			airway = "ICN-LHR";
			airway_text = "인천-런던"
			break;
		case "list9":
			airway = "PAR-ICN";
			airway_text = "파리-인천"
			break;
		}
		$("#sunspot_airway").val(airway);
		
				
		var year = $("#refresh_year").val();
		var month = $("#refresh_month").val();
		var date = $("#refresh_date").val();
		if($("#airway_date_year").val() != "") {
			year = $("#airway_date_year").val();
			month = $("#airway_date_month").val();
			date = $("#airway_date_date").val();
		}
		
		var dataString = airway + "/" + year + "/" + month + "/" + date;
		var value = "value=" + dataString;

		$
				.ajax({
					url : "monitorA.do",
					data : value,
					dataType : "json"
				})
				.success(
						function(data) {

							var calc = data.calc;
							var text = new Array();
							text = calc.split(" ");

							var hr = (text[0] / 60).toFixed(2);
							var uSv = (text[1] / 1000).toFixed(4);
							var mSv = (text[2] / 1000).toFixed(4);

							$("#hr").text(hr);
							$("#uSv").text(uSv);
							$("#mSv").text(mSv);
							$("#table_airway").text(airway_text);

							var cabinValue = uSv * 800;

							//승무원 경보표시
							if (cabinValue <= 6.0) {
								var html = "<div class='info' id='proton_info'><div class='sign4'><span class='num'></span></div></div>"
								$("#cabin").html(html);
							} else if (cabinValue <= 12.0) {
								var html = "<div class='info' id='proton_info'><div class='sign2'><span class='num'></span></div></div>"
								$("#cabin").html(html);
							} else {
								var html = "<div class='info' id='proton_info'><div class='sign3'><span class='num'></span></div></div>"
								$("#cabin").html(html);
							}

							//임산부 경보표시
							if (mSv <= 0.167) {
								var html = "<div class='info' id='proton_info'><div class='sign4'><span class='num'></span></div></div>"
								$("#pregnancy").html(html);
							} else if (mSv <= 0.333) {
								var html = "<div class='info' id='proton_info'><div class='sign2'><span class='num'></span></div></div>"
								$("#pregnancy").html(html);
							} else {
								var html = "<div class='info' id='proton_info'><div class='sign3'><span class='num'></span></div></div>"
								$("#pregnancy").html(html);
							}

							//일반인 경보표시
							if (mSv <= 0.33) {
								var html = "<div class='info' id='proton_info'><div class='sign4'><span class='num'></span></div></div>"
								$("#man").html(html);
							} else if (mSv <= 0.67) {
								var html = "<div class='info' id='proton_info'><div class='sign2'><span class='num'></span></div></div>"
								$("#man").html(html);
							} else {
								var html = "<div class='info' id='proton_info'><div class='sign3'><span class='num'></span></div></div>"
								$("#man").html(html);
							}

						});

		var addr = "<c:url value='/monitorSWAA/loadImageSunspot.do?type=HCP_AIRWAY&year="
				+ year
				+ "&month="
				+ month
				+ "&date="
				+ date
				+ "&airway="
				+ airway + "'/>";
		$("#" + imageNum + " img").attr("src", addr);

	}

	$(function() { 
		$("#scrollBar").perfectScrollbar({
			wheelSpeed : 100
		});
		timer.indicatorUpdate();

		imageSearchCalendar.initialize();
		chartCalendar.initialize();

		$(window)
				.load(
						function() {
							imageManager1 = new ImageManager();
							imageManager1.initialize($("#imageManager1"));
							//imageManager1.load();

							imageManager2 = new ImageManager();
							imageManager2.initialize($("#imageManager2"));
							//imageManager2.load();

							imageManager3 = new ImageManager();
							imageManager3.initialize($("#imageManager3"));
							//imageManager3.load();

							imageManager4 = new ImageManager();
							imageManager4.initialize($("#imageManager4"));
							//imageManager4.load();

							var chartOption = {
								axisLabelColor : 'white'
							};
							chartGraphManager.addXRayFlux({
								axisLabelColor : 'white',
								colors : [ 'cyan', 'red' ]
							});
							chartGraphManager.addProtonFlux(chartOption);
							chartGraphManager.addKpIndexSwpc(chartOption);
							chartGraphManager
									.addMagnetopauseRadius(chartOption);

							//chartGraphManager.loadOneDayFromNow();
							//chartGraphManager.setAutoRefresh(1000*60*5);
							//chartGraphManager.setAutoRefresh({enable:true});
							chartGraphManager.updateOptions({
								autoRefresh : true
							});

							setTimeout(onResize, 500);
							rollingEvent();

							//방사선 순간 피폭량(이미지 변경)
							$("#image1Header").click(function(e) {
								image1Change("image1", "list1");
								$("#sunspot_alt").val("0");
							})
							$("#image2Header").click(function(e) {
								image1Change("image1", "list2");
								$("#sunspot_alt").val("50");
							})
							$("#image3Header").click(function(e) {
								image1Change("image1", "list3");
								$("#sunspot_alt").val("75");
							})
							$("#image4Header").click(function(e) {
								image1Change("image1", "list4");
								$("#sunspot_alt").val("100");
							})

							//항공로별 순간 피폭량(이미지 변경)
							$("#image2-1").click(function(e) {
								image2Change("image2", "list1");
							})
							$("#image2-2").click(function(e) {
								image2Change("image2", "list2");
							})
							$("#image2-3").click(function(e) {
								image2Change("image2", "list3");
							})
							$("#image2-4").click(function(e) {
								image2Change("image2", "list4");
							})
							$("#image2-5").click(function(e) {
								image2Change("image2", "list5");
							})
							$("#image2-6").click(function(e) {
								image2Change("image2", "list6");
							})
							$("#image2-7").click(function(e) {
								image2Change("image2", "list7");
							})
							$("#image2-8").click(function(e) {
								image2Change("image2", "list8");
							})
							$("#image2-9").click(function(e) {
								image2Change("image2", "list9");
							})
							
							
							//var pop0, pop1, pop2, pop3, pop4, pop5, pop6, pop7, pop8, pop9;
							var pop = new Array(10);
							
														 																				
							//도움말 이벤트
							$("#qeu1").click(function(e) {
								for(var i=0; i<10; i++) {
									if(pop[i] != null) {
										pop[i].focus();	
									}
								}
								pop[0]= window.open("hcp_world.do",'qeu1','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
								pop[0].focus();
							});
											
							$("#qeu2").click(function(e) {
								for(var i=0; i<10; i++) {
									if(pop[i] != null) {
										pop[i].focus();
									}
								}
								pop[1] = window.open("hcp_airway.do",'qeu2','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
								pop[1].focus();
							});
											
							$("#qeu3").click(function(e) {
								for(var i=0; i<10; i++) {
									if(pop[i] != null) { 
										pop[i].focus();	
									}
								}
								pop[2] = window.open("ovation.do",'qeu3','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
								pop[2].focus();
							});
							$("#qeu4").click(function(e) {
								for(var i=0; i<10; i++) {
									if(pop[i] != null) { 
										pop[i].focus();	
									}
								}
								pop[3] = window.open("drap.do",'qeu4','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
								pop[3].focus();
							});
							$("#qeu5").click(function(e) {
								for(var i=0; i<10; i++) {
									if(pop[i] != null) {
										pop[i].focus();	
									}
								}
								pop[4] = window.open("tableInfo.do",'qeu5','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
								pop[4].focus();
							});
							$("#qeu6").click(function(e) {
								for(var i=0; i<10; i++) {
									if(pop[i] != null) {
										pop[i].focus();	
									}
								}
								pop[5] = window.open("graphInfo1.do",'qeu6','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
								pop[5].focus();
							});
							$("#qeu7").click(function(e) {
								for(var i=0; i<10; i++) {
									if(pop[i] != null) {
										pop[i].focus();	
									}
								}
								pop[6] = window.open("graphInfo2.do",'qeu7','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
								pop[6].focus();
							});					 
							$("#que_info1").click(function(e) {
								for(var i=0; i<10; i++) {
									if(pop[i] != null) {
										pop[i].focus();	
									}
								}
								pop[7] = window.open("info1.do",'qeu8','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
								pop[7].focus();
							});
							$("#que_info2").click( function(e) {
								for(var i=0; i<10; i++) {
									if(pop[i] != null) {
										pop[i].focus();	
									}
								}
								pop[8] = window.open("info2.do",'qeu9','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
								pop[8].focus();
							});
							$("#que_info3").click( function(e) {
								for(var i=0; i<10; i++) {
									if(pop[i] != null) {
										pop[i].focus();	
									}
								}
								pop[9] = window.open("info3.do",'qeu10','width=500,height=600,toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, directories=no, status=no');
								pop[9].focus();
							}); 
						});

	});
	
	
	var slice = true; //분할   t:4등분  f : 크게
	var play = true; //재생   t:준비 f : 재생중
	var mouseOn = false; //그래프 마우스 t:마우스 인 f:마우스 아웃
	var calendarOn = false; //달력  t:보임 f:숨김
	var rolling;
	var count;
	function graphRolling() {
		if (!slice && !play && !mouseOn && !calendarOn) { //크게 보기, 재생 중, 마우스 아웃상태, 달력/리스트 안보임 일때 >> 다음 그래프 보기
			/* $(".gr_graph.selected").removeClass("selected");
			$(".gr_graph:eq(" + count + ")").addClass("selected");
			count++;
			if (count > 2) {
				count = 0;
			} */
			//setTimeout(onResize, 500);
		}
	}
	function rollingEvent() {
		//4등분
		$(".slice").on(
				"click",
				function(e) {
					var now = $(this);
					count = now.parents(".gr_graph").index(); //선택 그래프

					var roll = $("#wrap_left");
					if (!roll.hasClass("rolling")) {
						slice = false; //크게 보기
						play = false; //재생 시작
						roll.addClass("rolling");
						$(".play, .slice").addClass("on");
						now.parents(".gr_graph").addClass("selected");
						//재생
						$(".play").bind("click", function(e) {
							$(this).toggleClass("on");
							play = !$(this).hasClass("on");
						});
						//그래프 마우스 오버
						$("#wrap_graph .graph").bind("mouseover", function(e) {
							mouseOn = true;
						});
						//그래프 마우스 아웃
						$("#wrap_graph .graph").bind("mouseout", function(e) {
							mouseOn = false;
						});
						//재생은 안함.
						//rolling = setInterval(graphRolling, 1000 * 5); //재생
					} else {

						$("#graph1").css("display", "block");
						$("#graph2").css("display", "block");

						slice = true;
						play = false;
						roll.removeClass("rolling");
						$(".play, .slice").removeClass("on");
						$(".gr_graph.selected").removeClass("selected");
						$(".play, #wrap_graph .graph").unbind(
								"click mouseover mouseout");
						clearInterval(rolling);
						rolling = null;
					}
					setTimeout(onResize, 500);
				});
	}

	function searchChart(type) {
		//var startDate = $("#sd").datepicker('getDate');
		//var endDate = $("#ed").datepicker('getDate');

		//var sd = $.datepicker.formatDate("yymmdd", startDate) + $("#sh").val() + "0000";
		//var ed = $.datepicker.formatDate("yymmdd", endDate) + $("#eh").val() + "0000";

		//chartGraphManager.load('20131012121212', '20131212121212');
	}

	var pheight = null;
	var pyear = null;
	var pmonth = null;
	var pdate = null;
	var pOnOff = null;
	//방사선 순간 피폭량 이미지 회전

	ponoff = "";
	function playImage(isOnOff, height) {

		var year = $("#refresh_year").val();
		var month = $("#refresh_month").val();
		var date = $("#refresh_date").val();

		pdate = date;
		pmonth = month;
		pyear = year;
		pheight = height;
		pOnOff = isOnOff;
		rollingImage();

	}
	var playimage = "";
	n = 1;
	//방사선 순간 피폭량 이미지 회전
	function rollingImage() {
		var addr = "<c:url value='/monitorSWAA/loadImageSunspot.do?type=HCP_ROTATE&year="
				+ pyear
				+ "&month="
				+ pmonth
				+ "&date="
				+ pdate
				+ "&alt="
				+ pheight + "&num=" + i + "'/>";

		$("#image1 img").attr("src", addr);

		playimage = setTimeout("rollingImage()", 400);

		if (i == 60) {
			i = 0;
		}

		i++;

		if (pOnOff == "off") {
			clearTimeout(playimage);
			playimage = null;
		}
	}

	//5분마다 극항로 통신 두절 영역 이미지 전환
	function ovationImageRefresh(year, month, date, hour, minute) {

		var addr = "<c:url value='/monitorSWAA/loadImageOvation.do?year="
				+ year + "&month=" + month + "&date=" + date + "&hour=" + hour
				+ "&minute=" + minute + "'/>";

		$("#image3 img").attr("src", addr);
	}

	function drapImageRefresh(year, month, date, hour, minute) {

		var addr = "<c:url value='/monitorSWAA/loadImageDrap.do?year=" + year
				+ "&month=" + month + "&date=" + date + "&hour=" + hour
				+ "&minute=" + minute + "'/>";

		$("#image4 img").attr("src", addr);
	}
</script>
</head>

<body>
	<input id="refresh_year" type="hidden" value="${syear}" />
	<input id="refresh_month" type="hidden" value="${smonth}" />
	<input id="refresh_date" type="hidden" value="${sdate}" />
	<input id="airway_date_year" type="hidden"/>
	<input id="airway_date_month" type="hidden" />
	<input id="airway_date_date" type="hidden"/>
		
	<input id="sunspot_alt" type="hidden" value="100" />
	<input id="sunspot_airway" type="hidden" value="JFK-ICN-polar" />
	<div id="scrollBar">
		<div id="wrap">
			<div id="header" style=" height: 78px">
				<h1 class="title">
			    	<img src="<c:url value="/images/monitor/titleSWAA1.png"/>"/>
			    </h1>
				<div class="wrap_time">
					<div class="time utc">
						<p class="tdate" id="utc_date"></p>
						<p class="hms">
							<span id="utc_hour"></span><span id="utc_minute"></span><span
								id="utc_second"></span>
						</p>
					</div>
					<div class="time kst">
						<p class="tdate" id="kst_date"></p>
						<p class="hms">
							<span id="kst_hour"></span><span id="kst_minute"></span><span
								id="kst_second"></span>
						</p>
					</div>
				</div>
			</div>

			<div id="contents">
				<div id="wrap_left">

					<!-- 전지구 방사선 순간 피폭량 -->
					<div class="gr_img" id="imageManager1">
						<div class="header">
							<h2 id="atitle">
								<div id="imageText1" class="imageHeader">
									<a href="#" class="on" name="SDO__01001">전지구 방사선 순간 피폭량(고도 15km)</a>
								</div>
							</h2>
							<div class="combo alist">
								<a href="#" id="image1Header" name="<c:out value="0"/>"><div>전지구 방사선 순간 피폭량(고도 0km)</div></a>
								<a href="#" id="image2Header" name="<c:out value="5"/>"><div>전지구 방사선 순간 피폭량(고도 5km)</div></a>
								<a href="#" id="image3Header" name="<c:out value="10"/>"><div>전지구	방사선 순간 피폭량(고도 10km)</div></a>
								<a href="#" id="image4Header" name="<c:out value="15"/>"><div>전지구 방사선 순간 피폭량(고도 15km)</div></a>
							</div>
							<p class="date">
							<a href="#"	class="vod"><span>동영상</span></a>
								<a href="#" class="calendar"><span>달력</span></a>
									<a href="#" class="question" id="qeu1"><span>도움말</span></a>
							</p>
						</div>

						<div class="contents" id="image1">
							<img
								src="<c:url value='/monitorSWAA/loadImageSunspot.do?type=HCP_WORLD&year=${syear}&month=${smonth}&date=${sdate}&alt=100'/>" />
							<br/>
						</div>

					</div>
					<!--  
	태양영상 2 -->
					<div class="gr_img" id="imageManager2">
						<div class="header">
							<h2 id="atitle">
								<div id="imageText2">
									<a href="#" class="on" name="SDO__01001">항공로 방사선 순간 피폭량
										[뉴욕-인천(polar)]</a>
								</div>
							</h2>
							<div class="combo alist">
								<a href="#" id="image2-1" name="<c:out value="0"/>"><div>항공로 방사선 순간 피폭량 [LA-인천]</div></a>
								<a href="#" id="image2-2" name="<c:out value="0"/>"><div>항공로 방사선 순간 피폭량 [뉴욕-인천]</div></a>
								<a href="#"	id="image2-3" name="<c:out value="0"/>"><div>항공로 방사선 순간 피폭량 [뉴욕-인천(polar)]</div></a>
								<a href="#" id="image2-4" name="<c:out value="0"/>"><div>항공로 방사선 순간 피폭량 [댈러스-인천]</div></a>
								<a href="#"	id="image2-5" name="<c:out value="0"/>"><div>항공로 방사선	순간 피폭량 [모스크바-인천]</div></a>
								<a href="#" id="image2-6" name="<c:out value="0"/>"><div>항공로 방사선 순간 피폭량 [시애틀-인천]</div></a>
								<a href="#"	id="image2-7" name="<c:out value="0"/>"><div>항공로 방사선	순간 피폭량 [이스탄불-인천]</div></a>
								<a href="#" id="image2-8" name="<c:out value="0"/>"><div>항공로 방사선 순간 피폭량 [인천-런던]</div></a>
								<a href="#"	id="image2-9" name="<c:out value="0"/>"><div>항공로 방사선	순간 피폭량 [파리-인천]</div></a>
							</div>
							<p class="date">
								<a href="#" class="calendar"><span>달력</span></a> <a href="#"
									class="question" id="qeu2"><span>도움말</span></a> 
							</p>
						</div>
						<div class="contents" id="image2">
							<img
								src="<c:url value='/monitorSWAA/loadImageSunspot.do?type=HCP_AIRWAY&year=${syear}&month=${smonth}&date=${sdate}&airway=JFK-ICN-polar'/>" />
							<br/>
						</div>
					</div>
					<!-- 
	태양영상 3  -->
					<div class="gr_img" id="imageManager3">
						<div class="header">
							<h2 class="nolink">
								 극항로 통신 장애 영역<span class="addBr"><br></span>(극관크기) 
							</h2>
							<p class="date">
								<a href="#" class="calendar"><span>달력</span></a> 
								<a href="#"	class="question" id="qeu3"><span>도움말</span></a>
							</p>
						</div>
						<div class="contents" id="image3">
							<img
								src="<c:url value='/monitorSWAA/loadImageOvation.do?year=${year}&month=${month}&date=${date}&hour=${hour}&minute=${minute}'/>" />
							<br/>
						</div>
					</div>
					<!-- 
	태양영상 4  -->
					<div class="gr_img" id="imageManager4">
						<div class="header">
							<h2>
								 HF통신 전파 흡수 <span class="addBr"><br></span>&nbsp;
							</h2>
							<p class="date">
								<a href="#" class="calendar"><span>달력</span></a> <a href="#"
									class="question" id="qeu4"><span>도움말</span></a>
							</p>
						</div>
						<div class="contents" id="image4">
							<img
								src="<c:url value='/monitorSWAA/loadImageDrap.do?year=${year}&month=${month}&date=${date}&hour=${hour}&minute=${minute}'/>" />
							<br/>
						</div>
					</div>
					<!--  					
		        
	태양영상 5  -->

				</div>
				<!-- END WRAP LEFT INFO -->

				<div id="wrap_right">
					<div id="wrap_info">
						<!-- 태양복사폭풍 -->
						<div class="wrap_info">
							<div class="header">
								<h2>우주기상 특보상황</h2>
								<p class="date"> 
								<a href="#" class="question" id="que_info1"><span>도움말</span></a>
								</p>
							</div>
							<div class="info_total">
								<div class="sign_wrap">
									<p>기상위성운영</p>
									<div class="signt" id="summary1">
										<span class="num"></span> <span class="txt"></span>
									</div>
								</div>
								<div class="sign_wrap">
									<p>극항로 항공기상</p>
									<div class="signt" id="summary2">
										<span class="num"></span> <span class="txt"></span>
									</div>
								</div>

								<div class="sign_wrap">
									<p>전리권기상</p>
									<div class="signt" id="summary3">
										<span class="num"></span> <span class="txt"></span>
									</div>
								</div>

							</div>
						</div>

						<!-- 태양복사폭풍 -->
						<div class="wrap_info">
							<div class="header">
								<h2>극항로 방사선</h2>
								<p class="date"> 
								<a href="#" class="question" id="que_info2"><span>도움말</span></a>
								</p>
							</div>
							<div class="info" id="proton_info1">
								<div class="sign">
									<span class="num"></span><span class="txt"></span>
								</div>
								<p> 
									<span>현재: </span> 
									<span>3시간 최대값: </span>  
									<span></span>
									<span>24시간 최대값:</span>
								</p>
							</div>
						</div>
						<!-- 태양입자폭풍 -->
						<div class="wrap_info">
							<div class="header">
								<h2>극항로 통신장애</h2>
								<p class="date"> 
								<a href="#" class="question" id="que_info3"><span>도움말</span></a>
								</p>
							</div>
							<div class="info" id="proton_info2">
								<div class="sign">
									<span class="num"></span><span class="txt"></span>
								</div>
								<p>
									<span>현재: </span> <span>3시간 최대값: </span><span></span> <span>24시간 최대값:
									</span>
								</p>
							</div>
						</div>
						<!-- 지자기폭풍 -->

					</div>

					<!-- END WRAP INFO -->
				</div>
				<!-- END WRAP RIGHT INFO -->

				<div id="wrap_b_left">
					<div class="gr_img_table">
						<div class="header" id="tableHeader">
							<h2>
								<font color="yellow">항공로 방사선 누적 피폭량</font>

							</h2>
							<p class="date">
								<a href="#" class="question" id="qeu5"><span>도움말</span></a>
							</p>
						</div>
						<div class="gr_graph_table">
							<div class="tableDiv">
								<table class="mtable">
									<tr>
										<td colspan="6" id="middleBar"></td>
									</tr>
									<tr>
										<td colspan="6" id="timeBar" class="tableTitle"></td>
									</tr>
									<tr>
										<td id="table_airway" colspan="2">뉴욕-인천(polar)</td>
										<td rowspan="4" id="centerBar"></td>
										<td rowspan="4" id="centerBar"></td>

										<td>구분</td>
										<td>방사능 노출 수준</td>
									</tr>
									<tr>
										<td class="t1">비행시간(hr)</td>
										<td id="hr">${hr}</td>
										<td>항공기 승무원</td>
										<td id="cabin">
											<div class="info" id="proton_info">
												<div class="${sign1}">
													<span class="num"></span>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td>평균피폭량(mSv/hr)</td>
										<td id="uSv">${mSvhr}</td>
										<td>일반인</td>
										<td id="man">
											<div class="info" id="proton_info">
												<div class="${sign2}">
													<span class="num"></span>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td>누적피폭량(mSv)</td>
										<td id="mSv">${mSv}</td>
										<td>임산부</td>
										<td id="pregnancy">
											<div class="info" id="proton_info">
												<div class="${sign3}">
													<span class="num"></span>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="6" id="middleBar"></td>
									</tr>
									<tr>
										<td colspan="6" class="tableTitle">방사능 노출 수준
											구분(국제방사선방호위원회(ICRP) 기준 준용)</td>
									</tr>
									<tr>
										<td>방사능 노출 수준</td>
										<td colspan="2">항공기 승무원<br/>연간(800hr)<br/></td>
										<td colspan="2">일반인<br/>1회 탑승시<br/></td>
										<td>임산부<br/>1회 탑승시<br/></td>
									</tr>
									<tr>
										<td>
											<div class="info" id="proton_info">
												<div class="sign4">
													<span class="num"></span>
												</div>
											</div>	
										</td>
										<td colspan="2">0~6.0 mSv</td>
										<td colspan="2">0~0.330 mSv</td>
										<td>0~0.167 mSv</td>
									</tr>
									<tr>
										<td>
											<div class="info" id="proton_info">
												<div class="sign2">
													<span class="num"></span>
												</div>
											</div>
										</td>
										<td colspan="2">6.0~12.0 mSv</td>
										<td colspan="2">0.330~0.670 mSv</td>
										<td>0.167~0.333 mSv</td>
									</tr>
									<tr>
										<td>
											<div class="info" id="proton_info">
												<div class="sign3">
													<span class="num"></span>
												</div>
											</div>
										</td>
										<td colspan="2">> 12.0 mSv</td>
										<td colspan="2">> 0.670 mSv</td>
										<td>> 0.333 mSv</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>

				<div id="wrap_b_right">
					<div>
						<div id="wrap_graph">
							<div class="gr_graph" id="graph1">
								<div class="header">
									<h2 id="text1">
										<font color="yellow">X-선 플럭스(GOES-15)</font>
									</h2>
									<div class="ginfo" id="XRAY_FLUX_LABELS_DIV"></div>
									<p class="date">
										<a href="#" class="play" title="재생"><span>재생</span></a> <a
											href="#" class="slice" title="롤링"><span>롤링</span></a> <a
											href="#" class="calendar" title="달력"><span>달력</span></a> <a
											href="#" class="detail" title="상세보기"><span>상세보기</span></a> <a
											href="#" class="question" id="qeu6"><span>도움말</span></a>
									</p>
								</div>
								<div class="graph" id="XRAY_FLUX"></div>
							</div>
							<!--
 END GRAPH 1 -->
							<div class="gr_graph" id="graph2">
								<div class="header">
									<h2 id="text2">
										<%-- <a href="#" class="on"><span><custom:ChartTItle type="PROTON_FLUX"/></span></a> --%>
										<font color="yellow">양성자 플럭스(GOES-13)</font>
									</h2>
									<div class="ginfo" id="PROTON_FLUX_LABELS_DIV"></div>
									<p class="date">
										<a href="#" class="play" title="재생"><span>재생</span></a> <a
											href="#" class="slice" title="롤링"><span>롤링</span></a> <a
											href="#" class="calendar" title="달력"><span>달력</span></a> <a
											href="#" class="detail" title="상세보기"><span>상세보기</span></a> <a
											href="#" class="question" id="qeu7"><span>도움말</span></a>
									</p>
								</div>
								<div class="graph" id="PROTON_FLUX"></div>
							</div>
						</div>

					</div>
				</div>
			</div>
			<!-- END CONTENTS  -->
		</div>
		<!-- END WRAP -->
	</div>

	<!-- 레이어 // 태양영상 달력 -->



	<div class="layer" style="top: 135px; left: 592px; display: none;"
		id="calendar_image">
		<div class="layer_contents">
			<p>
				<label>날짜</label> <input id="calendar_image_date" type="text"
					size="12" readonly="readonly" />
			</p>
			<p>
				<label>시</label> <select name="" id="calendar_image_hour">
					<c:forEach begin="0" end="23" var="item">
						<option
							value="<fmt:formatNumber minIntegerDigits="2" value="${item}"/>"><fmt:formatNumber
								minIntegerDigits="2" value="${item}" /></option>
					</c:forEach>
				</select>
			</p>
			<p>
				<label>분</label> <select name="" id="calendar_image_min">
					<c:forEach begin="0" end="55" var="item" step="5">
						<option
							value="<fmt:formatNumber minIntegerDigits="2" value="${item}"/>"><fmt:formatNumber
								minIntegerDigits="2" value="${item}" /></option>
					</c:forEach>
				</select>
			</p>
			<input type="button" class="btn" value="확인" /> <a href="#"
				class="close"><span>영상선택</span></a>
		</div>
	</div>


	<!-- 레이어 // 그래프 달력 -->
	<div class="layer" style="display: none;" id="calendar_chart">
		<div class="layer_contents">
			<p>
				<label>시작일</label> <input type="text" size="12"
					id="calendar_chart_start_date" />
			</p>
			<p>
				<label>종료일</label> <input type="text" size="12"
					id="calendar_chart_end_date" />
			</p>

			<input type="button" class="btn" value="검색" /> <a href="#"
				class="close"><span>영상선택</span></a>
		</div>
	</div>

</body>
</html>