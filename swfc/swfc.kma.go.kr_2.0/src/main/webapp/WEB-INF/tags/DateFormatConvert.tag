<%@ tag body-content="scriptless" pageEncoding="utf-8" description="String date time format Converter Tag" trimDirectiveWhitespaces="true"%>
<%@tag import="java.util.*"%>
<%@ attribute name="strDate" required="false" fragment="false" type="java.lang.String"%>
<%@ attribute name="strTime" required="false" fragment="false" type="java.lang.String"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%

String result = strDate + " " + strTime; 
try{
if(strDate == null || strDate == "" ){
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
	strDate = sdf.format(new Date());
}

if ( strTime == null || strTime == "" ) {
	strTime = "1200";	
}

String tmpDatetime = strDate + strTime;

java.text.SimpleDateFormat srcSdf = new java.text.SimpleDateFormat("yyyyMMddHHmm");
Date datetime = srcSdf.parse(tmpDatetime); 

java.text.SimpleDateFormat toSdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");

	result = toSdf.format(datetime);
}catch(Exception e){ }

%>
<c:out value="<%=result %>"></c:out> 