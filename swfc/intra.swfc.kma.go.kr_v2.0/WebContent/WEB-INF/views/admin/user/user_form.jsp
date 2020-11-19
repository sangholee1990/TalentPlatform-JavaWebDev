<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.UserDTO,org.springframework.util.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%
	UserDTO user = (UserDTO)request.getAttribute("user");

List<String> emailDomainList = new ArrayList<String>();
emailDomainList.add("kma.go.kr");
emailDomainList.add("daum.net");
emailDomainList.add("google.com");
pageContext.setAttribute("emailDomainList", emailDomainList);

String email = user.getEmail();
String emailId = "";
String emailDomain = "";
if(!StringUtils.isEmpty(email)) {
	StringTokenizer tokenizer = new StringTokenizer(email, "@");
	if(tokenizer.countTokens() == 2) {
		emailId = tokenizer.nextToken();
		emailDomain = tokenizer.nextToken();
	}
}
if(StringUtils.isEmpty(emailDomain))
	emailDomain = emailDomainList.get(0);

pageContext.setAttribute("emailId", emailId);
pageContext.setAttribute("emailDomain", emailDomain);

pageContext.setAttribute("IsCommonEmailDomain", user.getUserId() == null || (!StringUtils.isEmpty(emailDomain) && emailDomainList.contains(emailDomain.toLowerCase())));
%>
<!doctype html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />
<style type="text/css">
</style>
</head>
<body>
<div class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	
	<!--  -->
	<div class="row">
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">사용자등록</h4>
			<!-- content area start -->
				
				<form:form commandName="user" action="user_submit.do" method="post" class="form-horizontal" role="form">
					<input type="hidden" name="id" value="${user.id }" />
					<input type="hidden" name="p" value="${param.p}"/>
					<input type="hidden" name="mode" value="${mode}"/>
					<form:errors path="*" cssClass="errorBlock" element="div"/>
					<div class="form-group form-group-sm">
				    	<label for="userId" class="col-sm-2 control-label">아이디</label>
				    	<div class="col-sm-5">
				      		<form:input path="userId" class="form-control" />
				    	</div>
				  	</div>
					<div class="form-group form-group-sm">
				    	<label for="password" class="col-sm-2 control-label">비밀번호</label>
				    	<div class="col-sm-5">
				      		<form:password path="password" class="form-control" />
				    	</div>
				  	</div>
				  	<div class="form-group form-group-sm">
				    	<label for="password_confirm" class="col-sm-2 control-label">비밀번호 확인</label>
				    	<div class="col-sm-5">
				      		<input type="password" id="password_confirm" name="password_confirm" class="form-control" >
				    	</div>
				  	</div>
				  	<div class="form-group form-group-sm">
				    	<label for="name" class="col-sm-2 control-label">이름</label>
				    	<div class="col-sm-5">
				    		<form:input path="name" class="form-control"/><form:errors path="name" cssClass="error"/>
				    	</div>
				  	</div>
				  	<div class="form-group form-group-sm">
				    	<label for="department" class="col-sm-2 control-label">부서</label>
				    	<div class="col-sm-5">
				    		<form:input path="department" class="form-control"/>
				    	</div>
				  	</div>
				  	<div class="form-group form-group-sm">
				    	<label for="position" class="col-sm-2 control-label">직급</label>
				    	<div class="col-sm-5">
				    		<form:input path="position" class="form-control"/>
				    	</div>
				  	</div>
				  	<div class="form-group form-group-sm">
				    	<label for="phone" class="col-sm-2 control-label">전화번호</label>
				    	<div class="col-sm-9">
					    		<form:hidden path="phone"/>
					    		<input id="tel1" name="tel1" type="text" size="3" maxlength="3" value="${tel1}" class="input input-sm"  style="width: 100px;"/>-
					    		<input id="tel2" name="tel2" type="text" size="4" maxlength="4" value="${tel2}" class="input input-sm" style="width: 100px;"/>-
					    		<input id="tel3" name="tel3" type="text" size="4" maxlength="4" value="${tel3}" class="input input-sm" class="form-control" style="width: 100px;"/>                  
				    	</div>
				  	</div>
				  	<div class="form-group form-group-sm">
				    	<label for="email" class="col-sm-2 control-label">이메일</label>
				    	<div class="col-sm-9">
		                	<form:hidden path="email" />
				    		<input id="emailId" type="text" value="${emailId}" class="input input-sm"/>@
				    		<input id="emailDomain" type="text" class="input input-sm" value="${emailDomain}"  <c:if test="${IsCommonEmailDomain}">style="display:none;"</c:if>/>
				    		<select id="emailDomainSelector" class="input input-sm" >
		                	<c:forEach items="${emailDomainList}" var="item" >
		                		<option value="${item}" <c:if test="${item == fn:toLowerCase(emailDomain)}"> selected="selected"</c:if>>${item}</option>
		                	</c:forEach>
		                  	<option value="" <c:if test="${not IsCommonEmailDomain}">selected="selected"</c:if>>직접입력 ::::</option>
		                  </select>              
				    	</div>
				  	</div>
				  	<div class="form-group form-group-sm">
				    	<label for="role" class="col-sm-2 control-label">사용자권한</label>
				    	<div class="col-sm-5">
				    		<form:select path="role" class="form-control">
			                    <option value="">선택하세요 ::::</option>
			                    <form:options items="${roleList}" itemValue="code" itemLabel="code_ko_nm"/>
		                    </form:select>
				    	</div>
				  	</div>
				  	<div class="form-group form-group-sm">
				    	<label for="groupCd" class="col-sm-2 control-label">사용자그룹</label>
				    	<div class="col-sm-5">
				    		<form:select path="groupCd" class="form-control">
			                    <option value="">선택하세요 ::::</option>
			                    <form:options items="${UserGroupList}" itemValue="code" itemLabel="code_ko_nm"/>
		                    </form:select>
				    	</div>
				  	</div>
				  	<div class="form-group ">
					    <div class="col-sm-offset-2 col-sm-9 text-right">
					    	<input type="button" title="등록" value="등록" class="btn btn-default btn-sm" />
	       					<input type="button" title="취소" value="취소" class="btn btn-default btn-sm" />
					    	
					    </div>
				  	</div>
				</form:form>
    
			<!-- content area end -->
			
			 <!-- footer start -->
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />   
		    <!-- footer end -->
		</div>		
	</div>
		
</div>
<jsp:include page="/WEB-INF/views/include/commonJs.jsp" />
<script type="text/javascript">
$(function() {
	//updateEmail();
	
	$("input[type=button]").click(function() {
		switch($(this).val()) {
		case "등록":
			updateEmail();
			$("#user").submit();
			break;
			
		case "취소":
			if(confirm("취소하시겠습니까?")) {
				<c:if test="${not empty param.id}">location.href = "user_view.do?id=${param.id}&p=${param.p}";</c:if>
				<c:if test="${empty param.id}">location.href = "user_list.do?p=${param.p}";</c:if>
			}
			break;
		};
	});
	
	$("#emailDomainSelector").change(function() {
		var selectedValue = $("option:selected", this).val();
		$("#emailDomain").val(selectedValue);
		if(selectedValue == "") {
			$("#emailDomain").show();
			$("#emailDomain").focus();
		} else {
			$("#emailDomain").hide();
		}
	});
	
	$("#user").validate({
		debug: false,
		ignore:"",
		groups: {
			telphone:"tel1 tel2 tel3"
		},
		rules: {
			userId:{
				 required : true,
				 fieldLength : 20,
				 alphanumeric: true
				},
			password: {
				<c:if test="${empty user.userId}">required: true,</c:if>
                minlength: 5
			},
			password_confirm: {
				<c:if test="${empty user.userId}">required: true,</c:if>
                minlength: 5,
                equalTo: "#password"
			},			
			name:{
				 required : true,
				 fieldLength : 50
				},
			department:{
				 required : false,
				 fieldLength : 100
				},
			position:{
				 required : false,
				 fieldLength : 100
				},
			tel1: {
				digits: true,
				required : function() {
					return $("#tel2").val().length > 0 || $("#tel3").val().length > 0; 
				}
			},
			tel2: {
				digits: true,
				required : function() {
					return $("#tel1").val().length > 0 || $("#tel3").val().length > 0; 
				}
			},
			tel3: {
				digits: true,
				required : function() {
					return $("#tel1").val().length > 0 || $("#tel2").val().length > 0; 
				}
			},
			email: {
				required: true,
				email: true,
				alphanumeric: true
			},
			role: {
				required: true
			},
			groupCd: {
				required: true
			}
		},
		messages: {
			userId:{
				required: "아이디를 입력하세요.",
				fieldLength : "아이디는 최대 영문, 숫자를 조합하여 20자 까지 입력가능합니다.",
				alphanumeric : "아이디는 영문, 숫자를 조합하여 입력하세요."
			},
			password:"비밀번호를 입력하세요.",
			password_confirm: {
				required:"비밀번호를 입력하세요.",
				minlength: jQuery.format("최소 {0}자 이상 입력하세요."),
				equalTo: "비밀번호가 일치하지 않습니다."
			},
			name:{
				required: "이름을 입력하세요.",
				fieldLength : "이름은 최대 한글 16자, 영문 50자 까지 입력가능합니다."
			},
			department:{
				 fieldLength : "부서명은 최대 한글 32자, 영문 100자 까지 입력가능합니다."
			},
			position:{
				fieldLength : "직급은 최대 한글 32자, 영문 100자 까지 입력가능합니다."
			},
			email:{
				required: "이메일 주소를 입력하세요.",
				email : "이메일 주소를 확인해 주세요.",
				alphanumeric : "이메일 주소는 영문, 숫자를 조합하여 입력하세요."
			},
			role:"사용자 권한을 선택하세요.",
			groupCd: "사용자 그룹을 선택하세요.",
			tel1: {
				required: "전화번호를 입력하세요",
				digits: "숫자만 입력하세요."
			},
			tel2: {
				required: "전화번호를 입력하세요",
				digits: "숫자만 입력하세요."
			},
			tel3: {
				required: "전화번호를 입력하세요",
				digits: "숫자만 입력하세요."
			}
		},
		errorPlacement: function(error, element) {
		       if (element.attr("name") == "tel1" || element.attr("name") == "tel2" || element.attr("name") == "tel3") 
		        error.insertAfter("#tel3");
		       else 
		        error.insertAfter(element);
		},		
		submitHandler: (function(form) {
			if(confirm("등록하시겠습니까?")) {
				form.submit();
			}
		})
	});
});

function updateEmail() {
	$("#email").val($("#emailId").val() + "@" + $("#emailDomain").val());
}
</script>	
</body>
</html>