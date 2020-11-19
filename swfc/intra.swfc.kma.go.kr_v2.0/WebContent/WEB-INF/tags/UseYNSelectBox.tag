<%@ tag body-content="scriptless" pageEncoding="utf-8" description="ReportType Converter Tag" trimDirectiveWhitespaces="true"%>
<%@ attribute name="pathName" required="true" fragment="false" type="java.lang.String"%>
<%@ attribute name="pathValue" required="false" fragment="false" type="java.lang.String"%>
<%@tag import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<select name="${pathName}" id="${pathName }">
	<option value="Y" >예</option>
	<option value="N">아니오</option>
</select>