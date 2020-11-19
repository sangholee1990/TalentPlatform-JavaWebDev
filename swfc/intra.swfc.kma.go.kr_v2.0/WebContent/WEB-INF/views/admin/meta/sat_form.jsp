<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.SatDTO,org.springframework.util.*"
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
			<h4 class="page-header">수집대상 정보</h4>
			<!-- content area start -->
			
			<form:form commandName="satDTO" action="sat_submit.do" method="post" class="form-horizontal" role="form">
				<input type="hidden" name="clt_tar_grp_seq_n" id="clt_tar_grp_seq_n" value="${satDTO.clt_tar_grp_seq_n}"/>
				<input type="hidden" name="clt_tar_seq_n" value="${satDTO.clt_tar_seq_n}"/>
				<input type="hidden" name="del_f_cd" value="N"/>
				<input type="hidden" name="mode" value="${mode}"/>
				<form:errors path="*" cssClass="errorBlock" element="div"/>

			  	<div class="form-group form-group-sm">
			    	<label for="clt_tar_grp_kor_nm" class="col-sm-2 control-label">그룹명</label>
			    	<div class="col-sm-5">
			      		<form:input path="clt_tar_grp_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			    	<div class="col-sm-5">
			      		<button type="button" title="수집대상그룹" id="targetGroupBtn" class="btn btn-default btn-sm">수집대상그룹</button>
			    	</div>
			  	</div>
				
				<div class="form-group form-group-sm">
			    	<label for="clt_tar_cd" class="col-sm-2 control-label">코드</label>
			    	<div class="col-sm-5">
			      		<form:input path="clt_tar_cd" class="form-control"/>
			    	</div>
			  	</div>
				
				<div class="form-group form-group-sm">
			    	<label for="clt_tar_kor_nm" class="col-sm-2 control-label">한글명</label>
			    	<div class="col-sm-5">
			      		<form:input path="clt_tar_kor_nm" class="form-control"/>
			    	</div>
			  	</div>
	  	
				<div class="form-group form-group-sm">
			    	<label for="clt_tar_eng_nm" class="col-sm-2 control-label">영문명</label>
			    	<div class="col-sm-5">
			      		<form:input path="clt_tar_eng_nm" class="form-control"/>
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
			    	<label for="clt_tar_desc" class="col-sm-2 control-label">설명</label>
			    	<div class="col-sm-5">
			      		<form:textarea path="clt_tar_desc" class="form-control" rows="5"/>
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
var sat_grp_win;

//팝업 창 닫기
function closePopup(){
	if ( sat_grp_win != null ) {
		sat_grp_win.close();
	}
}

$(function() {

	//검색 파라메터 추가
	$(paramForm).find('input[type=hidden]').each(function() {
		$("#satDTO").addHidden($(this).attr("id"), $(this).val());
	});
	
	//검색 popup창 닫기
	window.onbeforeunload = function(e) {
		closePopup()
	};

	// 수집대상 그룹 검색 popup
	$("#saveBtn").click(function() {
		$("#satDTO").submit();
	});
	
	// 수집대상 그룹 검색 popup
	$("#cancelBtn").click(function() {
		//수정
		<c:if test="${mode eq 'update' }">
			$(paramForm).attr("action", "sat_view.do");
		</c:if>

		//등록
		 <c:if test="${mode eq 'new' }">
			$(paramForm).attr("action", "sat_list.do");
		</c:if>

		$(paramForm).submit();
	});
	
	
	// 수집대상 그룹 검색 popup
	$("#clt_tar_grp_kor_nm, #targetGroupBtn").click(function() {
		sat_grp_win = window.open('sat_grp_list_popup.do', 'sat_grp_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
		sat_grp_win.focus();
	});
	
	
	$("#satDTO").validate({
		debug: false,
		ignore:"",
		rules: {
			clt_tar_cd:{
				required : true,
				fieldLength : 50,
				regex: /[^ㄱ-ㅎㅏ-ㅣ가-힣]/g
			},
			clt_tar_kor_nm:{
				required : true,
				fieldLength : 50
			},
			clt_tar_eng_nm: {
				alphanumeric : true,
				fieldLength : 50
			},
			clt_tar_grp_kor_nm: {
				required : true
			},
			clt_tar_desc: {
				fieldLength : 2000 
			}
		},
		messages: {
			clt_tar_cd:{
				required : "코드를 입력하세요.",
				fieldLength : "코드명은 최대 50자 까지 입력가능합니다.",
				regex : "한글을 포함할 수 없습니다."
			},
			clt_tar_kor_nm:{
				required : "한글명을 입력하세요.",
				fieldLength : "한글명은 최대 한글 16자, 영문 50자 까지 입력가능합니다."
			},
			clt_tar_eng_nm: {
				alphanumeric : "영문명은 영문과 숫자만 입력 가능합니다.",
				fieldLength : "영문명은  최대 50자 까지 입력가능합니다."
			},
			clt_tar_grp_kor_nm: {
				required : "수집자료 그룹을 선택하세요."
			},
			clt_tar_desc: {
				fieldLength : "설명은  최대 한글 666자 영문 2000자 까지 입력가능합니다." 
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

//수집대상 그룹 설정
function setGroup(seq, nm){
	$("#clt_tar_grp_seq_n").val(seq);
	$("#clt_tar_grp_kor_nm").val(nm);
}

</script>

</body>
</html>
