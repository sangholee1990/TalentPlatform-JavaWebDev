<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!doctype html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />
</head>
<body>
<div class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	
	<!--  -->
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">GNSS지점 목록</h4>
			<!-- content area start -->
				
				<nav class="navbar navbar-default" role="navigation">
					<div class="collapse navbar-collapse navbar-ex1-collapse text-right">
				    	<form class="navbar-form navbar-right" role="search" action="gnss_station_list.do" method="post" name="listForm" id="listForm">
				    	<input type="hidden" name="page" id="page" value="${param.page}">
				      	<!-- 
				      	<div class="form-group _searchDate">
				    		<label for="_searchDate" class="control-label">검색일</label>
				        	<input type="text" name="_searchDate" id="_searchDate" class="form-control input-sm" placeholder="검색일" readonly="readonly" style="width: 90px;">
				      	</div>
				      	 -->
				      	<!-- 
				      	<button type="button" id="dayBtn" class="btn btn-primary btn-sm">일</button>
				     	<button type="button" id="weeklyBtn" class="btn btn-primary btn-sm">주</button>
				     	<button type="button" id="monthlyBtn" class="btn btn-primary btn-sm">월</button>
				      	 -->
				    	<div class="form-group">
				    		<label for="search_type" class="control-label">구분</label>
				    		<select class="form-control input-sm" name="search_type" id="search_type">
				    			<option>전체</option>
				    			<option value="station_id" <c:if test="${param.search_type eq 'station_id'}">selected='selected'</c:if>>지점약어</option>
				    			<option value="organ_id" <c:if test="${param.search_type eq 'organ_id'}">selected='selected'</c:if>>기관</option>
				    			<option value="station_nm" <c:if test="${param.search_type eq 'station_nm'}">selected='selected'</c:if>>관측소</option>
				    		</select>
				      	</div>
				      	<div class="form-group">
				        	<input type="text" name="search_value" class="form-control input-sm" placeholder="검색어" value="${ param.search_value }">
				      	</div>
				     	<button type="button" id="searchBtn" class="btn btn-primary btn-sm">검색</button>
				     	<!-- 
				     	<button type="button" id="resetBtn" class="btn btn-primary btn-sm">초기화</button>
				     	<button type="button" class="btn btn-primary btn-sm createDailyReportBtn">일데이터생성</button>
				     	<button type="button" id="excelDownload" class="btn btn-primary btn-sm">
							<span class="glyphicon glyphicon-save"></span> 
						</button>
				     	 -->
				    	</form>
				  	</div>
				</nav>
				
				<div class="top-button-group">
					<input type="button" class="btn btn-primary btn-sm addBtn" title="등록" value="등록" />
				</div>
				           
		        <table class="table table-striped">
		        	<thead>
		            	<tr>
		                	<th width="80">no</th>
		                	<th>관측소명</th>
		                	<th>기관</th>
		                	<th>위도</th>
		                	<th>경도</th>
		                	<th>고도</th>
		                	<th>지점약어</th>
		                	<th>검증 지점</th>
		                </tr>
		            </thead>
					<tbody>
						<c:forEach var="o" items="${data.list}" varStatus="status">
						<tr>
		                	<td class="no">${data.pageNavigation.startNum - status.index}</td>
		                	<td><a href="gnss_station_form.do?id=${o.id}"><spring:escapeBody>${o.station_nm}</spring:escapeBody></a></td>
		                	<td><spring:escapeBody>${o.organ_id}</spring:escapeBody></td>
		                	<td><spring:escapeBody>${o.station_lat}</spring:escapeBody></td>
		                	<td><spring:escapeBody>${o.station_lon}</spring:escapeBody></td>
		                	<td><spring:escapeBody>${o.station_hgt}</spring:escapeBody></td>
		                	<td><spring:escapeBody>${o.station_id}</spring:escapeBody></td>
		                	<td><spring:escapeBody>${o.qc_stn}</spring:escapeBody></td>
		                </tr>
						</c:forEach>
						<c:if test="${empty data.list}"> 
						<tr>
							<td colspan="8">등록된 컨텐츠가 존재하지 않습니다.</td>
						</tr> 
						</c:if>
					</tbody>
		        </table>
		        
		        <!-- paging -->
	    		<jsp:include page="/WEB-INF/views/include/commonPaging.jsp" />
		        <!-- paging -->
		        
		        <div class="top-button-group">
					<input type="button" class="btn btn-primary btn-sm addBtn" title="등록" value="등록" />
				</div>
    	
			<!-- content area end -->
			
			 <!-- footer start -->
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		    <!-- footer end -->
		</div>		
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript">
$(function() {
	
	$('#searchBtn').on('click', function(){
		paging(1);
	});
	
	$('.addBtn').on('click', function(){
		location.href = "gnss_station_form.do";
	});
});
</script>	
</body>
</html>