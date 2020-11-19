<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="<c:url value="/js/jquery-1.10.2.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery-ui.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.validate.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap/js/bootstrap.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap/js/moment.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap/js/bootstrap-datetimepicker.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap/js/bootstrap-datetimepicker.ko.js"/>"></script>
<script src="<c:url value="/js/menu.js"/>"></script>
<script type="text/javascript">
<!--

//리스트 결과 없을때 메세지
<c:if test="${empty list}">
 var lenTD = $("#searchResultList > thead > tr > th").length;
 $('#searchResultList').append("<tbody id=\"contact\"><tr><td class=\"text-center\" colspan=\""+ lenTD +"\"><strong>검색 결과가 없습니다.</strong></td></tr></tbody>");
</c:if>

//jquery validator 
//영문 숫자 특수문자 입력 ( 한글빼고 전부 입력 가능 )
jQuery.validator.addMethod("alphanumeric", function(value, element) {
	var resultSize = 0;
	for(var i=0; i<value.length; i++){
		var num = value.charCodeAt(i);
		if ( 44032 <= num && num <= 55203 || 12593 <= num && num <= 12643 ) {
				return false;
		}
		
		var c = escape(value.charAt(i));
		if(c.indexOf("%u") != -1){
			return false;
		}
	}
	return  this.optional(element) ||  true; 
});


//한글 byte체크
jQuery.validator.addMethod("fieldLength", function(str, element, param) {
	var resultSize = 0;
	 if(str == null){
	  return 0;
	 }
	 for(var i=0; i<str.length; i++){
	  var c = escape(str.charAt(i));
	  if(c.length == 1){
	   resultSize ++;
	  }else if(c.indexOf("%u") != -1){
	   resultSize += 3;
	  }else if(c.indexOf("%") != -1){
	   resultSize += c.length/3;
	  }
	 }
	 //alert(resultSize + " " + element + " " + param);
	 return  this.optional(element) ||  (resultSize <= param);
});

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

(function($) {
	 
    $.ajaxSetup({
           beforeSend: function(xhr) {
            xhr.setRequestHeader("AJAX", true);
        },
        error: function(xhr, status, err) {
            if (xhr.status == 401) {
                   alert("401");
            } else if (xhr.status == 403) {
                   alert("403");
            } else if (xhr.status == 901) { // ajax session timeout error code SWFCATimeoutRedirectFilter
                   alert("로그인 정보가 없습니다.\n 로그인 페이지로 이동합니다.");
                   window.location = "<c:url value='/'/>";
            } else {
            	if ( xhr.responseText != null && xhr.responseText != "" ){
            		alert(request.responseText);	
            	}else{
                	alert("예외가 발생했습니다. 관리자에게 문의하세요.");
            	}
            }
            
            
        }
    });

})(jQuery);

    
//파라메터 폼 생성
var paramForm ;
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


//검색
$(function() {
	$("#searchBtn").click(function() {
		$("#iPage").val(1);
		$("#searchForm").submit();
	});
	
	//입력란이 search_text일 경우 사용자 키보드가 엔터키일 경우 검색을 요청한다.
	$("input[name='search_text']").on('keypress', function(e){
		if(e.which == 10 || e.which == 13) {
         	$(this.form).submit();
         }
	});
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

//-->

</script>
