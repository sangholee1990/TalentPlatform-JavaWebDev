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
			<h4 class="page-header">실황통보관리</h4>
			<!-- content area start -->
				
				<h4>${sms.threshold_nm} <small>의 실황등급을 설정합니다.</small></h4>
				<form name="frm" id="frm" action="sms_threshold_grade_submit.do" method="post">
				<input type="hidden" name="sms_threshold_seq_n" value="${param.sms_threshold_seq_n}" />
		        <table class="table table-striped">
		        	<caption></caption>
		        	<thead>
		            	<tr>
		                	<th>등급</th>
		                	<th>비교값</th>
		                	<th>논리식</th>
		                	<th>값</th>
		                	<th>논리식</th>
		                    <th>비교값</th>
		                </tr>
		            </thead>
		            <tbody>
		            	<c:forEach var="o" items="${list}" varStatus="status">
		            		<tr>
			            		<td>
			            		<c:choose>
			            			<c:when test="${ o.grade_no == 1 }">일반(1)</c:when>
			            			<c:when test="${ o.grade_no == 2 }">관심(2)</c:when>
			            			<c:when test="${ o.grade_no == 3 }">주의(3)</c:when>
			            			<c:when test="${ o.grade_no == 4 }">경계(4)</c:when>
			            			<c:when test="${ o.grade_no == 5 }">심각(5)</c:when>
			            		</c:choose>
			            		<input type="hidden" name="grade_no" value="${o.grade_no}" /></td>
			            		<td><input type="text" name="pre_val" value="${ o.pre_val }"/></td>
			            		<td>
			            			<select name="pre_flag" >
			            				<option value="lt" <c:if test="${ o.pre_flag eq 'lt' }">selected='selected'</c:if> >&lt;</option>
			            				<option value="le" <c:if test="${ o.pre_flag eq 'le' }">selected='selected'</c:if>>&lt;=</option>
			            				<option value="gt" <c:if test="${ o.pre_flag eq 'gt' }">selected='selected'</c:if>>&gt;</option>
			            				<option value="ge" <c:if test="${ o.pre_flag eq 'ge' }">selected='selected'</c:if>>&gt;=</option>
			            				<option value="eq" <c:if test="${ o.pre_flag eq 'eq' }">selected='selected'</c:if>>=</option>
			            				<option value="ne" <c:if test="${ o.pre_flag eq 'ne' }">selected='selected'</c:if>>!=</option>
			            			</select>
			            		</td>
			            		<td>값</td>
			            		<td>
			            			<select name="next_flag" >
			            				<option value="lt" <c:if test="${ o.next_flag eq 'lt' }">selected='selected'</c:if> >&lt;</option>
			            				<option value="le" <c:if test="${ o.next_flag eq 'le' }">selected='selected'</c:if>>&lt;=</option>
			            				<option value="gt" <c:if test="${ o.next_flag eq 'gt' }">selected='selected'</c:if>>&gt;</option>
			            				<option value="ge" <c:if test="${ o.next_flag eq 'ge' }">selected='selected'</c:if>>&gt;=</option>
			            				<option value="eq" <c:if test="${ o.next_flag eq 'eq' }">selected='selected'</c:if>>=</option>
			            				<option value="ne" <c:if test="${ o.next_flag eq 'ne' }">selected='selected'</c:if>>!=</option>
			            			</select>
			            		</td>
			            		<td><input type="text" name="next_val" value="${ o.next_val }"/></td>
			            	</tr>
		            	</c:forEach>
		            	<c:if test="${empty list}"> 
		            	<c:forEach begin="1" end="5" varStatus="loop" var="j">
		            		 <c:set var="i" value="${5-j+1}" scope="page"></c:set>
			            	<tr>
			            		<td>
			            		<c:choose>
			            			<c:when test="${ i == 1 }">일반(1)</c:when>
			            			<c:when test="${ i == 2 }">관심(2)</c:when>
			            			<c:when test="${ i == 3 }">주의(3)</c:when>
			            			<c:when test="${ i == 4 }">경계(4)</c:when>
			            			<c:when test="${ i == 5 }">심각(5)</c:when>
			            		</c:choose>
			            		<input type="hidden" name="grade_no" value="${i}" /></td>
			            		<td><input type="text" name="pre_val" /></td>
			            		<td>
			            			<select name="pre_flag" >
			            				<option value="lt">&lt;</option>
			            				<option value="le">&lt;=</option>
			            				<option value="gt">&gt;</option>
			            				<option value="ge">&gt;=</option>
			            				<option value="eq">=</option>
			            				<option value="ne">!=</option>
			            			</select>
			            		</td>
			            		<td>값</td>
			            		<td>
			            			<select name="next_flag" >
			            				<option value="lt">&lt;</option>
			            				<option value="le">&lt;=</option>
			            				<option value="gt">&gt;</option>
			            				<option value="ge">&gt;=</option>
			            				<option value="eq">=</option>
			            				<option value="ne">!=</option>
			            			</select>
			            		</td>
			            		<td><input type="text" name="next_val" /></td>
			            	</tr>
						</c:forEach>
						</c:if>
		            </tbody>
		        </table>
				</form>           
		        
		        <div class="top-button-group">
					<input type="button" class="btn btn-primary btn-sm listBtn" title="실황통보관리목록" value="실황통보관리목록" />
					<c:choose>
						<c:when test="${ empty list}">
							<input type="button" class="btn btn-primary btn-sm addBtn" title="등록" value="등록" />
						</c:when>
						<c:otherwise>
							<input type="button" class="btn btn-primary btn-sm editBtn" title="수정" value="수정" />
						</c:otherwise>
					</c:choose>
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
		document.frm.submit();
	});
	$('.editBtn').on('click', function(){
		document.frm.submit();
	});
	$('.listBtn').on('click', function(){
		location.href="sms_threshold_list.do";
	});
});
</script>	
</body>
</html>