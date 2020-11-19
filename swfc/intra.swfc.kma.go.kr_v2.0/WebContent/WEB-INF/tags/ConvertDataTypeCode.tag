<%@ tag body-content="scriptless" pageEncoding="utf-8" description="마스터 데이터 수집자료형식 코드 변환" trimDirectiveWhitespaces="true"%>
<%@tag import="java.util.*"%>
<%@ attribute name="code" required="false" fragment="false" type="java.lang.String"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String codeNm = "";
	if ( code != null && code != "" ){
		if(code.equals("01")){
			codeNm = "수집자료 ( txt, dat, png, jpeg, gif ...)";	
		}else if ( code.equals("02") ) {
			codeNm = "수집자료 프로그램";	
		}else if ( code.equals("03")) {
			codeNm = "예측모델 프로그램";	
		}else if ( code.equals("04")) {
			codeNm = "산출물";	
		}else if ( code.equals("05")) {
			codeNm = "기타";	
		}
	}
%>
<c:out value="<%=codeNm %>"></c:out>