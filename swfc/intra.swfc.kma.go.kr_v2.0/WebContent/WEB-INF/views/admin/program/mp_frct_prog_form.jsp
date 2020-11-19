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
			<h4 class="page-header">예측모델프로그램매핑관리</h4>
			<!-- content area start -->
	        <form name="frm" id="frm" class="form-horizontal" role="form" action="frct_prog_submit.do" method="post">
	        	<input type="hidden" name="clt_dta_mstr_seq_n" value="${info.CLT_DTA_MSTR_SEQ_N}" >
	        	<c:if test="${info.CLT_DTA_MSTR_SEQ_N != '' && info.CLT_DTA_MSTR_SEQ_N ne null}">
	        	<div class="form-group form-group-sm">
			    	<label for="frct_prog_seq_n" class="col-sm-2 control-label">마스터 번호</label>
			    	<div class="col-sm-8">
			      		<input type="text" class="form-control" placeholder="마스터 번호" value="${info.CLT_DTA_MSTR_SEQ_N}" disabled="disabled">
			    	</div>
			  	</div>
			  	</c:if>
			 	<div class="form-group form-group-sm">
			    	<label for="prog_nm" class="col-sm-2 control-label">마스터명</label>
			    	<div class="col-sm-8">
			      		<input type="text" class="form-control" id="algo_nm" name="algo_nm" placeholder="프로그램명" value="${info.MSTR_NM}" disabled="disabled">
			    	</div>
			  	</div>
			  	<!-- 
			 	<div class="form-group form-group-sm">
			    	<label for="prog_nm" class="col-sm-2 control-label">프로그램명</label>
			    	<div class="col-sm-8">
			      		<input type="text" class="form-control" id="algo_nm" name="algo_nm" placeholder="프로그램명" value="${info.ALGO_NM}" disabled="disabled">
			    	</div>
			  	</div>
			 	<div class="form-group form-group-sm">
			    	<label for="prog_path" class="col-sm-2 control-label">프로그램 경로</label>
			    	<div class="col-sm-8">
			      		<input type="text" class="form-control" id="kep_dir" name="kep_dir" placeholder="자료경로" value="${info.KEP_DIR}" disabled="disabled">
			    	</div>
			  	</div>
			 	<div class="form-group form-group-sm">
			    	<label for="prog_file_nm" class="col-sm-2 control-label">프로그램 파일명</label>
			    	<div class="col-sm-8">
			      		<input type="text" class="form-control" id="file_nm" name="file_nm" placeholder="프로그램 파일명" value="${info.FILE_NM}" disabled="disabled">
			    	</div>
			  	</div>
			  	 -->
			  	<div class="form-group form-group-sm">
				    <div class="col-sm-10 text-right">
				    <!-- 
				    	<button type="button" class="btn btn-default listFrctProgBtn">예측모델프로그램목록</button>
				    	<button type="button" class="btn btn-default listCltDtaBtn">수집자료목록</button>
				     -->
				    	<button type="button" class="btn btn-default listBtn">목록</button>
				    	<button type="button" class="btn btn-primary editBtn">상세정보보기</button>
				    </div>
			  	</div>
			</form>		    
			<!-- content area end -->
			
			<br/>
			  	
			<div class="col-sm-10">          
			<table class="table table-striped table-bordered">
				<caption>수집자료 목록</caption>
	        	<thead>
	            	<tr>
	                	<th width="50"></th>
			            <th width="75">마스터 번호</th>
		                	<th>마스터명</th>
	                    <th width="170">등록일</th>
	                    <th width="90">자료타입</th>
	                    <!-- 
	                    <th width="70">기능</th>
	                     -->
	                </tr>
	            </thead>
				<tbody>
					<c:forEach var="o" items="${list}" varStatus="status">
					<tr>
	                	<td style="vertical-align: middle;"><input type="checkbox" name='clt_dta_seq_n' value="${o.CLT_DTA_MSTR_SEQ_N}" <c:if test="${ o.PROG_SEQ_N eq info.CLT_DTA_MSTR_SEQ_N  }">checked="checked"</c:if> > </td>
	                	<td style="vertical-align: middle;">${o.CLT_DTA_MSTR_SEQ_N}</td>
		                <td style="vertical-align: middle;">${o.MSTR_NM}</td>
	                	<td style="vertical-align: middle;"><custom:DateFormatConvert strDate="${o.RG_D}" strTime="${o.RG_TM}" /></td>
	                	<td style="vertical-align: middle;">
	                		<select name="dta_type" seq="${o.CLT_DTA_SEQ_N}">
	                			<option value="E" <c:if test="${ o.DTA_TYPE eq 'E' }">selected="selected"</c:if> >보조자료</option>
	                			<option value="M" <c:if test="${ o.DTA_TYPE eq 'M' }">selected="selected"</c:if> >주자료</option>
	                		</select>
	                	</td>
	                	<!-- 
	                	<td><button type="button" class="btn btn-primary btn-xs editCtlDtaBtn" seq="${o.CLT_DTA_SEQ_N}">수정</button></td>
	                	 -->
	                </tr>
					</c:forEach>
					<c:if test="${empty list}"> 
					<tr>
						<td colspan="6">등록된 컨텐츠가 존재하지 않습니다.</td>
					</tr> 
					</c:if>
				</tbody>
	        </table>
	       </div>
			
			
			 <!-- footer start -->
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		    <!-- footer end -->
		</div>		
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript">
var frct_prog_seq_n = '${info.CLT_DTA_MSTR_SEQ_N}';
$(function() {
	$('.listBtn').on('click', function(){
		location.href = "mp_ctl_data_list.do";
	});
	
	$('.listFrctProgBtn').on('click',function(){
		location.href = "frct_prog_list.do";
	});
	
	$('.listCltDtaBtn').on('click',function(){
		location.href = "mp_frct_prog_list.do";
	});
	
	$('.editBtn').on('click',function(){
		//location.href = "frct_prog_form.do?frct_prog_seq_n=" + frct_prog_seq_n;
		location.href = "<c:url value="/admin/master/datamaster_view.do?view_clt_dta_mstr_seq_n=${info.CLT_DTA_MSTR_SEQ_N}" />";
	});
	
	$('.editCtlDtaBtn').on('click',function(){
		location.href = "ctl_prog_form.do?clt_prog_seq_n=" + $(this).attr("seq");
	});
	
	$("input[type='checkbox']").on('click', function(){
		var idx =$("input[type='checkbox']").index($(this));
		var checked = $(this).is(":checked");
		if(confirm('상태를 변경하시겠습니까?')){
			var seq_n = $(this).val();
			var dtaType = $("select[seq='"+seq_n+"']").val();
			
			frctMappingStatusChage({
				frct_prog_seq_n : frct_prog_seq_n
				,clt_dta_seq_n : seq_n
				,dta_type : dtaType
				,flag : checked
			});
			/*
			$.post("mp_frct_data_status_change.do", {
				frct_prog_seq_n : frct_prog_seq_n
				,clt_dta_seq_n : seq_n
				,dta_type : dtaType
				,flag : checked
			} ,handlerStatusSuccess, "json")
			
			.fail(function(){
				alert('처리중 에러가 발생했습니다. \n잠시 후 다시 시도해주세요.');
			});
			*/
		}else{
			$("input[name='clt_dta_seq_n']")[idx].checked = !checked;
		}
	});
	
	
	$("select[name='dta_type']").on('change', dataTypeChangeHandler);
});


function dataTypeChangeHandler(event){
	var val = $(this).val();
	var seq = $(this).attr("seq");
	var checked = $("input[value='"+seq+"']").is(":checked");
	if(checked && confirm("자료타입을 변경하시겠습니까?")){
		frctMappingStatusChage({
			frct_prog_seq_n : frct_prog_seq_n
			,clt_dta_seq_n : seq
			,dta_type : val
			,flag : true
		});		
	}
}

function frctMappingStatusChage(params){
	$.post("mp_frct_data_status_change.do", params, handlerStatusSuccess, "json")
	.fail(function(){
		alert('처리중 에러가 발생했습니다. \n잠시 후 다시 시도해주세요.');
	});
}

function handlerStatusSuccess(data){
	alert(data.result + "건의 자료가 처리되었습니다.");
}
</script>	
</body>
</html>