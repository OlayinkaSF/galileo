<%-- 
    Document   : map
    Created on : Jan 27, 2015, 10:39:20 AM
    Author     : Olayinka
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div id="myMap" style="width: 100%; height: 100%"></div>


<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script type="text/javascript" src="/galileo/resources/map/OpenLayers.js"></script>
<script type="text/javascript" src="/galileo/resources/map/popup.js"></script>
<s:message code="google.map.key" var="googleMapKey" />

<script type="text/javascript">
    // Create the map using the specified DOM element
    var map = new OpenLayers.Map("myMap");
    
    var posts;

    map.addControl(new OpenLayers.Control.PanZoomBar());

    var layer = new OpenLayers.Layer.OSM("OpenStreetMap");
    map.addLayer(layer);
    map.setCenter(new OpenLayers.LonLat(0, 0), 2);

    var markers = new OpenLayers.Layer.Markers("Markers");
    map.addLayer(markers);

    // Create some random markers with random icons
    var icons = [
        "marker-gold.png",
        "marker-green.png"
    ];

    function removePopups() {
        var pops = map.popups;
        for (var a = 0; a < pops.length; a++) {
            map.removePopup(map.popups[a]);
        }
    }

    function buildPopUp(key, lonloat) {
        var post = posts[key];
        return function (e) {
            removePopups();
            var popup = newPopUp(lonloat, post.content);
            map.addPopup(popup);
        };
    }

    function placeMark(key) {
        var post = posts[key];
        var icon = Math.floor(Math.random() * icons.length);
        var px = post.longitude;
        var py = post.latitude;

        // Create size, pixel and icon instances
        var size = new OpenLayers.Size(15, 15);
        var offset = new OpenLayers.Pixel(-(size.w / 2), -size.h);
        var icon = new OpenLayers.Icon('/galileo/resources/map/img/' + icons[icon], size, offset);
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

        marker.events.register("click", marker, buildPopUp(key, marker.lonlat));

        markers.addMarker(marker);
    }

    function callGoogle(key) {
        var post = posts[key];
        $.ajax({
            url: 'https://maps.googleapis.com/maps/api/geocode/json?address=' + post.place + '&key=${googleMapKey}',
            success: function (position) {
                if (position.status !== "OK") {
                    return;
                }
                var lonlat = position.results[0].geometry.location;
                post.longitude = lonlat.lng;
                post.latitude = lonlat.lat;
                placeMark(key);
                $.ajax({
                    url: '/galileo/place/update',
                    type: "POST",
                    data: {
                        post: JSON.stringify(post)
                    }
                });
            }
        });
    }

    $.ajax({
        url: '/galileo/twitter/map/grab',
        success: function (data) {

            posts = $.parseJSON(data);

            for (var key in posts) {
                var post = posts[key];
                if (post.longitude == 0 && post.latitude == 0) {
                    continue;
                }
                placeMark(key);
            }

            for (var key in posts) {
                // Compute a random icon and lon/lat position.
                var icon = Math.floor(Math.random() * icons.length);
                var px = Math.random() * 360 - 180;
                var py = Math.random() * 170 - 85;

                var post = posts[key];

                if (post.longitude != 0 && post.latitude != 0) {
                    continue;
                }

                callGoogle(key);
            }
        }
    });

</script>
