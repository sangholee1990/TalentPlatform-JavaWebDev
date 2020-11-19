<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!doctype html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />
<style type="text/css">
    </style>
</head>
<body>
<div class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">실황통보관리</h4>
			<!-- content area start -->
		        <form name="frm" id="frm" class="form-horizontal" role="form" action="<c:url value="/admin/sms/sms_threshold_submit.do"/>" method="post">
			 	<div class="col-sm-6 col-md-6">
		        	<input type="hidden" name="sms_threshold_seq_n" id="sms_threshold_seq_n" value="${sms.sms_threshold_seq_n}" />
				 	<div class="form-group form-group-sm">
				    	<label for="use_yn" class="col-sm-3 control-label">사용여부</label>
				    	<div class="col-sm-5">
				    		<select name="use_yn" class="form-control" id="use_yn">
				    			<option value="Y" <c:if test="${sms.use_yn eq 'Y'}">selected='selected'</c:if>>사용</option>
				    			<option value="N" <c:if test="${sms.use_yn eq 'N'}">selected='selected'</c:if>>미사용</option>
				    		</select>
				    	</div>
				  	</div>
				  	<div class="form-group form-group-sm">
				    	<label for="threshold_nm" class="col-sm-3 control-label">등급</label>
				    	<div class="col-sm-9">
				    		<select name="grade_no"  class="form-control">
				    			<option value="1" <c:if test="${sms.grade_no eq '1'}">selected='selected'</c:if>>일반(1)</option>
				    			<option value="2" <c:if test="${sms.grade_no eq '2'}">selected='selected'</c:if>>관심(2)</option>
				    			<option value="3" <c:if test="${sms.grade_no eq '3'}">selected='selected'</c:if>>주의(3)</option>
				    			<option value="4" <c:if test="${sms.grade_no eq '4'}">selected='selected'</c:if>>경계(4)</option>
				    			<option value="5" <c:if test="${sms.grade_no eq '5'}">selected='selected'</c:if>>심각(5)</option>
				    		</select>
				    	</div>
				  	</div>
				 	<div class="form-group form-group-sm">
				    	<label for="threshold_nm" class="col-sm-3 control-label">요소명</label>
				    	<div class="col-sm-9">
				      		<input type="text" class="form-control" id="threshold_nm" name="threshold_nm" placeholder="요소명을 입력해주세요" value="${sms.threshold_nm}" maxlength="40">
				    	</div>
				  	</div>
				 	<div class="form-group form-group-sm">
				    	<label for="table_nm" class="col-sm-3 control-label">테이블명</label>
				    	<div class="col-sm-9">
				      		<input type="text" class="form-control" id="table_nm" name="table_nm" placeholder="테이블명을 입력해주세요." value="${sms.table_nm}" maxlength="40">
				    	</div>
				  	</div>
				 	<div class="form-group form-group-sm">
				    	<label for="column_nm" class="col-sm-3 control-label">컬럼명</label>
				    	<div class="col-sm-9">
				      		<input type="text" class="form-control" id="column_nm" name="column_nm" placeholder="컬럼명을 입력해주세요." value="${sms.column_nm}" maxlength="40">
				    	</div>
				  	</div>
				 	<div class="form-group form-group-sm">
				    	<label for="date_column_nm" class="col-sm-3 control-label">시간 컬럼명</label>
				    	<div class="col-sm-9">
				      		<input type="text" class="form-control" id="date_column_nm" name="date_column_nm" placeholder="컬럼명을 입력해주세요." value="${sms.date_column_nm}" maxlength="40">
				    	</div>
				  	</div>
				 	<div class="form-group form-group-sm">
				    	<label for="msg1" class="col-sm-3 control-label">발송 메세지</label>
				    	<div class="col-sm-9 text-right">
				    		<textarea class="form-control" rows="3" id="msg1" name="msg1" placeholder="발송 메세지를 입력해주세요." style="height: 100px;" maxlength="80">${sms.msg1}</textarea>
				    		<br/>
				    		<span id="messageByteInfo">0</span>/80 byte
				    	</div>
				  	</div>
				 	<div class="form-group form-group-sm">
				    	<label for="msg2" class="col-sm-3 control-label">경과 메세지</label>
				    	<div class="col-sm-9 text-right">
				    		<textarea class="form-control" rows="3" id="msg2" name="msg2" placeholder="발송 시간 경과후 메세지를 입력해주세요." style="height: 100px;" maxlength="80">${sms.msg2}</textarea>
				    		<br/>
				    		<span id="message2ByteInfo">0</span>/80 byte
				    	</div>
				  	</div>
				  	<div class="form-group form-group-sm">
				  		<label for="message" class="col-sm-3 control-label"></label>
					    <div class="col-sm-9 text-right">
					    	<button type="button" class="btn btn-default listBtn">목록</button>
					    	<c:if test="${sms.sms_threshold_seq_n eq null }">
					    	<button type="button" class="btn btn-default addBtn">등록</button>
					    	</c:if>
					    	<c:if test="${sms.sms_threshold_seq_n != '' && sms.sms_threshold_seq_n ne null}">
					    	<button type="button" class="btn btn-default editBtn">수정</button>
					    	<button type="button" class="btn btn-default deleteBtn">삭제</button>
					    	<button type="button" class="btn btn-primary gradeBtn">등급관리</button>
					    	</c:if>
					    </div>
				  	</div>
			 	</div>
			 	<div class="col-sm-4 col-md-4">
			 		 <table id="smsUserListTable" class="table table-striped">
			 		 	<caption style="display:none">사용자 목록</caption>
			        	<thead>
			            	<tr>
			                	<th>&nbsp;</th>
			                	<th>사용자</th>
			                    <th>연락처</th>
			                </tr>
			            </thead>
						<tbody>
							<c:forEach var="o" items="${data.list}" varStatus="status">
							<tr>
			                	<td class="no"><input type="checkbox" name="user_seq_n" value="${o.user_seq_n}" <c:if test="${ o.sms_seq_n != null }">checked='checked'</c:if> /></td>
			                	<td>${o.user_nm}</td>
			                	<td>${o.user_hdp}</td>
			                </tr>
							</c:forEach>
							<c:if test="${empty data.list}"> 
							<tr>
								<td colspan="3">등록된 컨텐츠가 존재하지 않습니다.</td>
							</tr> 
							</c:if>
						</tbody>
			        </table>
			        <div class="col-sm-12 col-md-12 text-right">
			        	<button type="button" class="btn btn-default smsUserListBtn">사용자관리</button>
			        </div>
			 	</div>
			 	</form>
			<!-- content area end -->
			
			 <!-- footer start -->
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		    <!-- footer end -->
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript" src="<c:url value="/js/underscore-1.5.2.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.scrollTableBody-1.0.0.js"/>"></script>
<script type="text/javascript">
$(function() {
	$('.searchSmsUserBtn').on('click', userListPopup);
	$('.smsUserListBtn').on('click', function(){
		location.href = "user_list.do";
	});
	$('.addBtn').on('click', insertSmsUser);
	$('.editBtn').on('click', modifySmsUser);
	$('.listBtn').on('click', function(){
		location.href = "sms_threshold_list.do";
	});
	
	$('#msg1').on('keyup', function(){
		$('#messageByteInfo').text( $(this).val().replace(/[\0-\x7f]|([0-\u07ff]|(.))/g,"$&$1$2").length);
	});
	
	$('#msg2').on('keyup', function(){
		$('#message2ByteInfo').text( $(this).val().replace(/[\0-\x7f]|([0-\u07ff]|(.))/g,"$&$1$2").length);
	});
	
	$('.deleteBtn').on('click', deleteSms);
	
	$('#smsUserListTable').scrollTableBody();
	 
	$('.gradeBtn').on('click', function(){
		location.href = "sms_threshold_grade_form.do?sms_threshold_seq_n=${sms.sms_threshold_seq_n}";
	});
	 
	 <c:if test="${!empty sms}">
		$('#messageByteInfo').text( $('#msg1').val().replace(/[\0-\x7f]|([0-\u07ff]|(.))/g,"$&$1$2").length);
	 	$('#message2ByteInfo').text($('#msg2').val().replace(/[\0-\x7f]|([0-\u07ff]|(.))/g,"$&$1$2").length);
	 </c:if>
});


function validate(){
	if($('#subject').val() == ''){
		alert('제목을 입력해주세요.');
		return false;
	}
	
	if($('#msg1').val() == ''){
		alert('메세지를 입력해주세요.');
		return false;
	}
	
	/*
	if($('#msg2').val() == ''){
		alert('경과 메세지를 입력해주세요.');
		return false;
	}
	*/
	if(!$('input:checkbox[name=user_seq_n]').is(':checked')){
		alert('수신자가 지정되지 않았습니다.');
		return false;
	}
	
	return true;
	
}

function insertSmsUser(){
	if(!validate()){
		return false;
	}
	
	if(confirm('등록하시겠습니까?')){
		$('#frm').attr("action", "sms_threshold_submit.do");
		frm.submit();
	}
}

function modifySmsUser(){
	if(!validate()){
		return false;
	}
	if(confirm('수정하시겠습니까?')){
		$('#frm').attr("action", "sms_threshold_modify.do");
		frm.submit();
	}
}

function deleteSms(){
	if(confirm('삭제하시겠습니까?')){
		$('#frm').attr("action", "sms_threshold_delete.do");
		frm.submit();
	}
}

function userListPopup(){
	sat_grp_win = window.open('user_list_popup.do', 'sat_grp_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
	sat_grp_win.focus();
}

</script>	
</body>
</html>