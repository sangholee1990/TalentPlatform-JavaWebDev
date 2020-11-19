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
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">
			<c:if test="${gnss.id eq null }">GNSS지점 등록</c:if>
	    	<c:if test="${gnss.id != '' && gnss.id ne null}">GNSS지점 수정</c:if>
			</h4>
			<!-- content area start -->
	        <form name="frm" id="frm" class="form-horizontal" role="form" action="gnss_station_submit.do" method="post">
	        	<input type="hidden" name="id" id="id" value="${gnss.id}" />
			  	<div class="col-sm-6 col-md-6">
					<br/><br/>
				 	<div class="form-group form-group-sm">
				    	<label for="station_nm" class="col-sm-3 control-label">관측소명</label>
				    	<div class="col-sm-9">
				      		<input type="text" class="form-control" id="station_nm" name="station_nm" placeholder="관측소명" value="${gnss.station_nm}">
				    	</div>
				  	</div>
				 	<div class="form-group form-group-sm">
				    	<label for="station_id" class="col-sm-3 control-label">영문약어</label>
				    	<div class="col-sm-9">
				      		<input type="text" class="form-control" id="station_id" name="station_id" placeholder="영문약어" value="${gnss.station_id}" maxlength="10">
				    	</div>
				  	</div>
				 	<div class="form-group form-group-sm">
				    	<label for="organ_id" class="col-sm-3 control-label">기관</label>
				    	<div class="col-sm-9">
				    		<select class="form-control input-sm"  name="organ_id" id="organ_id" >
				    			<c:forEach var="o" items="${gnssOrganzationList}" varStatus="status">            
				            	<option value="${o.code}" <c:if test="${o.code eq gnss.organ_id}">selected="selected"</c:if>>${o.code} (${o.code_nm})</option>
		            			</c:forEach>
				            </select>
				    	</div>
				  	</div>
				 	<div class="form-group form-group-sm">
				    	<label for="station_lat" class="col-sm-3 control-label">위도</label>
				    	<div class="col-sm-9">
				      		<input type="text" class="form-control" id="station_lat" name="station_lat" placeholder="위도" value="${gnss.station_lat}" maxlength="12">
				    	</div>
				  	</div>
				 	<div class="form-group form-group-sm">
				    	<label for="station_lon" class="col-sm-3 control-label">경도</label>
				    	<div class="col-sm-9">
				      		<input type="text" class="form-control" id="station_lon" name="station_lon" placeholder="경도" value="${gnss.station_lon}" maxlength="12">
				    	</div>
				  	</div>
				 	<div class="form-group form-group-sm">
				    	<label for="station_hgt" class="col-sm-3 control-label">고도</label>
				    	<div class="col-sm-9">
				      		<input type="text" class="form-control" id="station_hgt" name="station_hgt" placeholder="고도" value="${gnss.station_hgt}" maxlength="12">
				    	</div>
				  	</div>
				 	<div class="form-group form-group-sm">
				    	<label for="qc_stn" class="col-sm-3 control-label">검증지점</label>
				    	<div class="col-sm-9">
				      		<input type="text" class="form-control" id="qc_stn" name="qc_stn" placeholder="검증지점" value="${gnss.qc_stn}">
				    	</div>
				  	</div>
				  	<div class="form-group form-group-sm">
					    <div class="col-sm-11 text-right">
					    	<button type="button" class="btn btn-default listBtn">목록</button>
					    	<c:if test="${gnss.id eq null }">
					    	<button type="button" class="btn btn-default addBtn">등록</button>
					    	</c:if>
					    	<c:if test="${gnss.id != '' && gnss.id ne null}">
					    	<button type="button" class="btn btn-default deleteBtn">삭제</button>
					    	<button type="button" class="btn btn-default editBtn">수정</button>
					    	</c:if>
					    </div>
				  	</div>
				 </div>
				 
				 <div class="col-sm-4 col-md-4">
			 		 <table class="table table-striped">
			        	<thead>
			            	<tr>
			                	<th>선택</th>
			                	<th>구분명</th>
			                </tr>
			            </thead>
						<tbody>
							<c:forEach var="o" items="${gnssTypeList}" varStatus="status">
							<tr>
			                	<td class="no"><input type="checkbox" name="code" value="${o.CODE}" <c:if test="${ o.GNSS_STN_SEQ_N != null }">checked='checked'</c:if> /></td>
			                	<td>${o.CODE_NM}</td>
			                </tr>
							</c:forEach>
							<c:if test="${empty gnssTypeList}"> 
							<tr>
								<td colspan="2">등록된 컨텐츠가 존재하지 않습니다.</td>
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
<script type="text/javascript">
$(function() {
	$('.addBtn').on('click', insertSmsUser);
	$('.editBtn').on('click', modifySmsUser);
	$('.listBtn').on('click', function(){
		location.href = "gnss_station_list.do";
	});
	
	$('.deleteBtn').on('click', deleteSmsUser);
});


function validate(){
	var station = $('#station_id').val();
	
	if(station.trim() == ''){
		alert('지점 아이디를 입력해주세요.');
		return false;
	}
	
	var stLength = (function(s,b,i,c){
		for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
		return b;
	})(station);
	
	if(stLength > 20){
		alert("지점 아이디는  최대 한글 6자, 영문 20자 까지 입력가능합니다.");
		return false;
	}
	
	var organ = $('#organ_id').val();
	
	if(organ.trim() == ''){
		alert('기관 아이디를 입력해주세요.');
		return false;
	}

	var orLength = (function(s,b,i,c){
		for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
		return b;
	})(organ);
	
	
	if(orLength > 20){
		alert("기관 아이디는  최대 한글 6자, 영문 20자 까지 입력가능합니다.");
		return false;
	}

	var lat = parseInt($("#station_lat").val());
	var lon = parseInt($("#station_lon").val());
	var hgt = parseInt($("#station_hgt").val());
	
	var numberic = new RegExp("^[0-9]*$");
	
	if(!numberic.test(lat)){
		alert("위도는 숫자만 입력가능합니다.");
		return false;
	}
	
	if(!numberic.test(lon)){
		alert("경도는 숫자만 입력가능합니다.");
		return false;
	}
	
	if(!numberic.test(hgt)){
		alert("높이는 숫자만 입력가능합니다.");
		return false;
	}
	
	var nm = $('#station_nm').val();
	
	var nmLength = (function(s,b,i,c){
		for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
		return b;
	})(nm);
	
	if(nmLength > 20){
		alert("지점명은 최대 한글 6자, 영문 20자 까지 입력가능합니다.");
		return false;
	}
	
	var qc = $('#qc_stn').val();
	
	var qcLength = (function(s,b,i,c){
		for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
		return b;
	})(qc);
	
	if(qcLength > 10){
		alert("지점명은 최대 한글 3자, 영문 10자 까지 입력가능합니다.");
		return false;
	}
	
	return true;
}

function insertSmsUser(){
	if(!validate()){
		return false;
	}
	if(confirm('등록하시겠습니까?')){
		$('#frm').attr("action", "gnss_station_submit.do");
		frm.submit();
	}
}

function modifySmsUser(){
	if(!validate()){
		return false;
	}
	if(confirm('수정하시겠습니까?')){
		$('#frm').attr("action", "gnss_station_modify.do");
		frm.submit();
	}
}

function deleteSmsUser(){
	if(confirm('삭제하시겠습니까?')){
		$('#frm').attr("action", "gnss_station_delete.do");
		frm.submit();
	}
}
</script>	
</body>
</html>