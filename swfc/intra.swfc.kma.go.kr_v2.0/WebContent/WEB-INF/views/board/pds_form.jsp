<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.UserDTO,org.springframework.util.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><spring:message code="title"/></title>
<link rel="stylesheet" type="text/css" href="../css/default.css"  />
<jsp:include page="../include/jquery.jsp" />
<script type="text/javascript" src="<c:url value="/js/jquery.validate.min.js"/>"></script>
<script type="text/javascript">
$(function() {
	//updateEmail();
	
	$("#contents :button").click(function() {
		switch($(this).val()) {
		case "등록":
			$("#article").submit();
			break;
			
		case "취소":
			if(confirm("취소하시겠습니까?")) {
				<c:if test="${not empty param.id}">location.href = "pds_view.do?id=${param.id}&p=${param.p}";</c:if>
				<c:if test="${empty param.id}">location.href = "pds_list.do?p=${param.p}";</c:if>
			}
			break;
		};
	});
});

</script>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->

<div id="contents">
	<h2>
	<c:choose>
		<c:when test="${article.id == null}">게시물 작성</c:when>
		<c:otherwise>게시물 수정</c:otherwise>
	</c:choose>
	</h2>
	<form:form commandName="article" action="pds_submit.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="p" value="${param.p}"/>
	<form:hidden path="id" />
	<form:errors path="*" cssClass="errorBlock" element="div"/>
    <div class="report_form bm2">
        <table>
            <tr>
                <th width="75">종류</th>
                <td>
                <form:select path="type">
                	<form:option value="내부보고서" label="내부 보고서(우주기상 일일상황보고, 우주기상 특보 사후분석서, NASA-KMA 주간보고서 등)"/>
                	<form:option value="연구자료실" label="연구 자료실(사업 보고서, 기술노트 등)"/>
                	<form:option value="발표자료" label="발표자료(워크솝, 타기관의 발표자료 등)"/>
                </form:select>
                </td>                  
            </tr>
            <tr>
                <th width="75">제목</th>
                <td><form:input path="title" style="width:500px"/></td>                  
            </tr>
            <tr>
                <th>내용</th>
                <td><form:textarea path="content" style="width:100%; height:450px;"/></td>                  
            </tr>
            <tr>
                <th>첨부파일</th>
                <td>
                	<input type="file" id="fileData" name="fileData" style="width:300px" />
                </td>                  
            </tr>
        </table>
    </div>
    </form:form>    
    <div class="al_c bm2">
		<input type="button" title="등록" value="등록" class="btnsearch" />
        <input type="button" title="취소" value="취소" class="btnsearch gr" />
    </div>
            
       
</div>
<!-- END CONTENTS -->

<jsp:include page="../footer.jsp" />c

</body>
</html>
