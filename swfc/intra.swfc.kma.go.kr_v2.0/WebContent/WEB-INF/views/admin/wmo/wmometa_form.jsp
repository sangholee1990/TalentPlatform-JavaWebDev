<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.DomainDataMappingDTO,org.springframework.util.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!doctype html>
<html lang="ko">
<head>

<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />


	<link rel="stylesheet" href="<c:url value='/resources/wmo/assets/normalize.css'/>" type="text/css" />
    <link rel="stylesheet" href="<c:url value='/resources/wmo/onde.css'/>" type="text/css" />
    <link rel="stylesheet" href="<c:url value='/resources/wmo/assets/app.css'/>" type="text/css" />
    
    
<style type="text/css">
<!--

.onde-panel, .onde-panel td {
    font-family: "Helvetica Neue", "Helvetica", Verdana, sans-serif;
    font-size: 13px;
    line-height: 120%;
}

.onde-panel input[type=text],
.onde-panel textarea {
    border: none;
    margin: 0;
    padding: 2px 5px;
    border: 1px solid;
    border-color: #848484 #c1c1c1 #e1e1e1;
}
.onde-panel select {
/*    padding: 2px 2px 2px 5px;
    border: 1px solid;
    border-color: #848484 #c1c1c1 #e1e1e1; */
    border: 1px solid #c1c1c1;
    background-color: #ffffff;
}

.onde-panel a {
/*    color: #00970b; */
    color: #999;
}
.onde-panel {
/*    background-color: #e0e0e0;
    padding: 1px; */
    border-bottom: 1px solid #d9d9d9;
    border-right: 1px solid #d9d9d9;
}
.onde-panel .field .value input[type=text].value-input,
.onde-panel .field .value textarea.value-input {
/*    box-sizing: border-box; */
    width: 24em;
    border: none;
    margin: 0;
    padding: 2px 5px;
    border: 1px solid;
    border-color: #848484 #c1c1c1 #e1e1e1;
/*    font-size: 1.17em; */
}
.onde-panel .field .value textarea.value-input {
/*    height: 2.5em; */
    height: 85px;
    vertical-align: top;
}
.onde-panel .field.number .value input[type=text].value-input,
.onde-panel .field.integer .value input[type=text].value-input {
    font-family: Courier, "Courier New", monospace;
    width: 8em;
}
.onde-panel .field.object .value,
.onde-panel .field.array .value {
    color: #666;
}

.onde-panel .field-name {
    padding: 0 16px;
    display: inline-block;
    min-width: 200px;
    /*TODO: Vertical align */
    font-weight: bold;
}

.onde-panel .collapsible {
}


.onde-panel .collapsible-panel {
    padding-bottom: 3px;
}
.onde-panel .field-name.collapser {
    background-image: url( "<c:url value='/resources/wmo/onde/treeDownTriangleBlack.png' />");
    background-repeat: no-repeat;
    background-position: 5px 8px;
/*    background-color: #f3f3f3; */
/*    display: block; */
    padding-top: 4px;
    padding-bottom: 4px;
    cursor: pointer;
/*    min-width: 180px; */
    min-width: 0;
    border-bottom: 1px solid #e6e6e6;
    margin-bottom: 2px;
}
.onde-panel .field-name.array-index {
/*    min-width: 10px; */
    min-width: 23px;
    padding-right: 0;
}
.onde-panel .field-name.array-index.collapser {
/*    min-width: 80px; */
}
.onde-panel .field-name.collapser.collapsed {
    background-image: url("<c:url value='/resources/wmo/onde/treeRightTriangleBlack.png' />");
    border-bottom: none;
    margin-bottom: 0;
}
.onde-panel .required-marker {
    color: #ff3333;
}
.onde-panel input[type=text].field-key-input {
	width: auto;
}
.onde-panel ul,
.onde-panel ol {
/*    list-style: none; */
    margin: 0;
    padding: 0;
    border-bottom: 1px solid #d9d9d9;
    background-color: #f3f3f3;
}
.onde-panel label.field-name { color: #4f4f4f;/* color: #333; background-color: #fff; border-top-left-radius: 4px; */}
.onde-panel label.field-name.collapser { display: block !important; background-color: #fff;/* margin-bottom: 2px; */}
.onde-panel .field.primary > label.field-name { text-decoration: underline; }
.onde-panel ul {
    list-style: none;
}
.onde-panel ol {
/*    list-style-position: inside; */
}
.onde-panel ol li.array-item {
/*    padding-left: 20px; */
}
.onde-panel li.field {
    background-color: #fff;
    border-left: 1px solid #d9d9d9;
/*    background-color: #f3f3f3; */
    border-top: 1px solid #d9d9d9;
/*    margin-top: 1px;
    margin-bottom: 1px; */
    padding-top: 3px;
    padding-bottom: 3px;
/*    border-top-left-radius: 4px; */
}
.onde-panel li ul,
.onde-panel li ol,
.onde-panel li div.edit-bar {
    margin-left: 39px;
}
.onde-panel li div.edit-bar {
    margin: 0 0 0 39px;
    padding: 2px 7px;
    color: #999;
/*    border-top: 1px solid #d9d9d9;
    border-top: 1px solid #e3e3e3; */
    border-left: 1px solid #d9d9d9;
    border-bottom: 1px solid #d9d9d9;
    background-color: #f7f7f7;
}


.onde-panel li {
}

.onde-panel li.field.object,
.onde-panel li.field.array {
    background: none;
    padding-top: 0;
    padding-bottom: 0;
}


.onde-panel li ul.inline {
    margin: 0;
    display: inline-block;
    padding-left: 0;
}


.onde-panel small.description {
    vertical-align: top;
    width: 320px;
    margin-left: 30px;
    margin-right: 10px;
    color: #aaa;
    display: inline-block;
    font-weight: normal;
}


.onde-panel .inline li {
    display: inline;
}


.onde-panel .inline li .field-name {
    text-align: right;
}

.onde-panel button.field-add {
    /*TODO: cross-browser */
  -webkit-border-radius: 2px;
  -moz-border-radius: 2px;
  border-radius: 2px;
  -webkit-box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.1);
  -moz-box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.1);
  box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.1);
  -webkit-user-select: none;
  -moz-user-select: none;
  user-select: none;
  background: #fafafa; /* for non-css3 browsers */
  border: 1px solid #afafaf;
  color: #444;
  font-size: inherit;
  margin-bottom: 0px;
  min-width: 4em;
  padding: 2px 12px 2px 12px;;
}

.onde-panel button.field-add:hover {
  -webkit-box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.2);
  -moz-box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.2);
  background-color: #ffffff;
  border-color: #999;
  color: #222;
}

.onde-panel button.field-add:active {
  -webkit-box-shadow: inset 0px 1px 3px rgba(0, 0, 0, 0.2);
  -moz-box-shadow: inset 0px 1px 3px rgba(0, 0, 0, 0.2);
  background-color: #ebebeb;
  color: #333;
}
.onde-panel button.field-delete {
    border: none;
    outline: none;
    margin: 0;
    padding: 0;
    background-color: #ffffff;
/*    color: #e70000; */

    color: transparent;
    display: inline-block;
    overflow: hidden;
    width: 16px;
    height: 16px;
    background-image: url("<c:url value='/resources/wmo/onde/delete.png' />");
/*    padding-left: 10px; */
}
.onde-panel button.field-delete:hover {
/*    color: #e70000; */
    color: transparent;
    background-position: 32px 0;
}
.onde-panel button.field-delete:active {
    background-position: 16px 0;
}

.onde-panel th, .onde-panel td {
    padding: 0 1em;
}

.onde-panel .field.error,
.onde-panel .field.error > label.field-name.collapser {
    background-color: #ffe6df;
}

	.alert-box {
		color:#555;
		border-radius:10px;
		font-family:Tahoma,Geneva,Arial,sans-serif;font-size:11px;
		padding:10px 36px;
		margin:10px;
		position:relative;
	}
	.alert-box span {
		font-weight:bold;
		text-transform:uppercase;
	}
	.error {
		background:#ffecec url("<c:url value='/resources/wmo/onde/error.png'/>") no-repeat 10px 50%;
		border:1px solid #f5aca6;
	}
	.success {
		background:#e9ffd9 url("<c:url value='/resources/wmo/onde/success.png'/>") no-repeat 10px 50%;
		border:1px solid #a6ca8a;
	}
	.warning {
		background:#fff8c4 url("<c:url value='/resources/wmo/onde/warning.png'/>") no-repeat 10px 50%;
		border:1px solid #f2c779;
	}
	.notice {
		background:#e3f7fc url("<c:url value='/resources/wmo/onde/notice.png'/>") no-repeat 10px 50%;
		border:1px solid #8ed9f6;
	}


//-->
</style>    


</head>
<body>
<div id="contents" class="container">
	<jsp:include page="/WEB-INF/views/include/adminTopMenu.jsp" />
	
	<!--  -->
	<div class="row">
		
		<jsp:include page="/WEB-INF/views/include/adminLeftMenu.jsp" />	
		<div class="col-sm-10 col-md-10">
			<h4 class="page-header">WMO Meta 정보</h4>
			<!-- content area start -->
	
			<form:form commandName="MD_MetadataForm" action="wmometa_submit.do" method="post" class="form-horizontal" role="form">
				<input type="hidden" name="mode" value="${mode}"/>
				<input type="hidden" name="view_metadataseqn" id="view_metadataseqn" value="${param.view_dta_knd_inside_seq_n}"/>
				<form:errors path="*" cssClass="errorBlock" element="div"/>
			 
			 
			 	<div class="form-group form-group-sm">
					<div class="col-sm-12 text-right">
						<c:if test="${mode eq 'new' }">
				        <button type="button" value="saveBtn" class="btn btn-default" >등록</button>
				        </c:if>
						<c:if test="${mode eq 'update' }">
				        <button type="button" value="saveBtn" class="btn btn-default" >수정</button>
				        </c:if>
				        
				        <button type="button" value="cancelBtn" class="btn btn-default" >취소</button>
			        </div>
			    </div> 
			    
 				<div class="onde-panel"></div>
 			
 				<br />
     			<div class="form-group form-group-sm">
					<div class="col-sm-12 text-right">
						<c:if test="${mode eq 'new' }">
				        <button type="button" value="saveBtn" class="btn btn-default" >등록</button>
				        </c:if>
						<c:if test="${mode eq 'update' }">
				        <button type="button" value="saveBtn" class="btn btn-default" >수정</button>
				        </c:if>
				        
				        <button type="button" value="cancelBtn" class="btn btn-default" >취소</button>
			        </div>
			    </div> 
		    </form:form>   
		    <div style="display: none;">
		    <textarea id="testjson" rows="10" cols="100"></textarea> 
		    </div>
		    
		    <jsp:include page="/WEB-INF/views/include/commonFooter.jsp" />
       </div>
    </div>
</div>
<!-- END CONTENTS -->



<script type="text/javascript" src="<c:url value="/js/jquery-1.10.2.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery-ui.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.validate.min.js"/>"></script>
<script src="<c:url value="/resources/bootstrap/js/bootstrap.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap/js/moment.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap/js/bootstrap-datetimepicker.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap/js/bootstrap-datetimepicker.ko.js"/>"></script>
<script src="<c:url value="/js/menu.js"/>"></script>

<script type="text/javascript" src="<c:url value='/resources/wmo/onde/assets/jquery-1.7.1.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/resources/wmo/onde/assets/yaml-82eb5375dc.min.js' />"></script>

<script type="text/javascript" src="<c:url value='/resources/wmo/onde/onde_reg.js' />" ></script>

<script type="text/javascript">

var mode = "${param.mode}";

var schemaRef = null; // Parsed schema
var schemaText = null; // The schema as provided by the server

// wmo meta json schema
var schemaURL = "<c:url value='/resources/wmo/json/wmo_schema.json' />";


//wmo meta json data
var dataURL = "wmometa_getmeta.do?metadataseqn=${param.view_metadataseqn}";

//wmo meta code list
var codeListURL = "<c:url value='/admin/wmo/wmometa_getcodelist.do' />";




var formElement = $('#MD_MetadataForm');

onde.options = {
		view : false,
		seqHidden : true 
}

var ondeSession = new onde.Onde(formElement);

	function getHashParameterByName(name, defval)
	{
	  name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
	  var hash = window.location.hash || '#';
	  var hash_parts = hash.split('?', 2);
	  if (hash_parts.length != 2) {
	    return defval;
	  }
	  var regex = new RegExp("&?" + name + "=([^&#]*)");
	  var results = regex.exec(hash_parts[1]);
	  if(results == null)
	    return defval;
	  else
	    return decodeURIComponent(results[1].replace(/\+/g, " "));
	}


    
    function _buildFormImpl(schema, data) {
      if (!schema) {
        return;
      }
      //$('#data-entry-description').text('Rendering form...');
      //setPageMainTitle(schema.name || schemaURL || 'Untitled Schema');
      ondeSession.render(schema, data, {
          schemaURL: schemaURL,
          dataURL: dataURL,
          collapsedCollapsibles: true,
          renderFinished: function (element, details) {
              formElement.hide();
              formElement.fadeIn('fast');
              if (schema.description) {
                  //$('#data-entry-description').text(schema.description);
              } else {
                  //$('#data-entry-description').hide();
              }
          }
      });
    }

    function buildForm() {
        if (!schemaURL) {
            return false;
        }
        schemaText = null;
        schemaRef = null;
        formElement.find('.onde-panel').empty();
        formElement.hide();
        $.get(schemaURL, null, null, 'json')
          .success(function (schema, textStatus, jqxhr) {
            if (typeof schema == 'object') {
              schemaText = jqxhr.responseText;
              schemaRef = schema;
            } else {
              schemaText = schema;
              //TODO: Guard parse error
              schemaRef = JSON.parse(schemaText);
            }
            
            if ( codeListURL ){
            	getCodeList();
            }else{
	            if (mode == "update") {
	            	getMetaData();
	            } else {
	              _buildFormImpl(schemaRef, dataEdit);
	            }
            }
          })
          .error(function (jqxhr, textStatus, errorThrown) {
            alert("Schema loading failed: " + errorThrown);
          });
        return true;
    }

    
    function getMetaData(){
    	 if (mode == "update") {
         	$.get(dataURL, null, null, 'json').success(function (data) { 
         		dataEdit = data;
        		_buildFormImpl(schemaRef, dataEdit);
        	});
         	
         } else {
           _buildFormImpl(schemaRef, dataEdit);
         }
    }
    
    function getCodeList(){
    	$.get(codeListURL, null, null, 'json').success(function (data) { 
    		schemaRef.codeList = data;
    		getMetaData();
    	});
    }
 
    
$(function() {
	
	$("#contents :button").click(function() {
		
		switch($(this).val()) {
		case "saveBtn":
			$("#MD_MetadataForm").submit();
			break;
			
		case "cancelBtn":
			
				//수정
				<c:if test="${mode eq 'update' }">
					$(paramForm).attr("action", "wmometa_view.do");
				</c:if>

				//등록
				<c:if test="${mode eq 'new' }">
					$(paramForm).attr("action", "wmometa_list.do");
				</c:if>

				$(paramForm).submit();
				
			break;
		};
	});
	
	
	
	   // Listen to form submit
    formElement.submit(function (evt) {
    	
    	
    	//등록
		<c:if test="${mode eq 'new' }">
			var messageStr = "등록하시겠습니까?";
		</c:if>
	
		//수정
		<c:if test="${mode eq 'update' }">
			var messageStr = "수정하시겠습니까?";
		</c:if>
		
		if(confirm(messageStr)) {
			
        evt.preventDefault();
        var outData = ondeSession.getData();
        
        if (outData.errorCount) {
        	 _data = JSON.stringify(outData.data, null, "  "); //jsonObject로 변환 
             $("#testjson").val(_data);
        	 
            alert("입력값 체크 결과 " + outData.errorCount + "군데의 오류가 발견되었습니다.");
            console.log(outData);
        } else {
            _url = "wmometa_submit.do?mode=new";
            _data = JSON.stringify(outData.data, null, "  "); //jsonObject로 변환 
           
            $("#testjson").val(_data);
            $.ajax({
            	  type : 'POST',
            	  url : _url,
            	  cache: false,
            	  dataType: "json",
            	  data: _data,
            	  processData: false,
            	  contentType: "application/json; charset=utf-8", 
            	  success : function(data, status){
            	      console.log("status:"+status+","+"data:"+data);
            	      
            	      if ( status == "success"){
            	    	  /*
            	    	onde.options = {
            	    				view : false,
            	    				seqHidden : false 
            	    		}
            	      	_buildFormImpl(schemaRef, data);
            	    	  */
            	      	location.href="wmometa_view.do?view_metadataseqn=" + data.metadataseqn;
            	      }
            	  },
            	  error: function(request, status, error){
            	      alert("loading error:" + request.status);
            	      console.log("code : " +  request.statusText  + "\r\nmessage : " + request.responseText);
            	  
            	 }
            });
            
        }
        
		}
        return false;
    });
    
    if (schemaURL) {
      buildForm();
    }
    
    
    
});


//Form parameter append
jQuery.fn.addHidden = function (name, value) {
    return this.each(function () {
    	if ( $(this).find('input[name*="' + name + '"]').length < 1  && value != "" ) {
	        var input = $("<input>").attr("type", "hidden").attr("name", name).attr("id", name).val(value);
	        $(this).append($(input));
	    }else if ( value != "" ){
	    	$("input[name='" + name + "']").val(value);
	    }
    });
}

//파라메터 폼 생성
var paramForm ;
$(function() {
	//파라메터 폼 생성
	paramForm = document.createElement("form");
	$(paramForm).attr("method", "post");
	<c:forEach var="pageParameter" items="${param}">

		<c:if test="${fn:startsWith(pageParameter.key, 'search_')}">
			$(paramForm).addHidden("<c:out value="${pageParameter.key}" />", "<c:out value="${pageParameter.value}" />");
		</c:if>
		
		<c:if test="${fn:startsWith(pageParameter.key, 'view_')}">
			$(paramForm).addHidden("<c:out value="${pageParameter.key}" />", "<c:out value="${pageParameter.value}" />");
		</c:if>
		
		<c:if test="${pageParameter.key eq 'iPage'}">
			$(paramForm).addHidden("<c:out value="${pageParameter.key}" />", "<c:out value="${pageParameter.value}" />");
		</c:if>
		
		<c:if test="${pageParameter.key eq 'iPageSize'}">
			$(paramForm).addHidden("<c:out value="${pageParameter.key}" />", "<c:out value="${pageParameter.value}" />");
		</c:if>
	</c:forEach>
	document.body.appendChild(paramForm);

	if ( $(paramForm).find("input[id='iPage']").length == 0 )
		$(paramForm).addHidden("iPage","1");
});

//필수 입력 항목의 입력폼 생성용
var dataEdit = {
		  "fileidentifier": "",
		  "contact": [
		              {
		                "role": "001"
		              }
		            ],
		  "datestamp": "",
		  "metadatamaintenance": {
		    "maintenanceandupdatefrequency": ""
		  },
		  "identificationinfo": [
		    {
		      "citation": [
		        {
		          "title": "",
		          "dates": [
		            {
		              "dates": "",
		              "datetype": ""
		            }
		          ]
		        }
		      ],
		      "abstract": "",
		      "language": "",
		      "topiccategory": "",
		      "descriptivekeywords": [
		        {
		          "keyword": "",
		          "thesaurusname": {
		            "title": "",
		            "dates": [
		              {
		                "dates": "",
		                "datetype": ""
		              }
		            ]
		          }
		        }
		      ],
		      "extent": [
		        {
		          "geographicelement": []
		        }
		      ]
		    }
		  ]
		};
/*
{
		              "@type": "EX_GeographicDescription",
		              "g_type": "2",
		              "geographicidentifier": {
		                "authority": {
		                  "role": ""
		                },
		                "code": ""
		              }
}
		              */
		              
		              
var dataEdit2 =		              {
		            	  "fileidentifier": "urn:x-wmo:md:int.wmo.wis::SZCI01BABJ",
		            	  "language": "eng",
		            	  "hierarchylevel": "dataset",
		            	  "hierarchylevelname": ">GTS>By Type>Observations>From sea station>Others",
		            	  "contact": [
		            	    {
		            	      "individualname": "ZhuTing",
		            	      "organisationname": "China Meteorological Administration",
		            	      "positionname": "Telecommunication Division",
		            	      "contactinfo": [
		            	        {
		            	          "phone": [
		            	            {
		            	              "voice": "86-10-68406710"
		            	            }
		            	          ],
		            	          "address": [
		            	            {
		            	              "deliverypoint": "46 Zhongguancun Nandajie",
		            	              "city": "Beijing ( 100081 )",
		            	              "country": "China",
		            	              "electronicmailaddress": "zhuting@cma.gov.cn"
		            	            }
		            	          ]
		            	        }
		            	      ],
		            	      "role": "007"
		            	    }
		            	  ],
		            	  "datestamp": "2014-09-09T00:00:00Z",
		            	  "metadatastandardname": "ISO 19115-2 Geographic information - Metadata - Part 2: Extensions for imagery and gridded data",
		            	  "metadatastandardversion": "ISO 19115-2:2009-02-15",
		            	  "metadatamaintenance": {
		            	    "maintenanceandupdatefrequency": "009",
		            	    "userdefinedmaintenancefrequency": "This metadata record was created automatically by CMA Metadata Generator."
		            	  },
		            	  "identificationinfo": [
		            	    {
		            	      "citation": [
		            	        {
		            	          "title": "GTS-bulletin:SZCI01. Tidal elevation observations available from BABJ(PEKING (BEIJING)).",
		            	          "dates": [
		            	            {
		            	              "dates": "2014-09-10T00:00:00Z",
		            	              "datetype": "publication"
		            	            }
		            	          ],
		            	          "identifier": [
		            	            {
		            	              "authority": {
		            	                "role": "001"
		            	              },
		            	              "code": "urn:x-wmo:md:int.wmo.wis::SZCI01BABJ"
		            	            }
		            	          ],
		            	          "presentationform": "documentDigital"
		            	        }
		            	      ],
		            	      "abstract": "GTS-bulletin: SZCI01. Referring to WMO No.386 - Manual on the GTS, Data Designator 'TTAAii' decodes as follow: T1(S): Surface data; T1T2(SZ): Sea level data and deep-ocean tsuna",
		            	      "pointofcontact": [
		            	        {
		            	          "individualname": "Li Xiang",
		            	          "organisationname": "China Meteorological Administration",
		            	          "contactinfo": [
		            	            {
		            	              "phone": [
		            	                {
		            	                  "voice": "86-10-68406275"
		            	                }
		            	              ],
		            	              "address": [
		            	                {
		            	                  "deliverypoint": "46 Zhongguancun Nandajie",
		            	                  "city": "Beijing ( 100081 )",
		            	                  "country": "China",
		            	                  "electronicmailaddress": "lixiang@cma.gov.cn"
		            	                }
		            	              ],
		            	              "onlineresource": [
		            	                {
		            	                  "linkage": "http://wis.wmo.int http://wis.wmo.int"
		            	                }
		            	              ]
		            	            }
		            	          ],
		            	          "role": "006"
		            	        }
		            	      ],
		            	      "language": "eng",
		            	      "topiccategory": "(oceans)",
		            	      "resourcemaintenance": [
		            	        {
		            	          "maintenanceandupdatefrequency": "001",
		            	          "updatescope": "005"
		            	        }
		            	      ],
		            	      "descriptivekeywords": [
		            	        {
		            	          "keyword": "nil (Reason:withheld)",
		            	          "type": "005",
		            	          "thesaurusname": {
		            	            "title": "A codelist for theme keywords",
		            	            "dates": [
		            	              {
		            	                "dates": "nil (Reason:unknown)"
		            	              }
		            	            ]
		            	          }
		            	        },
		            	        {
		            	          "keyword": "CHINA / CHINE",
		            	          "type": "002",
		            	          "thesaurusname": {
		            	            "title": "TIDE STATION",
		            	            "dates": [
		            	              {
		            	                "dates": "nil (Reason:unknown)"
		            	              }
		            	            ]
		            	          }
		            	        },
		            	        {
		            	          "keyword": "11745, Xisha, LAT:16.83N, LON:112.33E, ELE:0M",
		            	          "type": "002",
		            	          "thesaurusname": {
		            	            "title": "nil (Reason:unknown)",
		            	            "dates": [
		            	              {
		            	                "dates": "TIDE STATION"
		            	              }
		            	            ]
		            	          }
		            	        },
		            	        {
		            	          "keyword": "1-minute",
		            	          "type": "004"
		            	        }
		            	      ],
		            	      "extent": [
		            	        {
		            	          "geographicelement": [
		            	            {
		            	              "@type": "EX_GeographicBoundingBox",
		            	              "westboundlongitude": 110.82,
		            	              "eastboundlongitude": 113.88,
		            	              "southboundlatitude": 9.5,
		            	              "northboundlatitude": 22.47
		            	            }
		            	          ]
		            	        }
		            	      ],
		            	      "resourceconstraints": [
		            	        {
		            	          "uselimitation": "otherRestrictions"
		            	        }
		            	      ]
		            	    }
		            	  ],
		            	  "distributioninfo": {
		            	    "distributor": [
		            	      {
		            	        "distributorcontact": {
		            	          "individualname": "Li Xiang",
		            	          "organisationname": "RTH Beijing - China Meteorological Administration(CMA)",
		            	          "contactinfo": [
		            	            {
		            	              "address": [
		            	                {
		            	                  "deliverypoint": "46 Zhongguancun Nandajie",
		            	                  "city": "Beijing ( 100081 )",
		            	                  "country": "CHINA",
		            	                  "electronicmailaddress": "lixiang@cma.gov.cn"
		            	                }
		            	              ]
		            	            }
		            	          ],
		            	          "role": "007"
		            	        },
		            	        "distributortransferoptions": [
		            	          {
		            	            "onlines": [
		            	              {
		            	                "linkage": "http://wisportal.cma.gov.cn/wis/jsp/DataQuery/dataOrderTree.jsp?M_PID=urn:x-wmo:md:int.wmo.wis::SZCI01BABJ",
		            	                "protocol": "WWW:LINK-1.0-http-link",
		            	                "name": "GISC Beijing",
		            	                "description": "SZCI01 bulletin from BABJ(PEKING (BEIJING)) is available at GISC Beijing."
		            	              }
		            	            ]
		            	          }
		            	        ]
		            	      }
		            	    ]
		            	  },
		            	  "dataqualityinfo": [
		            	    {
		            	      "scope": {
		            	        "levels": "dataset"
		            	      },
		            	      "lineage": {
		            	        "statement": "Initial quality control according to the procedures of observation."
		            	      }
		            	    }
		            	  ]
		            	}		            
</script>

</body>
</html>
