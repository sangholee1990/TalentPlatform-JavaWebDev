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
			<h4 class="page-header">보고서 목록</h4>
			<!-- content area start -->

			<nav class="navbar navbar-default" role="navigation">
				<div class="collapse navbar-collapse navbar-ex1-collapse text-right">
			    	<form class="navbar-form navbar-right" role="search" action="<c:url value="/admin/report/report_list.do"/>" method="post" name="listForm" id="listForm">
				    	<input type="hidden" name="page" id="page" value="${data.searchInfo.page}">
				    	
				    	<div class="form-group">
				    	
				    		<label for="startDate" class="control-label">작성일시 검색시작</label>
				    		<div class="form-group">
					        	<input type="text" name="startDate" id="startDate" class="form-control input-sm" placeholder="${ data.searchInfo.startDate }" value="${ data.searchInfo.startDate }" style="width: 100px;">
					        	<select class="form-control input-sm" name="startHour" id="startHour" style="width: 60px;">
									<c:forEach var="i" begin="0" end="23" step="1">
										<option value="<fmt:formatNumber minIntegerDigits="2" value="${i}"/>" <c:if test="${data.searchInfo.startHour + 0 == i }">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${i}"/>&nbsp;&nbsp;</option> 
									</c:forEach>				        	
					        	</select>&nbsp;<label class="control-label">시&nbsp;&nbsp;</label>
					      	</div>
					      	
					      	<label for="endDate" class="control-label">작성일시 검색종료</label>
					      	<div class="form-group">
					        	<input type="text" name="endDate" id="endDate" class="form-control input-sm" placeholder="${ data.searchInfo.endDate }" value="${ data.searchInfo.endDate }" style="width: 100px;">
					        	<select class="form-control input-sm" name="endHour" id="endHour" style="width: 60px;">
								<c:forEach var="i" begin="0" end="23" step="1">
									<option value="<fmt:formatNumber minIntegerDigits="2" value="${i}"/>" <c:if test="${data.searchInfo.endHour + 0 == i }">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${i}"/>&nbsp;&nbsp;</option> 
								</c:forEach>				        	
				        		</select>&nbsp;<label class="control-label">시&nbsp;</label>
					      	</div>
				    	</div>
				    	
				    	<br /><br />
				      	
				      	<label for="search_type" class="control-label">보고서 구분</label>
				    	<div class="form-group">
				    		<select class="form-control input-sm" name="search_type" id="search_type">
				    			<option value="" <c:if test="${data.searchInfo.search_type eq ''}">selected="selected"</c:if>>전체</option>
				    			<c:forEach var="subcodeList" items="${subcodeList }" varStatus="status">
				    				<option value="${subcodeList.code }" <c:if test="${data.searchInfo.search_type eq subcodeList.code}">selected="selected"</c:if>>
				    					<spring:escapeBody>${subcodeList.code_nm }</spring:escapeBody>
				    				</option>
				    			</c:forEach>
				    		</select>&nbsp;&nbsp;
				    	</div>
				      	
				      	<label for="search_kind_type" class="search_kind_type">경보요소</label>
				      	<div class="form-group search_kind_type">
				      		<select class="form-control input-sm" name="search_kind_type" id="search_kind_type">
				    			<option value="" <c:if test="${data.searchInfo.search_kind_type eq ''}">selected="selected"</c:if>>전체</option>
				            	<option value="1" <c:if test="${data.searchInfo.search_kind_type eq '1'}">selected="selected"</c:if>>기상위성운영</option>
				            	<option value="2" <c:if test="${data.searchInfo.search_kind_type eq '2'}">selected="selected"</c:if>>극항로항공기상&nbsp;&nbsp;</option>
				            	<option value="3" <c:if test="${data.searchInfo.search_kind_type eq '3'}">selected="selected"</c:if>>전리권기상</option>
				    		</select>&nbsp;&nbsp;
				      	</div>
				      	
				      	<label for="search_kind" class="search_kind">경보구분</label>
				      	<div class="form-group search_kind">
				      		<select class="form-control input-sm" name="search_kind" id="search_kind">
				    			<option value="" <c:if test="${searchInfo.search_kind eq ''}">selected="selected"</c:if>>전체</option>
				            	<option value="주의보" <c:if test="${searchInfo.search_kind eq '주의보'}">selected="selected"</c:if>>주의보&nbsp;&nbsp;</option>
				            	<option value="경보" <c:if test="${searchInfo.search_kind eq '경보'}">selected="selected"</c:if>>경보</option>
				    		</select>&nbsp;&nbsp;
				      	</div>
				      	
				      	<label for="st_publish_seq" class="publish_seq">발행호수 검색기간</label>
				    	<div class="form-group publish_seq">
				    		<input type="text" class="form-control input-sm" id="st_publish_seq" name="st_publish_seq" size="2" maxlength="2" value="${data.searchInfo.st_publish_seq }" />&nbsp;호 ~
				    		<input type="text" class="form-control input-sm" id="ed_publish_seq" name="ed_publish_seq" size="2" maxlength="2" value="${data.searchInfo.ed_publish_seq }" />&nbsp;호&nbsp;&nbsp;
				    	</div>
				      	
				     	<button type="button" id="searchBtn" class="btn btn-primary btn-sm">검색</button>
			    	</form>
			  	</div>
			</nav>

			<div class="top-button-group">
				<input name="oldFctAddBtn" type="button" class="btn btn-primary btn-sm addBtn" title="구통보문 작성" value="구통보문 작성" />
				<input name="newFctAddBtn" type="button" class="btn btn-primary btn-sm addBtn" title="신통보문 작성" value="신통보문 작성" />
				<input name="oldWrnAddBtn" type="button" class="btn btn-primary btn-sm addBtn" title="특보문 작성" value="특보문 작성" />
 				<input name="newWrnAddBtn" type="button" class="btn btn-primary btn-sm addBtn" title="신특보문 작성" value="신특보문 작성" />
				<input name="dailyAddBtn" type="button" class="btn btn-primary btn-sm addBtn" title="일일상황보고 작성" value="일일상황보고 작성" />
			</div>

	        <table class="table table-striped">
	        	<thead>
	            	<tr>
	                	<th width="5%">no</th>
	                	<th width="10%">구분</th>
	                    <th width="23%">제목</th>
	                    <th width="8%">발행호수</th>
	                    <th width="12%">발표일시</th>
	                    <th width="12%">작성일</th>
	                    <th width="8%">작성자</th>
	                    <th width="12%">COMIS 전송일</th>
	                    <th width="7%">PDF</th>
	                </tr>
	            </thead>
				<c:forEach var="o" items="${data.list}" varStatus="status">
				<c:choose>
					<c:when test="${o.rpt_type eq 'WRN' and o.rmk1 eq null }"><c:set var="rmk1" value="0" /></c:when>
					<c:when test="${o.rpt_type eq 'WRN' and o.rmk1 ne null }"><c:set var="rmk1" value="${o.rmk1 }" /></c:when>
				</c:choose>
	            <tr>
	            	<td class="no">${data.pageNavigation.startNum - status.index}</td>
	            	<td>
	            		<c:choose>
	            			<c:when test="${o.rpt_type eq 'FCT'}">
	            				<c:choose>
	            					<c:when test="${o.rpt_kind eq 'N' }">(신)통보</c:when>
	            					<c:when test="${o.rpt_kind eq 'O' }">통보</c:when>
	            				</c:choose>
	            			</c:when>
	            			<c:when test="${o.rpt_type eq 'WRN'}">특보</c:when>
	            			<c:when test="${o.rpt_type eq 'DSR'}">일일상황보고</c:when>
	            		</c:choose>
	            	</td>
	            	<td class="text-left">
	            		<c:choose>
	            			<c:when test="${o.rpt_type eq 'DSR'}">
		               			<a href="daily_situation_report_form.do?page=${data.searchInfo.page }&rpt_seq_n=${o.rpt_seq_n }"><spring:escapeBody>${o.title}</spring:escapeBody></a>
	            			</c:when>
	            			<c:otherwise>
								<c:choose>
				               		<c:when test="${not empty o.submit_dt}">
					               		<spring:escapeBody>${o.title}</spring:escapeBody>
					               		<c:choose>
					               			<c:when test="${o.rpt_type eq 'WRN' and o.wrn_flag eq 'S'}">
												발령
												<c:if test="${o.publish_seq_n != 0}">
													(제<fmt:formatDate value="${o.publish_dt}" pattern="MM"/> - ${rmk1}호)
												</c:if>
											</c:when>
					               			<c:when test="${o.rpt_type eq 'WRN' and o.wrn_flag eq 'E'}">
												해제
												<c:if test="${o.publish_seq_n != 0}">
													(제<fmt:formatDate value="${o.publish_dt}" pattern="MM"/> - ${rmk1}호)
												</c:if>
											</c:when>
					               		</c:choose>
				                   	</c:when>
				                   	<c:otherwise>
					               		<a href="report_form.do?page=${data.searchInfo.page }&rpt_seq_n=${o.rpt_seq_n }&rpt_type=${o.rpt_type }&rpt_kind=${o.rpt_kind }">
						               		<spring:escapeBody>${o.title}</spring:escapeBody>
						               		<c:choose>
						               			<c:when test="${o.rpt_type eq 'WRN' and o.wrn_flag eq 'S'}">
													발령
													<c:if test="${o.publish_seq_n != 0}">
														(제<fmt:formatDate value="${o.publish_dt}" pattern="MM"/> - ${rmk1}호)
													</c:if>
												</c:when>
						               			<c:when test="${o.rpt_type eq 'WRN' and o.wrn_flag eq 'E'}">
													해제
													<c:if test="${o.publish_seq_n != 0}">
														(제<fmt:formatDate value="${o.publish_dt}" pattern="MM"/> - ${rmk1}호)
													</c:if>
												</c:when>
						               		</c:choose>
					               		</a>
				                   	</c:otherwise>
								</c:choose>
	            			</c:otherwise>
	            		</c:choose>
					</td>
	            	<td>
	            		<c:if test="${o.rpt_type eq 'FCT' or o.rpt_type eq 'WRN' }">
	            		<fmt:formatDate value="${o.publish_dt}" pattern="MM"/>-${o.publish_seq_n}
	            		</c:if>
	            	</td>
	                <td>
	                	<c:choose>
	                		<c:when test="${not empty o.publish_dt }">
	                			<fmt:formatDate value="${o.publish_dt}" pattern="yyyy.MM.dd HH:mm"/>
	                		</c:when>
	                	</c:choose>
	                </td>
	                <td>
	                	<fmt:formatDate value="${o.write_dt}" pattern="yyyy.MM.dd HH:mm"/>
	                </td>
	                <td>${o.user_nm}</td>
	                <td>
	                	<c:if test="${o.rpt_type eq 'FCT' or o.rpt_type eq 'WRN' }">
                		<c:choose>
	                		<c:when test="${not empty o.submit_dt}">
	                		<fmt:formatDate value="${o.submit_dt}" pattern="yyyy.MM.dd HH:mm"/>
	                		</c:when>
	                		<c:otherwise>
	               			<a href="#"><span id="${o.rpt_seq_n }" class="glyphicon glyphicon-open"></span></a>
	                		</c:otherwise>
               			</c:choose>
               			</c:if>
	                </td>
	                <td>
	                	<c:if test="${not empty o.rpt_file_path }">
		                	<a href="<c:url value="/admin/report/covert_report_to_pdf.do?rpt_type=${o.rpt_type}&rpt_seq_n=${o.rpt_seq_n }"/>" target="_blank" ><img src="<c:url value="/images/report/ico_pdf.png" />" /></a>
	                	</c:if>
	                </td>
	            </tr>
	            </c:forEach>
	            <c:if test="${empty data.list }">
	            <tr>
	            	<td colspan="8">등록된 컨텐츠가 존재하지 않습니다.</td>
	            </tr>
	            </c:if>
	        </table>
		        
	        <!-- paging -->
    		<jsp:include page="/WEB-INF/views/include/commonPaging.jsp" />
	        <!-- paging -->
   			
   			
   			<div class="top-button-group">
				<input name="oldFctAddBtn" type="button" class="btn btn-primary btn-sm addBtn" title="구통보문 작성" value="구통보문 작성" />
				<input name="newFctAddBtn" type="button" class="btn btn-primary btn-sm addBtn" title="신통보문 작성" value="신통보문 작성" />
				<input name="oldWrnAddBtn" type="button" class="btn btn-primary btn-sm addBtn" title="구특보문 작성" value="특보문 작성" />
 				<input name="newWrnAddBtn" type="button" class="btn btn-primary btn-sm addBtn" title="신특보문 작성" value="신특보문 작성" /> 
				<input name="dailyAddBtn" type="button" class="btn btn-primary btn-sm addBtn" title="일일상황보고 작성" value="일일상황보고 작성" />
			</div>
    			
			<!-- content area end -->
			
			<jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />
		</div>		
	</div>
		
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript">


var dayNames = ['일', '월', '화', '수', '목', '금', '토'];
var monthNames = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
var datepickerOption = {
		hangeYear : true,
		showOn : "button",
		dayNames: dayNames,
		dayNamesMin: dayNames,
		dayNamesShort: dayNames,
		monthNames : monthNames,
		monthNamesShort : monthNames,
		buttonImage : '<c:url value="/images/btn_calendar.png"/>',
		buttonImageOnly : true,
		dateFormat: "yy-mm-dd"
};

$(function() {
	$("#searchBtn").on("click", function() {
		if($("#st_publish_seq").val() != "" && !$.isNumeric($("#st_publish_seq").val())) {
			alert("발행호수는 숫자만 입력해주세요.");
			
			$("#st_publish_seq").focus();
			
			return false;
		}
		
		if($("#ed_publish_seq").val() != "" && !$.isNumeric($("#ed_publish_seq").val())) {
			alert("발행호수는 숫자만 입력해주세요.");
			
			$("#ed_publish_seq").focus();
			
			return false;
		}
		
		paging(1);
	});
	
	$(".glyphicon").on("click", function() {
		$.getJSON(
			"<c:url value="/admin/report/comis_submit.do"/>",
			{
				rpt_seq_n : $(this).attr("id")
			}, function(data) {
				handleReponse(data);
			}
		);
	});
	
	$(function(){
		$("#startDate").datepicker(datepickerOption);
		$("#endDate").datepicker(datepickerOption);
	});
	
	$(".search_kind").hide();
	$(".search_kind_type").hide();
	$(".publish_seq").hide();
	
	changeSearchArea($("#search_type").val());
	
	$("#search_type").on("change", function() {
		changeSearchArea($(this).val());
	});
	
	$(".addBtn").on("click", function() {
		var name = $(this).attr("name");
		
		if(name == "oldFctAddBtn") {
			location.href = "report_form.do?rpt_type=FCT&rpt_kind=O";
		}
		else if(name == "newFctAddBtn") {
			location.href = "report_form.do?rpt_type=FCT&rpt_kind=N";
		}
		else if(name == "oldWrnAddBtn") {
			location.href = "report_form.do?rpt_type=WRN&rpt_kind=O";
		}
 		else if(name == "newWrnAddBtn") {
 			//alert("newWrnAddBtn");
 			location.href = "report_form.do?rpt_type=WRN&rpt_kind=N";
 		}
		else {
 			location.href = "daily_situation_report_form.do";
		}
	});
});

function changeSearchArea(search_type) {
	if(search_type == "FCT") {
		$(".search_kind").hide();
		$(".search_kind_type").hide();
		$(".publish_seq").show();
	}
	else if(search_type == "WRN") {
		$(".search_kind").show();
		$(".search_kind_type").show();
		$(".publish_seq").show();
	}
	else {
		$(".search_kind").hide();
		$(".search_kind_type").hide();
		$(".publish_seq").hide();
	}
}

function handleReponse(data) {
	alert(data.messages);
	
	if(data.success) {
		paging($("#page").val());
	}
}
</script>	
</body>
</html>