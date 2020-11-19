<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="<c:url value="/resources/common/js/jquery-ui.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/common/js/jquery.validate.min.js"/>"></script>
<script type="text/javascript">

//Form parameter append
jQuery.fn.addHidden = function (name, value) {
    return this.each(function () {
    	if ( $(this).find('input[name*="' + name + '"]').length < 1  && value != "" ) {
	        var input = $("<input>").attr("type", "hidden").attr("name", name).attr("id", name).val(value);
	        $(this).append($(input));
	    }else if ( value != "" ){
	    	$("input[name='" + name + "']").val(value);
	    }
    });
};

//파라메터 폼 생성
var paramForm;
$(function() {
	//파라메터 폼 생성
	paramForm = document.createElement("form");
	$(paramForm).attr("method", "post");
	
	<c:forEach var="pageParameter" items="${param}">
		<c:if test="${fn:startsWith(pageParameter.key, 'search_')}">
			$(paramForm).addHidden("<c:out value="${pageParameter.key}" />", "<c:out value="${pageParameter.value}" />");
		</c:if>
		
		<c:if test="${fn:startsWith(pageParameter.key, 'view_')}">
			$(paramForm).addHidden("<c:out value="${pageParameter.key}" />", "<c:out value="${pageParameter.value}" />");
		</c:if>
		
		<c:if test="${pageParameter.key eq 'iPage'}">
			$(paramForm).addHidden("<c:out value="${pageParameter.key}" />", "<c:out value="${pageParameter.value}" />");
		</c:if>
		
		<c:if test="${pageParameter.key eq 'iPageSize'}">
			$(paramForm).addHidden("<c:out value="${pageParameter.key}" />", "<c:out value="${pageParameter.value}" />");
		</c:if>
	</c:forEach>
	document.body.appendChild(paramForm);

	if ( $(paramForm).find("input[id='iPage']").length == 0 )
		$(paramForm).addHidden("iPage","1");
});

//페이지 이동
function goPage(iPage){
	
//	alert($(paramForm).find("#iPage").val() + " " + iPage);
	if ( iPage != $(paramForm).find("#iPage").val() ) {
		$(paramForm).addHidden("iPage",iPage);
		$(paramForm).attr("action",$("#searchForm").attr("action"));
		$(paramForm).submit();
	}
}
</script>