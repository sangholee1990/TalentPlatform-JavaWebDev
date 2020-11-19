<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	import="java.util.*,com.gaia3d.web.dto.DomainDataMappingDTO,org.springframework.util.*"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<meta charset="utf-8">
<title>Geographic Bounding Boxes</title>
<style>
#map svg {
  cursor: move;
} 
path {
  fill: none;
  stroke: #000;
}
.background {
  stroke: none;
  fill: #eef;
}
.land {
  stroke-width: .75px;
  pointer-events: all;
}
.graticule {
  stroke: #333;
  stroke-width: .25px;
}
.bounds {
  fill: #94BF8B;
  fill-opacity: .25;
  stroke: #000;
  stroke-width: 1px;
  pointer-events: none;
}
.country:hover .bounds {
  stroke-width: 2px;
}
.country:hover .land {
  stroke-width: 1px;
}
.outline {
  stroke: #000;
  stroke-width: 1.5px;
  fill: none;
}
.antimeridian {
  stroke-dasharray: 5 5;
}

.example path.Polygon {
  fill: url(#hatch);
}
.example text {
  font-size: 11px;
  font-family: sans-serif;
}
</style>


<div id="map"></div>

<script src="<c:url value='/resources/wmo/d3/jquery-2.0.2.min.js' />"></script>
<script src="<c:url value='/resources/wmo/d3/d3.v3.min.js' />"></script>
<script src="<c:url value='/resources/wmo/d3/topojson.v1.min.js' />"></script>
<script>

var width = 600,
    height = width;

/*
var projection = d3.geo.orthographic()
    .translate([width / 2, height / 2])
    .scale(295)
    .clipAngle(90)
    .precision(.1)
    .rotate([0, -30]);
*/    
    
    
var projection = d3.geo.orthographic()
.translate([width / 2, height / 2])
.scale(300)
.clipAngle(90)
.precision(.1)
.rotate([-127, -45, 0]);
//.rotate([-120, -30]);

    // There is a clipping bug, fixed in branch geo-clip-good
    //.rotate([-103.5, -20, 0]);

var path = d3.geo.path()
    .projection(projection);

var graticule = d3.geo.graticule()();

var svg = d3.select("#map").append("svg")
    .attr("width", width)
    .attr("height", height)
    .call(d3.behavior.drag()
      .origin(function() { var rotate = projection.rotate(); return {x: 2 * rotate[0], y: -2 * rotate[1]}; })
      .on("drag", function() {
        projection.rotate([d3.event.x / 2, -d3.event.y / 2, projection.rotate()[2]]);
        svg.selectAll("path").attr("d", path);
      }));

var hatch = svg.append("defs").append("pattern")
    .attr("id", "hatch")
    .attr("patternUnits", "userSpaceOnUse")
    .attr("width", 8)
    .attr("height", 8)
  .append("g");
hatch.append("path").attr("d", "M0,0L8,8");
hatch.append("path").attr("d", "M8,0L0,8");

svg.append("path")
    .datum({type: "Sphere"})
    .attr("class", "background")
    .attr("d", path);

svg.append("path")
    .datum(graticule)
    .attr("class", "graticule")
    .attr("d", path);

svg.append("path")
    .datum({type: "LineString", coordinates: [[180, -90], [180, 0], [180, 90]]})
    .attr("class", "antimeridian")
    .attr("d", path);

svg.append("path")
    .datum({type: "Sphere"})
    .attr("class", "graticule")
    .attr("d", path);


// FUNCTION: Get data and process!
d3.json("<c:url value='/resources/wmo/d3/world-110m.json' />", function(error, world) {
  var country = svg.selectAll(".country")
      .data(topojson.feature(world, world.objects.countries).features)
    .enter().append("g")
      .attr("class", "country");
  country.append("path")
      .attr("class", "land")
      .attr("d", path);

  country.append("path")
 //	  .datum(boundsPolygon(d3.geo.bounds))
      .attr("class", "bounds")
      .attr("d", path);

});




function boundsPolygon(b) {
  return function(geometry) {
    var bounds = b(geometry);
  // START WNES JSON GENERATOR ! #########################################################################################
    var WNES = {}; // MUST declare object var ... = {};
      WNES.id = geometry.id, // ...then add properties successfully!
      // borders' geo-coordinates (decimal degrees)
      WNES.W = bounds[0][0], // Note: D3js is WSEN based.
      WNES.N = bounds[1][1],
      WNES.E = bounds[1][0],
      WNES.S = bounds[0][1],
      // frame's geo-dimensions (decimal degrees)
      WNES.geo_width = (WNES.E - WNES.W), 
      WNES.geo_height= (WNES.N - WNES.S), 
      // center geo-coordinates
      WNES.lat_center = (WNES.S + WNES.N)/2, 
      WNES.lon_center = (WNES.W + WNES.E)/2;
    // add a 5% padding on all WNES sides
    var WNESplus = {};
      WNESplus.W = WNES.W - WNES.geo_width  * 0.05, 
      WNESplus.N = WNES.N + WNES.geo_height * 0.05,
      WNESplus.E = WNES.E + WNES.geo_width  * 0.05,  
      WNESplus.S = WNES.S - WNES.geo_height * 0.05,
      // frame+paddings' (decimal degrees)
      WNESplus.geo_width = (WNESplus.E - WNESplus.W),
      WNESplus.geo_height= (WNESplus.N - WNESplus.S);

    //Degree of precision to keep 4 meaningful digits, ie: 048⁰75 OR 0⁰05'44"6.
    var geo_side_max = Math.abs( Math.max( WNES.geo_width, WNES.geo_height) );
    if      ( geo_side_max < 1000 && geo_side_max >= 100   ) { digits = 1; }
    else if ( geo_side_max < 100  && geo_side_max >= 10    ) { digits = 2; }
    else if ( geo_side_max < 10   && geo_side_max >= 1     ) { digits = 3; }
    else if ( geo_side_max < 1    && geo_side_max >= 0.1   ) { digits = 4; }
    else if ( geo_side_max < 0.1  && geo_side_max >= 0.01  ) { digits = 5; }
    else if ( geo_side_max < 0.01  && geo_side_max >= 0.001) { digits = 6; };

    //PRINT RESULTS (4 meaningful digits): 
    console.log('Bound WNES: "'+ WNES.id +'":{ '
      + '"item":  { "name":"'+ WNES.id +'", "lat_center":'+ WNES.lat_center.toFixed(digits) + ',"lon_center":'+ WNES.lon_center.toFixed(digits) + '},'
      + '"WNES":  { "W":'+  WNES.W.toFixed(digits)     +',"N":' + WNES.N.toFixed(digits)     +',"E":' + WNES.E.toFixed(digits)     +',"S":' + WNES.S.toFixed(digits)     +',"geo_width":' + WNES.geo_width.toFixed(digits)     +',"geo_height":' + WNES.geo_height.toFixed(digits) +'},'
      + '"WNES+": { "W+":'+ WNESplus.W.toFixed(digits) +',"N+":'+ WNESplus.N.toFixed(digits) +',"E+":'+ WNESplus.E.toFixed(digits) +',"S+":'+ WNESplus.S.toFixed(digits) +',"geo_width+":'+ WNESplus.geo_width.toFixed(digits) +',"geo_height+":'+ WNESplus.geo_height.toFixed(digits) +'}'
      + '},');
  // END WNES JSON #########################################################################################################

    if (bounds[0][0] === -180 && bounds[0][1] === -90 && bounds[1][0] === 180 && bounds[1][1] === 90) {
      return {type: "Sphere"};
    }
    if (bounds[0][1] === -90) bounds[0][1] += 1e-6;
    if (bounds[1][1] === 90) bounds[0][1] -= 1e-6;
    if (bounds[0][1] === bounds[1][1]) bounds[1][1] += 1e-6;

    return {
      type: "Polygon",
      coordinates: [
        [bounds[0]]
          .concat(parallel(bounds[1][1], bounds[0][0], bounds[1][0]))
          .concat(parallel(bounds[0][1], bounds[0][0], bounds[1][0]).reverse())
      ]
    };
  };
}

function parallel(φ, λ0, λ1) {
  if (λ0 > λ1) λ1 += 360;
  var dλ = λ1 - λ0,
      step = dλ / Math.ceil(dλ);
  return d3.range(λ0, λ1 + .5 * step, step).map(function(λ) { return [normalise(λ), φ]; });
}

function normalise(x) {
  return (x + 180) % 360 - 180;
}
</script>