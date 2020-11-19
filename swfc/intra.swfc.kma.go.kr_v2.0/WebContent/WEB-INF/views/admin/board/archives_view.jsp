<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.BoardsDTO, org.springframework.util.*"
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
			<h4 class="page-header">자료실 보기</h4>
        <table class="table table-condensed">
            <tr>
                <th class="active text-center" width="90">사이트 구분</th>
                <td><spring:escapeBody>${archives.site_nm}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">표출여부</th>
                <td><spring:escapeBody>${archives.use_yn eq 'Y' ? '표출' : '미표출'}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">등록일</th>
                <td><spring:escapeBody>${ archives.create_date}</spring:escapeBody></td>                  
            </tr>
            <tr>
                <th class="active text-center">제목</th>
                <td><spring:escapeBody htmlEscape="true">${archives.title}</spring:escapeBody></td>                  
            </tr>
          
            <tr>
                <th class="active text-center">내용</th>
                <td>
                	<c:choose>
                		<c:when test="${5000 le archives.board_seq}"><custom:EscapeJavaScript>${archives.content}</custom:EscapeJavaScript></c:when>
                		<c:otherwise><custom:nl2br>${archives.content}</custom:nl2br></c:otherwise>
                	</c:choose>
                </td>                  
            </tr>
             <tr>
              <th class="active text-center" style="vertical-align: middle;">첨부파일</th>
              <td><c:forEach var="fileList" items="${archivesFileList}">
              		<p><a href="archives_download.do?board_file_seq=${fileList.board_file_seq}"><spring:escapeBody>${fileList.filename}</spring:escapeBody></a></p>
              	  </c:forEach>
              </td> 
		    </tr>
        </table>
	    <div class="top-button-group">
			<input type="button" title="수정" value="수정" class="btn btn-primary btn-sm" />
			<input type="button" title="삭제" value="삭제" class="btn btn-primary btn-sm" />
			<input type="button" title="목록" value="목록" class="btn btn-primary btn-sm" />
		</div>
		
		 <!-- footer start -->
		 <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		 <!-- footer end -->
		    
		</div>
	</div>
</div>
<!-- END CONTENTS -->

<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript">
$(function() {	
	$("#contents :button").click(function() {
		switch($(this).val()) {
		case "수정":
			//location.href = "archives_form.do?board_seq=${param.board_seq}&iPage=${param.iPage}"; 
			$(paramForm).addHidden("board_seq", '${archives.board_seq}');
			$(paramForm).attr("action","archives_form.do");
			$(paramForm).submit();
			break;
		case "삭제":
			if(confirm("삭제하시겠습니까?")) {
				//location.href = "archives_del.do?board_seq=${param.board_seq}&iPage=${param.iPage}";
				$(paramForm).addHidden("board_seq", '${archives.board_seq}');
				$(paramForm).attr("action","archives_del.do");
				$(paramForm).submit();
			}
			break;
		case "목록":
			//location.href = "archives_list.do?iPage=${param.iPage}";
			$(paramForm).attr("action","archives_list.do");
			$(paramForm).submit();
			break;
		}
	});
});
</script>
</body>
</html>