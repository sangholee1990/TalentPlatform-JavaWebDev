<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="text-center">
   <ul class="pagination pagination-sm">
	   	<c:if test="${pageNavigation.prevPage}">
		<li><a href="?p=1" title="처음">&#60;&#60;</a></li>
		<li><a href="?p=${pageNavigation.startPage - 1}" title="이전">&#60;</a></li>
		</c:if>
		<c:forEach var="page" begin="${pageNavigation.startPage}" end="${pageNavigation.endPage}">
	  	<li <c:if test="${page == pageNavigation.nowPage}">class="active"</c:if>><a href="?p=${page}">${page}</a></li>
		</c:forEach>
	  	<c:if test="${pageNavigation.nextPage}">
		<li><a href="?p=${pageNavigation.endPage + 1}" title="다음">&#62;</a></li>
		<li><a href="?p=${pageNavigation.totalPage}" title="끝">&#62;&#62;</a></li>
		</c:if>
	</ul>
</div>

<!-- 
<div class="pager bm4">
  		<c:if test="${pageNavigation.prevPage}">
	        <a href="?p=1" title="처음" class="move"><img src="../images/pager_ico_first.png" alt="이전" /></a>
	        <a href="?p=${pageNavigation.startPage - 1}" title="이전" class="move"><img src="../images/pager_ico_prev.png" alt="이전" /></a>
        </c:if>
        <c:forEach var="page" begin="${pageNavigation.startPage}" end="${pageNavigation.endPage}">
        	<a href="?p=${page}" <c:if test="${page == pageNavigation.nowPage}">class="thispage"</c:if>>${page}</a>
        </c:forEach>
        <c:if test="${pageNavigation.nextPage}">
			<a href="?p=${pageNavigation.endPage + 1}" title="다음" class="move"><img src="../images/pager_ico_next.png" alt="이전" /></a>
        	<a href="?p=${pageNavigation.totalPage}" title="끝" class="move"><img src="../images/pager_ico_last.png" alt="이전" /></a>        
        </c:if>
    </div>
 -->