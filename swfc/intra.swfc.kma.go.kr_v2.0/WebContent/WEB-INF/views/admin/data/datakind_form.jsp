<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.DataKindDTO,org.springframework.util.*"
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
			<h4 class="page-header">자료종류 정보</h4>
			<!-- content area start -->
			
			<form:form commandName="dataKindDTO" action="datakind_submit.do" method="post" class="form-horizontal" role="form">
				<input type="hidden" name="dta_knd_seq_n" value="${dataKindDTO.dta_knd_seq_n}"/>
				<input type="hidden" name="mode" value="${mode}"/>
				<input type="hidden" id="dmn_sub_seq_n" name="dmn_sub_seq_n" value="${dataKindDTO.dmn_sub_seq_n}"/>
				<input type="hidden" name="del_f_cd" value="N" />	
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
			    	<div class="col-sm-5">
			      		<button type="button" title="도메인 서브 정보" id="domainSubSearchBtn" value="도메인 서브정보" class="btn btn-default btn-sm">도메인 서브 정보</button>
			    	</div>
			  	</div>
			  	
				<div class="form-group form-group-sm">
			    	<label for="dta_knd_cd" class="col-sm-2 control-label">코드</label>
			    	<div class="col-sm-5">
			      		<form:input path="dta_knd_cd" class="form-control"/>
			    	</div>
			  	</div>
			  	
				<div class="form-group form-group-sm">
			    	<label for="dta_knd_kor_nm" class="col-sm-2 control-label">한글명</label>
			    	<div class="col-sm-5">
			      		<form:input path="dta_knd_kor_nm" class="form-control"/>
			    	</div>
			  	</div>
	  	
				<div class="form-group form-group-sm">
			    	<label for="dta_knd_eng_nm" class="col-sm-2 control-label">영문명</label>
			    	<div class="col-sm-5">
			      		<form:input path="dta_knd_eng_nm" class="form-control"/>
			    	</div>
			  	</div>
			  	

				<div class="form-group form-group-sm">
			    	<label for="measuring_unt" class="col-sm-2 control-label">측정단위</label>
			    	<div class="col-sm-5">
			      		<form:input path="measuring_unt" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="uncertainty_unt" class="col-sm-2 control-label">불확실성단위</label>
			    	<div class="col-sm-5">
			      		<form:input path="uncertainty_unt" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="hor_res_unt" class="col-sm-2 control-label">수평해상도단위</label>
			    	<div class="col-sm-5">
			      		<form:input path="hor_res_unt" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="ver_res_unt" class="col-sm-2 control-label">수직해상도단위</label>
			    	<div class="col-sm-5">
			      		<form:input path="ver_res_unt" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="stability_unt" class="col-sm-2 control-label">안정성단위</label>
			    	<div class="col-sm-5">
			      		<form:input path="stability_unt" class="form-control"/>
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
			    	<label for="dta_knd_desc" class="col-sm-2 control-label">설명</label>
			    	<div class="col-sm-5">
			      		<form:textarea path="dta_knd_desc" class="form-control" rows="5"/>
			      	</div>
			  	</div>	  	
			  	
			  	
			  	<div class="form-group">
			    	<label for="rmk" class="col-sm-2 control-label">비고</label>
			    	<div class="col-sm-5">
			      		<form:textarea path="rmk" class="form-control" rows="5"/>
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

var domainsub_win;

var dmn_nm;

$(function() {
	
	dmn_nm = $("#dmn_kor_nm").val();

	//검색 파라메터 추가
	$(paramForm).find('input[type=hidden]').each(function() {
		$("#dataKindDTO").addHidden($(this).attr("id"), $(this).val());
	});
	
	//검색 popup창 닫기
	window.onbeforeunload = function(e) {
		if ( domainsub_win != null ) {
			domainsub_win.close();
		}
	}
		
	$("#contents :button").click(function() {
		switch($(this).attr("id")) {
		case "saveBtn":
			$("#dataKindDTO").submit();
			break;
			
		case "cancelBtn":
			
			//수정
			<c:if test="${mode eq 'update' }">
				$(paramForm).attr("action", "datakind_view.do");
			</c:if>

			//등록
			 <c:if test="${mode eq 'new' }">
				$(paramForm).attr("action", "datakind_list.do");
			</c:if>

			$(paramForm).submit();
			
			break;
		case "domainSubSearchBtn":
			domainsub_win = window.open('domainsub_list_popup.do', '_blank','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
			domainsub_win.focus();
			break;	
		
		}
	});
	
	$("#dataKindDTO").validate({
		debug: true,
		ignore:"",
		rules: {
			dta_knd_cd:{
				required : true,
				fieldLength : 50,
				regex: /[^ㄱ-ㅎㅏ-ㅣ가-힣]/g
			},
			dta_knd_kor_nm:{
				required : true,
				fieldLength : 50
			},
			dta_knd_eng_nm: {
				alphanumeric : true,
				fieldLength : 50
			},
			dta_knd_desc: {
				fieldLength : 4000 
			},
			dmn_sub_kor_nm : {
				required : true
			},
			measuring_unt: {
				fieldLength : 50 
			},
			uncertainty_unt: {
				fieldLength : 50 
			},
			hor_res_unt: {
				fieldLength : 50 
			},
			ver_res_unt: {
				fieldLength : 50 
			},
			stability_unt: {
				fieldLength : 50 
			},
			rmk: {
				fieldLength : 4000 
			}	
		},
		messages: {
			dta_knd_cd:{
				required : "코드를 입력하세요.",
				fieldLength : "코드명은 최대 50자 까지 입력가능합니다.",
				regex : "한글을 포함할 수 없습니다."
			},
			dta_knd_kor_nm:{
				required : "한글명을 입력하세요.",
				fieldLength : "한글명은 최대 한글 16자, 영문 50자 까지 입력가능합니다."
			},
			dta_knd_eng_nm: {
				alphanumeric : "영문명은 영문과 숫자만 입력 가능합니다.",
				fieldLength : "영문명은  최대 50자 까지 입력가능합니다."
			},
			dta_knd_desc: {
				fieldLength : "설명은  최대 한글 666자 영문 2000자 까지 입력가능합니다." 
			},
			dmn_sub_kor_nm : {
				required : "도메인 서브정보를 선택 하십시요."
			},
			measuring_unt: {
				fieldLength : "측정단위는 최대 한글 16자 영문 50자 까지 입력가능합니다."
			},
			uncertainty_unt: {
				fieldLength : "불확실성단위는 최대 한글 16자 영문 50자 까지 입력가능합니다." 
			},
			hor_res_unt: {
				fieldLength : "수평해상도단위는 최대 한글 16자 영문 50자 까지 입력가능합니다."
			},
			ver_res_unt: {
				fieldLength : "수직해상도단위는 최대 한글 16자 영문 50자 까지 입력가능합니다."
			},
			stability_unt: {
				fieldLength : "안정성단위는 최대 한글 16자 영문 50자 까지 입력가능합니다."
			},
			rmk: {
				fieldLength : "비고는  최대 한글 1333자  영문 4000자 까지 입력가능합니다." 
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
function setDomainSub(seq, nm, dmnNm){
	$("#dmn_sub_seq_n").val(seq);
	$("#dmn_sub_kor_nm").val(nm);
	$("#dmn_kor_nm").val(dmnNm);
	
}

</script>

</body>
</html>
