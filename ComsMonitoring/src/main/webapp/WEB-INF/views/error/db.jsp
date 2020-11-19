<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	데이터 베이스 에러
	
	Failed URL: ${url}
    Exception:  ${exception.message}
        <c:forEach items="${exception.stackTrace}" var="ste">    ${ste} 
</body>
</html>