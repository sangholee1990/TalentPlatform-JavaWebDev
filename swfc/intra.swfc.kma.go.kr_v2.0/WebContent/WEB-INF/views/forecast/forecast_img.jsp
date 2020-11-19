<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>국가기상위성센터 :: 우주기상인트라넷</title>
<link rel="stylesheet" type="text/css" href="../css/default.css"  />
</head>

<body>
<jsp:include page="../header.jsp" />
<!-- END HEADER -->

<div id="contents">
    <h2>예측모델</h2>    
    <!-- SEARCH -->
    <div class="search_wrap">
        <div class="search">
            <label class="type_tit sun">검색</label>                  
            <input type="text" size="12" /><img src="../images/btn_calendar.png" class="imgbtn" />
            <select name=""><option value="01">01</option></select>시
            <select name=""><option value="01">01</option></select>분 ~
            <input type="text" size="12" /><img src="../images/btn_calendar.png" class="imgbtn" />
            <select name=""><option value="01">01</option></select>시
            <select name=""><option value="01">01</option></select>분            
            <span class="mg">
                <input type="button" title="1일" value="1일" class="btn" />
                <input type="button" title="2일" value="2일" class="btn" />
                <input type="button" title="3일" value="3일" class="btn" />
            </span>
            
            <div class="searchbtns">           
                <input type="button" title="검색" value="검색" class="btnsearch" />
                <input type="button" title="상세검색" value="상세검색" class="btnsearch gr" />
            </div>               
        </div>
        <!-- 상세검색 -->
        <div class="search detail">
            <p class="type">
            	<span><input name="" type="checkbox" value="" /> 전체</span>
            </p>
            <p class="type">
                <span><input name="" type="checkbox" value="" /> 플레어-양성자현상 통합 예측</span>
                <span><input name="" type="checkbox" value="" /> 양성자현상 통합 예측</span>
                <span><input name="" type="checkbox" value="" /> 지자기지수 통합 예측</span>
                <span><input name="" type="checkbox" value="" /> 자기권계면 예측</span>
                <span><input name="" type="checkbox" value="" /> 전리권</span>
                <span><input name="" type="checkbox" value="" /> 태양풍</span>
                <span><input name="" type="checkbox" value="" /> 방사선대</span>
                <span><input name="" type="checkbox" value="" /> 자기권내 전류 시스템</span>
            </p>
        </div>
    </div>
    
    <!-- 검색결과 시작 -->
    <div class="tab_date">
    	<a href="#" class="on">2013. 09. 01</a>
        <a href="#">2013. 09. 02</a>
        <a href="#">2013. 09. 03</a>
    </div>  
        
    <!-- RESULT LIST TABLE -->
    <div class="hour">
    	<span>시 : </span>
        <a href="#">01</a>
        <a href="#" class="thispage">02</a>
        <a href="#">03</a>
        <a href="#">04</a>
        <a href="#">05</a> 
        <a href="#">06</a>
        <a href="#">07</a>  
        <a href="#">08</a>  
        <a href="#">09</a>  
        <a href="#">10</a>  
        <a href="#">11</a>  
        <a href="#">12</a>  
        <a href="#">13</a>  
        <a href="#">14</a>  
        <a href="#">15</a>  
        <a href="#">16</a>  
        <a href="#">17</a>  
        <a href="#">18</a>  
        <a href="#">19</a>  
        <a href="#">20</a>  
        <a href="#">21</a>  
        <a href="#">22</a>  
        <a href="#">23</a>  
        <a href="#">24</a>
        <div class="inbtn">
            <input type="button" title="리스트로보기" class="btnimg list" />
            <input type="button" title="이미지로보기" class="btnimg img" />       
    	</div> 	
    </div>
    <!-- END PAGER -->
   
    <div class="board_list">
    	<table>
        	<thead>
            	<tr>
                	<th class="min">분</th>
                    <th>플레어-양성자현상 통합 예측</th>
                    <th>양성자현상 통합 예측</th>
                    <th>지자기지수 통합 예측</th>
                    <th>자기권계면 예측</th>
                </tr>
            </thead>
            <tbody>
            	<tr>
                	<th>06</th>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="플레어-양성자현상 통합 예측" alt="플레어-양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="양성자현상 통합 예측" alt="양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="지자기지수 통합 예측" alt="지자기지수 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="자기권계면 예측" alt="자기권계면 예측" /></td>
                </tr>
                <tr>
                	<th>12</th>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="플레어-양성자현상 통합 예측" alt="플레어-양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="양성자현상 통합 예측" alt="양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="지자기지수 통합 예측" alt="지자기지수 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="자기권계면 예측" alt="자기권계면 예측" /></td>
                </tr>
                <tr>
                	<th>18</th>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="플레어-양성자현상 통합 예측" alt="플레어-양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="양성자현상 통합 예측" alt="양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="지자기지수 통합 예측" alt="지자기지수 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="자기권계면 예측" alt="자기권계면 예측" /></td>
                </tr>
                <tr>
                	<th>24</th>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="플레어-양성자현상 통합 예측" alt="플레어-양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="양성자현상 통합 예측" alt="양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="지자기지수 통합 예측" alt="지자기지수 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="자기권계면 예측" alt="자기권계면 예측" /></td>
                </tr>
                <tr>
                	<th>30</th>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="플레어-양성자현상 통합 예측" alt="플레어-양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="양성자현상 통합 예측" alt="양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="지자기지수 통합 예측" alt="지자기지수 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="자기권계면 예측" alt="자기권계면 예측" /></td>
                </tr>
                <tr>
                	<th>36</th>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="플레어-양성자현상 통합 예측" alt="플레어-양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="양성자현상 통합 예측" alt="양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="지자기지수 통합 예측" alt="지자기지수 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="자기권계면 예측" alt="자기권계면 예측" /></td>
                </tr>
                <tr>
                	<th>42</th>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="플레어-양성자현상 통합 예측" alt="플레어-양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="양성자현상 통합 예측" alt="양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="지자기지수 통합 예측" alt="지자기지수 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="자기권계면 예측" alt="자기권계면 예측" /></td>
                </tr>
                <tr>
                	<th>48</th>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="플레어-양성자현상 통합 예측" alt="플레어-양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="양성자현상 통합 예측" alt="양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="지자기지수 통합 예측" alt="지자기지수 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="자기권계면 예측" alt="자기권계면 예측" /></td>
                </tr>
                <tr>
                	<th>54</th>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="플레어-양성자현상 통합 예측" alt="플레어-양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="양성자현상 통합 예측" alt="양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="지자기지수 통합 예측" alt="지자기지수 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="자기권계면 예측" alt="자기권계면 예측" /></td>
                </tr>
                <tr>
                	<th>60</th>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="플레어-양성자현상 통합 예측" alt="플레어-양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="양성자현상 통합 예측" alt="양성자현상 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="지자기지수 통합 예측" alt="지자기지수 통합 예측" /></td>
                    <td><img src="../images/test_graph2.png" class="imgbtn" title="자기권계면 예측" alt="자기권계면 예측" /></td>
                </tr>
            </tbody>        
        </table>
	</div>  
</div>
<!-- END CONTENTS -->

<jsp:include page="../footer.jsp" />

</body>
</html>
