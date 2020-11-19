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
<link href="<c:url value='/css/zTreeStyle/zTreeStyle.css'/>" rel="stylesheet">
<style type="text/css">
	.form-group label {
	 	width: 120px;
	}
	.form-group input {
	 	width: 380px;
	}
	.form-group textarea {
	 	width: 380px;
	}
	.form-group select {
	 	width: 380px;
	}
	/*
	div .error{
		color: red;
	}*/
</style>
</head>
<body>
<div class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">공통 코드 관리</h4>
			<!-- content area start -->
			<div class="row col-sm-4 col-md-4">
	        	<div class="btn-group" style="margin-bottom: 5px;">
					<button type="button" class="btn btn-default btn-xs expanNodeAllOpenBtn">모두 펼침</button>
					<button type="button" class="btn btn-default btn-xs expanNodeAllCloseBtn">모두 접기</button>
					<button type="button" class="btn btn-primary btn-xs addNewCodeBtn">신규 코드 추가</button>
				</div>
				<div class="well col-sm-12 col-md-12" style="overflow:scroll; height: 600px; width: 100%;margin-right: 30px;">
					<ul id="treeList" class="ztree"></ul>
				</div>
			</div>
			<div class="col-sm-8 col-md-8" style="padding-top:30px;">
				<form name="frm" id="frm" class="form-horizontal" role="form" method="post">
					<input type="hidden" name="parent_code_seq_n" id="parent_code_seq_n" />
					<input type="hidden" name="code_seq_n" id="code_seq_n" />
					<div class="form-group form-group-sm" >
				    	<label for="code" class="col-sm-2 control-label">상위코드명</label>
				    	<div class="col-sm-5">
				      		<input type="text" class="form-control" id="pCodeName" disabled />
				    	</div>
				  	</div>
					<div class="form-group form-group-sm">
				    	<label for="code" class="col-sm-2 control-label">코드</label>
				    	<div class="col-sm-5">
				      		<input type="text" class="form-control" id="code" name="code" placeholder="코드">
				    	</div>
				  	</div>
					<div class="form-group form-group-sm">
				    	<label for="code_nm" class="col-sm-2 control-label">코드명</label>
				    	<div class="col-sm-5">
				      		<input type="text" class="form-control" id="code_nm" name="code_nm" placeholder="코드명" >
				    	</div>
				  	</div>
					<div class="form-group form-group-sm">
				    	<label for="code_ko_nm" class="col-sm-2 control-label">국문명</label>
				    	<div class="col-sm-5">
				      		<input type="text" class="form-control" id="code_ko_nm" name="code_ko_nm" placeholder="국문명">
				    	</div>
				  	</div>
					<div class="form-group form-group-sm">
				    	<label for="code_en_nm" class="col-sm-2 control-label">영문명</label>
				    	<div class="col-sm-5">
				      		<input type="text" class="form-control" id="code_en_nm" name="code_en_nm" placeholder="영문명">
				    	</div>
				  	</div>
					<div class="form-group form-group-sm">
				    	<label for="description" class="col-sm-2 control-label">설명</label>
				    	<div class="col-sm-5">
				    		<textarea rows="5" cols="20" class="form-control" id="description" name="description" placeholder="설명" style="height: 100px;"></textarea>
				    	</div>
				  	</div>
				  	<div class="form-group form-group-sm">
				    	<label for="use_yn" class="col-sm-2 control-label">사용여부</label>
				    	<div class="col-sm-5">
				    		<select name="use_yn" class="form-control" id="use_yn">
				    			<option value="Y">사용</option>
				    			<option value="N">미사용</option>
				    		</select>
				    	</div>
				  	</div>
					<div class="col-sm-10 col-md-10 text-right addBtnArea" style="display:none;">
				    	<button type="button" class="btn btn-default addBtn">등록</button>
				        <button type="button" class="btn btn-default resetBtn">취소</button>
				    </div>
					<div class="col-sm-10 col-md-10 text-right editBtnArea">
				        <button type="button" class="btn btn-default editBtn">수정</button>
				        <button type="button" class="btn btn-danger deleteBtn">삭제</button>
				    </div>
				    <div class="col-sm-12 col-md-12 text-left errorDiv" style="color: red;">
						<ol></ol>
				    </div>
				</form>
			</div>  
			<!-- footer start -->
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		    <!-- footer end -->
		</div>		
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript" src="<c:url value="/js/jquery.ztree.all-3.5.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.form.min.js"/>"></script>
<script type="text/javascript">
var zTreeObj = null;
var code_seq_n = null;
var setting = {
		async: {
			enable: true,
			dataType: "json",
			url: "code_list_ajax.do",
			dataFilter: ajaxDataFilter
			//autoParam: ["id", "name"]
		},
		data: {
			simpleData: {
				enable: true,
				idKey: 'CODE_SEQ_N',
				pIdKey: 'PARENT_CODE_SEQ_N',
				rootPId: 0
			},
			key: {
				name: "CODE_NM"
			}
		},
		view: {
			selectedMulti: false
		},
		callback: {
			//beforeClick: beforeClick,
			onClick: treeNodeClick,
			onDblClick: zTreeOnDblClick,
			onAsyncSuccess: zTreeOnAsyncSuccess
		}
	};

function ajaxDataFilter(treeId, parentNode, responseData) {
    if (responseData) {
    	if(responseData.list){
    		responseData = responseData.list;
    	}
    }
    if(responseData != null){
    	responseData.push( { CODE_SEQ_N:0, PARENT_CODE_SEQ_N:0, CODE_NM :"공통코드", CODE_EN_NM  :"", CODE_KO_NM :"", DESCRIPTION :"",CODE:"", USE_YN:"", open: true} ); 
    }
    return responseData;
};
/*
var zNodes =[
			{ id:0, pId:0, name:"공통코드", engNm:"", korNm:"", des:"",code:"", useYn:"", open: true},  
	        <c:forEach var="code" items="${list}" varStatus="status" >
	        { id:${code.CODE_SEQ_N}, pId:${code.PARENT_CODE_SEQ_N}, name:"${code.CODE_NM}", engNm:"${code.CODE_EN_NM}", korNm:"${code.CODE_KO_NM}", des:"${code.DESCRIPTION}",code:"${code.CODE}", useYn:"${code.USE_YN}", open: false}<c:if test="${!status.last}">,</c:if> 
	        </c:forEach>
             ]; 

*/
/*
$.validator.setDefaults({
	submitHandler: function() {
		$('#frm').ajaxSubmit({
			target: "#result"
		});
	}
});
*/

$(function() {
	zTreeObj = $.fn.zTree.init($("#treeList"), setting, null);
	
	$('.expanNodeAllOpenBtn').on('click', function(){
		expanNode(true);
	});
	
	$('.expanNodeAllCloseBtn').on('click', function(){
		expanNode(false);
	});
	
	$('.addNewCodeBtn').on('click', function(){
		addNewForm();
	});
	
	$('.editBtn').on('click', function(){
		$("#frm").attr("action", "code_update_ajax.do");
		$("#frm").submit();
	});
	
	$('.addBtn').on('click', function(){
		$("#frm").attr("action", "code_insert_ajax.do");
		$("#frm").submit();
	});
	
	$('.deleteBtn').on('click', function(){
		//$("#frm").attr("action", "delete_code.do");
		//$("#frm").submit();
		
		if(!confirm('선택한 코드를 삭제하시겠습니까?')){
			return false;
		}
		
		$.getJSON( "code_delete_ajax.do", {
			code_seq_n : $("#code_seq_n").val()
		}, function( data ) {
			//alert(data.result);
			$("#frm")[0].reset();
			zTreeObj.reAsyncChildNodes(null, "refresh");
		});
	});
	
	$('.resetBtn').on('click', function(){
		$("#frm")[0].reset();
	});
	
	var container = $('.errorDiv');
	$("#frm").validate({
		//errorLabelContainer: $("#frm div.error"),
		errorContainer: container,
		errorLabelContainer: $("ol", container),
		wrapper: 'li',
		rules: {
			code: {
				required: true,
				minlength: 1
			},
			code_nm: {
				required: true,
				minlength: 2
			},
			code_ko_nm: {
				required: true,
				minlength: 2
			},
			code_en_nm: {
				required: true,
				minlength: 2
			}
		},
		messages: {
			code: {
				required: "코드를 입력해주세요",
				minlength: "코드는 최소 1자리 이상 입력해주세요."
			},
			code_nm: {
				required: "코드명을 입력해주세요",
				minlength: "코드명은 최소 2자리 이상 입력해주세요"
			},
			code_ko_nm: {
				required: "국문명을 입력해주세요",
				minlength: "국문명은 최소 2자리 이상 입력해주세요"
			},
			code_en_nm: {
				required: "영문명을 입력해주세요",
				minlength: "영문명은 최소 2자리 이상 입력해주세요"
			}
		},
		/*
		errorPlacement: function(error, element) {
		    error.insertAfter(element);
		},*/
		submitHandler: function(form) {
			var msg = "등록하시겠습니까?";
			if($('#frm').attr('action').indexOf('_update_') != -1) msg = "수정하시겠습니까?";
			if(!confirm(msg)){
				return false;
			}
			
			code_seq_n = null;
			
			$('#frm').ajaxSubmit({
				//target: "#result"
				//beforeSubmit:  showRequest,  // pre-submit callback 
        		success:       showResponse  // post-submit callback 
        		,dataType:  'json'
        		,clearForm: false
        		,resetForm: false
			});
			return false; 
		}
	});
});

function showResponse(responseText, statusText, xhr, $form){
	//zTreeObj.refresh();
	zTreeObj.reAsyncChildNodes(null, "refresh");
	//alert('status: ' + statusText + '\n\nresponseText: \n' + responseText + '\n\nThe output div should have already been updated with the responseText.'); 
	/*
	if(responseText.code_seq_n){
		//zTreeObj.
		var node = zTreeObj.getNodeByTId("treeList_" + responseText.code_seq_n);
		alert("treeList_" + responseText.code_seq_n);
		if(node != null){
			zTreeObj.selectNode(node);
		}
	}
	*/
	
	//alert(responseText.code_seq_n);
	if(responseText.code_seq_n){
		//var node = zTreeObj.getNodeByParam("CODE_SEQ_N", responseText.code_seq_n, null);
		//zTreeObj.selectNode(node);
		code_seq_n = responseText.code_seq_n;
	}
	
}

function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
	if(code_seq_n != null){
		var node = zTreeObj.getNodeByParam("CODE_SEQ_N", code_seq_n, null);
		if(node != null){
				
			zTreeObj.selectNode(node); //노드를 선택시킨다.
		
			setFormValue(node); //노느값을 폼값에 셋팅한다.
		}
	}
	//code_seq_n = null;
};

function treeNodeClick(event, treeId, treeNode, clickFlag) {
	setFormValue(treeNode);
}	
/**
 * 전달 받은 노드값으로 폼값을 매핑한다.
 */
function setFormValue(treeNode){
	if(treeNode){
		$('#code_nm').val(treeNode.CODE_NM);
		$('#code').val(treeNode.CODE);
		$('#code_ko_nm').val(treeNode.CODE_KO_NM);
		$('#code_en_nm').val(treeNode.CODE_EN_NM);
		$('#description').val(treeNode.DESCRIPTION);
		$('#use_yn').val(treeNode.USE_YN);
		$("#parent_code_seq_n").val(treeNode.PARENT_CODE_SEQ_N);
		$("#code_seq_n").val(treeNode.CODE_SEQ_N);
		
		var pNode = treeNode.getParentNode();
		if(pNode != null){
			$("#pCodeName").val(pNode.CODE_NM);
		}
		
		var childrens = treeNode.children;
		if(childrens != undefined && childrens.length > 0){
			$('.deleteBtn').hide();
		}else{
			$('.deleteBtn').show();
			
		}
		
		$('.addBtnArea').hide();
		$('.editBtnArea').show();
	}
}
/**
 * node 더블 클릭
 */
function zTreeOnDblClick(event, treeId, treeNode) {
    alert(treeNode ? treeNode.tId + ", " + treeNode.name : "isRoot");
};

/**
 * 노드를 펼친다.
 * @param flag : tree를 모두 펼칠지 접을지의 여부 
 */
function expanNode(flag){
	zTreeObj.expandAll(flag);
}

/**
 * 신규 코드를 등록하기 위한 폼을 생성한다.
 */
function addNewForm(){
	var nodes = zTreeObj.getSelectedNodes();
	var selectNode = null;
	if(nodes.length > 0){
		selectNode = nodes[0];
	}else{
		alert('신규 코드를 추가할 레벨을 선택해주세요.');
		return false;
	}
	if(selectNode != null){
		 
		var pNode = selectNode.getParentNode();
		if(pNode != null){
			$("#pCodeName").val(pNode.CODE_NM);
		}
		
		$('#code_nm').val('');
		$('#code').val('');
		$('#code_ko_nm').val('');
		$('#code_en_nm').val('');
		$('#description').val('');
		$('#use_yn').val("Y");
		$("#parent_code_seq_n").val(selectNode.CODE_SEQ_N);
	}
	
	$('.addBtnArea').show();
	$('.editBtnArea').hide();
}
</script>	
</body>
</html>