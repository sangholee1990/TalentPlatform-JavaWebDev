<%@ tag body-content="scriptless" pageEncoding="utf-8" description="마스터 데이터 수집자료저장형식 코드 변환" trimDirectiveWhitespaces="true"%>
<%@tag import="java.util.*"%>
<%@ attribute name="code" required="false" fragment="false" type="java.lang.String"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String codeNm = "";
	if ( code != null && code != "" ){
		String[] tmpCodes = code.split(",");
	
		for ( int i = 0; i < tmpCodes.length; i++ ) {
			String tmpCode = tmpCodes[i];

			if ( i > 0 ) codeNm += ", ";
			
			if(tmpCode.equals("01")){
				codeNm += "DB";
			}else if ( tmpCode.equals("02") ) {
				codeNm += "자료";	
			}else if ( tmpCode.equals("03")) {
				codeNm += "기타";	
			}
		}
	}
%>
<c:out value="<%=codeNm %>"></c:out>