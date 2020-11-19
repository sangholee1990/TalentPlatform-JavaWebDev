<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.BoardsDTO,org.springframework.util.*"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!doctype html>
<html lang="ko">
<head>
  <link rel="stylesheet" type="text/css" href="<c:url value="/resources/CLEditor1_4_5/jquery.cleditor.css"/>" />
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />
</head>
<body>
<div id="contents" class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	
	<!--  -->
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">
			<c:choose>
				<c:when test="${archives.board_seq == null}">자료실 등록</c:when>
				<c:otherwise>자료실 수정</c:otherwise>
			</c:choose>
			</h4>
			<!-- content area start -->
			
			<form:form commandName="archives" role="form" action="archives_submit.do" method="post" class="form-horizontal" enctype="multipart/form-data">
				<input type="hidden" name="board_seq" value="${archives.board_seq}"/>
				<input type="hidden" name="mode" value="${mode}"/>
				<form:errors path="*" cssClass="errorBlock" element="div"/>
				<div class="form-group form-group-sm">
			    	<label for="site_code_cd" class="col-sm-2 control-label">사이트 구분</label>
			    	<div class="col-sm-3">
			      	  <form:select path="site_code_cd" class="form-control">
			    		<c:forEach var="o" items="${subList}" varStatus="status">            
			            	<option value="${o.code}" <c:if test="${archives.site_code_cd == o.code }">selected="selected"</c:if>>${o.code_ko_nm}</option>
	            		</c:forEach>
			           </form:select>
			    	</div>
			  	</div>
			  	
				<div class="form-group form-group-sm">
			    	<label for="board_section_cd" class="col-sm-2 control-label">자료실 구분</label>
			    	<div class="col-sm-3">
			      	  <form:select path="board_section_cd" class="form-control">
			    		<c:forEach var="o" items="${boardSubCodeList}" varStatus="status">            
			            	<option value="${o.code}" <c:if test="${archives.board_section_cd == o.code }">selected="selected"</c:if>>${o.code_ko_nm}</option>
	            		</c:forEach>
			           </form:select>
			    	</div>
			  	</div>
	  	
			   <div class="form-group form-group-sm">
			    	<label for="use_yn" class="col-sm-2 control-label">표출여부</label>
			    	<div class="col-sm-3">
			      		<form:select path="use_yn" class="form-control">
	                		<form:option value="Y" label="표출"/>
	                		<form:option value="N" label="미표출"/>
			           </form:select>
			    	</div>
			  	</div>
			  
				<div class="form-group form-group-sm">
			    	<label for="title" class="col-sm-2 control-label">제목</label>
			    	<div class="col-sm-8">
			      		<form:input path="title" class="form-control" maxlength="4000"/>
			    	</div>
			  	</div>
			  					    		  	
				<div class="form-group">
			    	<label for="content" class="col-sm-2 control-label">내용</label>
			    	<div class="col-sm-8">
			    	<c:choose>
                		<c:when test="${5000 le archives.board_seq}">
					    	<textarea id="content" name="content" rows="5" class="form-control">${archives.content}</textarea>
                		</c:when>
                		<c:otherwise>
                			<form:textarea path="content" cssClass="form-control" cssStyle="width:620px; height: 300px;"/>
                		</c:otherwise>
                	</c:choose>
			      	</div>
			  	</div>
			  	
			  	<div class="form-group form-group-sm">
              		<label for="fileData" class="col-sm-2 control-label">첨부파일</label>
		    		<div class="col-sm-5">
		    			<ul style='list-style:none;' id="fileupload" class="fileupload">
		    				<li>
		    				<input type="file" name="fileData" id="fileData" class="form-control"/>
		    				</li>
		    			</ul>
		    		</div>
		  		</div>
		  		
		  		<c:choose>
					<c:when test="${archives.board_seq == null}">
						<div class="form-group form-group-sm">
	              		<label for="fileData" class="col-sm-2 control-label"></label>
			    		<div class="col-sm-5">
			    			<ul style='list-style:none' id="filecontent" class="fileupload">
			    				<li><span class="filenone"></span></li>
			    			</ul>
			    		</div>
		  			</div>	
					</c:when>
				<c:otherwise>
					<div class="form-group form-group-sm">
              		<label for="fileData" class="col-sm-2 control-label"></label>
		    		<div class="col-sm-5">
		    			<ul style='list-style:none' id="filecontent" class="fileupload">
		    				<c:forEach var="fileList" items="${archivesFileList}">
		    				<li><span class="filenone">
              					<p><spring:escapeBody>${fileList.filename}</spring:escapeBody><a href="#" class="fileDelBtn" id="${fileList.board_file_seq}">[x]</a></p>
              	  			</span></li>
              	  			</c:forEach>
		    			</ul>
		    		</div>
		  		</div>	
				</c:otherwise>
			</c:choose>
				<div class="form-group form-group-sm">
				    <div class="col-sm-offset-2 col-sm-9 text-right">
				    	<c:choose>
				    		<c:when test="${archives.board_seq == null}">
				    			<input type="button" title="등록" value="등록" class="btn btn-primary btn-sm" />
				    		</c:when>
				    		<c:otherwise>
				    			<input type="button" title="수정" value="수정" class="btn btn-primary btn-sm"/>
				    		</c:otherwise>
				    	</c:choose>
	     				<input type="button" title="취소" value="취소" class="btn btn-primary btn-sm" />
				    </div>
			  	</div>
		    </form:form> 
		    
		    <!-- footer start -->
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		    <!-- footer end -->
       		
       </div>
    </div>
</div>
<!-- END CONTENTS -->
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />

<script type="text/javascript" src="<c:url value="/resources/CLEditor1_4_5/jquery.cleditor.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/CLEditor1_4_5/jquery.cleditor.js"/>"></script>
<script type="text/javascript">
$(function() {
	
	//검색 파라메터 추가
	$(paramForm).find('input[type=hidden]').each(function() {
		$("#archives").addHidden($(this).attr("id"), $(this).val());
	});
	
	<c:if test="${empty archives.board_seq or 5000 le archives.board_seq}">
		$("#content").cleditor();
	</c:if>
	
	// 유효성 검사
	$("#archives").validate({
		debug: false,
		rules: {
			sitegubun: "required",
			use_yn: "required",
			title: {
					required : true,
					fieldLength : 300
				   },
			content: "required"
		},
		
		
		
		messages: {
			sitegubun: "사이트를 선택하여 주십시오.",
			use_yn: "표출여부를 선택하여 주십시오.",
			title: {
				    required : "제목을 입력하여 주십시오.",
					fieldLength : "제목은 최대 한글 100자, 영문 300자 까지 입력가능합니다."	
				   },
			content: "내용을 입력하여 주십시오."
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

	$("input[type=button]").click(function() {
		switch($(this).val()) {
		case "등록":
			$("#archives").submit();
			break;
		case "수정":
			$("#archives").submit();
			break;
		case "취소":
			//수정
			$(paramForm).addHidden("board_seq", '${archives.board_seq}');
			<c:if test="${mode eq 'update' }">
				$(paramForm).attr("action", "archives_view.do");
			</c:if>

			//등록
			 <c:if test="${mode eq 'new' }">
				$(paramForm).attr("action", "archives_list.do");
			</c:if>

			$(paramForm).submit();
			break;
		};
	});
	
	// 첨부파일 필드에 변경 이벤트를 바인딩
	$("#fileData").bind("change", function(event) {
		event.preventDefault();
		var changDate = new Date().getTime();
		// 첨부파일을 추가
		addFile(this, changDate);
		// 첨부파일을 생성
		createFile(changDate);
	});
	
	// 첨부파일 데이터 항목에서 삭제
	$(".fileDelBtn").click(function() {
		id:$(file).attr("id");
	}, function(event) {
		removeFile(event.data.id, this);
	});
});
//첨부파일을 추가
function addFile(file, changDate) {
	var item = $("<li><span class=\"test\"></span><a href=\"#none\" class=\"fileDelBtn\">[x]</a></li>");
	var ext = getFileExt($(file).val());
	
	if(ext === null) {
		item.find(".test").text(ext);
		item.find(".fileDelBtn").bind("click", {
			id:$(file).attr("id") + changDate
		}, function(event) {
			removeFile(event.data.id, this);
		});
	
		$(".filenone").parent().remove();
		$("#filecontent").append(item);
	} else if(ext != null) {
		item.find(".test").text(ext);
		item.find(".fileDelBtn").bind("click", {
			id:$(file).attr("id") + changDate
		}, function(event) {
			event.preventDefault();
			removeFile(event.data.id, this);
		});
		
		$("#filecontent").append(item);
	}
	
	//$(file).parent().hide();
}

//첨부파일을 생성
function createFile(changDate) {
	var item = $("<li><input name=\"fileData\" type=\"file\" class=\"form-control\" id=\"fileData\" /></li>");
	
	
	item.find(":file").bind("change", function(event) {
		var changDate = new Date().getTime();
		addFile(this, changDate);
		createFile(changDate);
	});
	
	$("#fileupload li:last").hide().children().attr("id", "fileData" + changDate);
	
	$("#fileupload").append(item);
}

// 파일명을 얻는다
function getFileExt(path) {
	return path.substring(path.lastIndexOf("\\") + 1);
}

// 첨부파일 항목을 목록에서 삭제
function removeFile(id, link) {
	var linkId = $(link).attr("id");
	if(linkId != null || typeof linkId != 'undefined'){
		$("#archives").append("<input type=\"hidden\" name=\"delete_file_seq\" value=\""+linkId+"\"/>");
	}
	$("#" + id).parent().remove();
    $(link).parent().remove();
   
    if ($("#filecontent .fileupload").size() == 0) {
        $("#filecontent").append("<li><span class=\"filenone\"></span></li>");
    }
}

</script>

</body>
</html>