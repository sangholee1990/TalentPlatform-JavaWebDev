<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.SchdDTO,org.springframework.util.*"
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
			<h4 class="page-header">수집대상 스케줄 정보</h4>
			<!-- content area start -->
			
			<form:form commandName="schdDTO" action="sat_schd_submit.do" method="post" class="form-horizontal" role="form">
				<input type="hidden" name="clt_tar_sch_seq_n" value="${schdDTO.clt_tar_sch_seq_n}"/>
				<input type="hidden" name="clt_tar_seq_n" value="${schdDTO.clt_tar_seq_n}"/>
				<input type="hidden" name="clt_tar_grp_seq_n" value="${schdDTO.clt_tar_grp_seq_n}"/>
				<input type="hidden" name="del_f_cd" value="N" />	
				<input type="hidden" name="mode" value="${mode}"/>
				<form:errors path="*" cssClass="errorBlock" element="div"/>
				
				<div class="form-group form-group-sm">
			    	<label for="rcv_d" class="col-sm-2 control-label">수신일자</label>
			    	<div class="col-sm-5">
			      		<div class='input-group date' id='rcv_datepicker' data-date-format="YYYYMMDD">
                                    <form:input path="rcv_d" class="form-control" readonly="true" />
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                         </div>
               		</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="rcv_tm" class="col-sm-2 control-label">수신시간</label>
               		<div class="col-sm-5">
			      		<div class='input-group date' id='rcv_timepicker' data-date-format="HHmm">
                                    <form:input path="rcv_tm" class="form-control" readonly="true"/>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span>
                                    </span>
                         </div>
               		</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="rcv_nd_tm" class="col-sm-2 control-label">수신소요시간</label>
			    	<div class="col-sm-5">
			      		<form:input path="rcv_nd_tm" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="rcv_line" class="col-sm-2 control-label">수신라인</label>
			    	<div class="col-sm-5">
			      		<form:input path="rcv_line" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="rcv_fmt" class="col-sm-2 control-label">수신포맷</label>
			    	<div class="col-sm-5">
			      		<form:input path="rcv_fmt" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="rcv_st_pgm" class="col-sm-2 control-label">수신시시작프로그램</label>
			    	<div class="col-sm-5">
			      		<form:input path="rcv_st_pgm" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="rcv_cncl_f_cd" class="col-sm-2 control-label">수신취소여부코드 </label>
			    	<div class="col-sm-2">
			      		<form:select path="rcv_cncl_f_cd" class="form-control">
			                		<form:option value="Y" label="수신"/>
			                		<form:option value="N" label="취소"/>
			           </form:select>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="max_hi" class="col-sm-2 control-label">최대고도</label>
			    	<div class="col-sm-5">
			      		<form:input path="max_hi" class="form-control"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="prty_rnk" class="col-sm-2 control-label">우선순위</label>
			    	<div class="col-sm-5">
			      		<form:input path="prty_rnk" class="form-control"/>
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
				        <button type="button" id="saveBtn" class="btn btn-default" >등록</button>
				        </c:if>
						<c:if test="${mode eq 'update' }">
				        <button type="button" id="saveBtn" class="btn btn-default" >수정</button>
				        </c:if>
				        <button type="button" title="취소" id="cancelBtn" class="btn btn-default" >취소</button>
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
//var toDay = new Date();

$(function() {
	
	//검색 파라메터 추가
	$(paramForm).find('input[type=hidden]').each(function() {
		$("#schdDTO").addHidden($(this).attr("id"), $(this).val());
	});
	

	//스케줄 년월일 설정
	 $('#rcv_datepicker').datetimepicker({
		 language: 'ko',
		 showToday: true,
         pickTime: false
     });

	$("#rcv_d").click(function () {
       $('#rcv_datepicker').data("DateTimePicker").show();
    }); 
	
	 if ( $("#rcv_d").val() == "" )
	 	$('#rcv_datepicker').data("DateTimePicker").setDate(moment().format('YYYYMMDD'));

	//스케줄 시분 설정
     $('#rcv_timepicker').datetimepicker({
         language: 'ko',
         pick12HourFormat: true,
         pickDate: false,
         showToday: true
     });
     
	$("#rcv_tm").click(function () {
       $('#rcv_timepicker').data("DateTimePicker").show();
    }); 
     if ( $("#rcv_tm").val() == "" )
 	 	$('#rcv_timepicker').data("DateTimePicker").setDate(moment().format('HHmm'));

     
     //저장 
     $("#saveBtn").click(function() {
    	 $("#schdDTO").submit();
     });
    
     //취소
     $("#cancelBtn").click(function() {
    	//수정
			<c:if test="${not empty schdDTO.clt_tar_sch_seq_n}">
				var url = "sat_schd_view.do";
			</c:if>

			//등록
			<c:if test="${empty schdDTO.clt_tar_sch_seq_n}">
				var url = "sat_view.do";
			</c:if>
			
			$(paramForm).attr("action", url);
			$(paramForm).submit();
     });
     
     
     //validate
	$("#schdDTO").validate({
		debug: false,
		ignore:"",
		rules: {
			rcv_d:{
				required:true
			},
			rcv_tm: {
				required:true
			},
			rcv_line: {
				number: true
			},
			rcv_nd_tm: {
				fieldLength : 5,
				number: true
			},
			rcv_fmt: {
				fieldLength : 10
			},
			rcv_st_pgm: {
				required:true,
				fieldLength : 50
			},
			max_hi: {
				number: true
			},
			prty_rnk: {
				number: true
			}
		},
		messages: {
			rcv_d:{
				required:"수신일자를 입력하세요. "
			},
			rcv_tm: {
				required:"수신시간을 입력하세요."
			},
			rcv_line: {
				number: "수신라인은 숫자만 입력 가능합니다." 
			},
			rcv_nd_tm: {
				fieldLength : "수신 소요시간은 최대 5자리 까지 입력 가능합니다.",
				number: "수신 소요시간은 숫자만 입력 가능합니다." 
			},
			rcv_fmt: {
				fieldLength : "수신포멧은 최대 10자리 까지 입력 가능합니다." 
			},
			rcv_st_pgm: {
				required: "수신시작 프로그램을 입력하세요.", 
				fieldLength : "수신시작 프로그램은 최대 50자리 까지 입력 가능합니다." 
			},
			max_hi: {
				number: "최대고도는 숫자만 입력 가능합니다." 
			},
			prty_rnk: {
				number: "우선순위는 숫자만 입력 가능합니다." 
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
