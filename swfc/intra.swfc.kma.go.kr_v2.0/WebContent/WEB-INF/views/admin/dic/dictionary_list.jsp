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
			<h4 class="page-header">단어사전</h4>
			<!-- content area start -->

			<!-- SEARCH -->
    		<nav class="navbar navbar-default" role="navigation">
				<div class="collapse navbar-collapse navbar-ex1-collapse text-right">
			    	<form class="navbar-form navbar-right" role="search" action="<c:url value="/admin/dic/dictionary_list.do"/>" method="post" name="searchForm" id="searchForm">
			    	<input type="hidden" name="ipage" id="ipage" value="${pageNavigation.nowPage}">
			    	
			      	<div class="form-group">
			    		<label for="system_seq" class="control-label">검색 조건</label>
			    		<select class="form-control input-sm"  name="search_target" id="search_target" title="검색">
							<option value="" <c:if test="${param.search_target eq ''}">selected="selected"</c:if>>[전체]</option>
							<option value="simple_nm" <c:if test="${param.search_target eq 'simple_nm'}">selected="selected"</c:if>>예약어</option>
							<option value="kor_nm" <c:if test="${param.search_target eq 'kor_nm'}">selected="selected"</c:if>>국문명</option>
							<option value="eng_nm" <c:if test="${param.search_target eq 'eng_nm'}">selected="selected"</c:if>>영문명</option>
						</select>
						<input class="form-control input-sm" type="text" title="검색어 입력" name="search_text" id="search_text" value="${param.search_text}" />
			      	</div>

			     	<button type="button" id="searchBtn" class="btn btn-primary btn-sm">검색</button>
			     	<button type="button" id="resetBtn" class="btn btn-primary btn-sm">초기화</button>
			    	</form>
			  	</div>
			</nav>
			<!-- SEARCH -->
			
			<div class="top-button-group">
				<input type="button" class="btn btn-primary btn-sm addBtn" title="등록" value="등록" onclick="javascript:goWriteForm();" />
				<input type="button" class="btn btn-primary btn-sm addBtn" title="양식 다운로드" value="양식 다운로드" onclick="javascript:SampleDownload();" />
				<input type="button" class="btn btn-primary btn-sm addBtn" title="엑셀 다운로드" value="엑셀 다운로드" onclick="javascript:ExcelDownload();" />
				<form name="uploadForm" id="uploadForm" action="" method="post" encType="multipart/form-data" style="display:inline-block;overflow:hidden;vertical-align:middle">
				<input type="button" class="btn btn-primary btn-sm addBtn" title="엑셀 업로드" value="엑셀 업로드" onclick="javascript:goExcelUpload();" style="float:left"/>
			</form>
			</div>
    		<table class="table table-striped">
	        	<colgroup>
	        		<col width="50">
	        		<col>
	        		<col>
	        		<col>
	        		<col width="120">
	        	</colgroup>
	        	<thead>
	            	<tr>
	                	<th>No</th>
	                	<th>예약어</th>
	                	<th>국문명</th>
	                	<th>영문명</th>
	                    <th>등록일자</th>
	                </tr>
	            </thead>
	            <tbody>
	             <c:choose>
            	<c:when test="${fn:length(list) == 0}">
            		<tr><td colspan="5">등록된 컨텐츠가 없습니다.</td></tr>
            	</c:when>
            	<c:otherwise>
					<c:forEach var="o" items="${list}" varStatus="status">            
		            <tr>
		            	<td class="no">${pageNavigation.startNum - status.index}</td>
		                <td><a href="javascript:goView(${o.wrd_dic_seq_n});"><spring:escapeBody>${o.simple_nm}</spring:escapeBody></a></td>
		                <td><spring:escapeBody>${o.kor_nm}</spring:escapeBody></td>
		                <td><spring:escapeBody>${o.eng_nm}</spring:escapeBody></td>
		                <td><fmt:formatDate value="${o.reg_dt}" pattern="yyyy-MM-dd"/></td>
		            </tr>
		            </c:forEach>
		         </c:otherwise>
		       </c:choose>
				</tbody>
	        </table>
	        <div class="top-button-group">
				<input type="button" class="btn btn-primary btn-sm addBtn" title="등록" value="등록"  onclick="javascript:goWriteForm();"/>
				<input type="button" class="btn btn-primary btn-sm addBtn" title="양식 다운로드" value="양식 다운로드" onclick="javascript:SampleDownload();" />
				<input type="button" class="btn btn-primary btn-sm addBtn" title="엑셀 다운로드" value="엑셀 다운로드" onclick="javascript:ExcelDownload();"/>
			<form name="uploadForm" id="uploadForm" action="" method="post" encType="multipart/form-data" style="display:inline-block;overflow:hidden;vertical-align:middle">
				<input type="button" class="btn btn-primary btn-sm addBtn" title="엑셀 업로드" value="엑셀 업로드" onclick="javascript:goExcelUpload();" style="float:left"/>
			</form>
			</div>
			    
	    	<!-- START PAGER -->  
			<div class="text-center">
			   <ul class="pagination pagination-sm">
			  		<c:if test="${pageNavigation.prevPage}">
				        <li><a href="javascript:goPage(1);" title="처음">&#60;&#60;</a></li>
				        <li><a href="javascript:goPage(${pageNavigation.startPage - 1});" title="이전">&#60;</a></li>
			        </c:if>
			        <c:forEach var="page" begin="${pageNavigation.startPage}" end="${pageNavigation.endPage}">
			        	<li <c:if test="${page eq pageNavigation.nowPage}">class="active"</c:if>><a href="javascript:goPage(${page});">${page}</a></li>
			        </c:forEach>
			        <c:if test="${pageNavigation.nextPage}">
						<li><a href="javascript:goPage(${pageNavigation.endPage + 1});" title="다음">&#62;</a></li>
			        	<li><a href="javascript:goPage(${pageNavigation.totalPage});" title="끝">&#62;&#62;</a></li>        
			        </c:if>
				</ul>
			</div>
	    	<!-- END PAGER -->  
	    	
	    	 <!-- footer start -->
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		    <!-- footer end -->
	    </div>
	</div>
</div>
<!-- END CONTENTS -->

<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />

<script type="text/javascript">
$(function() { //html 문서가 처음 로딩 되고 난후 실행되는 init 함수
	// 검색
	$("#searchBtn").click(function() {
		paging(1);
	});
	
	// 검색 초기화
	$("#resetBtn").click(function() {
		location.href="dictionary_list.do";
	});
});

// 등록페이지로 이동
function goWriteForm() {
	location.href="dictionary_form.do";
}

// 페이징
function paging(idx){
	$("#iPage").val(idx);
	$("#searchForm").submit();
}

// 엑셀 다운로드 URL 호출
function ExcelDownload() {
	location.href = "dictionary_excelDownload.do";
}

// 양식 다운로드 URL 호출
function SampleDownload() {
	location.href = "dictionary_sampleDownload.do";	
}

// 엑셀 업로드 팝업창 열기
function goExcelUpload() {
	window.open('dictionary_excelUploadPopup.do', '_blank', 'width=765, height=225, menubar=no, status=no, toolbar=no location=no, directories=no');
}

//상세보기
function goView(wrd_dic_seq_n){
	$(paramForm).addHidden("wrd_dic_seq_n", wrd_dic_seq_n);
	$(paramForm).attr("action", "dictionary_view.do");
	$(paramForm).submit();
}
</script>

</body>
</html>
