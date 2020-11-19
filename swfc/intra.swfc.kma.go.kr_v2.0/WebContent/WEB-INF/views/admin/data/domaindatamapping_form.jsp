<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.DomainDataMappingDTO,org.springframework.util.*"
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
			<h4 class="page-header">도메인 레이어 자료종류 매핑 정보</h4>
			<!-- content area start -->
	
			<form:form commandName="domainDataMappingDTO" action="domaindatamapping_submit.do" method="post" class="form-horizontal" role="form">
				<input type="hidden" name="mode" value="${mode}"/>
				<input type="hidden" name="view_dta_knd_inside_seq_n" id="view_dta_knd_inside_seq_n" value="${param.view_dta_knd_inside_seq_n}"/>
				<input type="hidden" name="view_dmn_layer_seq_n" id="view_dmn_layer_seq_n" value="${param.view_dmn_layer_seq_n}"/>

				<input type="hidden" name="dta_knd_inside_seq_n" id="dta_knd_inside_seq_n" value="${domainDataMappingDTO.dta_knd_inside_seq_n}"/>
				<input type="hidden" name="dmn_layer_seq_n" id="dmn_layer_seq_n" value="${domainDataMappingDTO.dmn_layer_seq_n}"/>
				
				<input type="hidden" name="multi_dmn_layer_seq_n" id="multi_dmn_layer_seq_n" value=""/>
				<form:errors path="*" cssClass="errorBlock" element="div"/>
			 

				<div class="form-group form-group-sm">
			    	<label for="dmn_kor_nm" class="col-sm-2 control-label">도메인</label>
			    	<div class="col-sm-5">
			      		<form:input path="dmn_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			  	</div>

			  	<div class="form-group form-group-sm">
			    	<label for="dmn_sub_kor_nm" class="col-sm-2 control-label">도메인 서브 정보</label>
			    	<div class="col-sm-5">
			      		<form:input path="dmn_sub_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			  	</div>
			  	
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="dta_knd_kor_nm" class="col-sm-2 control-label">자료종류 정보</label>
			    	<div class="col-sm-5">
			      		<form:input path="dta_knd_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			  	</div>
			  
			  	<div class="form-group form-group-sm">
			    	<label for="dta_knd_inside_kor_nm" class="col-sm-2 control-label">자료종류 내부 정보</label>
			    	<div class="col-sm-5">
			      		<form:input path="dta_knd_inside_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			    	<div class="col-sm-5">
			      		<button type="button" id="dataKindInsideSearch" title="자료종류 내부 정보" value="자료종류 내부 정보" class="btn btn-default btn-sm" >자료종류 내부 정보</button>
			    	</div>
			  	</div>
			  		
			  	<div class="form-group form-group-sm">
			    	<label for="dmn_layer_kor_nm" class="col-sm-2 control-label">도메인 레이어정보</label>
			    	<div id="domainLayerDiv" class="col-sm-5">
			      		<form:input path="dmn_layer_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			    	<div class="col-sm-5">
			      		<button type="button" id="domainLayerSearch" title="도메인 레이어정보" value="도메인 레이어정보" class="btn btn-default btn-sm" >도메인 레이어정보</button>
			      		<c:if test="${mode eq 'new' }">
			      		<button type="button" id="domainLayerDelete" title="도메인 레이어정보 삭제" value="도메인 레이어정보 삭제" class="btn btn-default btn-sm" >도메인 레이어정보 삭제</button>
			      		</c:if>
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
				        
				        <button type="button" id="cancelBtn" class="btn btn-default" >취소</button>
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

//검색창 popup
var datakindinside_win;
var domainlayer_win;

$(function() {

	window.onbeforeunload = function(e) {
		if ( datakindinside_win != null ) {
			datakindinside_win.close();
		}
		
		if ( domainlayer_win != null ) {
			domainlayer_win.close();
		}
	};

	//검색 파라메터 추가
	$(paramForm).find('input[type=hidden]').each(function() {
		$("#domainDataMappingDTO").addHidden($(this).attr("id"), $(this).val());
	});
	
	$("#contents :button").click(function() {
		
		switch($(this).attr("id")) {
		case "saveBtn":
			$("#domainDataMappingDTO").submit();
			break;
			
		case "cancelBtn":
			
			$(paramForm).attr("action", "domaindatamapping_list.do");
			$(paramForm).submit();
			
			break;
		
		case "dataKindInsideSearch":
			datakindinside_win = window.open('datakindinside_list_popup.do', 'datakindinside_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
			datakindinside_win.focus();
			break;
			
		case "domainLayerSearch":
			
			if ( $("#dta_knd_inside_kor_nm").val() == "" ){
				alert("자료종류 내부 정보를 먼저 선택해 주세요.");
			}else{
				domainlayer_win= window.open('domainlayer_list_popup.do?mode=${mode}','domainlayer_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
				domainlayer_win.focus();
			}
			break;
		};
	});
	
	$("#domainDataMappingDTO").validate({
		debug: false,
		ignore:"",
		rules: {
			dta_knd_inside_kor_nm: {
				required : true
			},
			dmn_layer_kor_nm : {
				required : true
			}
		},
		messages: {
			dta_knd_inside_kor_nm : {
					required : "자료종류 내부정보를 선택 하십시요."
				},
				dmn_layer_kor_nm : {
					required : "도메인 레이어정보를 선택 하십시요."
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
	
	
	$("#domainLayerDelete").click(function (){
		domainLayerReset();
	});
});

//도메인 레이어 선택 초기화
function domainLayerReset(){
	
	$("#dmn_layer_seq_n").val("");
	
	$("#domainDataMappingDTO").find("input[id='multi_dmn_layer_seq_n']").each(function(){
		$(this).remove();
	});
	$('#domainLayerDiv').children().remove();
	
	var inputNm = $("<input>")
		.attr("type", "text")
		.attr("name", "dmn_layer_kor_nm")
		.attr("id", "dmn_layer_kor_nm")
		.attr("readonly", "true")
		.addClass( "form-control" );

	$("#domainLayerDiv").append($(inputNm));

	var inputSeq = $("<input>").attr("type", "hidden").attr("name", "multi_dmn_layer_seq_n").attr("id", "multi_dmn_layer_seq_n");
	$("#domainDataMappingDTO").append(inputSeq);
}

//밴드 설정
function setDataKindInside(seq, nm, dmnNm, dmnSubNm, dtaKindNm ){
	
	$("#dta_knd_inside_seq_n").val(seq);
	$("#dta_knd_inside_kor_nm").val(nm);
	$("#dta_knd_kor_nm").val(dtaKindNm);

	$("#dmn_kor_nm").val(dmnNm);
	$("#dmn_sub_kor_nm").val(dmnSubNm);

	//도메인 레이어 선택 초기화
	domainLayerReset();
}

// 센서 설정
function setDomainLayer(seq, nm){
	var mode = "${mode}";
	var dupCheck = false;

	//매핑정보 중복 체크
	var jsonString = {
			"dta_knd_inside_seq_n": $("#dta_knd_inside_seq_n").val(),
			"dmn_layer_seq_n": seq
	};
	
	if ( mode == "update" ){
		$("#dmn_layer_seq_n").val(seq);
		$("#dmn_layer_kor_nm").val(nm);
		
		var url = "<c:url value='/admin/data/domaindatamapping_mapping_check_ajax.do'/>";
		$.ajax({ 
	        url: url, 
	        type:"POST", 
	        contentType: "application/json; charset=utf-8",
	        data: JSON.stringify( jsonString ), //Stringified Json Object
	        async: false,    //Cross-domain requests and dataType: "jsonp" requests do not support synchronous operation
	        cache: false,    //This will force requested pages not to be cached by the browser          
	        processData:false, //To avoid making query String instead of JSON
	        success: function(resposeJsonObject){
	        	//alert(resposeJsonObject.dmn_seq_n);
	        	if ( resposeJsonObject.dmn_seq_n != undefined  ){
	        		if ( domainlayer_win != null)
	        			domainlayer_win.duplicateMessage();
	        	}else{
	        		$("#dmn_layer_seq_n").val(seq);
	        		$("#dmn_layer_kor_nm").val(nm);
	        		domainlayer_win.close();
	        	}
			}
	    });
		
	}else{
		var layerObj = $.find("input[name='dmn_layer_kor_nm']");
		var layerLen = $(layerObj).length; 

		//중복 선택 체크
		$("#domainDataMappingDTO").find("input[id='multi_dmn_layer_seq_n']").each(function(){
			if ( $(this).val() == seq ){
				dupCheck = true;
				return;
			}
		});
		
		if ( dupCheck == true)
			return "exist";

		var url = "<c:url value='/admin/data/domaindatamapping_mapping_check_ajax.do'/>";
		$.ajax({ 
	        url: url, 
	        type:"POST", 
	        contentType: "application/json; charset=utf-8",
	        data: JSON.stringify( jsonString ), //Stringified Json Object
	        async: false,    //Cross-domain requests and dataType: "jsonp" requests do not support synchronous operation
	        cache: false,    //This will force requested pages not to be cached by the browser          
	        processData:false, //To avoid making query String instead of JSON
	        success: function(resposeJsonObject){
	        	//alert(resposeJsonObject.dmn_seq_n);
	        	if ( resposeJsonObject.dmn_seq_n != undefined  ){
	        		if ( domainlayer_win != null)
	        			domainlayer_win.duplicateMessage();	
	        	}else{
	        		//선택 레이어 추가
		    		if ( ( layerLen == 1 && $("#dmn_layer_kor_nm").val() == '' ) ){
		    			$("#multi_dmn_layer_seq_n").val(seq);
		    			$("#dmn_layer_kor_nm").val(nm);
		    		}else{
		    			
		    			var inputSeq = $("<input>").attr("type", "hidden").attr("name", "multi_dmn_layer_seq_n").attr("id", "multi_dmn_layer_seq_n").val(seq);
		    			$("#domainDataMappingDTO").append($(inputSeq));
		    		      
		    			//class="form-control" readonly="true"
		    			var inputNm = $("<input>")
		    				.attr("type", "text")
		    				.attr("name", "dmn_layer_kor_nm")
		    				.attr("id", "dmn_layer_kor_nm")
		    				.attr("readonly", "true")
		    				.addClass( "form-control" )
		    				.val(nm);
		    			$(layerObj[layerLen-1]).after($(inputNm)).after("<br/>");
		    		}
	        	}
			}
	    });
	}
}

</script>

</body>
</html>
