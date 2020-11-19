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
			<h4 class="page-header">SMS 관리</h4>
			<!-- content area start -->
		        <form name="frm" id="frm" class="form-horizontal" role="form" action="<c:url value="/admin/sms/sms_submit.do"/>" method="post">
			 	<div class="col-sm-6 col-md-6">
		        	<input type="hidden" name="sms_seq_n" id="sms_seq_n" value="${sms.sms_seq_n}" />
				 	<div class="form-group form-group-sm">
				    	<label for="title" class="col-sm-2 control-label">제목</label>
				    	<div class="col-sm-9">
				      		<input type="text" class="form-control" id="subject" name="subject" placeholder="제목" value="${sms.subject}">
				    	</div>
				  	</div>
				 	<div class="form-group form-group-sm">
				    	<label for="message" class="col-sm-2 control-label">내용</label>
				    	<div class="col-sm-9 text-right">
				    		<textarea class="form-control" rows="3" id="message" name="message" placeholder="메세지를 입력해주세요." style="height: 100px;">${sms.message}</textarea>
				    		<br/>
				    		<span id="messageByteInfo">0</span>/80 byte
				    	</div>
				  	</div>
				  	<div class="form-group form-group-sm">
				  		<label for="message" class="col-sm-2 control-label"></label>
					    <div class="col-sm-9 text-right">
					    	<button type="button" class="btn btn-default listBtn">목록</button>
					    	<c:if test="${sms.sms_seq_n eq null }">
					    	<button type="button" class="btn btn-default addBtn">등록</button>
					    	</c:if>
					    	<c:if test="${sms.sms_seq_n != '' && sms.sms_seq_n ne null}">
					    	<button type="button" class="btn btn-default editBtn">수정</button>
					    	<button type="button" class="btn btn-default deleteBtn">삭제</button>
					    	<button type="button" class="btn btn-primary sendSMSBtn">SMS발송</button>
					    	<!-- 
					    	<button type="button" class="btn btn-default smsUserListBtn">사용자관리</button>
					    	 -->
					    	</c:if>
					    </div>
				  	</div>
			 	</div>
			 	<div class="col-sm-4 col-md-4">
			 		 <table id="smsUserListTable" class="table table-striped">
			        	<thead>
			            	<tr>
			                	<th>선택</th>
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
		location.href = "sms_list.do";
	});
	
	$('#message').on('keyup', function(){
		$('#messageByteInfo').text( $(this).val().replace(/[\0-\x7f]|([0-\u07ff]|(.))/g,"$&$1$2").length);
	});
	
	$('.deleteBtn').on('click', deleteSms);
	$('.sendSMSBtn').on('click', sendSMS);
	
	 $('#smsUserListTable').scrollTableBody();
});


function validate(){
	if($('#subject').val() == ''){
		alert('제목을 입력해주세요.');
		$('#subject').focus();
		return false;
	}
	if($('#message').val() == ''){
		alert('메세지를 입력해주세요.');
		$('#message').focus();
		return false;
	}
	
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
		$('#frm').attr("action", "sms_submit.do");
		frm.submit();
	}
}

function modifySmsUser(){
	if(!validate()){
		return false;
	}
	if(confirm('수정하시겠습니까?')){
		$('#frm').attr("action", "sms_modify.do");
		frm.submit();
	}
}

function deleteSms(){
	if(confirm('삭제하시겠습니까?')){
		$('#frm').attr("action", "sms_delete.do");
		frm.submit();
	}
}

function userListPopup(){
	sat_grp_win = window.open('user_list_popup.do', 'sat_grp_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
	sat_grp_win.focus();
}

function sendSMS(){
	if(confirm("SMS 발송하시겠습니까?")){
		$.getJSON( "sms_send_ajax.do", {
			sms_seq_n : "${sms.sms_seq_n}"
		}, function( data ) {
		});
	}
}

</script>	
</body>
</html>