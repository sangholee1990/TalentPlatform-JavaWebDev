<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<title><fmt:message key="title" /></title>
	<meta charset="utf-8">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" href="<c:url value="/favicon.ico"/>" type="image/x-icon" >
	<link rel="icon" href="<c:url value="/favicon.ico"/>" type="image/x-icon" >
	<meta name="description" content="">
	<link href="<c:url value='/resources/bootstrap/css/bootstrap.min.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/bootstrap/css/bootstrap-datetimepicker.css'/>" rel="stylesheet">
	<link rel="stylesheet" href="<c:url value="/js/themes/base/jquery-ui.css"/>" />
	<style type="text/css">
	
		div .custom-overflow {  
		    height: 200px !important;
		    width: 768px;
    		overflow: auto;
    		white-space:pre;
		}
		
		.table .text-right {text-align: right}
		.table .text-left {text-align: left}
		.table .text-center {text-align: center}
		
		.table-condensed th {
		    text-align: center;
			width: 170px;
			background-color: #f5f5f5;
			vertical-align: top;
		}

		.table-striped th {
			text-align: center;
		}
		
		.table-striped td {
			text-align: center;
		}
		
		.table-spcf-user th {
			background-color: #f5f5f5;
			text-align: center;
		}
		
		.table-spcf-user .contents {
			width: 45%;
		}
		
		.table-spcf-user td {
			text-align: left;
		}
		
		.table-spcf-user .chkbox {
			width: 10%;
			text-align: center;
		}
		
		footer {			
			height : 25px;
			font-size : 14px;
			text-align : center;
		}
		
		.top-button-group {
			text-align: right;
			margin-bottom: 20px;
		}
		
		.input {
			background-color: #fff;
			background-image: none;
			border: 1px solid #ccc;
			border-radius: 4px;
			-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
			/* box-shadow: inset 0 1px 1px rgba(0,0,0,0.075); */
			/* -webkit-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s; */
			-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
			/* transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s; */
		}

		.left-inner-addon {
		    position: relative;
		}
		.left-inner-addon input {
		    padding-left: 30px;    
		}
		.left-inner-addon i {
		    position: absolute;
		    padding: 10px 12px;
		    pointer-events: none;
		}
		
		.right-inner-addon {
		    position: relative;
		}
		.right-inner-addon input {
		    padding-right: 30px;    
		}
		.right-inner-addon i {
		    position: absolute;
		    right: 0px;
		    padding: 10px 12px;
		    pointer-events: none;
		}
		
		.leftNav>li>a{
			padding: 4px 10px;
		}
		
		footer .bs-footer {
			padding-top: 40px;
			padding-bottom: 40px;
			margin-top: 100px;
			color: #777;
			text-align: center;
			border: 1px solid #e5e5e5;
		}
		
		footer .container{
			padding-right: 15px;
			padding-left: 15px;
			margin-right: auto;
			margin-left: auto;
		}
		
		.bs-footer-links li{
			display: inline;
			padding: 0 2px;
			text-align: -webkit-match-parent;
		}
		
		.bs-footer-links li:FIRST-CHILD {
			padding-left: 0;
		}
		
		/*
	 	* Footer
	 	*/
		.bs-footer {
		  padding-top: 20px;
		  padding-bottom: 30px;
		  margin-top: 100px;
		  color: #777;
		  text-align: center;
		  border-top: 1px solid #e5e5e5;
		  clear: both;
		}
		
	</style>
