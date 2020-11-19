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
	<meta name="Filename" content="swfc_fct_<fmt:formatDate value="${report.publish_dt}" pattern="yyyyMMddHHmm"/>_${report.publish_seq_n}.pdf" />
	
        <title>${report.title}</title>
		<style type="text/css">
		body {
			font-family:Baekmuk Gulim,Dotum;
    	}
		.td_normal
		{
			border:1px black solid;
		}
		
		.td_outline_first {
			border:1.5px black solid;
		}
		
		.td_outline
		{
			border:1.5px black solid;
			border-top-width:0px;
		}
		</style>
    </head>
    <body>
<table cellpadding="10" cellspacing="0" border="0" align="center" style="width:100%;">
<tr>
<td style="text-align:center;" class="td_outline_first">
	<span style="font-size:20pt;font-weight:bold;"><spring:escapeBody>${report.title}</spring:escapeBody></span>
	<br/>
	<table cellpadding="0" cellspacing="0" border="0" style="width:100%">
		<tr>
			<td>
				<img src="${baseUrl}/images/kma.jpg" width="81" height="81"/>
			</td>
		<td style="text-align:right;vertical-align:bottom;font-weight:bold;">
			국가기상위성센터, <spring:escapeBody>${report.writer}</spring:escapeBody><br/><fmt:formatDate value="${report.publish_dt}" pattern="yyyy년 MM월 dd일 HH시 mm분"/> 발표
		</td>
		</tr>
	</table>
</td>
</tr>
<tr style="height:300pt">
 <td style="vertical-align:top;" class="td_outline">
	<b>□ 개 요</b>
	<br/>
	<p style="padding:10px;text-indent:5em;">
	<custom:nl2br>${report.contents}</custom:nl2br>
	</p>
</td>
</tr>
<tr>
 <td class="td_outline">
	<b>□ 주의사항</b>
	<br/>
	<table width="100%" cellpadding="10" align="center" style="text-align:center;margin-top:10px;" >
		<tr style="height:22pt;">
			<td width="85" class="td_normal"><b>종 류</b></td>
			<td class="td_normal"><b>기상위성운영</b></td>
			<td class="td_normal"><b>극항로 항공기상</b></td>
			<td class="td_normal"><b>전리권기상</b></td>
		</tr>
		<tr>
			<td class="td_normal">주의사항</td>
			<td class="td_normal"><c:forEach items="${report.not1_desc}" var="item" varStatus="status"><spring:escapeBody>${item}</spring:escapeBody><c:if test="${not status.last}"><br/></c:if></c:forEach></td>
			<td class="td_normal"><c:forEach items="${report.not2_desc}" var="item" varStatus="status"><spring:escapeBody>${item}</spring:escapeBody><c:if test="${not status.last}"><br/></c:if></c:forEach></td>
			<td class="td_normal"><c:forEach items="${report.not3_desc}" var="item" varStatus="status"><spring:escapeBody>${item}</spring:escapeBody><c:if test="${not status.last}"><br/></c:if></c:forEach></td>
		</tr>
	</table>
 </td>
</tr>
</table>
</body>
</html>