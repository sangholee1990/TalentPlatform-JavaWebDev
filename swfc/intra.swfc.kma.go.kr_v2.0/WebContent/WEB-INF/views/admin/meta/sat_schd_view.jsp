<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.SchdDTO, org.springframework.util.*"
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
			<h4 class="page-header">수집대상 스케줄 정보</h4>
	
        <table class="table table-condensed">
            <tr>
                <th class="active text-center" width="90">수신일시</th>
                <td><spring:escapeBody><custom:DateFormatConvert strDate="${schdDTO.rcv_d}" strTime="${schdDTO.rcv_tm}" /></spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">수신소요시간</th>
                <td><spring:escapeBody>${schdDTO.rcv_nd_tm}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">수신라인</th>
                <td><spring:escapeBody>${schdDTO.rcv_line}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">수신포맷</th>
                <td><spring:escapeBody>${schdDTO.rcv_fmt}</spring:escapeBody></td>                  
            </tr>
            
           <tr>
                <th class="active text-center">수신시시작프로그램</th>
                <td><spring:escapeBody>${schdDTO.rcv_st_pgm}</spring:escapeBody></td>                  
            </tr>
            
            <tr>
                <th class="active text-center">수신취소여부코드</th>
                <td><spring:escapeBody>${schdDTO.rcv_cncl_f_cd == "Y" ? "수신" : "취소"}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">최대고도</th>
                <td><spring:escapeBody>${schdDTO.max_hi}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">우선순위</th>
                <td><spring:escapeBody>${schdDTO.prty_rnk}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">사용여부</th>
                <td><spring:escapeBody><custom:UseYNConvert useYN="${schdDTO.use_f_cd}"/></spring:escapeBody></td>                  
            </tr>
            
        </table>
    	
    	<div class="top-button-group">
						<input type="button" title="수정" value="수정" id="updateBtn" class="btn btn-primary btn-sm" />
				    	<input type="button" title="삭제" value="삭제" id="deleteBtn" class="btn btn-primary btn-sm" />
				        <input type="button" title="목록" value="목록" id="listBtn" class="btn btn-primary btn-sm" />
			</div>
			<!-- content area end -->
			
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
		case "updateBtn":
			$(paramForm).addHidden("mode", "update");
			$(paramForm).attr("action","sat_schd_form.do");
			$(paramForm).submit();
			break;

		case "deleteBtn":
			if(confirm("삭제하시겠습니까?")) {
				$(paramForm).attr("action","sat_schd_del.do");
				$(paramForm).submit();
			}
			break;
		case "listBtn":
			$(paramForm).attr("action","sat_view.do");
			$(paramForm).submit();
			break;
		};
	});
});

</script>
</body>
</html>
