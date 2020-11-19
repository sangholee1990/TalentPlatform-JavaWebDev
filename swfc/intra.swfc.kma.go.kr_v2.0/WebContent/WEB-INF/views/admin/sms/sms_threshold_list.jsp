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
</head>
<body>
<div class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	
	<!--  -->
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">실황통보관리 </h4>
			<!-- content area start -->
				
				<div class="top-button-group">
					<input type="button" class="btn btn-primary btn-sm addBtn" title="등록" value="등록" />
				</div>
				           
		        <table class="table table-striped">
		        	<thead>
		            	<tr>
		                	<th>요소명</th>
		                	<th>테이블명</th>
		                	<th>컬럼명</th>
		                	<th>발송상태</th>
		                	<th>발송후지난분</th>
		                	<th>발송상태변경시간</th>
		                    <th width="120">등록일</th>
		                	<th>등급</th>
		                	<th>사용여부</th>
		                    <th>기능</th>
		                </tr>
		            </thead>
					<tbody>
						<c:forEach var="o" items="${list}" varStatus="status">
						<tr>
		                	<td><a href="sms_threshold_form.do?sms_threshold_seq_n=${o.sms_threshold_seq_n}"><spring:escapeBody>${o.threshold_nm}</spring:escapeBody></a></td>
		                	<td><spring:escapeBody>${o.table_nm}</spring:escapeBody></td>
		                	<td><spring:escapeBody>${o.column_nm}</spring:escapeBody></td>
		                	<td>${ o.send_yn }</td>
		                	<td>${ o.send_date_min }</td>
		                	<td><fmt:formatDate value="${o.up_dt}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
		                	<td><fmt:formatDate value="${o.rg_date}" pattern="yyyy.MM.dd"/></td>
		                	<td>
		                		<select name="grade_no" onchange="changeStatus(this, 'grade_no', '${ o.sms_threshold_seq_n }')">
					    			<option value="1" <c:if test="${o.grade_no eq '1'}">selected='selected'</c:if>>일반(1)</option>
					    			<option value="2" <c:if test="${o.grade_no eq '2'}">selected='selected'</c:if>>관심(2)</option>
					    			<option value="3" <c:if test="${o.grade_no eq '3'}">selected='selected'</c:if>>주의(3)</option>
					    			<option value="4" <c:if test="${o.grade_no eq '4'}">selected='selected'</c:if>>경계(4)</option>
					    			<option value="5" <c:if test="${o.grade_no eq '5'}">selected='selected'</c:if>>심각(5)</option>
					    		</select>
		                	</td>
		                	<td>
		                		<select name="use_yn" onchange="changeStatus(this, 'use_yn', '${ o.sms_threshold_seq_n }')">
					    			<option value="Y" <c:if test="${o.use_yn eq 'Y'}">selected='selected'</c:if>>사용</option>
					    			<option value="N" <c:if test="${o.use_yn eq 'N'}">selected='selected'</c:if>>미사용</option>
					    		</select>
		                	</td>
		                	<td><button type="button" class="btn btn-primary btn-xs gradeBtn" idx="${ o.sms_threshold_seq_n }">등급관리</button></td>
		                </tr>
						</c:forEach>
						<c:if test="${empty list}"> 
						<tr>
							<td colspan="9">등록된 컨텐츠가 존재하지 않습니다.</td>
						</tr> 
						</c:if>
					</tbody>
		        </table>
		        
		        <div class="top-button-group">
					<input type="button" class="btn btn-primary btn-sm addBtn" title="등록" value="등록" />
				</div>
    	
			<!-- content area end -->
			
			 <!-- footer start -->
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		    <!-- footer end -->
		</div>		
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript">
$(function() {
	$('.addBtn').on('click', function(){
		location.href = "sms_threshold_form.do";
	});
	$('.gradeBtn').on('click', function(){
		var sms_threshold_seq_n = $(this).attr("idx");
		location.href = "sms_threshold_grade_form.do?sms_threshold_seq_n=" + sms_threshold_seq_n;
	});
});

function changeStatus(obj, type ,seq){
	var param = 'userUpdate=N&sms_threshold_seq_n='+seq+'&&{type}=' + obj.value;
	param = param.replace('&{type}', type);
	if(confirm('상태를 변경하시겠습니까?')){
		$.ajax({  
			  type: 'POST',  
			  url: 'sms_threshold_status_update.do',  
			  data: param,  
			  dataType: 'json',  
			  success: function(e){
				  if(parseInt(e.result) > 0){
						//처리 완료					  
				  }
			  }  
			}); 
	}	
}
</script>	
</body>
</html>