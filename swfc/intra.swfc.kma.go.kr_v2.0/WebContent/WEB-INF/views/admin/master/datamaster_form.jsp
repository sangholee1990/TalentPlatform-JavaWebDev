<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.DataMasterDTO,org.springframework.util.*"
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
			<h4 class="page-header">수집자료 마스터 정보</h4>
			<!-- content area start -->
	
			<form:form commandName="dataMasterDTO" action="datamaster_submit.do" method="post" class="form-horizontal" role="form">
				<input type="hidden" name="mode" value="${mode}"/>
				
				<input type="hidden" name="clt_dta_mstr_seq_n" id="clt_dta_mstr_seq_n" value="${dataMasterDTO.clt_dta_mstr_seq_n}"/>

				<input type="hidden" name="coverage_seq_n" id="coverage_seq_n" value="${dataMasterDTO.coverage_seq_n}"/>
				<input type="hidden" name="clt_tar_grp_seq_n" id="clt_tar_grp_seq_n" value="${dataMasterDTO.clt_tar_grp_seq_n}"/>
				<input type="hidden" name="clt_tar_seq_n" id="clt_tar_seq_n" value="${dataMasterDTO.clt_tar_seq_n}"/>
				<input type="hidden" name="dmn_seq_n" id="dmn_seq_n" value="${dataMasterDTO.dmn_seq_n}"/>
				<input type="hidden" name="dmn_layer_seq_n" id="dmn_layer_seq_n" value="${dataMasterDTO.dmn_layer_seq_n}"/>
				<input type="hidden" name="dta_knd_inside_seq_n" id="dta_knd_inside_seq_n" value="${dataMasterDTO.dta_knd_inside_seq_n}"/>
				<input type="hidden" name="dta_knd_seq_n" id="dta_knd_seq_n" value="${dataMasterDTO.dta_knd_seq_n}"/>
				<input type="hidden" name="dmn_sub_seq_n" id="dmn_sub_seq_n" value="${dataMasterDTO.dmn_sub_seq_n}"/>
				<input type="hidden" name="metadataseqn" id="metadataseqn" value="${dataMasterDTO.metadataseqn}"/>

				<input type="hidden" name="del_f_cd" id="del_f_cd" value="N"/>
				
				
				<form:errors path="*" cssClass="errorBlock" element="div"/>

			  	<div class="form-group form-group-sm">
			    	<label for="clt_tar_grp_kor_nm" class="col-sm-2 control-label">수집대상 그룹 정보</label>
			    	<div class="col-sm-5">
			      		<form:input path="clt_tar_grp_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="clt_tar_kor_nm" class="col-sm-2 control-label">수집대상 정보</label>
			    	<div class="col-sm-5 has-feedback">
			      		<form:input path="clt_tar_kor_nm" class="form-control" readonly="true"/>
			      		<span class="glyphicon glyphicon-remove form-control-feedback" id="cltTarClearIcon"></span>
			    	</div>
			    	<div class="col-sm-5">
			      		<button type="button" id="satSearch" class="btn btn-default btn-sm" >수집대상 정보</button>
			    	</div>
			  	</div>


			  	<div class="form-group form-group-sm">
			    	<label for="dmn_kor_nm" class="col-sm-2 control-label">도메인</label>
			    	<div class="col-sm-5">
			      		<form:input path="dmn_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="dmn_sub_kor_nm" class="col-sm-2 control-label">도메인 서브</label>
			    	<div class="col-sm-5">
			      		<form:input path="dmn_sub_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="dmn_layer_kor_nm" class="col-sm-2 control-label">도메인 레이어</label>
			    	<div class="col-sm-5">
			      		<form:input path="dmn_layer_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="dta_knd_kor_nm" class="col-sm-2 control-label">자료 종류</label>
			    	<div class="col-sm-5">
			      		<form:input path="dta_knd_kor_nm" class="form-control" readonly="true"/>
			    	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
			    	<label for="dta_knd_inside_kor_nm" class="col-sm-2 control-label">도메인 -<br /> 자료종류 내부 매핑</label>
			    	<div class="col-sm-5 has-feedback">
			      		<form:input path="dta_knd_inside_kor_nm" class="form-control" readonly="true"/>
			      		<span class="glyphicon glyphicon-remove form-control-feedback" id="dataKindInsideClearIcon"></span>
			    	</div>
			    	<div class="col-sm-5">
			      		<button type="button" id="domainDataMappingSearch" class="btn btn-default btn-sm" >도메인 레이어 자료 종류 내부 매칭 정보</button>
			    	</div>
			  	</div>
			  				  
			  	<div class="form-group form-group-sm">
			    	<label for="coverage_kor_nm" class="col-sm-2 control-label">범위 정보</label>
			    	<div class="col-sm-5 has-feedback">
			      		<form:input path="coverage_kor_nm" class="form-control" readonly="true"/>
			      		<span class="glyphicon glyphicon-remove form-control-feedback" id="coverageClearIcon"></span>
			    	</div>
			    	<div class="col-sm-5">
			      		<button type="button" id="coverageSearch" class="btn btn-default btn-sm" >범위 정보</button>
			    	</div>
			  	</div>
			  		
			  	<div class="form-group form-group-sm">
			    	<label for="metadataStandardName" class="col-sm-2 control-label">MetaData WMO<br />정보 검색</label>
			    	<div class="col-sm-5 has-feedback">
			      		<form:input path="metadataStandardName" class="form-control" readonly="true"/>
			      		<span class="glyphicon glyphicon-remove form-control-feedback" id="metadataClearIcon"></span>
			    	</div>
			    	<div class="col-sm-5">
			      		<button type="button" id="metadataSearch" class="btn btn-default btn-sm" >MetaData WMO</button>
			    	</div>
			  	</div>


				<div class="form-group form-group-sm">
			    	<label for="clt_dta_sv_tp_cds" class="col-sm-2 control-label">수집자료저장<br />형식코드</label>
			    	<div class="col-sm-5">
				      	<label class="checkbox-inline">
				      		<form:checkbox path="clt_dta_sv_tp_cds" value="01" />DB 
				      	</label>	
				      	<label class="checkbox-inline">
	                        <form:checkbox path="clt_dta_sv_tp_cds" value="02" />자료
	                    </label>
	                    <label class="checkbox-inline" id="clt_dta_sv_tp_cds_label">
	                        <form:checkbox path="clt_dta_sv_tp_cds" value="03" />기타
	                    </label>
			    	</div>
			  	</div>

				<div class="form-group form-group-sm">
			    	<label for="clt_dta_tp_cd" class="col-sm-2 control-label">수집자료형식코드</label>
			    	<div class="col-sm-5">
                    	<label class="radio-inline" id="clt_dta_tp_cd_label">
			      			<form:radiobutton path="clt_dta_tp_cd" value="01" />수집자료 ( txt, dat, png, jpeg, gif ...)<br/>
                        	<form:radiobutton path="clt_dta_tp_cd" value="02" />수집자료 프로그램<br/>
                        	<form:radiobutton path="clt_dta_tp_cd" value="03" />예측모델 프로그램<br/>
                        	<form:radiobutton path="clt_dta_tp_cd" value="04" />산출물<br/>
                        	<form:radiobutton path="clt_dta_tp_cd" value="05" />기타<br/>
			      		</label>
			      		<!-- 
			      		<label class="radio-inline">
                        </label>
                        <label class="radio-inline" id="clt_dta_tp_cd_label">
                        </label>
                        <label class="radio-inline" id="clt_dta_tp_cd_label">
                        </label>
                        <label class="radio-inline" id="clt_dta_tp_cd_label">
                        </label>
			      		 -->
			    	</div>
			  	</div>

				<div class="form-group form-group-sm">
			    	<label for="mstr_nm" class="col-sm-2 control-label">마스터명</label>
			    	<div class="col-sm-5">
			      		<form:input path="mstr_nm" class="form-control"/>
			    	</div>
			  	</div>

				<div class="form-group form-group-sm">
			    	<label for="kep_dir" class="col-sm-2 control-label">보관디렉토리</label>
			    	<div class="col-sm-5">
			      		<form:input path="kep_dir" class="form-control"/>
			    	</div>
			  	</div>
				<div class="form-group form-group-sm">
			    	<label for="prog_path" class="col-sm-2 control-label">프로그램경로</label>
			    	<div class="col-sm-5">
			      		<form:input path="prog_path" class="form-control"/>
			    	</div>
			  	</div>
				<div class="form-group form-group-sm">
			    	<label for="prog_file_nm" class="col-sm-2 control-label">프로그램파일명</label>
			    	<div class="col-sm-5">
			      		<form:input path="prog_file_nm" class="form-control"/>
			    	</div>
			  	</div>
			  	
				<div class="form-group form-group-sm">
			    	<label for="algo_nm" class="col-sm-2 control-label">알고리즘명</label>
			    	<div class="col-sm-5">
			      		<form:input path="algo_nm" class="form-control"/>
			    	</div>
			  	</div>
			  	
				<div class="form-group form-group-sm">
			    	<label for="frct_mdl_svr_ip" class="col-sm-2 control-label">알고리즘서버아이피</label>
			    	<div class="col-sm-5">
			      		<form:input path="frct_mdl_svr_ip" class="form-control"/>
			    	</div>
			  	</div>

				<div class="form-group form-group-sm">
			    	<label for="algo_ver" class="col-sm-2 control-label">알고리즘버전</label>
			    	<div class="col-sm-5">
			      		<form:input path="algo_ver" class="form-control"/>
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

//검색 popup 창
var sat_win;
var domaindatamapping_win;
var coverage_win;
var metadata_win;


$(function() {

	//검색 파라메터 추가
	$(paramForm).find('input[type=hidden]').each(function() {
		$("#dataMasterDTO").addHidden($(this).attr("id"), $(this).val());
	});

	//검색 popup창 닫기
	window.onbeforeunload = function(e) {
		if ( sat_win != null ) {
			sat_win.close();
		}

		if ( domaindatamapping_win != null ) {
			domaindatamapping_win.close();
		}
		
		if ( coverage_win != null ) {
			coverage_win.close();
		}
		
		if ( metadata_win != null ) {
			metadata_win.close();
		}
		
	};

	
	$("#contents :button").click(function() {
		
		switch($(this).attr("id")) {
		case "saveBtn":
			$("#dataMasterDTO").submit();
			break;
			
		case "cancelBtn":
			//수정
			<c:if test="${mode eq 'update' }">
				$(paramForm).attr("action", "datamaster_view.do");
			</c:if>

			//등록
			 <c:if test="${mode eq 'new' }">
				$(paramForm).attr("action", "datamaster_list.do");
			</c:if>

			$(paramForm).submit();
			
			break;
		
		case "satSearch":
			sat_win = window.open('<c:url value="/admin/meta/sat_list_popup.do"/>', 'sat_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
			sat_win.focus();
			break;
			
		case "domainDataMappingSearch":
			domaindatamapping_win = window.open('<c:url value="/admin/data/domaindatamapping_list_popup.do"/>','domaindatamapping_win','width=1000,height=670,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
			domaindatamapping_win.focus();
			break;
			
		case "coverageSearch":
			coverage_win = window.open('<c:url value="/admin/meta/coverage_list_popup.do"/>', 'coverage_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
			coverage_win.focus();
			break;
			
		case "metadataSearch":
			metadata_win = window.open('<c:url value="/admin/wmo/wmometa_list_popup.do"/>','metadata_win','width=1000,height=630,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no');
			metadata_win.focus();
			break;
		};
	});
	
	$("#dataMasterDTO").validate({
		debug: false,
		ignore:"",
		rules: {
			/*
			clt_tar_kor_nm: {
				required : true
			},
			metadataStandardName : {
				required : true
			},
			coverage_kor_nm: {
				required : true
			},
			dta_knd_inside_kor_nm : {
				required : true
			},
			*/
			mstr_nm: {
				required : true
			},
			clt_dta_sv_tp_cds: {
				required : true
			},
			clt_dta_tp_cd: {
				required : true
			},
			kep_dir: {
				fieldLength : 50
			},
			algo_nm: {
				fieldLength : 50
			},
			algo_ver: {
				fieldLength : 50
			}
		},
		messages: {
				/*
				clt_tar_kor_nm: {
					required : "수집대상정보를 선택 하십시요."
				},
				metadataStandardName : {
					required : "Meta Data 정보를 선택 하십시요."
				},
				coverage_kor_nm: {
					required : "범위정보를 선택 하십시요."
				},
				dta_knd_inside_kor_nm : {
					required : "도메인 데이터 자료종류 매핑정보를 선택 하십시요."
				},
				*/
				mstr_nm: {
					required : "마스터명을 입력해주세요."
				},
				clt_dta_sv_tp_cds: {
					required : "수집자료저장형식코드를 체크  하십시요."
				},
				clt_dta_tp_cd: {
					required : "수집자료 저장형식을 체크 하십시요."
				},
				kep_dir: {
					fieldLength : "보관디렉토리는 최대 50자 까지 입력 가능합니다."
				},
				algo_nm: {
					fieldLength : "알고리즘명은 최대 50자 까지 입력 가능합니다."
				},
				algo_ver: {
					fieldLength : "알고리즘버전은 최대 50자 까지 입력 가능합니다."
				}	
		},
		errorPlacement: function(error, element) {
			if ( element.attr("name") == 'clt_dta_sv_tp_cds' ) {
			    error.insertAfter( $("#clt_dta_sv_tp_cds_label") );
			}else if ( element.attr("name") == 'clt_dta_tp_cd' ) {
			    error.insertAfter( $("#clt_dta_tp_cd_label") );
			}else{
			    error.insertAfter(element);
			}
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


//수집대상 검색 제거
$("#cltTarClearIcon").click(function(){
	setSat(null, null, null);
});


//수집자료 설정
function setSat(seq, nm, groupNm){
	
	$("#clt_tar_seq_n").val(seq);
	$("#clt_tar_kor_nm").val(nm);
	$("#clt_tar_grp_kor_nm").val(groupNm);
}

//WMO Meta 검색 제거
$("#metadataClearIcon").click(function(){
	setMetaDataWMO(null , null);
});


//MO Meta 데이터 
function setMetaDataWMO(seq, nm){
	$("#metadataseqn").val(seq);
	$("#metadataStandardName").val(nm);
}

//범위정보 검색 제거
$("#coverageClearIcon").click(function(){
	setCoverage(null , null);
});

// 범위정보
function setCoverage(seq, nm){
	$("#coverage_seq_n").val(seq);
	$("#coverage_kor_nm").val(nm);
}

//자료종류 내부 검색 제거
$("#dataKindInsideClearIcon").click(function(){
	setDomainDataMapping(null, 
			null, 
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null);
});


// 도메인 데이터 자료종류 매핑
function setDomainDataMapping(dmn_seq_n, 
		dmn_layer_seq_n, 
		dmn_sub_seq_n,
		dta_knd_seq_n,
		dta_knd_inside_seq_n,
		dataKindInsideNm,
		dmnNm,
		dmnSubNm,
		dmnLayerNm,
		dataKindNm
		) {
	
	$("#dmn_seq_n").val(dmn_seq_n);
	$("#dmn_sub_seq_n").val(dmn_sub_seq_n);
	$("#dmn_layer_seq_n").val(dmn_layer_seq_n);
	$("#dta_knd_seq_n").val(dta_knd_seq_n);
	$("#dta_knd_inside_seq_n").val(dta_knd_inside_seq_n);

	
	$("#dmn_kor_nm").val(dmnNm);
	$("#dmn_sub_kor_nm").val(dmnSubNm);
	$("#dmn_layer_kor_nm").val(dmnLayerNm);
	$("#dta_knd_kor_nm").val(dataKindNm);
	$("#dta_knd_inside_kor_nm").val(dataKindInsideNm);
	
}

function setWmoMeta(seq, nm){
	$("#metadataseqn").val(seq);
	$("#metadataStandardName").val(nm);
}

</script>

</body>
</html>
