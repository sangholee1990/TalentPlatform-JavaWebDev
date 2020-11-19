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
			<h4 class="page-header">도메인 레이어 자료종류 매핑 정보</h4>
			<!-- content area start -->
				

			<!-- SEARCH -->
    		<nav class="navbar navbar-default" role="navigation">
					<div class="collapse navbar-collapse navbar-ex1-collapse text-right">
				    	<form class="navbar-form navbar-right" role="search" action="domaindatamapping_list.do" method="post" name="searchForm" id="searchForm">
				    	<input type="hidden" name="iPage" id="iPage" value="${pageNavigation.nowPage}">
				      
				        <input type="hidden" name="search_dmn_seq_n" id="search_dmn_seq_n" value="${param.search_dmn_seq_n}" />
				      	<input type="hidden" name="search_dmn_sub_seq_n" id="search_dmn_sub_seq_n" value="${param.search_dmn_sub_seq_n}" />
				      	<input type="hidden" name="search_dmn_layer_seq_n" id="search_dmn_layer_seq_n" value="${param.search_dmn_layer_seq_n}" />
						<input type="hidden" name="search_dta_knd_seq_n" id="search_dta_knd_seq_n" value="${param.search_dta_knd_seq_n}" />
				    		
				    	<div class="form-group has-feedback">
					    	<label for="search_dmn_kor_nm" class="control-label">도메인</label>
					      	<input class="form-control input-sm" name="search_dmn_kor_nm" id="search_dmn_kor_nm" type="text" value="${param.search_dmn_kor_nm}" class="form-control" readonly="true"/>
				      		<span class="glyphicon glyphicon-remove form-control-feedback" id="domainClearIcon"></span>
					  	</div>
					  	<button type="button" class="btn btn-default" title="도메인" value="domainSearch" id="domainSearch" ><span class="glyphicon glyphicon-search"></span></button>
				    		
				      	
				      	<div class="form-group has-feedback">
					    	<label for="search_dmn_sub_kor_nm" class="control-label">도메인서브</label>
					      	<input class="form-control input-sm" name="search_dmn_sub_kor_nm" id="search_dmn_sub_kor_nm" type="text" value="${param.search_dmn_sub_kor_nm}" class="form-control" readonly="true"/>
				      		<span class="glyphicon glyphicon-remove form-control-feedback" id="domainSubClearIcon"></span>
					  	</div>
					  	<button type="button" class="btn btn-default" title="도메인 서브" value="domainSubSearch" id="domainSubSearch" ><span class="glyphicon glyphicon-search"></span></button>
	

						<div class="form-group has-feedback">
					    	<label for="search_dmn_layer_kor_nm" class="control-label">도메인레이어 </label>
					      	<input class="form-control input-sm" name="search_dmn_layer_kor_nm" id="search_dmn_layer_kor_nm" type="text" value="${param.search_dmn_layer_kor_nm}" class="form-control" readonly="true"/>
				      		<span class="glyphicon glyphicon-remove form-control-feedback" id="domainLayerClearIcon"></span>
					  	</div>
					  	<button type="button" class="btn btn-default" title="도메인 서브" value="domainLayerSearch" id="domainLayerSearch" ><span class="glyphicon glyphicon-search"></span></button>
	
		<br /> <br/>
				      	
				      	<div class="form-group has-feedback">
					    	<label for="search_dta_knd_kor_nm" class="control-label">자료종류</label>
					      	<input class="form-control input-sm" name="search_dta_knd_kor_nm" id="search_dta_knd_kor_nm" type="text" value="${param.search_dta_knd_kor_nm}" class="form-control" readonly="true"/>
				      		<span class="glyphicon glyphicon-remove form-control-feedback" id="dataKindClearIcon"></span>
					  	</div>
					  	<button type="button" class="btn btn-default" title="자료종류" value="dataKindSearch" id="dataKindSearch" ><span class="glyphicon glyphicon-search"></span></button>
				      	
				     
				      	<div class="form-group has-feedback">
					    	<label for="search_dta_knd_inside_kor_nm" class="control-label">자료종류내부</label>
					      	<input class="form-control input-sm" name="search_dta_knd_inside_kor_nm" id="search_dta_knd_inside_kor_nm" type="text" value="${param.search_dta_knd_inside_kor_nm}" class="form-control" readonly="true"/>
				      		<span class="glyphicon glyphicon-remove form-control-feedback" id="dataKindInsideClearIcon"></span>
					  	</div>
					  	<button type="button" class="btn btn-default" title="자료종류내부" value="dataKindInsideSearch" id="dataKindInsideSearch" ><span class="glyphicon glyphicon-search"></span></button>
				      	
				      	
				      			
				      	<div class="form-group">
				      	    <label for="search_use" class="control-label">사용여부</label>
				        	<select class="form-control input-sm"   name="search_use" id="search_use" title="검색">
								<option value="" >[전체]</option>
								<option value="Y" <c:if test="${param.search_use eq 'Y'}">selected="selected"</c:if> ><fmt:message key="useyn.yes" /></option>
								<option value="N" <c:if test="${param.search_use eq 'N'}">selected="selected"</c:if> ><fmt:message key="useyn.no" /></option>
							</select>
				      	</div>
				      	
				      	
				      	<!--
				    	<div class="form-group">
				    		<label for="system_seq" class="control-label">검색조건</label>
				    		<select class="form-control input-sm"   name="search_target" id="search_target" title="검색">
								<option value="all">[전체]</option>
								<option value="dmn_kor_nm" <c:if test="${param.search_target eq 'dmn_kor_nm'}">selected="selected"</c:if> >도메인</option>
								<option value="dmn_sub_kor_nm" <c:if test="${param.search_target eq 'dmn_sub_kor_nm'}">selected="selected"</c:if> >도메인 서브</option>
								<option value="dmn_layer_kor_nm" <c:if test="${param.search_target eq 'dmn_layer_kor_nm'}">selected="selected"</c:if> >도메인레이어</option>
								<option value="dta_knd_kor_nm" <c:if test="${param.search_target eq 'dta_knd_kor_nm'}">selected="selected"</c:if> >자료종류</option>
								<option value="dta_knd_inside_kor_nm" <c:if test="${param.search_target eq 'dta_knd_inside_kor_nm'}">selected="selected"</c:if> >자료종류 내부</option>
							</select>
							<input class="form-control input-sm"   type="text" title="검색어 입력" name="search_text" id="search_text" value="${param.search_text}" />
				      	</div>
				      	-->
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
	                	<th>도메인레이어</th>
	                	<th>자료종류</th>
	                	<th>자료종류내부</th>
	                    <th>사용여부</th>
	                    <th>등록일</th>
	                </tr>
	            </thead>
				<c:forEach var="o" items="${list}" varStatus="status">            
	            <tr>
	            	<td class="no">${pageNavigation.startNum - status.index}</td>
	            	<td><spring:escapeBody>${o.dmn_kor_nm}</spring:escapeBody></td>
	            	<td><spring:escapeBody>${o.dmn_sub_kor_nm}</spring:escapeBody></td>
	            	<td><spring:escapeBody>${o.dmn_layer_kor_nm}</spring:escapeBody></td>
	            	<td><spring:escapeBody>${o.dta_knd_kor_nm}</spring:escapeBody></td>
	            	<td><a href="javascript:goView(${o.dmn_seq_n}, ${o.dmn_layer_seq_n}, ${o.dmn_sub_seq_n},${o.dta_knd_seq_n}, ${o.dta_knd_inside_seq_n});"><spring:escapeBody>${o.dta_knd_inside_kor_nm}</spring:escapeBody></a></td>
	                <td><spring:escapeBody><custom:UseYNConvert useYN="${o.use_f_cd}"/></spring:escapeBody></td>
	                <td><spring:escapeBody><custom:DateFormatConvert strDate="${o.rg_d}" strTime="${o.rg_tm}" /></spring:escapeBody></td>
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


var domain_win;
var domainsub_win;
var domainlayer_win;
var datakind_win;
var datakindinside_win;


$(function() {

	window.onbeforeunload = function(e) {
		if ( domain_win != null ) {
			domain_win.close();
		}
		
		if ( domainsub_win != null ) {
			domainsub_win.close();
		}
		
		if ( domainlayer_win != null ) {
			domainlayer_win.close();
		}
		if ( datakind_win != null ) {
			datakind_win.close();
		}
		if ( datakindinside_win != null ) {
			datakindinside_win.close();
		}
	};
	
	//도메인 검색 제거
	$("#domainClearIcon").click(function(){
		setDomain(null , null);
	});
	

	// 도메인 검색
	$("#domainSearch, #search_dmn_kor_nm").click(function() {
		domain_win = window.open('<c:url value="/admin/data/domain_list_popup.do"/>', 'domain_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
		domain_win.focus();
	});
	
	
	//도메인 서브 검색 제거
	$("#domainSubClearIcon").click(function(){
		setDomainSub(null , null);
	});
	
	// 도메인서브 검색
	$("#domainSubSearch, #search_dmn_sub_kor_nm").click(function() {
		domainsub_win = window.open('<c:url value="/admin/data/domainsub_list_popup.do"/>', 'domainsub_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
		domainsub_win.focus();
	});

	//도메인  레이어 검색 제거
	$("#domainLayerClearIcon").click(function(){
		setDomainLayer(null , null);
	});
	
	// 도메인레이어 검색
	$("#domainLayerSearch, #search_dmn_layer_kor_nm").click(function() {
		domainlayer_win = window.open('<c:url value="/admin/data/domainlayer_list_popup.do"/>', 'domainlayer_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
		domainlayer_win.focus();
	});
	
	
	//자료종류 검색 제거
	$("#dataKindClearIcon").click(function(){
		setDataKind(null , null);
	});
	
	
	//자료종류 검색창
	$("#dataKindSearch, #search_dta_knd_kor_nm").click(function() {
		datakind_win = window.open('<c:url value="/admin/data/datakind_list_popup.do"/>', 'datakind_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
		datakind_win.focus();
	});	
	
	
	//자료종류 내부 검색 제거
	$("#dataKindInsideClearIcon").click(function(){
		setDataKindInside(null , null);
	});
	
	
	//자료종류 내부 검색창
	$("#dataKindInsideSearch, #search_dta_knd_inside_kor_nm").click(function() {
		datakindinside_win = window.open('<c:url value="/admin/data/datakindinside_list_popup.do"/>', 'datakindinside_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
		datakindinside_win.focus();
	});	

	// 등록
	$("#regBtn").click(function() {
		location.href="domaindatamapping_form.do?mode=new";
	});

});


//매핑 수정
function goView(dmn_seq_n, 
		dmn_layer_seq_n, 
		dmn_sub_seq_n,
		dta_knd_seq_n,
		dta_knd_inside_seq_n ){

	$(paramForm).addHidden("mode", "update");
	$(paramForm).addHidden("view_dmn_seq_n", dmn_seq_n);
	$(paramForm).addHidden("view_dmn_layer_seq_n", dmn_layer_seq_n);
	$(paramForm).addHidden("view_dmn_sub_seq_n", dmn_sub_seq_n);
	$(paramForm).addHidden("view_dta_knd_seq_n", dta_knd_seq_n);
	$(paramForm).addHidden("view_dta_knd_inside_seq_n", dta_knd_inside_seq_n);
	
	$(paramForm).attr("action", "domaindatamapping_form.do");
	$(paramForm).submit();
	
}



//도메인 설정
function setDomain(seq, nm){
	$("#search_dmn_seq_n").val(seq);
	$("#search_dmn_kor_nm").val(nm);
	
}


//도메인 서브 설정
function setDomainSub(seq, nm){
	$("#search_dmn_sub_seq_n").val(seq);
	$("#search_dmn_sub_kor_nm").val(nm);
	
}



//도메인 레이어 설정
function setDomainLayer(seq, nm){
	$("#search_dmn_layer_seq_n").val(seq);
	$("#search_dmn_layer_kor_nm").val(nm);
}


//자료종류 설정
function setDataKind(seq, nm){
	$("#search_dta_knd_seq_n").val(seq);
	$("#search_dta_knd_kor_nm").val(nm);
}

//자료종류 내부 설정
function setDataKindInside(seq, nm){
	$("#search_dta_knd_inside_seq_n").val(seq);
	$("#search_dta_knd_inside_kor_nm").val(nm);
}
</script>
</body>
</html>
