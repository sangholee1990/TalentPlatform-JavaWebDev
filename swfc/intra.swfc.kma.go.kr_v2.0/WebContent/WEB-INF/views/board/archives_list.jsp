<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><spring:message code="title"/></title>
<link rel="stylesheet" type="text/css" href="../css/default.css"  />
<jsp:include page="../include/jquery.jsp" />
<script type="text/javascript">
$(function() {
	$(":button").click(function() {
		goList(1);
	});
});

function goList(iPage){
	$('#iPage').val(iPage);
	$('#searchForm').submit();
}
</script>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->
<div id="contents">
	<h2>자료실</h2>
	
	<div class="search_wrap">    
        <div class="search">
        	<form class="navbar-form navbar-right" action="archives_list.do" method="post" name="searchForm" id="searchForm">
        	<input type="hidden" name="iPage" id="iPage" value="${pageNavigation.nowPage}" />
            <label class="type_tit sun">검색</label>&nbsp;
            자료구분
            <select name="board_section_cd" id="board_section_cd" title="검색">
				<option value="">[전체]</option>
    			<c:forEach var="o" items="${boardSubCodeList}" varStatus="status">            
            	<option value="${o.code}" <c:if test="${o.code eq param.board_section_cd}">selected="selected"</c:if>>${o.code_nm}</option>
          		</c:forEach>
			</select>
			검색구분
            <select name="search_target" id="search_target" title="검색">
            	<option value="" <c:if test="${param.search_target eq ''}">selected="selected"</c:if>>[전체]</option>
            	<option value="title" <c:if test="${param.search_target eq 'title'}">selected="selected"</c:if>>제목</option>
            	<option value="content" <c:if test="${param.search_target eq 'content'}">selected="selected"</c:if>>내용</option>
			</select>
			<input type="text" size="12" id="search_text" name="search_text" value="${param.search_text}"/>
            <div class="searchbtns">           
                <input type="button" title="검색" value="검색" class="btnsearch" id="btnsearch"/>
            </div>
           </form>               
        </div>
    </div>
	
    <div class="report_list">
        <table>
        	<thead>
            	<tr>
                	<th>no</th>
                	<th>종류</th>
                	<th>제목</th>
                	<!-- 
                	<th>첨부파일</th>
                	 -->
                    <th width="120">작성일</th>
                    <th width="120">조회</th>
                </tr>
            </thead>
            <c:choose>
            	<c:when test="${fn:length(list) == 0}">
            		<tr><td colspan="5">등록된 자료가 없습니다.</td></tr>
            	</c:when>
            	<c:otherwise>
					<c:forEach var="o" items="${list}" varStatus="status">            
		            <tr>
		            	<td class="no">${pageNavigation.startNum - status.index}</td>
		            	<td><spring:escapeBody>${o.board_section_nm}</spring:escapeBody></td>
		            	<td><a href="archives_view.do?board_seq=${o.board_seq}&iPage=${pageNavigation.nowPage}"><spring:escapeBody>${o.title}</spring:escapeBody></a>
		            	<c:if test="${ o.is_new  eq 'Y'}"><span class="new">New</span></c:if></td>
		                <!-- 
		                 -->
		                <td><spring:escapeBody>${o.create_date}</spring:escapeBody></td>
		                <td><spring:escapeBody>${o.hit}</spring:escapeBody></td>
		            </tr>
		            </c:forEach>
            	</c:otherwise>
            </c:choose>
        </table>
    </div>
    
    <div class="pager bm4">
  		<c:if test="${pageNavigation.prevPage}">
	        <a href="javascript:goList(1);" title="처음" class="move"><img src="../images/pager_ico_first.png" alt="이전" /></a>
	        <a href="javascript:goList();" title="이전" class="move"><img src="../images/pager_ico_prev.png" alt="이전" /></a>
        </c:if>
        <c:forEach var="page" begin="${pageNavigation.startPage}" end="${pageNavigation.endPage}">
        	<a href="javascript:goList(${page});" <c:if test="${page == pageNavigation.nowPage}">class="thispage"</c:if>>${page}</a>
        </c:forEach>
        <c:if test="${pageNavigation.nextPage}">
			<a href="javascript:goList(${pageNavigation.endPage + 1});" title="다음" class="move"><img src="../images/pager_ico_next.png" alt="이전" /></a>
        	<a href="javascript:goList(${pageNavigation.totalPage});" title="끝" class="move"><img src="../images/pager_ico_last.png" alt="이전" /></a>        
        </c:if>
    </div>
    <!-- END PAGER -->  
</div>
<!-- END CONTENTS -->

<jsp:include page="../footer.jsp" />

</body>
</html>
