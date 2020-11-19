<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.CoverageDTO,com.gaia3d.web.dto.CoverageCDTDTO, org.springframework.util.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!doctype html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />
</head>
<body>
<div id="contents" class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">범위 정보</h4>
	
        <table class="table table-condensed">
            <tr>
                <th class="active text-center">코드</th>
                <td><spring:escapeBody>${coverageDTO.coverage_cd}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">한글명</th>
                <td><spring:escapeBody>${coverageDTO.coverage_kor_nm}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">영문명</th>
                <td><spring:escapeBody>${coverageDTO.coverage_eng_nm}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">사용여부</th>
                <td><spring:escapeBody><custom:UseYNConvert useYN="${coverageDTO.use_f_cd}"/></spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">설명</th>
                <td><div class="custom-overflow"><spring:escapeBody>${coverageDTO.coverage_desc}</spring:escapeBody></div></td> 
            </tr>
        </table>
    	
    	<div class="top-button-group">
				        <input type="button" class="btn btn-primary btn-sm" title="범위좌표 등록 " value="범위좌표 등록" />
						<input type="button" title="수정" value="수정" class="btn btn-primary btn-sm" />
				    	<input type="button" title="삭제" value="삭제" class="btn btn-primary btn-sm" />
				        <input type="button" title="목록" value="목록" class="btn btn-primary btn-sm" />
			</div>
			<!-- content area end -->
	
		<h4 class="page-header">범위 좌표 정보</h4>
		
	        <table class="table table-striped">
	        	<thead>
	            	<tr>
	                	<th>No</th>
	                    <th>좌측상단좌표X,Y</th>
	                    <th>좌측하단좌표X,Y</th>
	                    <th>우측상단좌표X,Y</th>
	                    <th>우측하단좌표X,Y</th>
	                    <th>사용여부</th>
	                    <th>등록일</th>
	                </tr>
	            </thead>
				<c:forEach var="o" items="${list}" varStatus="status"> 
	            <tr>
	            	<td class="col-sm-1">${status.index + 1}</td>
	            	<td class="col-sm-1"><a href="javascript:goView(${o.coverage_cdt_seq_n});"><spring:escapeBody>${o.lft_top_cdt_x}, ${o.lft_top_cdt_y}</spring:escapeBody></a></td>
	            	<td class="col-sm-1"><spring:escapeBody>${o.lft_btm_cdt_x},${o.lft_btm_cdt_y}</spring:escapeBody></td>
	            	<td class="col-sm-1"><spring:escapeBody>${o.righ_top_cdt_x},${o.righ_top_cdt_y}</spring:escapeBody></td>
	            	<td class="col-sm-1"><spring:escapeBody>${o.righ_btm_cdt_x},${o.righ_btm_cdt_y}</spring:escapeBody></td>
	                <td class="col-sm-1"><spring:escapeBody><custom:UseYNConvert useYN="${o.use_f_cd}" /></spring:escapeBody></td>
	                <td class="col-sm-2"><spring:escapeBody><custom:DateFormatConvert strDate="${o.rg_d}" strTime="${o.rg_tm}" /></spring:escapeBody></td>
	            </tr>
	            </c:forEach>
	        </table>
	        
	        <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />
    	</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript" src="<c:url value="/js/metadata/metadata.js"/>"></script>
<script type="text/javascript">

$(function() {
	
	$("#contents :button").click(function() {
		switch($(this).val()) {
		case "수정":
			$(paramForm).addHidden("mode", "update");	
			$(paramForm).attr("action", "coverage_form.do");
			$(paramForm).submit();
			break;

		case "삭제":
			if(confirm("삭제하시겠습니까?")) {
				$(paramForm).attr("action", "coverage_del.do");
				$(paramForm).submit();
			}
			break;
		case "목록":
				$(paramForm).attr("action", "coverage_list.do");
				$(paramForm).submit();
			break;
		case "범위좌표 등록":
			$(paramForm).addHidden("mode", "new");	
			$(paramForm).attr("action", "coverage_cdt_form.do");
			$(paramForm).submit();
			break;
		};
	});
}); 


//상세보기
function goView(coverage_cdt_seq_n){
	
	$(paramForm).addHidden("view_coverage_cdt_seq_n", coverage_cdt_seq_n);
	$(paramForm).attr("action","coverage_cdt_view.do");
	$(paramForm).submit();
	
}


</script>
</body>
</html>
