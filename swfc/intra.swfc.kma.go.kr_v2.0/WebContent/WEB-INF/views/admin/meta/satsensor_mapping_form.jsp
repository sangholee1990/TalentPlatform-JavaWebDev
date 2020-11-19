<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.SatSensorMPDTO,org.springframework.util.*"
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
			<h4 class="page-header">수집대상 센서 매핑 정보</h4>
			<!-- content area start -->
	
			<form:form commandName="satSensorMPDTO" action="satsensor_mapping_submit.do" method="post" class="form-horizontal" role="form">
				<input type="hidden" name="mode" value="${mode}"/>
				<input type="hidden" name="clt_tar_seq_n" id="clt_tar_seq_n" value="${satSensorMPDTO.clt_tar_seq_n}"/>
				<input type="hidden" name="clt_tar_sensor_seq_n" id="clt_tar_sensor_seq_n" value="${satSensorMPDTO.clt_tar_sensor_seq_n}"/>
				<form:errors path="*" cssClass="errorBlock" element="div"/>


			   	<div class="form-group form-group-sm">
			    	<label for="clt_tar_grp_kor_nm" class="col-sm-2 control-label">수집대상 그룹</label>
			    	<div class="col-sm-5">
			      		<form:input path="clt_tar_grp_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			  	</div>
			  				 
			   	<div class="form-group form-group-sm">
			    	<label for="clt_tar_kor_nm" class="col-sm-2 control-label">수집대상</label>
			    	<div class="col-sm-5">
			      		<form:input path="clt_tar_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			    	<div class="col-sm-5">
			      		<button type="button" title="수집대상" value="수집대상" class="btn btn-default btn-sm" >수집대상</button>
			    	</div>
			  	</div>
			  	 
			  	<div class="form-group form-group-sm">
			    	<label for="clt_tar_sensor_kor_nm" class="col-sm-2 control-label">센서</label>
			    	<div class="col-sm-5">
			      		<form:input path="clt_tar_sensor_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			    	<div class="col-sm-5">
			      		<button type="button" title="센서" value="센서" class="btn btn-default btn-sm" >센서</button>
			    	</div>
			  	</div>
			  		
			  	
			    <div class="form-group form-group-sm">
			    	<label for="use_f_cd" class="col-sm-2 control-label">사용여부</label>
			    	<div class="col-sm-2">
			      		<form:select path="use_f_cd"  class="form-control">
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

//수집대상, 센서 검색창
var sat_win;
var sensor_win;


//중복체크시 원복용 변수
var sensor_nm;
var sat_nm;
var sat_grp_nm;

$(function() {
	
	sensor_nm = $("#clt_tar_sensor_kor_nm").val();
	sat_nm = $("#clt_tar_kor_nm").val();
	sat_grp_nm = $("#clt_tar_grp_kor_nm").val();
	
	window.onbeforeunload = function(e) {
		if ( sat_win != null ) {
			sat_win.close();
		}
		
		if ( sensor_win != null ) {
			sensor_win.close();
		}
	};
	
	//검색 파라메터 추가
	$(paramForm).find('input[type=hidden]').each(function() {
		$("#satSensorMPDTO").addHidden($(this).attr("id"), $(this).val());
	});
	
	
	$("#contents :button").click(function() {
		
		switch($(this).val()) {
		case "saveBtn":
			$("#satSensorMPDTO").submit();
			break;
			
		case "cancelBtn":
			$(paramForm).attr("action", "satsensor_mapping_list.do");
			$(paramForm).submit();
			break;
		
		case "수집대상":
			sat_win = window.open('sat_list_popup.do', 'sat_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
			sat_win.focus();
			break;
			
		case "센서":
			sensor_win= window.open('sensor_list_popup.do','sensor_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
			sensor_win.focus();
			break;
		};
	});
	
	$("#satSensorMPDTO").validate({
		debug: false,
		ignore:"",
		rules: {
				clt_tar_kor_nm : {
					required : true
				},
				clt_tar_sensor_kor_nm : {
					required : true
				}
		},
		messages: {
				clt_tar_kor_nm : {
					required : "수집대상을 선택 하십시요."
				},
				clt_tar_sensor_kor_nm : {
					required : "수집대상 센서를 선택 하십시요."
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


//수집대상 설정
function setSat(seq, nm, grpNm){
	$("#clt_tar_seq_n").val(seq);
	$("#clt_tar_kor_nm").val(nm);
	$("#clt_tar_grp_kor_nm").val(grpNm);
	checkDuplicate();
}


//센서 설정
function setSensor(seq, nm){
	$("#clt_tar_sensor_seq_n").val(seq);
	$("#clt_tar_sensor_kor_nm").val(nm);
	checkDuplicate();
}


//매핑정보 중복 체크
function checkDuplicate(){

	if ( $("#clt_tar_seq_n").val() != "" 
			&& $("#clt_tar_sensor_seq_n").val() != "" 
			&& ( $("#clt_tar_seq_n").val() != $("#view_clt_tar_seq_n").val() ||
				 $("#clt_tar_sensor_seq_n").val() !=  $("#view_clt_tar_sensor_seq_n").val() 
			    )
	) {
		
		var jsonString = {
				"clt_tar_seq_n": $("#clt_tar_seq_n").val(),
				"clt_tar_sensor_seq_n":$("#clt_tar_sensor_seq_n").val()
				};
	
		var url = "<c:url value='/admin/meta/satsensor_mapping_check_ajax.do'/>";
		$.ajax({ 
	        url: url, 
	        type:"POST", 
	        contentType: "application/json; charset=utf-8",
	        data: JSON.stringify( jsonString ), //Stringified Json Object
	        async: false,    //Cross-domain requests and dataType: "jsonp" requests do not support synchronous operation
	        cache: false,    //This will force requested pages not to be cached by the browser          
	        processData:false, //To avoid making query String instead of JSON
	        success: function(resposeJsonObject){
	        	if ( resposeJsonObject.clt_tar_seq_n != undefined ){

	        		if ( sat_win != null ) {
	        			sat_win.close();
	        		}
	        		
	        		if ( sensor_win != null ) {
	        			sensor_win.close();
	        		}
	        		
		        	alert("수집대상, 센서  매핑 정보 중복입니다. \n 다른 수집대상이나 센서나 선택하세요.");
		        	
		        	$("#clt_tar_seq_n").val($("#view_clt_tar_seq_n").val());
		        	$("#clt_tar_kor_nm").val(sat_nm);
		        	$("#clt_tar_grp_kor_nm").val(sat_grp_nm);
		        	
		        	$("#clt_tar_sensor_seq_n").val($("#view_clt_tar_sensor_seq_n").val());
		        	$("#clt_tar_sensor_kor_nm").val(sensor_nm);
		        	
	        	}
			}
	    });
	}
}


</script>

</body>
</html>
