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
			<h4 class="page-header">수집자료매핑관리</h4>
			<!-- content area start -->
	        <form name="frm" id="frm" class="form-horizontal" role="form" action="ctl_data_submit.do" method="post">
	        	<input type="hidden" name="clt_dta_mstr_seq_n" value="${info.CLT_DTA_MSTR_SEQ_N}" >
			 	<div class="form-group form-group-sm">
			    	<label for="clt_dta_seq_n" class="col-sm-2 control-label">마스터 번호</label>
			    	<div class="col-sm-8">
			      		<input type="text" class="form-control" placeholder="자료코드" value="${info.CLT_DTA_MSTR_SEQ_N}" disabled="disabled">
			    	</div>
			  	</div>
			 	<div class="form-group form-group-sm">
			    	<label for="mstr_nm" class="col-sm-2 control-label">마스터명</label>
			    	<div class="col-sm-8">
			      		<input type="text" class="form-control" id="mstr_nm" name="mstr_nm" placeholder="자료명" value="${info.MSTR_NM}" disabled="disabled">
			    	</div>
			  	</div>
			  	<div class="form-group form-group-sm">
				    <div class="col-sm-10 text-right">
				    <!-- 
				    	<button type="button" class="btn btn-default listCltProgBtn">수집프로그램목록</button>
				    	<button type="button" class="btn btn-default listCltDtaBtn">수집자료목록</button>
				     -->
				    	<button type="button" class="btn btn-default listBtn">목록</button>
				    	<button type="button" class="btn btn-primary editBtn">상세정보보기</button>
			  	<!-- 
				    	<c:if test="${info.CLT_DTA_SEQ_N eq null }">
				    	<button type="button" class="btn btn-default addBtn">등록</button>
				    	</c:if>
				    	<c:if test="${info.CLT_DTA_SEQ_N != '' && info.CLT_DTA_SEQ_N ne null}">
				    	<button type="button" class="btn btn-default deleteBtn">삭제</button>
				    	<button type="button" class="btn btn-default editBtn">수정</button>
				    	</c:if>
			  	 -->
				    </div>
			  	</div>
			</form>		    
		  	<br/>
		  	<div class="col-sm-10">
			  	<table class="table table-striped table-bordered" >
			  		<caption>수집프로그램 목록</caption>
		        	<thead>
		            	<tr>
		                	<th width="70"></th>
		                	<th width="150">마스터 번호</th>
		                	<th>마스터명</th>
		                    <th width="170">등록일</th>
		                    <!-- 
		                    <th width="80">기능</th>
		                     -->
		                </tr>
		            </thead>
					<tbody>
						<c:forEach var="o" items="${list}" varStatus="status">
						<tr>
		                	<td style="vertical-align: middle;"><input type="radio" name='clt_prog_seq_n' value="${o.CLT_DTA_MSTR_SEQ_N}" <c:if test="${ o.CLT_DTA_SEQ_N eq info.CLT_DTA_MSTR_SEQ_N  }">checked="checked"</c:if> > </td>
		                	<td style="vertical-align: middle;">${o.CLT_DTA_MSTR_SEQ_N}</td>
		                	<td style="vertical-align: middle;">${o.MSTR_NM}</td>
		                	<td><custom:DateFormatConvert strDate="${o.RG_D}" strTime="${o.RG_TM}" /></td>
		                	<!-- 
		                	<td><button type="button" class="btn btn-primary btn-xs editProgBtn" seq="${o.CLT_DTA_MSTR_SEQ_N}">수정</button></td>
		                	 -->
		                </tr>
						</c:forEach>
						<c:if test="${empty list}"> 
						<tr>
							<td colspan="4">등록된 컨텐츠가 존재하지 않습니다.</td>
						</tr> 
						</c:if>
					</tbody>
		        </table>
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
var clt_dta_seq_n = '${info.CLT_DTA_MSTR_SEQ_N}';
$(function() {
	$('.listBtn').on('click', function(){
		location.href = "mp_ctl_data_list.do";
	});
	
	$('.listCltProgBtn').on('click',function(){
		location.href = "ctl_prog_list.do";
	});
	
	$('.listCltDtaBtn').on('click',function(){
		location.href = "ctl_data_list.do";
	});
	
	$('.editBtn').on('click',function(){
		location.href = "<c:url value="/admin/master/datamaster_view.do?view_clt_dta_mstr_seq_n=${info.CLT_DTA_MSTR_SEQ_N}" />";
	});
	
	$('.editProgBtn').on('click',function(){
		location.href = "ctl_prog_form.do?clt_prog_seq_n=" + $(this).attr("seq");
	});
	
	$("input[type='radio']").on('click', function(){
		var seq_n = $(this).val();
		var idx =$("input[type='radio']").index($(this));
		var checked = $(this).is(":checked");
		
		if(confirm('상태를 변경하시겠습니까?')){
			$.post("mp_ctl_data_status_change.do", {
				clt_dta_seq_n : clt_dta_seq_n
				,clt_prog_seq_n : seq_n
				,flag : checked
			} ,handlerStatusSuccess, "json")
			.fail(function(){
				alert('처리중 에러가 발생했습니다. \n잠시 후 다시 시도해주세요.');
			});
		}else{
			$("input[name='clt_prog_seq_n']")[idx].checked = !checked;
		}
	});
	
});

function handlerStatusSuccess(data){
	alert(data.result + "건의 자료가 처리되었습니다.");
}


</script>	
</body>
</html>