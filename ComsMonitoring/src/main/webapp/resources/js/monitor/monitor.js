$(function(){	
	
	startClock();
	initialize();
	
//Tab
	$('#tab li').on('click', changeTab);

//ComboBox 
	$('select[name="sensor"]').on('change', {'depth' : 0}, bindSelectBox);
	$('select[name="lvl"]').on('change', {'depth' : 1}, bindSelectBox);

//scroll 사용 안함
	$('.scroll').scrollbar();

});

var idx, callBackArry = [setComsImage, setComsInsImage, setTodayCount, setMonthCount];
function initialize(){
	idx = 0;
	
	$('#tab li').not(':eq(' + idx + ')').removeClass('select').end().eq(idx).addClass('select');	//Tab Menu All Hide  Select Tab Show
	$('#contents > .section').not(':eq(' + idx + ')').hide().end().eq(idx).show();	//Content All Hide Select Content Show
	
//날짜
	var now = new Date(), nowTime = now.getTime();
	nowTime = now.getTime() + now.getTimezoneOffset() * 60 * 1000;
	now = new Date(nowTime);
	$('.date').val($.format.date(now, 'yyyy-MM-dd')).datepicker({
		dateFormat: 'yy-mm-dd',
		changeYear: true
	});

//시간
	var nowHour = $.format.date(now, 'HH');
	$('<option value="">').text('전체').appendTo('select[name="hour"]');
	for(var i = 0; i < 24; i++){
		var hour = i > 9 ? i : '0' + i;
		$('<option value="' + hour + '">').attr('selected', (nowHour == hour)).text(hour + '시').appendTo('select[name="hour"]');
	}
	
//년도
	var nowYear = parseInt($.format.date(now, 'yyyy'));
	for(var i = 2011; i <= nowYear; i++){
		$('select[name="year"]').prepend($('<option value="' + i + '">').text(i + '년'));
	}
	
	$('select[name="year"] option:eq(0)').attr('selected', true);
	
//위성 선택	
	$.each($('select[name="sensor"]'), function(e){
		var form = $(this).parents('form');
		var sensor = form.find('.sensor').val();
		var lvlData = satBox[sensor].lvl;
		var lvl = form.find('.lvl');
		$.each(lvlData, function(k, v){
			$('<option value="' + k + '">').text(v.text).appendTo(lvl);
		});	
		
		var fileData = satBox[sensor].file[lvl.val()];
		var data = form.find('.data');
		$.each(fileData, function(k, v){
			$('<option value="' + k + '">').text(v).appendTo(data);
		});		
		
		form.data('host', (satBox[sensor].host || ''));
		form.data('path', (lvlData[lvl.val()].path || ''));
	});
	
	getData();
	
//검색
	$('.searchBtn').on('click', function(e){e.preventDefault();getData();});
	
}
//수집 현황
var miChart, gociChart;
function setMonthCount(data){
	var div = $('#contents .section').eq(idx);
	var gociOption = jQuery.extend(true, {}, miOption)
	if(!miChart && !gociChart){
		miChart = echarts.init($('.graph.mi')[0]);
		gociChart = echarts.init($('.graph.goci')[0]);
		miOption.xAxis[0].data = data.date;
		gociOption.xAxis[0].data = data.date;
		gociOption.legend.data = ['L1B-GOCI'];
		$.each(data.data, function(key, val){
			var code = matchCode[key], option = (key != 143) ? miOption : gociOption;
			if(key == 32 || key == 33) code = 'L1B-MI';
			if(key == 143) code ='L1B-GOCI';	
			option.series.push(
				{
					name : code,
					type : 'line',
					symbol : 'circle',
					data : val
				}	
			)				
		});
		miChart.setOption(miOption);
		gociChart.setOption(gociOption);
		$(window).resizeEnd({ delay: 100}, function(){
			miChart.resize();
			gociChart.resize();
			 
		});
		miChart.on('legendSelected', function(param){
			var selected = param.selected, target = param.target, option = miChart._option,
		    select = selected['전체'], check = true, total = false;
		    if (target == '전체') {
				$.each(selected, function(key, val){
					selected[key] = select;
				});
			}else{
				$.each(selected, function(key, val){
					if(key != '전체' && check) 
						if(val) {
							check = false;
							total = true;
						}
				});
				selected['전체'] = total;
			}
		    option.legend.selected = selected;
		    miChart.setOption(option);
		});
	}else{
		$.each(data.data, function(){
			var key = this.search_info_seq, code = matchCode[key], chart = (key != 143) ? miChart : gociChart;
			if(key == 32 || key == 33) code = 'L1B-MI';
			if(key == 143) code ='L1B-GOCI';	
			var idx = $.inArray(code, chart._optionRestore.legend.data);
			chart.addData([
          		[
  	            	idx,        // 시리즈 색인
  	            	this.cnt, // 새로운 데이터
  	            	false,     // 새로운 데이터가 큐의 헤드로부터 삽입 하였는지 확인
  	            	false,     // 큐의 길이를 증가 여부, 허위 원래 사용자 정의 데이터를 삭제, 꼬리를 천공 팀 헤드 삽입, 꼬리 삽입 천공 팀 머리
  	            	this.scan_date
          		]
      		]);
		});
	}
	div.find('.initYn').val('N');
}

//수집모니터링
function setTodayCount(data){
	$('.todayList .dt, .todayList .cnt').empty();
	$.each(data, function(k, v){
		var tr = $('.todayList tr[data-type="' + matchCode[this.search_info_seq] + '"]')
		var dt = tr.find('.dt')
		dt.text(dt.text() ? dt.text() < this.last_date ? this.last_date : dt.text() : this.last_date);
		var cnt = tr.find('.cnt');
		if(cnt.text())
			cnt.text(parseInt(cnt.text()) + parseInt(this.cnt || 0));
		else
			cnt.text(this.cnt || 0);
	});
}

//일사량영상
function setComsInsImage(data){
	var div = $('#contents .section').eq(idx), form = div.find('form');
	var list = div.find('.imageList').empty();
	$.each(data, function(path, v){
		if(path == 'date'){var date = v[0].split(' ');div.find('.hour').val(date[1]);div.find('.date').val(date[0]);return;}
		if(v){
			$.each(v, function(k, file){
				$('<li>').text(file).data('path', path + file).unbind('click').bind('click', imageView).appendTo(list);
			});			
		}
	});
	
	div.find('.imageList li').sort(function(a, b){
		a = $(a).text();
		b = $(b).text();
		return a > b ? -1 : a < b ? 1 : 0;
	}).appendTo(div.find('.imageList'));
	
	var first = div.find('.imageList li:eq(0)').addClass('on');
	if(first.length > 0){
		div.find('.imageDown').attr('href', '/lDownload.do?path=' + first.data('path')).unbind('click');
		div.find('.imageView img').attr('src', '/imageView.do?path=' + first.data('path')).error(function(){
			div.find('.imageDown').attr('href', '#').unbind('click').bind('click', function(){alert('선택이미지 없음');});
		});
	}else{
		div.find('.imageView img').attr('src','');
		div.find('.imageDown').attr('href', '#').unbind('click').bind('click', function(){alert('선택이미지 없음');});
	}
	
	function imageView(e){
		e.preventDefault();
		div.find('.imageList li.on').removeClass('on');
		$(this).addClass('on');
		div.find('.imageView img').attr('src', '/imageView.do?path=' + $(this).data('path'));
		div.find('.imageDown').attr('href', '/lDownload.do?path=' + $(this).data('path')).unbind('click');
	}
	
	div.find('.initYn').val('N');
}

//위성영상
function setComsImage(data){
	var div = $('#contents .section').eq(idx), form = div.find('form'), host = form.data('host');
	var list = div.find('.imageList').empty();
	$.each(data, function(){
		if(this.hour){div.find('.hour').val(this.hour); div.find('.date').val(this.date); return;}
		var imageNm = this.image_nm, fileNm = this.file_nm, path = form.data('path'), type = matchCode[this.search_info_seq];
		path = path.replace('#year#', this.date_y);
		path = path.replace('#month#', this.date_m);
		path = path.replace('#day#', this.date_d);
		if(div.find('.sensor').val() == 1 && div.find('.lvl').val() == 'le1b' &&  div.find('.data').val() == ''){
			$.each(div.find('.data option'), function(k, v){
				if(k > 0){
					var reNm = imageNm.replace('zzz', $(this).val());
					$('<li>').text(reNm).data({
						'fileNm' : fileNm, 
						'sensor' : div.find('.sensor').val(), 
						'lvl' : div.find('.lvl').val(), 
						'type' : $(this).val(),
						'path' : host + path + reNm , 
						'imageNm' : reNm,
						'date' : $('#tab1 .date').val()
					}).unbind('click').bind('click', imageView).appendTo(list);								
				}
			});
		}else{
			if(div.find('.sensor').val() == 2){
				imageNm = imageNm.replace('_L1B_GA_', '_BI_');
				imageNm = imageNm.replace('.png', '.JPG');
			}else {
				if(div.find('.lvl').val() == 'le1b'){
					type=div.find('.data').val();
					imageNm = imageNm.replace('zzz', div.find('.data').val());					
				}else{
					path = path.replace('#data#', matchCode[this.search_info_seq]);									
				}
			}
			if(this.search_info_seq == 60) imageNm = imageNm.replace('_cn_', '_a_');
			if(this.search_info_seq == 58 || this.search_info_seq == 145) imageNm = imageNm.replace('_cttp_', '_ctp_');
			
			$('<li>').text(imageNm).data({
				'fileNm' : fileNm, 
				'sensor' : div.find('.sensor').val(), 
				'lvl' : div.find('.lvl').val(), 
				'type' : type,
				'path' : host + path + imageNm , 
				'imageNm' : imageNm,
				'date' : $('#tab1 .date').val()
			}).unbind('click').bind('click', imageView).appendTo(list);
		}
	});
	
	var first = div.find('.imageList li:eq(0)').addClass('on');
	
	div.find('.imageView img').attr('src', '');
	div.find('.imageDown').attr('href', '#').unbind('click').bind('click', function(){alert('선택이미지 없음');});
	div.find('.textDown').attr('href', '#').unbind('click').bind('click', function(){alert('선택이미지 없음');});
	if(first.length > 0){
		div.find('.imageView img').attr('src', first.data('path')).load(function(){
			div.find('.imageDown').attr('href', '/uDownload.do?' + $.param(first.data())).unbind('click');
			div.find('.textDown').attr('href', '/textDownload.do?' + $.param(first.data())).unbind('click');
		}).error(function(){
			div.find('.imageDown').attr('href', '#').unbind('click').bind('click', function(){alert('선택이미지 없음');});
			div.find('.textDown').attr('href', '#').unbind('click').bind('click', function(){alert('선택이미지 없음');});
		});
	}

	function imageView(e){
		e.preventDefault();
		div.find('.imageList li.on').removeClass('on');
		$(this).addClass('on');
		div.find('.imageView img').attr('src', $(this).data('path'));
		div.find('.imageDown').attr('href', '/uDownload.do?'+ $.param($(this).data())).unbind('click');
		div.find('.textDown').attr('href', '/textDownload.do?' + $.param($(this).data())).unbind('click');
	}
	
	div.find('.initYn').val('N');
}

function getData(){
	var form = $('.searchForm').eq(idx);
	$.ajax({
		url : form.attr('action'),
		data : form.serialize(),
		dataType : 'json',
		method : 'post',
		success : function(data){
			if(data)
				callBackArry[idx](data);
		},
		error : function(){
			
		}
	});
}

//탭 이벤트
function changeTab(e){
	e.preventDefault();
	if(idx != $(this).index()){
		idx = $(this).index();
		$('#tab li').not(':eq(' + idx + ')').removeClass('select').end().eq(idx).addClass('select');	//Tab Menu All Hide  Select Tab Show
		$('#contents > .section').not(':eq(' + idx + ')').hide().end().eq(idx).show();	//Content All Hide Select Content Show
		getData();
	}
}

//셀렉트 박스 이벤트
function bindSelectBox(e){
	var form = $(this).parents('form');
	var sensor = form.find('.sensor').val();
	var lvlData = satBox[sensor].lvl;
	//form.data('path', host);
	var lvl = form.find('.lvl');
	var fileData = satBox[sensor].file[lvl.val()];
	var data = form.find('.data');
	if(e.data.depth == 0){
		setLvl(satBox);
		setFile(satBox);
	}else if(e.data.depth == 1){
		setFile(satBox);
	}
	function setLvl(selectBox){
		if(lvlData) lvl.empty();
		$.each(lvlData, function(k, v){
			$('<option value="' + k + '">').text(v.text).appendTo(lvl);
		});		
		fileData = satBox[sensor].file[lvl.val()];
	}
	function setFile(selectBox){
		if(fileData) data.empty();
		$.each(fileData, function(k, v){
			$('<option value="' + k + '">').text(v).appendTo(data);
		});		
	}
	form.data('host', (satBox[sensor].host || ''));
	form.data('path', (lvlData[lvl.val()].path || ''));
}		

function bindSelectBox2(){
	var form = $('#tab4 form');
	var sensor = form.find('.sensor').val();
	var lvlData = satBox2[sensor];
	var lvl = form.find('.lvl');
	if(lvlData) lvl.empty();
	$.each(lvlData, function(k, v){
		$('<option value="' + k + '">').text(v).appendTo(lvl);
	});		
	fileData = satBox[sensor].file[lvl.val()];
}

/* 시계 작동 */
var timeZone = 'UTC';
function startClock() {
    var clock = setInterval(function() {
    	var now = new Date(), nowTime = now.getTime();
    	if(timeZone == 'UTC') nowTime = now.getTime() + now.getTimezoneOffset() * 60 * 1000;
    	now = new Date(nowTime);
        $('.clock').text($.format.date(now, 'yyyy-MM-dd E HH:mm:ss') + '(' + timeZone + ')');
        if($.format.date(now, 'ss') == '00' && (idx == 2 || idx == 3)) getData();
        clearInterval(clock);
        startClock();
    }, 1000);
}//startClock end

var satBox = {
		'1' : { 
			'lvl' : {'le1b' : {'text' : 'L1B', 'path' : '/emcoms/BIMG/COMS/Y#year#/M#month#/D#day#/'}, 'le2' :  {'text' : 'L2', 'path' : '/emcoms/AIMG/COMS/#data#/Y#year#/M#month#/D#day#/'}}, 
			'file' : {
							'le1b' : {'' : '전체', 'ir1' : 'IR1', 'ir2' : 'IR2', 'swir' : 'SWIR', 'wv' : 'WV', 'vis' : 'VIS'},
							'le2' : {'' : '전체', 'cld' : 'CLD', 'cttp' : 'CTTP' , 'fog' : 'FOG', 'ins' : 'INS', 'lst' : 'LST', 'olr' : 'OLR', 'ri' : 'RI', 'ssi' : 'SSI', 'sst' : 'SST', 'tpw' : 'TPW', 'uth' : 'UTH'}
						},
			'host' : 'http://nmsc.kma.go.kr/'
		}
		
		,'2' : { 
				'lvl' : {'le1b' : {'text' : 'L1B', 'path' : '/#year#/#month#/#day#/ETC/' }},
				'file' : {
							'le1b' : {'' : '전체'}
						 },
				'host' : 'http://222.236.46.36/files/nfsdb/COMS/GOCI/1.0/'
		}
	};

var satBox2 = {
		'1' : {'le1b' : 'L1B', 'aod' : 'AOD', 'cla' : 'CLA', 'cld' : 'CLD', 'cttp' : 'CTTP', 'fog' : 'FOG', 'ins' : 'INS', 'lst' : 'LST', 'olr' : 'OLR', 'ri' : 'RI', 'ssi' : 'SSI', 'sst' : 'SST', 'tpw' : 'TPW', 'uth' : 'UTH' },
		'2' : {'le1b' : 'L1B'}
}

var matchCode = {//, 112 : 'AI'
		32 : 'L1B', 33 : 'L1B', 36 : 'AOD', 37 : 'AOD', 40 : 'CLA', 42 : 'CLA', 24 : 'CLD', 50 : 'CLD', 58 : 'CTTP', 145 : 'CTTP', 60 : 'FOG', 25 : 'UTH',
		99 : 'INS', 146 : 'INS', 107 : 'LST', 147 : 'OLR', 151 : 'OLR', 144 : 'RI', 100 : 'SSI', 152 : 'SSI', 155 : 'SST', 158 : 'SST', 159 : 'TPW', 143 : 'COMS-GOCI'
}

var miOption = {
        tooltip : {
            trigger: 'axis'
        },
        legend: {
        	textStyle:{fontSize : 15},
            data:['L1B-MI', 'AOD', 'CLA', 'CLD', 'CTTP', 'FOG', 'INS', 'LST', 'OLR', 'RI', 'SSI', 'SST', 'TPW', 'UTH', '전체'],
            borderWidth : 1,
            selected: {
                '전체' : true
            },
//            borderColor : '#000'
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: false},
                dataView : {show: false, readOnly: false},
                magicType : {show: false, type: ['line']},
                restore : {show: true, title: '새로고침'},
                saveAsImage : {show: true, title:'이미지 저장'}
            }
        },
        grid : {x:50, x2:50, y:30},
        calculable : false,
        animation: false,         
        addDataAnimation: false,
        dataZoom : {
	        show : true,
	        realtime : true,
	        start : 95,
	        end : 100
	    },
	    axisPointer : {
	    	lineStyle: {
		        color: '#48b',
		        width: 2,
		        type: 'solid'
		    }
	    },
        xAxis : [
            {
                type : 'category',
                data : [],
                scale : true,
                boundaryGap: true
            }
        ],
        yAxis : [
            {
                type : 'value',
                splitArea : {show : true}
            }
        ],
        series : []
    };