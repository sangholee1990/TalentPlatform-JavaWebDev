<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.DataMasterDTO, org.springframework.util.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!doctype html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />
</head>
<body>
<div id="contents" class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">수집자료 마스터 정보</h4>
	
	
<ul id="myTab" class="nav nav-tabs">
  <li class="active"><a href="#datamaster" data-toggle="tab">마스터정보</a></li>
  <li class=""><a href="#satmeta" data-toggle="tab">기본정보</a></li>
  <li class=""><a href="#domain" data-toggle="tab">자료정보</a></li>
  <li class=""><a href="#wmometa" data-toggle="tab">WMO Meta</a></li>
</ul>
 
<div id="myTabContent" class="tab-content">

  <div class="tab-pane fade active in" id="datamaster">
  	<br />
  	<h4>수집자료 마스터 정보</h4>
			<table class="table table-condensed">
	            
	            <tr>
	                <th class="active text-center">마스터번호</th>
	                <td><spring:escapeBody>${dataMasterDTO.CLT_DTA_MSTR_SEQ_N}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">수집자료저장형식</th>
	                <td><spring:escapeBody><custom:ConvertDataSaveTypeCode code="${dataMasterDTO.CLT_DTA_SV_TP_CD}" /></spring:escapeBody></td>                  
	            </tr>
	            
	            <tr>
	                <th class="active text-center">수집자료 형식</th>
	                <td><spring:escapeBody><custom:ConvertDataTypeCode code="${dataMasterDTO.CLT_DTA_TP_CD}" /></spring:escapeBody></td>                  
	            </tr>
	            
	            <tr>
	                <th class="active text-center">마스터명</th>
	                <td><spring:escapeBody>${dataMasterDTO.MSTR_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">보관디렉토리</th>
	                <td><spring:escapeBody>${dataMasterDTO.KEP_DIR}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">프로그램경로</th>
	                <td><spring:escapeBody>${dataMasterDTO.PROG_PATH}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">프로그램파일명</th>
	                <td><spring:escapeBody>${dataMasterDTO.PROG_FILE_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">파일명</th>
	                <td><spring:escapeBody>${dataMasterDTO.FILE_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">알고리즘명</th>
	                <td><spring:escapeBody>${dataMasterDTO.ALGO_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">알고리즘서버아이피</th>
	                <td><spring:escapeBody>${dataMasterDTO.FRCT_MDL_SVR_IP}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">알고리즘버전</th>
	                <td><spring:escapeBody>${dataMasterDTO.ALGO_VER}</spring:escapeBody></td>                  
	            </tr>
	            
	            <tr>
	                <th class="active text-center">사용여부</th>
	                <td><spring:escapeBody><custom:UseYNConvert useYN="${dataMasterDTO.USE_F_CD}"/></spring:escapeBody></td>                  
	            </tr>
	            
	        </table>
	    	
	    	<div class="top-button-group">
				<input type="button" title="수정" value="수정" class="btn btn-primary btn-sm" />
		    	<input type="button" title="삭제" value="삭제" class="btn btn-primary btn-sm" />
		        <input type="button" title="목록" value="목록" class="btn btn-primary btn-sm" />
			</div>
				 
  </div>

  <div class="tab-pane fade" id="satmeta">
  
  			<br />
  			<h4>수집대상그룹</h4>
			<table class="table table-condensed">
	            <tr>
	                <th class="active text-center">수집대상그룹</th>
	                <td><spring:escapeBody>${dataMasterDTO.CLT_TAR_GRP_KOR_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">수집대상그룹 영문명</th>
	                <td><spring:escapeBody>${dataMasterDTO.CLT_TAR_GRP_ENG_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">수집대상그룹 설명</th>
	                <td><spring:escapeBody>${dataMasterDTO.CLT_TAR_GRP_DESC}</spring:escapeBody></td>                  
	            </tr>
	        </table>
	        
	        <br />
	        <h4>수집대상</h4>
	        <table class="table table-condensed"> 
	            <tr>
	                <th class="active text-center">수집대상</th>
	                <td><spring:escapeBody>${dataMasterDTO.CLT_TAR_KOR_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">수집대상 영문명</th>
	                <td><spring:escapeBody>${dataMasterDTO.CLT_TAR_ENG_NM}</spring:escapeBody></td>                  
	            </tr>
	            
	            <tr>
	                <th class="active text-center">수집대상 설명</th>
	                <td><spring:escapeBody>${dataMasterDTO.CLT_TAR_DESC}</spring:escapeBody></td>                  
	            </tr>
	        </table>
	        
	         <br />
	        <h4>범위 정보</h4>
	        <table class="table table-condensed">    
	            <tr>
	                <th class="active text-center">범위 정보</th>
	                <td><spring:escapeBody>${dataMasterDTO.COVERAGE_KOR_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">범위 정보 영문명</th>
	                <td><spring:escapeBody>${dataMasterDTO.COVERAGE_ENG_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">범위 정보 설명</th>
	                <td><spring:escapeBody>${dataMasterDTO.COVERAGE_DESC}</spring:escapeBody></td>                  
	            </tr>
	        </table>
	        
	        <div class="top-button-group">
				<input type="button" title="수정" value="수정" class="btn btn-primary btn-sm" />
		    	<input type="button" title="삭제" value="삭제" class="btn btn-primary btn-sm" />
		        <input type="button" title="목록" value="목록" class="btn btn-primary btn-sm" />
			</div>
 </div>
  
  <div class="tab-pane fade" id="domain">
			<br />
	        <h4>도메인</h4>
	        <table class="table table-condensed"> 	            
	            
	            <tr>
	                <th class="active text-center"  width="120">도메인</th>
	                <td><spring:escapeBody>${dataMasterDTO.DMN_KOR_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center"  width="120">도메인 영문명</th>
	                <td><spring:escapeBody>${dataMasterDTO.DMN_ENG_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center"  width="120">도메인 설명</th>
	                <td><spring:escapeBody>${dataMasterDTO.DMN_DESC}</spring:escapeBody></td>                  
	            </tr>
	        </table>
	         
	        <br />
	        <h4>도메인서브</h4>
	        <table class="table table-condensed">
	            <tr>
	                <th class="active text-center">도메인서브</th>
	                <td><spring:escapeBody>${dataMasterDTO.DMN_SUB_KOR_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">도메인서브 영문명</th>
	                <td><spring:escapeBody>${dataMasterDTO.DMN_SUB_ENG_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">도메인서브 설명</th>
	                <td><spring:escapeBody>${dataMasterDTO.DMN_SUB_DESC}</spring:escapeBody></td>                  
	            </tr>
	       </table>
	       
	        
	       <br />
	        <h4>도메인레이어</h4>
	        <table class="table table-condensed">     
	            <tr>
	                <th class="active text-center">도메인레이어</th>
	                <td><spring:escapeBody>${dataMasterDTO.DMN_LAYER_KOR_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">도메인레이어 영문명</th>
	                <td><spring:escapeBody>${dataMasterDTO.DMN_LAYER_ENG_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">도메인레이어 설명</th>
	                <td><spring:escapeBody>${dataMasterDTO.DMN_LAYER_DESC}</spring:escapeBody></td>                  
	            </tr>
	       </table>
	       
	          
	       <br />
	        <h4>자료종류</h4>
	        <table class="table table-condensed">
	           <tr>
	                <th class="active text-center">자료종류</th>
	                <td><spring:escapeBody>${dataMasterDTO.DTA_KND_KOR_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">자료종류 영문명</th>
	                <td><spring:escapeBody>${dataMasterDTO.DTA_KND_ENG_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">측정단위</th>
	                <td><spring:escapeBody>${dataMasterDTO.MEASURING_UNT}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">불확실성단위</th>
	                <td><spring:escapeBody>${dataMasterDTO.UNCERTAINTY_UNT}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">수평해상도단위</th>
	                <td><spring:escapeBody>${dataMasterDTO.HOR_RES_UNT}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">수직해상도단위</th>
	                <td><spring:escapeBody>${dataMasterDTO.VER_RES_UNT}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">안정성단위</th>
	                <td><spring:escapeBody>${dataMasterDTO.STABILITY_UNT}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">설명</th>
	                <td><div class="custom-overflow"><spring:escapeBody>${dataMasterDTO.DTA_KND_DESC}</spring:escapeBody></div></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">비고</th>
	                <td><div class="custom-overflow"><spring:escapeBody>${dataMasterDTO.RMK}</spring:escapeBody></div></td>                  
	            </tr>
	      </table>
	      
	      
	      <br />
	        <h4>자료종류내부</h4>
	        <table class="table table-condensed">      
	            <tr>
	                <th class="active text-center">자료종류내부</th>
	                <td><spring:escapeBody>${dataMasterDTO.DTA_KND_INSIDE_KOR_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">자료종류내부 영문명</th>
	                <td><spring:escapeBody>${dataMasterDTO.DTA_KND_INSIDE_ENG_NM}</spring:escapeBody></td>                  
	            </tr>
	            <tr>
	                <th class="active text-center">자료종류내부설명</th>
	                <td><spring:escapeBody>${dataMasterDTO.DTA_KND_INSIDE_DESC}</spring:escapeBody></td>                  
	            </tr>
	        </table>
	    	
	    	<div class="top-button-group">
				<input type="button" title="수정" value="수정" class="btn btn-primary btn-sm" />
		    	<input type="button" title="삭제" value="삭제" class="btn btn-primary btn-sm" />
		        <input type="button" title="목록" value="목록" class="btn btn-primary btn-sm" />
			</div>
				
 
  </div>
   
   <div class="tab-pane fade" id="wmometa">
    <br />
    <div id="wmocontents">
     <p>Please waite loading ... </p>
    </div>
    <br />
    <div class="top-button-group">
		<input type="button" title="수정" value="수정" class="btn btn-primary btn-sm" />
    	<input type="button" title="삭제" value="삭제" class="btn btn-primary btn-sm" />
        <input type="button" title="목록" value="목록" class="btn btn-primary btn-sm" />
        <input type="button" title="Xml download" value="Xml download" class="btn btn-primary btn-sm" />
	</div>
  </div>

</div>


</div>
</div>


<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript" src="<c:url value="/js/metadata/metadata.js"/>"></script>
<script type="text/javascript">

$(function() {

	//매핑정보 체크
	$('a[data-toggle="tab"]').on('click', function (e) {
		 var target = $(e.target).attr("href"); // activated tab
		  
		 // 기본정보
		 if (target == "#satmeta" && "${dataMasterDTO.CLT_TAR_SEQ_N}" == "" && "${dataMasterDTO.COVERAGE_SEQ_N}" == "") {
			 e.preventDefault();
			 alert("기본정보가 등록되지 않았습니다.");
			 return false;
		 }
		 
		//자료정보 
		 if (target == "#domain" && "${dataMasterDTO.DTA_KND_INSIDE_SEQ_N}" == "" ) {
			 e.preventDefault();
			 alert("자료정보가 등록되지 않았습니다.");
			 return false;
		 }
		
		// Wmo meta 
		 if (target == "#wmometa" && "${dataMasterDTO.METADATASEQN}" == "" ) {
			 e.preventDefault();
			 alert("WMO Meta정보가 등록되지 않았습니다.");
			 return false;
		 }
		 
	});

	// Wmo meta innerHtml load
	if ( "${dataMasterDTO.METADATASEQN}" !=  "") {
		$.ajax({
		      type: "GET",
		      url: "<c:url value='/admin/wmo/wmometa_view_innerHtml.do?view_metadataseqn=${dataMasterDTO.METADATASEQN}' />",
		      error: function(data){
		        alert("There was a problem");
		      },
		      success: function(data){
		        $("#wmocontents").html(data);
		      }
		});
	}

	$("#contents :button").click(function() {
		switch($(this).val()) {
		case "수정":
			$(paramForm).addHidden("mode", "update");
			$(paramForm).attr("action","datamaster_form.do");
			$(paramForm).submit();
			
			break;

		case "삭제":
			if(confirm("삭제 하시겠습니까?")) {
				$(paramForm).attr("action","datamaster_del.do");
				$(paramForm).submit();
			}
			break;
		case "목록":
			$(paramForm).attr("action","datamaster_list.do");
			$(paramForm).submit();
			break;
			
		case "Xml download":
			$(paramForm).addHidden("view_metadataseqn", "${dataMasterDTO.METADATASEQN}");
			$(paramForm).attr("action","<c:url value='/admin/wmo/wmometa_xmldownload.do' />");
			//$(paramForm).attr("target", "_blink");
			$(paramForm).submit();
			break;
		};
	});
});



</script>
</body>
</html>
