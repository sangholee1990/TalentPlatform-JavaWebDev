<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.CoverageCDTDTO,org.springframework.util.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
			<h4 class="page-header">범위 좌표 정보</h4>
			<!-- content area start -->
			
			<form:form commandName="coverageCDTDTO" action="coverage_cdt_submit.do" method="post" class="form-horizontal" role="form">
				<input type="hidden" name="coverage_seq_n" value="${coverageCDTDTO.coverage_seq_n}"/>
				<input type="hidden" name="coverage_cdt_seq_n" value="${coverageCDTDTO.coverage_cdt_seq_n}"/>
				<input type="hidden" name="del_f_cd" value="N" />	
				<input type="hidden" name="mode" value="${mode}"/>
				<form:errors path="*" cssClass="errorBlock" element="div"/>
				
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="lft_top_cdt_x" class="col-sm-2 control-label">좌측상단좌표X</label>
			    	<div class="col-sm-5">
			      		<form:input path="lft_top_cdt_x" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="lft_top_cdt_y" class="col-sm-2 control-label">좌측상단좌표Y</label>
			    	<div class="col-sm-5">
			      		<form:input path="lft_top_cdt_y" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="righ_top_cdt_x" class="col-sm-2 control-label">우측상단좌표X</label>
			    	<div class="col-sm-5">
			      		<form:input path="righ_top_cdt_x" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="righ_top_cdt_y" class="col-sm-2 control-label">우측상단좌표Y</label>
			    	<div class="col-sm-5">
			      		<form:input path="righ_top_cdt_y" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="lft_btm_cdt_x" class="col-sm-2 control-label">좌측하단좌표X</label>
			    	<div class="col-sm-5">
			      		<form:input path="lft_btm_cdt_x" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="lft_btm_cdt_y" class="col-sm-2 control-label">좌측하단좌표Y</label>
			    	<div class="col-sm-5">
			      		<form:input path="lft_btm_cdt_y" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="righ_btm_cdt_x" class="col-sm-2 control-label">우측하단좌표X</label>
			    	<div class="col-sm-5">
			      		<form:input path="righ_btm_cdt_x" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="righ_btm_cdt_y" class="col-sm-2 control-label">우측하단좌표Y</label>
			    	<div class="col-sm-5">
			      		<form:input path="righ_btm_cdt_y" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="pixel_per_dstc_x" class="col-sm-2 control-label">픽셀당실거리X</label>
			    	<div class="col-sm-5">
			      		<form:input path="pixel_per_dstc_x" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="pixel_per_dstc_y" class="col-sm-2 control-label">픽셀당실거리Y</label>
			    	<div class="col-sm-5">
			      		<form:input path="pixel_per_dstc_y" class="form-control"/>
			    	</div>
			  	</div>
			  	
				<div class="form-group form-group-sm">
			    	<label for="use_f_cd" class="col-sm-2 control-label">사용여부</label>
			    	<div class="col-sm-2">
			      		<form:select path="use_f_cd" class="form-control">
			                		<form:option value="Y"><fmt:message key="useyn.yes" /></form:option>
			                		<form:option value="N"><fmt:message key="useyn.no" /></form:option>
			           </form:select>
			    	</div>
			  	</div>
			  	
			  	
				<div class="form-group form-group-sm">
					<div class="col-sm-5 text-right">
				        <c:if test="${mode eq 'new' }">
				        <button type="button" value="saveBtn" class="btn btn-default" >등록</button>
				        </c:if>
						<c:if test="${mode eq 'update' }">
				        <button type="button" value="saveBtn" class="btn btn-default" >수정</button>
				        </c:if>
				        
				        <button type="button" value="cancelBtn" class="btn btn-default" >취소</button>
			        </div>
			    </div>

    		</form:form>   
    		
    		<jsp:include page="/WEB-INF/views/include/commonFooter.jsp" /> 
       </div>
    </div>
</div>
<!-- END CONTENTS -->

<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript" src="<c:url value="/js/metadata/metadata.js"/>"></script>
<script type="text/javascript">
$(function() {

	//검색 파라메터 추가
	$(paramForm).find('input[type=hidden]').each(function() {
		$("#coverageCDTDTO").addHidden($(this).attr("id"), $(this).val());
	});
	
	$("#contents :button").click(function() {
		
		switch($(this).val()) {
		case "saveBtn":
			$("#coverageCDTDTO").submit();
			break;
			
		case "cancelBtn":
			
			//수정
			<c:if test="${mode eq 'update' }">
				$(paramForm).attr("action", "coverage_cdt_view.do");
			</c:if>

			//등록
			<c:if test="${mode eq 'new' }">
				$(paramForm).attr("action", "coverage_view.do");
			</c:if>

			$(paramForm).submit();
			
			break;
		};
	});
	
	$("#coverageCDTDTO").validate({
		debug: false,
		ignore:"",
		rules: {
			lft_top_cdt_x:{
				number : true,
				max : 999.9999,
				min : -999.9999
			},
			lft_top_cdt_y:{
				number : true,
				max : 999.9999,
				min : -999.9999
			},
			righ_top_cdt_x:{
				number : true,
				max : 999.9999,
				min : -999.9999
			},
			righ_top_cdt_y:{
				number : true,
				max : 999.9999,
				min : -999.9999
			},
			lft_btm_cdt_x:{
				number : true,
				max : 999.9999,
				min : -999.9999
			},
			lft_btm_cdt_y:{
				number : true,
				max : 999.9999,
				min : -999.9999
			},
			righ_btm_cdt_x:{
				number : true,
				max : 999.9999,
				min : -999.9999
			},
			righ_btm_cdt_y:{
				number : true,
				max : 999.9999,
				min : -999.9999
			},
			pixel_per_dstc_x:{
				number : true,
				max : 999.9999,
				min : -999.9999
			},
			pixel_per_dstc_y:{
				number : true,
				max : 999.9999,
				min : -999.9999
			}
		},
		messages: {
			lft_top_cdt_x:{
				number : "숫자만 입력 가능합니다.",
				max : "최대 값은 999.9999 입니다.",
				min : "최소 값은 -999.9999 입니다."
			},
			lft_top_cdt_y:{
				number : "숫자만 입력 가능합니다.",
				max : "최대 값은 999.9999 입니다.",
				min : "최소 값은 -999.9999 입니다."
			},
			righ_top_cdt_x:{
				number : "숫자만 입력 가능합니다.",
				max : "최대 값은 999.9999 입니다.",
				min : "최소 값은 -999.9999 입니다."
			},
			righ_top_cdt_y:{
				number : "숫자만 입력 가능합니다.",
				max : "최대 값은 999.9999 입니다.",
				min : "최소 값은 -999.9999 입니다."
			},
			lft_btm_cdt_x:{
				number : "숫자만 입력 가능합니다.",
				max : "최대 값은 999.9999 입니다.",
				min : "최소 값은 -999.9999 입니다."
			},
			lft_btm_cdt_y:{
				number : "숫자만 입력 가능합니다.",
				max : "최대 값은 999.9999 입니다.",
				min : "최소 값은 -999.9999 입니다."
			},
			righ_btm_cdt_x:{
				number : "숫자만 입력 가능합니다.",
				max : "최대 값은 999.9999 입니다.",
				min : "최소 값은 -999.9999 입니다."
			},
			righ_btm_cdt_y:{
				number : "숫자만 입력 가능합니다.",
				max : "최대 값은 999.9999 입니다.",
				min : "최소 값은 -999.9999 입니다."
			},
			pixel_per_dstc_x:{
				number : "숫자만 입력 가능합니다.",
				max : "최대 값은 999.9999 입니다.",
				min : "최소 값은 -999.9999 입니다."
			},
			pixel_per_dstc_y:{
				number : "숫자만 입력 가능합니다.",
				max : "최대 값은 999.9999 입니다.",
				min : "최소 값은 -999.9999 입니다."
			}
		},
		errorPlacement: function(error, element) {
		    error.insertAfter(element);
		},		
		submitHandler: (function(form) {
			
			
			//등록
			<c:if test="${mode eq 'new' }">
				var messageStr = "등록하시겠습니까?";
			</c:if>
		
			//수정
			<c:if test="${mode eq 'update' }">
				var messageStr = "수정하시겠습니까?";
			</c:if>
			
			if(confirm(messageStr)) {
				form.submit();
			}
		})
	});
});

</script>

</body>
</html>
