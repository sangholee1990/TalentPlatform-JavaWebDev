<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<html>
<head>
<jsp:include page="../include/jquery.jsp" />
<script type="text/javascript"  src="../js/dygraph-combined.js"></script>
<script type="text/javascript">
$(function() {
	darwGraph("ACE__02001", "ACE__02001");
	darwGraph("ACE__02002", "ACE__02002");
	darwGraph("ACE__02003", "ACE__02003");
	darwGraph("ACE__02004", "ACE__02004");
});

function darwGraph(id, type) {
	$.getJSON( "chartData.do?type=" + type, function( data ) {
		var items = [];
		var labels = [];
		for(var label in data[0]) {
			labels.push(label);
		}
		
		$.each(data, function(key,val) {
			var item = [];
			var m = val.tm.match(/(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})/);
			//item.push(new Date(m[1], m[2], m[3], m[4], m[5], m[6]), val.s, val.bx, val.by, val.bz, val.bt, val.lat, val.lon);
			item.push(new Date(m[1], m[2], m[3], m[4], m[5], m[6]));
			for(var itemKey in val) {
				if(itemKey == "tm")
					continue;
				item.push(val[itemKey]);
			}
			items.push(item);
		});
		
		g = new Dygraph(
			    document.getElementById(id),
			    items,
			    {
			    	labels:labels,
			    }
		);
	});
}

</script>
</head>
<body>
<div id="ACE__02001" style="width:100%;"></div><br/>
<div id="ACE__02002" style="width:100%;"></div>
<div id="ACE__02003" style="width:100%;"></div>
<div id="ACE__02004" style="width:100%;"></div>
</body>
</html>