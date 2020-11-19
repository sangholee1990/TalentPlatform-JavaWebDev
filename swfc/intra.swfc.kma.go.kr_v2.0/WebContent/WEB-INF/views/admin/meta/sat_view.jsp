<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.SatDTO, org.springframework.util.*"
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
			<h4 class="page-header">수집대상 정보</h4>
	
        <table class="table table-condensed">
            <tr>
                <th class="active text-center">그룹명(영문)</th>
                <td><spring:escapeBody>${satDTO.clt_tar_grp_kor_nm} (${satDTO.clt_tar_grp_eng_nm})</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">코드명</th>
                <td><spring:escapeBody>${satDTO.clt_tar_cd}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">한글명</th>
                <td><spring:escapeBody>${satDTO.clt_tar_kor_nm}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">영문명</th>
                <td><spring:escapeBody>${satDTO.clt_tar_eng_nm}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">사용여부</th>
                <td><spring:escapeBody><custom:UseYNConvert useYN="${satDTO.use_f_cd}"/></spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">설명</th>
                <td><div class="custom-overflow"><spring:escapeBody>${satDTO.clt_tar_desc}</spring:escapeBody></div></td>
            </tr>
        </table>
    	
    	<div class="top-button-group">
				        <input type="button" class="btn btn-primary btn-sm" value="스케줄등록" id="regBtn" title="스케줄 등록" >
						<input type="button" title="수정" value="수정" id="updateBtn" class="btn btn-primary btn-sm" />
				    	<input type="button" title="삭제" value="삭제" id="deleteBtn" class="btn btn-primary btn-sm" />
				        <input type="button" title="목록" value="목록" id="listBtn" class="btn btn-primary btn-sm" />
			</div>
			<!-- content area end -->


		<h4 class="page-header">수집대상 스케줄</h4>
	
	        <table class="table table-striped">
	        	<thead>
	            	<tr>
	                	<th>No</th>
	                    <th>수신시시작프로그램</th>
	                    <th>수신시작 일시</th>
	                    <th>사용여부</th>
	                    <th>등록일</th>
	                </tr>
	            </thead>
				<c:forEach var="o" items="${list}" varStatus="status"> 
	            <tr>
	            	<td class="col-sm-1">${status.index + 1}</td>
	            	<td class="col-sm-4"><a href="javascript:goView(${o.clt_tar_sch_seq_n});"><spring:escapeBody>${o.rcv_st_pgm}</spring:escapeBody></a></td>
	                <td class="col-sm-2"><spring:escapeBody><custom:DateFormatConvert strDate="${o.rcv_d}" strTime="${o.rcv_tm}" /></spring:escapeBody></td>
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
		
		switch($(this).attr("id")) {
		case "regBtn":
		
			$(paramForm).addHidden("mode", "new");
			$(paramForm).attr("action","sat_schd_form.do");
			$(paramForm).submit();
			break;
			
		case "updateBtn":
			$(paramForm).addHidden("mode", "update");
			$(paramForm).attr("action","sat_form.do");
			$(paramForm).submit();
			break;
			
		case "deleteBtn":
			if(confirm("삭제하시겠습니까?")) {
				$(paramForm).attr("action","sat_del.do");
				$(paramForm).submit();
			}
			break;
			
		case "listBtn":
			$(paramForm).attr("action","sat_list.do");
			$(paramForm).submit();
			break;
		}
		
	});
});


//상세보기
function goView(clt_tar_sch_seq_n){
	$(paramForm).addHidden("view_clt_tar_sch_seq_n", clt_tar_sch_seq_n);
	$(paramForm).attr("action" , "sat_schd_view.do");
	$(paramForm).submit();
}

</script>
</body>
</html>
