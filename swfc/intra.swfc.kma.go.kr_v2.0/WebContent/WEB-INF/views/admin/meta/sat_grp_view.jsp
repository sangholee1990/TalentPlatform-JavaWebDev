<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.SatGroupDTO, org.springframework.util.*"
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
			<h4 class="page-header">수집대상그룹</h4>
			
        <table class="table table-condensed">
           <tr>
                <th>코드</th>
                <td><spring:escapeBody>${satGroupDTO.clt_tar_grp_cd}</spring:escapeBody></td>                  
            </tr>
           <tr>
                <th>한글명</th>
                <td><spring:escapeBody>${satGroupDTO.clt_tar_grp_kor_nm}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th>영문명</th>
                <td><spring:escapeBody>${satGroupDTO.clt_tar_grp_eng_nm}</spring:escapeBody></td>                  
            </tr>
            
            <tr>
                <th>사용여부</th>
                <td><spring:escapeBody><custom:UseYNConvert useYN="${satGroupDTO.use_f_cd}" /></spring:escapeBody></td>                  
            </tr>
            
            <tr>
                <th>설명</th>
                <td><div class="custom-overflow"><spring:escapeBody>${satGroupDTO.clt_tar_grp_desc}</spring:escapeBody></div></td> 
            </tr>
        </table>
    <div class="top-button-group">
						<input type="button" title="수정" value="수정" class="btn btn-primary btn-sm" />
				    	<input type="button" title="삭제" value="삭제" class="btn btn-primary btn-sm" />
				        <input type="button" title="목록" value="목록" class="btn btn-primary btn-sm" />
			</div>
			
			<jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />
		</div>
	</div>
</div>
<!-- END CONTENTS -->

<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript" src="<c:url value="/js/metadata/metadata.js"/>"></script>
<script type="text/javascript">

$(function() {
	
	$("#contents :button").click(function() {
		switch($(this).val()) {
		case "수정":
			$(paramForm).addHidden("mode", "update");	
			$(paramForm).attr("action", "sat_grp_form.do");
			$(paramForm).submit();
			break;

		case "삭제":
			if(confirm("삭제하시겠습니까?")) {
				$(paramForm).attr("action", "sat_grp_del.do");
				$(paramForm).submit();
			}
			break;
		case "목록":
			$(paramForm).attr("action", "sat_grp_list.do");
			$(paramForm).submit();
			break;
		};
	});
});



</script>

</body>
</html>
