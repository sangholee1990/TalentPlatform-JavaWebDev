<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%pageContext.setAttribute("LF", "\n"); %>
<c:set var="baseUrl" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="Filename" content="swfc_wrn_<fmt:formatDate value="${report.publish_dt}" pattern="yyyyMMddHHmm"/>_${report.publish_seq_n}.pdf" />
        <title>${report.title}</title>
		<style type="text/css">
		body {
			font-family:Baekmuk Gulim,Dotum;
    	}
    	
		.td_normal
		{
			border:1px black solid;
		}
		
		.td_outline_top {
			border-left-color:black;
			border-left-width:1.5px;
			border-top-color:black;
			border-top-width:1.5px;
			border-right-color:black;
			border-right-width:1.5px;
			border-bottom-color:black;
			border-bottom-width:1.5px;
			text-align:center;
		}
		
		.td_outline
		{
			border-left-color:black;
			border-left-width:1.5px;
			border-right-color:black;
			border-right-width:1.5px;
			border-bottom-color:black;
			border-bottom-width:1.5px;
		}
		
		.td_outline_rb
		{
			border-right-color:black;
			border-right-width:1.5px;
			border-bottom-color:black;
			border-bottom-width:1.5px;
			text-align:center;
		}
		
		.td_thin_top {
			border-left-color:black;
			border-left-width:1.5px;
			border-right-color:black;
			border-right-width:1px;
			border-bottom-color:black;
			border-bottom-width:1px;
			text-align:center;		
		}
		
		.td_thin_top_center {
			border-right-color:black;
			border-right-width:1px;
			border-bottom-color:black;
			border-bottom-width:1px;
			text-align:center;			
		}
		
		.td_thin_top_right {
			border-right-color:black;
			border-right-width:1.5px;
			border-bottom-color:black;
			border-bottom-width:1px;
			text-align:center;			
		}
		
		.td_notice_top {
			border-left-color:black;
			border-left-width:1px;
			border-top-color:black;
			border-top-width:1px;
			border-right-color:black;
			border-right-width:1px;
			border-bottom-color:black;
			border-bottom-width:1px;
		}
		
		.td_notice {
			border-left-color:black;
			border-left-width:1px;
			border-right-color:black;
			border-right-width:1px;
			border-bottom-color:black;
			border-bottom-width:1px;
		}		
		
		</style>
    </head>
    <body>
<table cellpadding="5" cellspacing="0" border="0" style="width:100%;height:100%;">
<tr>
<td class="td_outline_top" colspan="4">
	<span style="font-size:20pt;font-weight:bold;"><spring:escapeBody>${report.title}</spring:escapeBody> (제<fmt:formatDate value="${report.publish_dt}" pattern="MM"/> - ${report.publish_seq_n}호)</span>
	<br/>
	<table cellpadding="0" cellspacing="0" border="0" style="width:100%">
		<tr>
			<td>
				<img src="${baseUrl}/images/kma.jpg" width="81" height="81"/>
			</td>
			<td style="text-align:right;vertical-align:center;font-weight:bold;">
				국가기상위성센터, <spring:escapeBody>${report.writer}</spring:escapeBody><br/><fmt:formatDate value="${report.publish_dt}" pattern="yyyy년 MM월 dd일 HH시 mm분"/> 발표
			</td>
		</tr>
	</table>
</td>
</tr>
<tr>
	<td style="height:180pt;vertical-align:top;" class="td_outline" colspan="4">
		<b>□ 개 요</b>
		<br/>
		<p style="padding:10px;text-indent:5em;">
		<custom:nl2br>${report.contents}</custom:nl2br>
		</p>
	</td>
</tr>
<tr>
	<td class="td_thin_top" style="width:90pt;background-color:#FFE6BB;">구&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;분</td>
	<td class="td_thin_top_center" style="width:33.33%;background-color:#FFE6BB;">기상위성운영</td>
	<td class="td_thin_top_center" style="width:33.33%;background-color:#FFE6BB;">극항로 항공기상</td>
	<td class="td_thin_top_right" style="width:33.33%;background-color:#FFE6BB;">전리권기상</td>
</tr>
<tr>
	<td class="td_thin_top" style="background-color:#FFE6BB;">특 보 종 류</td>
	<td class="td_thin_top_center" style="background-color:#FFE6BB;"><spring:escapeBody>${report.not1_type}</spring:escapeBody></td>
	<td class="td_thin_top_center" style="background-color:#FFE6BB;"><spring:escapeBody>${report.not2_type}</spring:escapeBody></td>
	<td class="td_thin_top_right" style="background-color:#FFE6BB;"><spring:escapeBody>${report.not3_type}</spring:escapeBody></td>
</tr>
<tr>
	<td class="td_thin_top">발 표 시 각</td>
	<td class="td_thin_top_center"><spring:escapeBody>${report.not1_publish}</spring:escapeBody></td>
	<td class="td_thin_top_center"><spring:escapeBody>${report.not2_publish}</spring:escapeBody></td>
	<td class="td_thin_top_right"><spring:escapeBody>${report.notiP_pblish}</spring:escapeBody></td>
</tr>
<tr>
	<td class="td_thin_top">종 료 시 각</td>
	<td class="td_thin_top_center"><spring:escapeBody>${report.not1_finish}</spring:escapeBody></td>
	<td class="td_thin_top_center"><spring:escapeBody>${report.not2_finish}</spring:escapeBody></td>
	<td class="td_thin_top_right"><spring:escapeBody>${report.not3_fnish}</spring:escapeBody></td>
</tr>
<tr>
	<td class="td_thin_top" style="border-bottom-width:1.5px;">대&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;상</td>
	<td class="td_thin_top_center" style="border-bottom-width:1.5px;"><spring:escapeBody>${report.not1_tar}</spring:escapeBody></td>
	<td class="td_thin_top_center" style="border-bottom-width:1.5px;"><spring:escapeBody>${report.not2_tar}</spring:escapeBody></td>
	<td class="td_thin_top_right" style="border-bottom-width:1.5px;"><spring:escapeBody>${report.not3_tar}</spring:escapeBody></td>
</tr>			
<tr>
 <td class="td_outline" colspan="4">
	<b>□ 주의사항</b>
	<br/>
	<table width="100%" cellpadding="5" style="text-align:center;margin-top:10px;border-collapse:collapse;" >
		<tr>
			<td width="150pt" class="td_notice_top" style="background-color:silver;"><b>구&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;분</b></td>
			<td class="td_notice_top" style="border-left-width:0px;"><b>주 의 사 항</b></td>
		</tr>
		<tr>
			<td class="td_notice" style="background-color:silver;"><b>기상위성운영</b></td>
			<td class="td_notice" style="border-left-width:0px;text-align:left;"><c:forEach items="${report.not1_desc}" var="item" varStatus="status"><spring:escapeBody>${item}</spring:escapeBody><c:if test="${not status.last}"><br/></c:if></c:forEach></td>
		</tr>
		<tr>
			<td class="td_notice" style="background-color:silver;"><b>극항로 항공기상</b></td>
			<td class="td_notice" style="border-left-width:0px;text-align:left;"><c:forEach items="${report.not2_desc}" var="item" varStatus="status"><spring:escapeBody>${item}</spring:escapeBody><c:if test="${not status.last}"><br/></c:if></c:forEach></td>
		</tr>
		<tr>
			<td class="td_notice" style="background-color:silver;"><b>전리권기상</b></td>
			<td class="td_notice" style="border-left-width:0px;text-align:left;"><c:forEach items="${report.not3_desc}" var="item" varStatus="status"><spring:escapeBody>${item}</spring:escapeBody><c:if test="${not status.last}"><br/></c:if></c:forEach></td>
		</tr>							
	</table>
 </td>
</tr>
<tr>
 <td class="td_outline" colspan="4">
	<b>□ 상세정보</b>
	<br/>
	<table style="width:100%;">
		<tr>
			<td style="padding:5px; text-align:center"><b><spring:escapeBody>${report.file_path1_title}</spring:escapeBody></b></td>
			<td style="padding:5px; text-align:center"><b><spring:escapeBody>${report.file_path2_title}</spring:escapeBody></b></td>
		</tr>
		<tr>
			<td style="vertical-align:top;text-align:center;"><img src="${report.file_path1}" ${File1Axis}="200pt"/></td>
			<td style="vertical-align:top;text-align:center;"><img src="${report.file_path2}" ${File2Axis}="200pt"/></td>
		</tr>
	</table>
	</td>
</tr>
</table>
</body>
</html>