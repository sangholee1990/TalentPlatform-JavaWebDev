 <%@ tag body-content="scriptless" pageEncoding="utf-8" description="ReportType Converter Tag" trimDirectiveWhitespaces="true"%>
 <%@ attribute name="useYN" required="true" fragment="false" type="java.lang.String"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
${useYN == 'Y' ? "예" : "아니오"}