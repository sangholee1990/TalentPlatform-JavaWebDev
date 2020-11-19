<%@ tag body-content="scriptless" pageEncoding="utf-8" description="ReportType Converter Tag" trimDirectiveWhitespaces="true"%>
<%@ attribute name="path" required="false" fragment="false" type="java.lang.String"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String param = path;
	if(param != null){
		param = param.replaceAll("/", "-");
		if(param.startsWith("-")){
			param = param.substring(param.indexOf("-") + 1);
			param = param.substring(0, param.lastIndexOf("-") ) + "&hour=";
			param += path.substring(path.lastIndexOf("/") + 1 );
		}
	}
%>
<c:out value="<%=param %>"></c:out> 
