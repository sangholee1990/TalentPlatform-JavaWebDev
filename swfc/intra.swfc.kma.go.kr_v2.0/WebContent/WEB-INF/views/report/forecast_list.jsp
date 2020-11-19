<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 우주기상인트라넷</title>
<link rel="stylesheet" type="text/css" href="../css/default.css"  />
<jsp:include page="../include/jquery.jsp" />
<jsp:include page="../include/jquery-ui.jsp" />
<script type="text/javascript">
$(function() {
	var datepickerOption = {
			changeYear:true,
			showOn: "button",
			buttonImage: '../images/btn_calendar.png', 
			buttonImageOnly: true
	};
	
	if($("#search_type").val() == "WRN") {
		$('.WRN').show();
	} else {
		$('.WRN').hide();
	}
	
	$("#startDate").datepicker(datepickerOption);
	$("#endDate").datepicker(datepickerOption);
	
	$("#fctAddBtn").on('click',function(){
		location.href="forecast_form.do?rpt_type=FCT";
	});
	
	$("#wrnAddBtn").on('click',function(){
		location.href="forecast_form.do?rpt_type=WRN";
	});
	
	$("#btnsearch").on('click',function(){
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
		
		search(1);
	});
	
	$(".btn_sf").click(function() {
		if(confirm("삭제하시겠습니까?")) {
			location.href=$(this).attr("href");
		} else {
			
		}
		return false;
	});
	
	$("#contents .report_list .senddate .btn").click(function() {
		if(confirm("전송하시겠습니까?")) {
			location.href=$(this).attr("href");
		}
		return false;
	});
	
	$("#search_type").on('change', function(){
		var val = $(this).val();
		if(val == 'WRN'){
			$('.WRN').show();
		}else{
			$('.WRN').hide();
		}
	});
});

function search(page){
	$("#page").val(page);
 	$("#searchForm").submit();
}
</script>
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->

<div id="contents">
	<h2>특보 및 예보</h2>
	 <div class="search_wrap">    
        <div class="search">
        	<form class="navbar-form navbar-right" action="<c:url value="/report/forecast_list.do"/>" method="post" name="searchForm" id="searchForm">
        	<input type="hidden" name="page" id="page" value="${pageNavigation.nowPage}" />
            <label class="type_tit sun">검색</label>&nbsp;
			<label for="startDate">작성일시</label>
			<input type="text" size="12" id="startDate" name="startDate" value="${searchInfo.startDate}"/>
			<select id="startHour" name="startHour">
				<c:forEach begin="0" end="23" varStatus="loop" var="i">
					<option	value="<fmt:formatNumber minIntegerDigits="2" value="${i}"/>" <c:if test="${searchInfo.startHour+0 == i}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${i}" /></option>
				</c:forEach>
			</select>시 ~  
			<input type="text" size="12" id="endDate" name="endDate" value="${searchInfo.endDate}"/>
			<select id="endHour" name="endHour">
				<c:forEach begin="0" end="23" varStatus="loop" var="i">
					<option value="<fmt:formatNumber minIntegerDigits="2" value="${i}"/>" <c:if test="${searchInfo.endHour+0 == i}">selected="selected"</c:if>><fmt:formatNumber minIntegerDigits="2" value="${i}" /></option>
				</c:forEach>
			</select>시
            <label for="search_type">구분</label>
            <select name="search_type" id="search_type" title="검색">
				<option value="" <c:if test="${searchInfo.search_type eq ''}">selected="selected"</c:if>>[전체]</option>
				<option value="FCT" <c:if test="${searchInfo.search_type eq 'FCT'}">selected="selected"</c:if>>예보</option>
				<option value="WRN" <c:if test="${searchInfo.search_type eq 'WRN'}">selected="selected"</c:if>>특보</option>
			</select>
			<label class="WRN">경보요소</label>
			<select name="search_kind_type" id="search_kind_type" title="경보요소" class="WRN">
            	<option value="" <c:if test="${searchInfo.search_kind_type eq ''}">selected="selected"</c:if>>[전체]</option>
            	<option value="1" <c:if test="${searchInfo.search_kind_type eq '1'}">selected="selected"</c:if>>기상위성운영</option>
            	<option value="2" <c:if test="${searchInfo.search_kind_type eq '2'}">selected="selected"</c:if>>극항로항공기상</option>
            	<option value="3" <c:if test="${searchInfo.search_kind_type eq '3'}">selected="selected"</c:if>>전리권기상</option>
			</select>
			<label class="WRN">경보구분</label>
            <select name="search_kind" id="search_kind" title="경보구분" class="WRN">
            	<option value="" <c:if test="${searchInfo.search_kind eq ''}">selected="selected"</c:if>>[전체]</option>
            	<option value="주의보" <c:if test="${searchInfo.search_kind eq '주의보'}">selected="selected"</c:if>>주의보</option>
            	<option value="경보" <c:if test="${searchInfo.search_kind eq '경보'}">selected="selected"</c:if>>경보</option>
			</select>
			발행호수
			<input type="text" id="st_publish_seq" name="st_publish_seq" style="width: 20px;" maxlength="2" value="${searchInfo.st_publish_seq }" />&nbsp;호 ~
    		<input type="text" id="ed_publish_seq" name="ed_publish_seq" style="width: 20px;" maxlength="2" value="${searchInfo.ed_publish_seq }" />&nbsp;호
            <div class="searchbtns">           
                <input type="button" title="검색" value="검색" class="btnsearch" id="btnsearch"/>
            </div>
           </form>               
        </div>
    </div>

<%-- 	<security:authorize ifAnyGranted="ROLE_USER"> --%>
<!--     <div class="al_r bm1"> -->
<!--     	<input type="button" title="예보 작성" value="예보 작성" class="btnsearch gr" id="fctAddBtn"/> -->
<!--     	<input type="button" title="특보 작성" value="특보 작성" class="btnsearch gr" id="wrnAddBtn"/> -->
<!--     </div> -->
<%--     </security:authorize> --%>
	           
    <div class="report_list">
        <table>
        	<thead>
            	<tr>
                	<th>no</th>
                    <th>종류</th>
                    <th>제목</th>
                    <security:authorize ifAnyGranted="ROLE_USER">
                    <th>발행호수</th>
                    </security:authorize>
                    <th>발표일시</th>
                    <th>작성일</th>
                    <security:authorize ifAnyGranted="ROLE_USER">
                    <th>COMIS전송일</th>
                    </security:authorize>
                    <th>PDF</th>
                </tr>
            </thead>
			<c:forEach var="o" items="${list}" varStatus="status">            
				<c:choose>
					<c:when test="${o.rpt_type eq 'WRN' and o.rmk1 eq null }"><c:set var="rmk1" value="0" /></c:when>
					<c:when test="${o.rpt_type eq 'WRN' and o.rmk1 ne null }"><c:set var="rmk1" value="${o.rmk1 }" /></c:when>
				</c:choose>
            <tr>
            	<td class="no">${pageNavigation.startNum - status.index}</td>
                <td class="type">
<%--                 	<spring:escapeBody>${o.rpt_type}</spring:escapeBody> --%>
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
                <td class="title">
                	<security:authorize ifNotGranted="ROLE_USER">
                	<spring:escapeBody>${o.title}</spring:escapeBody>
                	</security:authorize>
                	<security:authorize ifAnyGranted="ROLE_USER">
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
<%--                 	<c:choose> --%>
<%--                 		<c:when test="${not empty o.submit_dt}"> --%>
<%--                 		<spring:escapeBody>${o.title}</spring:escapeBody><c:if test="${o.publish_seq_n != 0}">(제<fmt:formatDate value="${o.publish_dt}" pattern="MM"/> - ${o.publish_seq_n}호)</c:if> --%>
<%--                     	</c:when> --%>
<%--                     	<c:otherwise> --%>
<%--                 	<a href="forecast_form.do?rpt_seq_n=${o.rpt_seq_n}&rpt_type=${o.rpt_type}&${pageStatus}"> --%>
<%--                 	<spring:escapeBody>${o.title}</spring:escapeBody> --%>
<%--                 	<c:if test="${o.publish_seq_n != 0}">(제<fmt:formatDate value="${o.publish_dt}" pattern="MM"/> - ${o.publish_seq_n}호)</c:if> --%>
<!--                 	</a> -->
<!--                     <span> -->
<%--                         <a class="btn_sf" href="forecast_del.do?rpt_seq_n=${o.rpt_seq_n}&${pageStatus}"><img src="../images/btn_del.png" alt="삭제" class="imgbtn" /></a> --%>
<!--                     </span> -->
<%--                     	</c:otherwise> --%>
<%--                     </c:choose> --%>
                    </security:authorize>
                </td>
                <security:authorize ifAnyGranted="ROLE_USER">
                <td>
                	<fmt:formatDate value="${o.publish_dt}" pattern="MM"/>-${o.publish_seq_n}
                </td>
                </security:authorize>
                <td class="writedate">
                	<fmt:formatDate value="${o.publish_dt}" pattern="yyyy.MM.dd HH:mm"/>
                </td>
                <td class="writedate">
                	<fmt:formatDate value="${o.write_dt}" pattern="yyyy.MM.dd HH:mm"/>
                </td>
                <security:authorize ifAnyGranted="ROLE_USER">
                <td class="senddate">
                	<c:choose>
                		<c:when test="${not empty o.submit_dt}">
                		<fmt:formatDate value="${o.submit_dt}" pattern="yyyy.MM.dd HH:mm"/>
                		</c:when>
<%--                 		<c:otherwise> --%>
<%--                 			<a class="btn" href="comis_submit.do?rpt_seq_n=${o.rpt_seq_n}">COMIS전송</a> --%>
<%--                 		</c:otherwise> --%>
                	</c:choose>
                </td>
                </security:authorize>
                <td class="pdf">
                	<c:choose>
                	<c:when test="${o.rpt_type == 'FCT' and o.rpt_kind=='O'}">
<%-- 	                    <a class="btn" href="#" onclick="window.open('forecast_download_pdf.do?rpt_seq_n=${o.rpt_seq_n}', '_blank', 'fullscreen=yes'); return false;">구통보문 PDF</a> --%>
	                    <a href="<c:url value="/report/covert_report_to_pdf.do?rpt_type=${o.rpt_type}&rpt_seq_n=${o.rpt_seq_n }"/>" target="_blank"><img src="<c:url value="/images/report/ico_pdf.png" />" /></a>
                   	</c:when>
                   	<c:when test="${o.rpt_type == 'FCT' and o.rpt_kind=='N'}">
<%-- 	                <a class="btn" href="#" onclick="window.open('forecast_export_pdf.do?rpt_seq_n=${o.rpt_seq_n}', '_blank', 'fullscreen=yes'); return false;">신통보문 PDF</a> --%>
	                <a href="<c:url value="/report/covert_report_to_pdf.do?rpt_type=${o.rpt_type}&rpt_seq_n=${o.rpt_seq_n }"/>" target="_blank"><img src="<c:url value="/images/report/ico_pdf.png" />" /></a>
	                </c:when>
	                <c:when test="${o.rpt_type == 'WRN' }">
<%-- 	                	<a class="btn" href="#" onclick="window.open('forecast_download_pdf.do?rpt_seq_n=${o.rpt_seq_n}', '_blank', 'fullscreen=yes'); return false;">특보문 PDF</a> --%>
	                	<a href="<c:url value="/report/covert_report_to_pdf.do?rpt_type=${o.rpt_type}&rpt_seq_n=${o.rpt_seq_n }"/>" target="_blank"><img src="<c:url value="/images/report/ico_pdf.png" />" /></a>
	                </c:when>
	                </c:choose>
                </td>              
            </tr>
            </c:forEach>
        </table>
    </div>
        
     <div class="pager bm4">
  		<c:if test="${pageNavigation.prevPage}">
	        <a href="javascript:search(1);" title="처음" class="move"><img src="../images/pager_ico_first.png" alt="이전" /></a>
	        <a href="#" onclick="search('${pageNavigation.startPage - 1}');" title="이전" class="move"><img src="../images/pager_ico_prev.png" alt="이전" /></a>
        </c:if>
        <c:forEach var="page" begin="${pageNavigation.startPage}" end="${pageNavigation.endPage}">
        	<a href="javascript:search('${page}');" <c:if test="${page == pageNavigation.nowPage}">class="thispage"</c:if>>${page}</a>
        </c:forEach>
        <c:if test="${pageNavigation.nextPage}">
			<a href="#" onclick="search('${pageNavigation.endPage + 1}');" title="다음" class="move"><img src="../images/pager_ico_next.png" alt="이전" /></a>
        	<a href="#" onclick="search('${pageNavigation.totalPage}');" title="끝" class="move"><img src="../images/pager_ico_last.png" alt="이전" /></a>        
        </c:if>
    </div>
    <!-- END PAGER -->  
</div>
<!-- END CONTENTS -->

<jsp:include page="../footer.jsp" />
</body>
</html>
