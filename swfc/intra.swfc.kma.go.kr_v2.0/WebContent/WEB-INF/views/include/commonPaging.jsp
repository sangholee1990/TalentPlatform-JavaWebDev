<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="text-center">
   <ul class="pagination pagination-sm">
	   	<c:if test="${data.pageNavigation.prevPage}">
		<li><a href="javascript:void(0);" title="처음" onclick="paging('1');">&#60;&#60;</a></li>
		<li><a href="javascript:void(0);"  onclick="paging('${data.pageNavigation.startPage - 1}');" title="이전">&#60;</a></li>
		</c:if>
		<c:forEach var="page" begin="${data.pageNavigation.startPage}" end="${data.pageNavigation.endPage}">
	  	<li <c:if test="${page == data.pageNavigation.nowPage}">class="active"</c:if>><a href="javascript:void(0);" onclick="paging('${page}');">${page}</a></li>
		</c:forEach>
	  	<c:if test="${data.pageNavigation.nextPage}">
		<li><a href="javascript:void(0);" onclick="paging('${data.pageNavigation.endPage + 1}');" title="다음">&#62;</a></li>
		<li><a href="javascript:void(0);" onclick="paging('${data.pageNavigation.totalPage}');" title="끝">&#62;&#62;</a></li>
		</c:if>
	</ul>
</div>
<script type="text/javascript">
function paging(page){
	document.listForm.page.value = page;
	document.listForm.submit();
}

</script>
