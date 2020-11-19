<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/js/plugin/lightbox/css/lightbox.css"/>" />	
<jsp:include page="/WEB-INF/views/include/jquery.jsp" />
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript">
	$(function() {
		$("#listBtn").click(function(e) {
			e.preventDefault();
			$(paramForm).attr("action", "faq_list.do");
			$(paramForm).submit();
		});
	});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/topMenu.jsp"/>
<div id="wrap_sub">
	<h2 class="community">
    	<span>정보마당</span>
    </h2>
    <div id="tab" class="tab2">
    	<a href="<c:url value="/ko/board/notice_list.do"/>" class="notice"><span>공지사항</span></a>
        <a href="<c:url value="/ko/board/faq_list.do"/>" class="faq on"><span>FAQ</span></a>
        <a href="<c:url value="/ko/board/archives_list.do"/>" class="data"><span>자료실</span></a>
    </div>
	<div id="faq">
        <h3 class="faq">
            <span>faq</span>
        </h3>
		<table summary='자주묻는질문' class="list">
			<colgroup>
				<col width="10%"/>
				<col width="50%"/>
				<col width="10%"/>
				<col width="50%" style="text-align:left;"/>
			</colgroup>
			<tr>
				<th width="90">제목</th>
				<td style="text-align:left" colspan="3"><spring:escapeBody htmlEscape="true">${faq.title}</spring:escapeBody></td>
			</tr>
			<tr>
				<th>등록일</th>
				<td style="text-align:left;">${faq.create_date}</td>
				<th>조회수</th>
				<td style="text-align:left;">${faq.hit}</td>
			</tr>
			<c:if test="${ not empty fileList}"> 
			<tr>
				<th width="90">첨부파일</th>
				<td colspan="3" style="text-align:left">
					<c:forEach var="file" items="${fileList}">
						<a href="download.do?board_file_seq=${file.board_file_seq}">${file.filename}</a><br/>
					</c:forEach>
				</td>
			</tr>
			</c:if>
			<tr>
				<th style="min-height: 300px;">내용</th>
				<td colspan="3" style="text-align: left; padding-top: 10px; vertical-align: top;"><spring:escapeBody htmlEscape="false">${faq.content}</spring:escapeBody></td>
			</tr>
		</table>
		<a href='#' id="listBtn"><img class='bt_list' src='<c:url value="/resources/ko/images/bt_list.png" />' alt='목록'/></a><!--//bbs : view -->
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
