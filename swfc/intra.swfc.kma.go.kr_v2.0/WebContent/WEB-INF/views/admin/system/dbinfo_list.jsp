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
			<h4 class="page-header">데이터베이스 정보</h4>
			<!-- content area start -->
				
				
				<h5>테이블스페이스 정보</h5>
				
		        <table class="table table-bordered">
		        	<colgroup>
						<col width="*" />
						<col width="300" />
						<col width="*" />
						<col width="150" />
						<col width="120" />
						<col width="100" />
					</colgroup>
		        	<thead>
		            	<tr>
		                	<th class="text-center">테이블스페이스명</th>
		            		<th class="text-center">파일명</th>
		                	<th class="text-center">전체용량</th>
		                	<th class="text-center">현재사용</th>
		                	<th class="text-center">나머지용량</th>
		                	<th class="text-center">사용률</th>
		                </tr>
		            </thead>
		            <tbody>
		            <c:forEach var="o" items="${tableSpaceInfoList}" varStatus="status">     
					    <tr>
					        <td class="text-center"><spring:escapeBody>${o.tablespace_Name}</spring:escapeBody></td>
					        <td class="text-left"><spring:escapeBody>${o.file_Name}</spring:escapeBody></td>
					        <td class="text-right"><fmt:formatNumber value="${o.total}" type="number"/> (${o.unit})</td>
					        <td class="text-right"><fmt:formatNumber value="${o.used}" type="number"/> (${o.unit})</td>
					        <td class="text-right"><fmt:formatNumber value="${o.free}" type="number"/> (${o.unit})</td>
					        <td class="text-right">${o.used_Percent} (%)</td>
					    </tr>
		            </c:forEach>
		            </tbody>                    
		        </table>
		        
		        <br/><br/><br/>
		        <h5>테이블 정보</h5>
    			<nav class="navbar navbar-default" role="navigation">
					<div class="collapse navbar-collapse navbar-ex1-collapse text-right">
				    	<form class="navbar-form navbar-right" role="search" action="dbinfo_list.do" method="post" name="searchForm" id="searchForm">
				    	<input type="hidden" name="iPage" id="iPage" value="${pageNavigation.nowPage}">
				    	<div class="form-group">
				    		<label for="search_target" class="control-label">검색</label>
				    		<select class="form-control input-sm" name="search_target" id="search_target">
				    			<option value="" <c:if test="${param.search_target eq ''}">selected="selected"</c:if>>전체</option>
								<option value="1" <c:if test="${param.search_target eq '1'}">selected="selected"</c:if>>테이블명</option>
				    		</select>
				      	</div>
				      	<div class="form-group">
				        	<input type="text" name="search_text" class="form-control input-sm" placeholder="검색어" value="${param.search_text }">
				      	</div>
				     	<button type="button" class="btn btn-primary btn-sm" id="searchBtn">검색</button>
				    	</form>
				  	</div>
				</nav>
		        
		        
		        <table class="table table-striped">
		        	<colgroup>
						<col width="300" />
						<col width="*" align=left />
						<col width="150" />
						<col width="150" />
						<col width="150" />
					</colgroup>
		        	<thead>
		            	<tr>
		                	<th>테이블명</th>
		                	<th>설명</th>
		                	<th>등록건수</th>
		                    <th>생성일</th>
		                    <th>최근수정일</th>
		                </tr>
		            </thead>
					<c:forEach var="o" items="${list}" varStatus="status">            
				    <tr>
				        <td class="text-left"><spring:escapeBody>${o.table_Name}</spring:escapeBody></td>
				        <td class="text-left">${o.comments}</td>
				        <td><fmt:formatNumber value="${o.num_Rows}" type="number"/></td>
				        <td><fmt:formatDate value="${o.created}" pattern="yyyy.MM.dd HH:mm"/></td>
				        <td><fmt:formatDate value="${o.last_Ddl_Time}" pattern="yyyy.MM.dd HH:mm"/></td>
				    </tr>
				    </c:forEach>
		        </table>
		        
		        
		        <!-- paging -->
		        <div class="text-center">
				   <ul class="pagination pagination-sm">
					   	<c:if test="${pageNavigation.prevPage}">
						<li><a href="javascript:void(0);" title="처음" onclick="paging('1');">&#60;&#60;</a></li>
						<li><a href="javascript:void(0);"  onclick="paging('${pageNavigation.startPage - 1}');" title="이전">&#60;</a></li>
						</c:if>
						<c:forEach var="page" begin="${pageNavigation.startPage}" end="${pageNavigation.endPage}">
					  	<li <c:if test="${page == pageNavigation.nowPage}">class="active"</c:if>><a href="javascript:void(0);" onclick="paging('${page}');">${page}</a></li>
						</c:forEach>
					  	<c:if test="${pageNavigation.nextPage}">
						<li><a href="javascript:void(0);" onclick="paging('${pageNavigation.endPage + 1}');" title="다음">&#62;</a></li>
						<li><a href="javascript:void(0);" onclick="paging('${pageNavigation.totalPage}');" title="끝">&#62;&#62;</a></li>
						</c:if>
					</ul>
				</div>
		        <!-- paging -->
		        
			<!-- content area end -->
			
			 <!-- footer start -->
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		    <!-- footer end -->
		</div>		
	</div>
		
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript">
//검색
$(function() {
	$("#searchBtn").click(function() {
		paging(1);
	});
});

function paging(idx){
	$("#iPage").val(idx);
	$("#searchForm").submit();
}
</script>	
</body>
</html>