<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ include file="common/tag.jsp" %><!DOCTYPE html>
<html lang="ko">
<head><jsp:include page="common/head.jsp" />
	<!--[if lt IE 9]>
      <script src="/resources/js/jquery/echart/html5shiv.min.js"></script><script src="/resources/js/jquery/echart/respond.min.js"></script>
    <![endif]-->
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/reset.css"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/common.css"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/js/jquery/jquery-ui-1.11.4/jquery-ui.min.css"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/js/jquery/jquery.scrollbar/jquery.scrollbar.css"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/monitor/monitor.css"/>"/>
</head>
<body>
	<div id="wrap">
		<div id="header">
			<h1 class="title">천리안 위성영상 기반 일사량 분석 시스템</h1>
			<p class="clock"></p>
		</div>
		<div id="nav">
		 	<ul id="tab">
		 		<li class="on"><a href="#tab1">위성영상</a></li>
		 		<li><a href="#tab2">일사량영상</a></li>
	     		<li><a href="#tab3">영상별 수집 현황</a></li>					
		 	 	<li><a href="#tab4">일별 수집 현황</a></li>					
		 	</ul>
		 </div>
		 <div id="contents">
			<div id="tab1" class="section">
				<form name="searchForm" class="searchForm" action="<c:url value="comsImageList.json"/>" method="post">
					<fieldset>
						<p class="searchBox">
							<input type="hidden" name="initYn" class="initYn" value="Y"/>
							<input type="text" name="date" class="date"/>
							<select name="hour" class="hour"></select>
							<select name="sensor" class="sensor">
								<option value="1">COMS-MI</option>
								<option value="2">COMS-GOCI</option>
							</select>
							<select name="lvl" class="lvl"></select>
							<select name="data" class="data"></select>
							<button type="submit" class="searchBtn btn">검색</button>
							<a href="#" class="imageDown btn">Image 자료</a>
							<a href="/textDownload.do" class="textDown btn">Text 자료</a>
						</p>
					</fieldset>
				</form>
				
				<div class="content">
					<div class="imageView"><img src="" class=""/></div>
					<div class="imageWrap scroll scrollbar-inner">
						<ul class="imageList"></ul>
					</div>
				</div>
			</div>
			<div id="tab2" class="section">
				<form name="searchForm" class="searchForm" action="<c:url value="comsInsImageList.json"/>" method="post">
					<fieldset>
						<p class="searchBox">
							<input type="hidden" name="initYn" class="initYn" value="Y"/>
							<input type="text" name="date" class="date"/>
							<select name="hour" class="hour"></select>
							<button type="submit" class="searchBtn btn">검색</button>
							<a href="#" class="imageDown btn">Image 자료</a>
						</p>
					</fieldset>
				</form>
				<div class="content">
					<div class="imageView"><img src="" class=""/></div>
					<div class="imageWrap scroll scrollbar-inner">
						<ul class="imageList"></ul>
					</div>
				</div>
			</div>
			<div id="tab3" class="section">
				<form name="searchForm" class="searchForm" action="<c:url value="todayMonitorCount.json"/>" method="post">
					<fieldset>
					</fieldset>
				</form>
				<div class="content">
					<table class="todayTable">
						<caption></caption>
						<colgroup>
							<col style="width:140px;"/>
							<col style="width:180px;"/>
							<col style="width:250px;"/>
							<col style="width:150px;"/>
						</colgroup>
						<thead>
							<tr>
								<th>센서종류</th>
								<th>자료종류</th>
								<th>최근 자료 수집 시간</th>
								<th>전 기간 누적</th>
							</tr>
						</thead>
						<tbody class="todayList">
							<tr data-type="L1B">
								<th rowspan="14">MI</th>
								<th>L1B</th><td class="dt"></td><td class="cnt"></td>
							</tr>
							<tr data-type="AOD">
								<th>AOD</th><td class="dt"></td><td class="cnt"></td>
							</tr>
							<tr data-type="CLA">
								<th>CLA</th><td class="dt"></td><td class="cnt"></td>
							</tr>
							<tr data-type="CLD">
								<th>CLD</th><td class="dt"></td><td class="cnt"></td>
							</tr>
							<tr data-type="CTTP">
								<th>CTTP</th><td class="dt"></td><td class="cnt"></td>
							</tr>
							<tr data-type="FOG">
								<th>FOG</th><td class="dt"></td><td class="cnt"></td>
							</tr>
							<tr data-type="INS">
								<th>INS</th><td class="dt"></td><td class="cnt"></td>
							</tr>
							<tr data-type="LST">
								<th>LST</th><td class="dt"></td><td class="cnt"></td>
							</tr>
							<tr data-type="OLR">
								<th>OLR</th><td class="dt"></td><td class="cnt"></td>
							</tr>
							<tr data-type="RI">
								<th>RI</th><td class="dt"></td><td class="cnt"></td>
							</tr>
							<tr data-type="SSI">
								<th>SSI</th><td class="dt"></td><td class="cnt"></td>
							</tr>
							<tr data-type="SST">
								<th>SST</th><td class="dt"></td><td class="cnt"></td>
							</tr>
							<tr data-type="TPW">
								<th>TPW</th><td class="dt"></td><td class="cnt"></td>
							</tr>
							<tr data-type="UTH">
								<th>UTH</th><td class="dt"></td><td class="cnt"></td>
							</tr>							
							<tr data-type="COMS-GOCI">
								<th rowspan="10">GOCI</th>
								<th>L1B</th><td class="dt"></td><td class="cnt"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div id="tab4" class="section">
				<form name="searchForm" class="searchForm" action="<c:url value="totalMonitorCount.json"/>" method="post">
					<fieldset>
						<input type="hidden" name="initYn" class="initYn" value="Y"/>
					</fieldset>
				</form>
				<div class="content">
				     <div class="graph mi" style="width:100%;height:400px;"></div>
				     <div class="graph goci" style="width:100%;height:400px;"></div>
				</div>
			</div>
		 </div>
		 <form name="imageDownForm" class="imageDownForm" action="/imageDown.do" method="POST">
			<fieldset>
				<input type="hidden" name="path" class="path"/>
				<input type="hidden" name="file"  class="file"/>
				<input type="hidden" name="imgUrl" value="Y"/>
			</fieldset>
		</form>
	</div><jsp:include page="common/script.jsp"/>
	<script src="<c:url value="/resources/js/jquery/jquery.form.js"/>"></script>
	<script src="<c:url value="/resources/js/jquery/jQuery.resizeEnd.js"/>"></script>
	<script src="<c:url value="/resources/js/jquery/echart/echarts-all.js"/>"></script>
	<!-- script src="<c:url value="/resources/js/jquery/calendar.js"/>"></script -->
	<script src="<c:url value="/resources/js/jquery/jquery.scrollbar/jquery.scrollbar.min.js"/>"></script>
	<script src="<c:url value="/resources/js/monitor/monitor.js"/>"></script>
</body>
</html>	