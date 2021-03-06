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

	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">자료종류 정보</h4>
			<!-- content area start -->
				

			<!-- SEARCH -->
    		<nav class="navbar navbar-default" role="navigation">
					<div class="collapse navbar-collapse navbar-ex1-collapse text-right">
				    	<form class="navbar-form navbar-right" role="search" action="datakind_list.do" method="post" name="searchForm" id="searchForm">
				    	<input type="hidden" name="iPage" id="iPage" value="${pageNavigation.nowPage}">

				    	<input type="hidden" name="search_dmn_sub_seq_n" id="search_dmn_sub_seq_n" value="${param.search_dmn_sub_seq_n}" />
				      	
				      	<div class="form-group has-feedback">
					    	<label for="search_clt_tar_grp_kor_nm" class="control-label">도메인 서브</label>
					      	<input class="form-control input-sm" name="search_dmn_sub_kor_nm" id="search_dmn_sub_kor_nm" type="text" value="${param.search_dmn_sub_kor_nm}" class="form-control" readonly="true"/>
				      		<span class="glyphicon glyphicon-remove form-control-feedback" id="domainSubClearIcon"></span>
					  	</div>
					  	<button type="button" class="btn btn-default" title="도메인 서브" value="domainSubSearch" id="domainSubSearch" ><span class="glyphicon glyphicon-search"></span></button>
	
				      	
						<div class="form-group">
				      	    <label for="search_use" class="control-label">사용여부</label>
				        	<select class="form-control input-sm" name="search_use" id="search_use" title="검색">
								<option value="" >[전체]</option>
								<option value="Y" <c:if test="${param.search_use eq 'Y'}">selected="selected"</c:if> ><fmt:message key="useyn.yes" /></option>
								<option value="N" <c:if test="${param.search_use eq 'N'}">selected="selected"</c:if> ><fmt:message key="useyn.no" /></option>
							</select>
				      	</div>
				      	
				    	<div class="form-group">
				    		<label for="system_seq" class="control-label">검색조건</label>
				    		<select class="form-control input-sm"   name="search_target" id="search_target" title="검색">
								<option value="all">[전체]</option>
								<option value="dta_knd_kor_nm" <c:if test="${param.search_target eq 'dta_knd_kor_nm'}">selected="selected"</c:if> >한글명</option>
								<option value="dta_knd_eng_nm" <c:if test="${param.search_target eq 'dta_knd_eng_nm'}">selected="selected"</c:if> >영문명</option>
							</select>
							<input class="form-control input-sm"   type="text" title="검색어 입력" name="search_text" id="search_text" value="${param.search_text}" />
				      	</div>
				      	
				     	<button type="button" id="searchBtn" class="btn btn-primary btn-sm">검색</button>
				    	</form>
				  	</div>
			</nav>
    				
   		    <div class="top-button-group">
				<input type="button" class="btn btn-primary btn-sm" id="regBtn" title="등록" value="등록" />
			</div>
          
	        <table id="searchResultList" class="table table-striped">
	        	<thead>
	            	<tr>
	                	<th>No</th>
	                	<th>도메인</th>
	                	<th>도메인서브</th>
	                	<th>한글명</th>
	                    <th>영문명</th>
	                    <th>사용여부</th>
	                    <th>등록일</th>
	                </tr>
	            </thead>
				<c:forEach var="o" items="${list}" varStatus="status">            
	            <tr>
	            	<td class="col-sm-1">${pageNavigation.startNum - status.index}</td>
	            	<td class="col-sm-2 text-left"><spring:escapeBody>${o.dmn_kor_nm}</spring:escapeBody></td>
	            	<td class="col-sm-2 text-left"><spring:escapeBody>${o.dmn_sub_kor_nm}</spring:escapeBody></td>
	            	<td class="col-sm-2 text-left"><a href="javascript:goView(${o.dta_knd_seq_n});"><spring:escapeBody>${o.dta_knd_kor_nm}</spring:escapeBody></a></td>
	                <td class="col-sm-2 text-left"><spring:escapeBody>${o.dta_knd_eng_nm}</spring:escapeBody></td>
	                <td class="col-sm-1"><spring:escapeBody><custom:UseYNConvert useYN="${o.use_f_cd}"/></spring:escapeBody></td>
	                <td class="col-sm-2"><spring:escapeBody><custom:DateFormatConvert strDate="${o.rg_d}" strTime="${o.rg_tm}" /></spring:escapeBody></td>
	            </tr>
	            </c:forEach>
	        </table>
	    
	    	<!-- START PAGER -->  
		    <div class="text-center">
			   <ul class="pagination pagination-sm">
			  		<c:if test="${pageNavigation.prevPage}">
				        <li class="active"><a href="javascript:goPage(1);" title="처음"><img src="../images/pager_ico_first.png" alt="이전" /></a></li>
				        <li class="active"><a href="javascript:goPage(${pageNavigation.startPage - 1});" title="이전"><img src="../images/pager_ico_prev.png" alt="이전" /></a></li>
			        </c:if>
			        <c:forEach var="page" begin="${pageNavigation.startPage}" end="${pageNavigation.endPage}">
			        	<li <c:if test="${page eq pageNavigation.nowPage}">class="active"</c:if>><a href="javascript:goPage(${page});">${page}</a></li>
			        </c:forEach>
			        <c:if test="${pageNavigation.nextPage}">
						<li class="active"><a href="javascript:goPage(${pageNavigation.endPage + 1});" title="다음"><img src="../images/pager_ico_next.png" alt="이전" /></a></li>
			        	<li class="active"><a href="javascript:goPage(${pageNavigation.totalPage});" title="끝"><img src="../images/pager_ico_last.png" alt="이전" /></a></li>        
			        </c:if>
				</ul>
			</div>
    		<!-- END PAGER -->  
    		
    		<jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />
		</div>
	</div>
</div>
<!-- END CONTENTS -->

<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript" src="<c:url value="/js/metadata/metadata.js"/>"></script>
<script type="text/javascript">

var domainsub_win;

$(function() {

	window.onbeforeunload = function(e) {
		if ( domainsub_win != null ) {
			domainsub_win.close();
		}
	};

	//검색 제거
	$("#domainSubClearIcon").click(function(){
		setDomainSub(null , null);
	});
	
	// 검색창
	$("#domainSubSearch, #search_dmn_sub_kor_nm").click(function() {
		domainsub_win = window.open('domainsub_list_popup.do', 'sat_grp_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
		domainsub_win.focus();
	});
	
	
	// 등록
	$("#regBtn").click(function() {
		location.href="datakind_form.do?mode=new";
	});
	
});

//상세보기
function goView(dta_knd_seq_n){
	$(paramForm).addHidden("view_dta_knd_seq_n", dta_knd_seq_n);
	$(paramForm).attr("action","datakind_view.do");
	$(paramForm).submit();
}


//도메인 서브 설정
function setDomainSub(seq, nm){
	$("#search_dmn_sub_seq_n").val(seq);
	$("#search_dmn_sub_kor_nm").val(nm);
	
}

</script>
</body>
</html>
