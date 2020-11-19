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
			<h4 class="page-header">수집프로그램관리</h4>
			<!-- content area start -->
				
				
				<nav class="navbar navbar-default" role="navigation">
					<div class="collapse navbar-collapse navbar-ex1-collapse text-right">
				    	<form class="navbar-form navbar-right" role="search" action="<c:url value="/admin/sms/user_list.do"/>" method="post" name="listForm" id="listForm">
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
				    			<option value="prog_nm" <c:if test="${param.search_type eq 'prog_nm'}">selected='selected'</c:if>>프로그램명</option>
				    			<option value="prog_file_nm" <c:if test="${param.search_type eq 'prog_file_nm'}">selected='selected'</c:if>>파일명</option>
				    		</select>
				      	</div>
				      	<div class="form-group">
				        	<input type="text" name="search_value" class="form-control input-sm" placeholder="검색어" value="${ param.search_value }">
				      	</div>
				     	<button type="button" id="searchBtn" class="btn btn-primary btn-sm">검색</button>
				     	<button type="button" id="resetBtn" class="btn btn-primary btn-sm">초기화</button>
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
					<input type="button" class="btn btn-primary btn-sm addBtn" title="수집프로그램등록" value="수집프로그램등록" />
				</div>
				           
		        <table class="table table-striped">
		        	<thead>
		            	<tr>
		                	<th width="80">no</th>
		                	<th width="100">코드 번호</th>
		                	<th>수집 프로그램</th>
		                    <th width="120">등록일</th>
		                </tr>
		            </thead>
					<tbody>
						<c:forEach var="o" items="${data.list}" varStatus="status">
						<tr>
		                	<td class="no">${data.pageNavigation.startNum - status.index}</td>
		                	<td>${o.CLT_PROG_SEQ_N}</td>
		                	<td><a href="ctl_prog_form.do?clt_prog_seq_n=${o.CLT_PROG_SEQ_N}">${o.PROG_NM}</a></td>
		                	<td><fmt:formatDate value="${o.RG_DT}" pattern="yyyy-MM-dd"/></td>
		                </tr>
						</c:forEach>
						<c:if test="${empty data.list}"> 
						<tr>
							<td colspan="4">등록된 컨텐츠가 존재하지 않습니다.</td>
						</tr> 
						</c:if>
					</tbody>
		        </table>
		        
		        <!-- paging -->
	    		<jsp:include page="/WEB-INF/views/include/commonPaging.jsp" />
		        <!-- paging -->
		        
		        <div class="top-button-group">
					<input type="button" class="btn btn-primary btn-sm addBtn" title="수집프로그램등록" value="수집프로그램등록" />
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
		if($('input[name=search_value]').val() == ''){
			alert('검색어를 입력해주세요.');
			$('input[name=search_value]').focus();
			return false;
		}
		paging(1);
	});
	
	$('.addBtn').on('click', function(){
		location.href = "ctl_prog_form.do";
	});
	$('#resetBtn').on('click', function(){
		location.href = "ctl_prog_list.do";
	});
});

</script>	
</body>
</html>