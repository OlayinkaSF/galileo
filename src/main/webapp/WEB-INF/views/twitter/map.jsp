<%-- 
    Document   : map
    Created on : Jan 27, 2015, 10:39:20 AM
    Author     : Olayinka
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div id="myMap" style="width: 100%; height: 100%"></div>

<script type="text/javascript" src="/galileo/resources/OpenLayers.js"></script>
<script type="text/javascript"
src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script type="text/javascript">
    $.ajax({
        url: '/galileo/twitter/map/grab',
        success: function (data) {

            var posts = $.parseJSON(data);

            // Create the map using the specified DOM element
            var map = new OpenLayers.Map("myMap");

            var layer = new OpenLayers.Layer.OSM("OpenStreetMap");
            map.addLayer(layer);

            map.addControl(new OpenLayers.Control.LayerSwitcher());
            map.setCenter(new OpenLayers.LonLat(0, 0), 2);

            map.addControl(new OpenLayers.Control.PanZoomBar());



            var markers = new OpenLayers.Layer.Markers("Markers");
            map.addLayer(markers);

            // Create some random markers with random icons
            var icons = [
                "marker-gold.png",
                "marker-green.png"
            ];

            for (var post in posts) {
                // Compute a random icon and lon/lat position.
                var icon = Math.floor(Math.random() * icons.length);
                var px = Math.random() * 360 - 180;
                var py = Math.random() * 170 - 85;

                // Create size, pixel and icon instances
                var size = new OpenLayers.Size(32, 37);
                var offset = new OpenLayers.Pixel(-(size.w / 2), -size.h);
                var icon = new OpenLayers.Icon('/galileo/resources/img/' + icons[icon], size, offset);
                icon.setOpacity(0.6);

                // Create a lonlat instance and transform it to the map projection.
                var lonlat = new OpenLayers.LonLat(px, py);
                lonlat.transform(new OpenLayers.Projection("EPSG:4326"), new OpenLayers.Projection("EPSG:900913"));

                // Add the marker
                var marker = new OpenLayers.Marker(lonlat, icon);

                // Event to handler when the mouse is over
                // Inflate the icon and change its opacity
                marker.events.register("mouseover", marker, function () {
                    this.inflate(1.4);
                    this.setOpacity(1);
                });
                // Event to handler when the mouse is out
                // Inflate the icon and change its opacity
                marker.events.register("mouseout", marker, function () {
                    this.inflate(1 / 1.4);
                    this.setOpacity(0.6);
                });

                markers.addMarker(marker);
            }


        }
    });
</script>























































