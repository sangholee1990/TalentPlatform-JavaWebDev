<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.DataKindInsideDTO,org.springframework.util.*"
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
			<h4 class="page-header">자료종류 내부 정보</h4>
			<!-- content area start -->
			
			<form:form commandName="dataKindInsideDTO" action="datakindinside_submit.do" method="post" class="form-horizontal" role="form">
				<input type="hidden" id="dta_knd_seq_n" name="dta_knd_seq_n" value="${dataKindInsideDTO.dta_knd_seq_n}"/>
				<input type="hidden" name="del_f_cd" value="N" />	
				<input type="hidden" name="mode" value="${mode}"/>
				<input type="hidden" name="dta_knd_inside_seq_n" value="${dataKindInsideDTO.dta_knd_inside_seq_n}"/>
				<form:errors path="*" cssClass="errorBlock" element="div"/>



				<div class="form-group form-group-sm">
			    	<label for="dmn_kor_nm" class="col-sm-2 control-label">도메인</label>
			    	<div class="col-sm-5">
			      		<form:input path="dmn_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			  	</div>

			  	<div class="form-group form-group-sm">
			    	<label for="dmn_sub_kor_nm" class="col-sm-2 control-label">도메인 서브 정보</label>
			    	<div class="col-sm-5">
			      		<form:input path="dmn_sub_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			  	</div>
			  	
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="dta_knd_kor_nm" class="col-sm-2 control-label">자료종류 정보</label>
			    	<div class="col-sm-5">
			      		<form:input path="dta_knd_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			    	<div class="col-sm-5">
			      		<button type="button" id="dataKindSearch" title="자료종류정보" value="자료종류 정보" class="btn btn-default btn-sm">자료종류 정보</button>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="dta_knd_cd" class="col-sm-2 control-label">코드</label>
			    	<div class="col-sm-5">
			      		<form:input path="dta_knd_cd" class="form-control"/>
			    	</div>
			  	</div>
			  	
				<div class="form-group form-group-sm">
			    	<label for="dta_knd_inside_kor_nm" class="col-sm-2 control-label">한글명</label>
			    	<div class="col-sm-5">
			      		<form:input path="dta_knd_inside_kor_nm" class="form-control"/>
			    	</div>
			  	</div>
	  	
				<div class="form-group form-group-sm">
			    	<label for="dta_knd_inside_eng_nm" class="col-sm-2 control-label">영문명</label>
			    	<div class="col-sm-5">
			      		<form:input path="dta_knd_inside_eng_nm" class="form-control"/>
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
			    	<label for="dta_knd_inside_desc" class="col-sm-2 control-label">설명</label>
			    	<div class="col-sm-5">
			      		<form:textarea path="dta_knd_inside_desc" class="form-control" rows="5"/>
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
//검색 popup창
var datakind_win;

$(function() {

	//검색 파라메터 추가
	$(paramForm).find('input[type=hidden]').each(function() {
		$("#dataKindInsideDTO").addHidden($(this).attr("id"), $(this).val());
	});
	
	
	//검색 popup창 닫기
	window.onbeforeunload = function(e) {
		if ( datakind_win != null ) {
			datakind_win.close();
		}
	};
	
	$("#contents :button").click(function() {
		switch($(this).attr("id")) {
		case "saveBtn":
			$("#dataKindInsideDTO").submit();
			break;
			
		case "cancelBtn":
			//수정
			<c:if test="${mode eq 'update' }">
				$(paramForm).attr("action", "datakindinside_view.do");
			</c:if>

			//등록
			 <c:if test="${mode eq 'new' }">
				$(paramForm).attr("action", "datakindinside_list.do");
			</c:if>

			$(paramForm).submit();
			
			break;
		case "dataKindSearch":
			datakind_win= window.open('datakind_list_popup.do', '_blank','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
			datakind_win.focus();
			break;	
		
		}
	});
	
	$("#dataKindInsideDTO").validate({
		debug: true,
		ignore:"",
		rules: {
			dta_knd_cd:{
				required : true,
				fieldLength : 50,
				regex: /[^ㄱ-ㅎㅏ-ㅣ가-힣]/g
			},
			dta_knd_inside_kor_nm:{
				required : true,
				fieldLength : 50
			},
			dta_knd_inside_eng_nm: {
				alphanumeric : true,
				fieldLength : 50
			},
			dta_knd_inside_desc: {
				fieldLength : 4000 
			},
			dta_knd_kor_nm : {
				required : true
			}
		},
		messages: {
			dta_knd_cd:{
				required : "코드를 입력하세요.",
				fieldLength : "코드명은 최대 50자 까지 입력가능합니다.",
				regex : "한글을 포함할 수 없습니다."
			},
			dta_knd_inside_kor_nm:{
				required : "한글명을 입력하세요.",
				fieldLength : "한글명은 최대 한글 16자, 영문 50자 까지 입력가능합니다."
			},
			dta_knd_inside_eng_nm: {
				alphanumeric : "영문명은 영문과 숫자만 입력 가능합니다.",
				fieldLength : "영문명은  최대 50자 까지 입력가능합니다."
			},
			dta_knd_inside_desc: {
				fieldLength : "설명은  최대 한글 666자 영문 2000자 까지 입력가능합니다." 
			},
			dta_knd_kor_nm : {
				required : "자료종류 정보를 선택 하십시요."
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
function setDataKind(seq, nm, dmnNm, dmnSubNm){
	$("#dta_knd_seq_n").val(seq);
	$("#dta_knd_kor_nm").val(nm);
	$("#dmn_kor_nm").val(dmnNm);
	$("#dmn_sub_kor_nm").val(dmnSubNm);
	
}

</script>

</body>
</html>
