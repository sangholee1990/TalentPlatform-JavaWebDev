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
    height: 2.5em;
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
//-->
</style> 


</head>
<body>
<div id="contents" class="col-sm-12 col-md-12">
	<div class="row">
			<form:form commandName="MD_MetadataForm" action="wmometa_submit.do" method="post" class="form-horizontal" role="form">
 				<div class="onde-panel"></div>
		    </form:form>    
    </div>
</div>
<!-- END CONTENTS -->

<script type="text/javascript" src="<c:url value='/resources/wmo/onde/onde.js' />" ></script>
<script type="text/javascript">

	var schemaRef = null; // Parsed schema
	var schemaText = null; // The schema as provided by the server
	var formElement = $('#MD_MetadataForm');
	
	// wmo meta json schema
	var schemaURL = "<c:url value='/resources/wmo/json/wmo_schema.json' />";

	//wmo meta json data
	var dataURL = "<c:url value='/admin/wmo/wmometa_getmeta.do?metadataseqn=${param.view_metadataseqn}' />";

	//wmo meta code list
	var codeListURL = "<c:url value='/admin/wmo/wmometa_getcodelist.do' />";

	
	// onde view option
	onde.options = {
		view : true,
		seqHidden : true 
	}

	var ondeSession = new onde.Onde(formElement);

	// json data rendering
    function _buildFormImpl(schema, data) {

      if (!schema) {
        return;
      }

      ondeSession.render(schema, data, {
          schemaURL: schemaURL,
          dataURL: dataURL,
          collapsedCollapsibles: true,
          renderFinished: function (element, details) {
              formElement.hide();
              formElement.fadeIn('fast');
          }
      });
    }

	// json data load
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
	            if (dataURL) {
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
    	$.get(dataURL, null, null, 'json').success(function (data) {
    		_buildFormImpl(schemaRef, data);
    	});
    }
    
    function getCodeList(){
    	$.get(codeListURL, null, null, 'json').success(function (data) { 
    		schemaRef.codeList = data;
    		getMetaData();
    	});
    }
 
    

	
	$(function() {
		
		$("#contents :button").click(function() {
			
			switch($(this).attr("id")) {
	
			case "updateBtn":
				$(paramForm).addHidden("mode", "update");
				$(paramForm).attr("action","wmometa_form.do");
				$(paramForm).submit();
				break;
				
			case "deleteBtn":
				if(confirm("삭제하시겠습니까?")) {
					$(paramForm).attr("action","wmometa_delete.do");
					$(paramForm).submit();
				}
				break;
				
			case "listBtn":
				$(paramForm).attr("action","wmometa_list.do");
				$(paramForm).submit();
				break;
			}
			
		});
		
	    if (schemaURL) {
	      buildForm();
	    }
	});

</script>

</body>
</html>
