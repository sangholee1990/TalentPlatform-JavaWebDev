<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.BoardsDTO, org.springframework.util.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

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
			<h4 class="page-header">단어사전 보기</h4>
			 <table class="table table-condensed">
			 	  <tr>
	                <th class="active text-center">예약어</th>
	                <td><spring:escapeBody>${dictionary.simple_nm}</spring:escapeBody></td>                  
	              </tr>
	              <tr>
	                <th class="active text-center">국문명</th>
	                <td><spring:escapeBody>${dictionary.kor_nm}</spring:escapeBody></td>                  
	              </tr>
	               <tr>
	                <th class="active text-center">영문명</th>
	                <td><spring:escapeBody>${dictionary.eng_nm}</spring:escapeBody></td>                  
	              </tr>
	               <tr>
	                <th class="active text-center">등록일자</th>
	                <td><fmt:formatDate value="${dictionary.reg_dt}" pattern="yyyy-MM-dd"/></td>                  
	              </tr>
	               <tr>
	                <th class="active text-center">설명</th>
	                <td><spring:escapeBody>${dictionary.wrd_desc}</spring:escapeBody></td>              
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
			$(paramForm).addHidden("wrd_dic_seq_n", '${dictionary.wrd_dic_seq_n}');
			$(paramForm).attr("action","dictionary_form.do");
			$(paramForm).submit();
			break;
		case "삭제":
			if(confirm("삭제하시겠습니까?")) {
				$(paramForm).addHidden("wrd_dic_seq_n", '${dictionary.wrd_dic_seq_n}');
				$(paramForm).attr("action","dictionary_del.do");
				$(paramForm).submit();
			}
			break;
		case "목록":
			$(paramForm).attr("action","dictionary_list.do");
			$(paramForm).submit();
			break;
		}
	});
});
</script>
</body>
</html>