<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.DomainLayerDTO,org.springframework.util.*"
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
	
	<!--  -->
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">도메인 레이어 정보</h4>
			<!-- content area start -->
			
			<form:form commandName="domainLayerDTO" action="domainlayer_submit.do" method="post" class="form-horizontal" role="form">
				<input type="hidden" name="dmn_layer_seq_n" value="${domainLayerDTO.dmn_layer_seq_n}"/>
				<input type="hidden" name="del_f_cd" value="N" />
				<input type="hidden" name="mode" value="${mode}"/>
				<input type="hidden" name="dmn_seq_n" id="dmn_seq_n" value="${domainLayerDTO.dmn_seq_n}"/>
				<form:errors path="*" cssClass="errorBlock" element="div"/>

			  	<div class="form-group form-group-sm">
			    	<label for="dmn_kor_nm" class="col-sm-2 control-label">도메인 정보</label>
			    	<div class="col-sm-5">
			      		<form:input path="dmn_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			    	<div class="col-sm-5">
			      		<button type="button" id="domainSearch" title="도메인 정보" value="도메인 정보" class="btn btn-default btn-sm">도메인 정보</button>
			    	</div>
			  	</div>
			  	
				<div class="form-group form-group-sm">
			    	<label for="dmn_layer_cd" class="col-sm-2 control-label">코드</label>
			    	<div class="col-sm-5">
			      		<form:input path="dmn_layer_cd" class="form-control"/>
			    	</div>
			  	</div>
				<div class="form-group form-group-sm">
			    	<label for="dmn_layer_kor_nm" class="col-sm-2 control-label">한글명</label>
			    	<div class="col-sm-5">
			      		<form:input path="dmn_layer_kor_nm" class="form-control"/>
			    	</div>
			  	</div>
	  	
				<div class="form-group form-group-sm">
			    	<label for="dmn_layer_eng_nm" class="col-sm-2 control-label">영문명</label>
			    	<div class="col-sm-5">
			      		<form:input path="dmn_layer_eng_nm" class="form-control"/>
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
		
			  	
				<div class="form-group">
			    	<label for="dmn_layer_desc" class="col-sm-2 control-label">설명</label>
			    	<div class="col-sm-5">
			      		<form:textarea path="dmn_layer_desc" class="form-control" rows="5"/>
			      	</div>
			  	</div>	  	
			  	
				<div class="form-group form-group-sm">
					<div class="col-sm-5 text-right">
				         <c:if test="${mode eq 'new' }">
				        <button type="button" id="saveBtn" class="btn btn-default" >등록</button>
				        </c:if>
						<c:if test="${mode eq 'update' }">
				        <button type="button" id="saveBtn" class="btn btn-default" >수정</button>
				        </c:if>
				        
				        <button type="button" id="cancelBtn" class="btn btn-default" >취소</button>
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
//검색창
var domain_win;

$(function() {

	window.onbeforeunload = function(e) {
		if ( domain_win != null ) {
			domain_win.close();
		}
	};

	//검색 파라메터 추가
	$(paramForm).find('input[type=hidden]').each(function() {
		$("#domainLayerDTO").addHidden($(this).attr("id"), $(this).val());
	});
	
	
	$("#contents :button").click(function() {
		
		switch($(this).attr("id")) {
		case "saveBtn":
			$("#domainLayerDTO").submit();
			break;
			
		case "cancelBtn":
			//수정
			<c:if test="${mode eq 'update' }">
				$(paramForm).attr("action", "domainlayer_view.do");
			</c:if>

			//등록
			 <c:if test="${mode eq 'new' }">
				$(paramForm).attr("action", "domainlayer_list.do");
			</c:if>

			$(paramForm).submit();
			
			break;
		case "domainSearch":
			domain_win = window.open('domain_list_popup.do', 'domain_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
			domain_win.focus();
			break;	
		}
	});
	
	$("#domainLayerDTO").validate({
		debug: true,
		ignore:"",
		rules: {
			dmn_layer_cd:{
				required : true,
				fieldLength : 50,
				regex: /[^ㄱ-ㅎㅏ-ㅣ가-힣]/g
			},
			dmn_layer_kor_nm:{
				required : true,
				fieldLength : 50
			},
			dmn_layer_eng_nm: {
				alphanumeric : true,
				fieldLength : 50
			},
			dmn_layer_desc: {
				fieldLength : 2000 
			},
			dmn_kor_nm : {
				required : true
			}
		},
		messages: {
			dmn_layer_cd:{
				required : "코드를 입력하세요.",
				fieldLength : "코드명은 최대 50자 까지 입력가능합니다.",
				regex : "한글을 포함할 수 없습니다."
			},
			dmn_layer_kor_nm:{
				required : "한글명을 입력하세요.",
				fieldLength : "한글명은 최대 한글 16자, 영문 50자 까지 입력가능합니다."
			},
			dmn_layer_eng_nm: {
				alphanumeric : "영문명은 영문과 숫자만 입력 가능합니다.",
				fieldLength : "영문명은  최대 50자 까지 입력가능합니다."
			},
			dmn_layer_desc: {
				fieldLength : "설명은  최대 한글 666자 영문 2000자 까지 입력가능합니다." 
			},
			dmn_kor_nm : {
				required : "도메인을 선택 하십시요."
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


//도메인 설정
function setDomain(seq, nm){
	$("#dmn_seq_n").val(seq);
	$("#dmn_kor_nm").val(nm);
}

</script>

</body>
</html>
