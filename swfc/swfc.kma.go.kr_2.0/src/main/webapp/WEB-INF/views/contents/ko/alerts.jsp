<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/common/js/plugin/lightbox/css/lightbox.css"/>" />
<style type="text/css">
	.searchBox {
		width:100%; 
		vertical-align: middle;
	}
	
	.searchBox select {
		float: left;
	}
	.searchBox a {
		float: right;
	}
</style>
<jsp:include page="/WEB-INF/views/include/jquery.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/topMenu.jsp"/>
<div id="wrap_sub">
	<div class="wrap_graph example-set">
    	<div>
        	<h6>태양 X선 세기</h6>
        	<a class="example-image-link" href="<c:url value="/ko/alerts/img/xflux_5m.do"/>" data-lightbox="image_field" data-title="태양 X선 세기">
        	<img class="example-image" src="<c:url value="/ko/alerts/img/xflux_5m.do"/>" alt="" width="220"/>
        	</a>
        </div>
        <div>
        	<h6>태양 양성자 세기</h6>
        	<a class="example-image-link" href="<c:url value="/ko/alerts/img/goes13_proton.do"/>" data-lightbox="image_field" data-title="태양 양성자 세기">
			<img src="<c:url value="/ko/alerts/img/goes13_proton.do"/>" alt="" width="220"/>   
			</a>
        </div>
        <div>
        	<h6>지구 자기 교란 지수</h6>
        	<a class="example-image-link" href="<c:url value="/ko/alerts/img/kp_index.do"/>" data-lightbox="image_field" data-title="지구 자기 교란 지수">
			<img src="<c:url value="/ko/alerts/img/kp_index.do"/>" alt="" width="220"/>   
			</a>
        </div>
        <div>
        	<h6>자기권계면 위치</h6>
        	<a class="example-image-link" href="<c:url value="/ko/alerts/img/geomag_B.do"/>" data-lightbox="image_field" data-title="자기권계면 위치">
			<img src="<c:url value="/ko/alerts/img/geomag_B.do"/>" alt="" width="220"/>
			</a>   
        </div>
        
    </div>
    <div align="right">
    	<span>* 해당 이미지를 선택하면 원본 이미지를 볼 수 있습니다.&nbsp;&nbsp;&nbsp;</span>
    </div>
	<h2 class="alert">
    	<span>우주기상예특보</span>
    </h2>
    <div class="searchBox" >
    	<select name="search_type" id="searchType">
    		<option value="">전체</option>
    		<option value="FCT" <c:if test="${param.rpt_type eq 'FCT'}">selected="selected"</c:if>>예보</option>
    		<option value="WRN" <c:if test="${param.rpt_type eq 'WRN'}">selected="selected"</c:if>>특보</option>
    	</select>
   		<a href="http://www.adobe.com/kr/products/reader.html" target="_blank" class="download">Adobe Reader 다운로드</a>
    </div>    
    <div class="result_wrap">
        <table class="list">
            <thead>
                <tr>
                    <th width="20">NO</th>
                    <th>유형</th>
                    <th>제목</th>
                    <th>파일보기</th>
                </tr>
            </thead>
            <tbody>
            	<c:forEach items="${list}" var="item" varStatus="status">
            	<tr>
                    <td>${pageNavigation.startNum - status.index}</td>
                    <td>
                    	<c:if test="${item.rpt_type=='FCT'}"><img src="<c:url value="/resources/ko/images/ico_forecast.png"/>" alt="예보" /></c:if>
                    	<c:if test="${item.rpt_type=='WRN'}"><img src="<c:url value="/resources/ko/images/ico_alert.png"/>" alt="특보" /></c:if>
                    </td>
                    <td><span><fmt:formatDate value="${item.publish_dt}" pattern="yyyy.MM.dd HH:mm"/></span>발표</td>
                    <td>
	                    <a href="<c:url value="/ko/alerts/covert_report_to_pdf/${item.rpt_seq_n}.do"/>" target="_blank"><img src="<c:url value="/resources/ko/images/ico_pdf.png"/>" alt="Adobe Reader" class="imgbtn" /></a>
                    </td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="pager">
  		<c:if test="${pageNavigation.prevPage}">
  			<a href="#" class="fir" page="1"><span>처음</span></a>
  			<a href="#" page="${pageNavigation.startPage - 1}" class="pre"><span>이전</span></a>
        </c:if>
        <c:forEach var="page" begin="${pageNavigation.startPage}" end="${pageNavigation.endPage}">
        	<a href="#" <c:if test="${page == pageNavigation.nowPage}">class="tsp"</c:if> page="${page}">${page}</a>
        </c:forEach>
        <c:if test="${pageNavigation.nextPage}">
	        <a href="#" class="nex" page="${pageNavigation.endPage + 1}"><span>다음</span></a>
	        <a href="#" class="las" page="${pageNavigation.totalPage}"><span>마지막</span></a>
        </c:if>
    </div>
    <!-- END PAGER -->
</div>
<form id="forecastForm" id="forecastForm" action="<c:url value="/ko/alerts.do"/>" method="post">
<input type="hidden" name="p" id="p" value="${pageNavigation.nowPage}"/>
<input type="hidden" name="search_type" id="search_type" value=""/>
</form>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
<script type="text/javascript" src="<c:url value="/resources/common/js/plugin/lightbox/js/lightbox.js"/>"></script>
<script type="text/javascript">
$(function() {
	$('#searchType').on('change', function(){
		search();
	});
	
	$('.pager a').on('click', function(e){
		e.preventDefault();
		$('#p').val($(this).attr('page'));
		search();
	});
});

function search(){
	$('#search_type').val($('#searchType').val());
	$('#forecastForm').submit();
}
</script>
</body>
</html>