<%-- 
    Document   : map
    Created on : Jan 27, 2015, 10:39:20 AM
    Author     : Olayinka
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div id="myMap" style="width: 100%; height: 100%"></div>

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


    var MEAN_COUNT = 1000;
    var MAX_LOOP_COUNT = 100;

    var means = new Array();
    var distances = {};
    var clusterContents = new Array();

    function computeDistance(a, b) {
        return Math.sqrt(Math.pow(a.longitude - b.longitude, 2) + Math.pow(a.latitude - b.latitude, 2));
    }
    var clusterSizes = new Array();
    function cluster() {
        var converged = false;
        var dirty = false;
        var distance = 0.0;
        var curMinDistance = 0.0;
        var sumX = new Array();
        var sumY = new Array();

        var cluster = new Array();
        var loopCount = 0;

        while (!converged) {
            dirty = false;
            for (var i = 0; i < posts.length; i = i + 1) {
                curMinDistance = distances[hash(posts[i])];
                for (var j = 0; j < means.length; j = j + 1) {
                    distance = computeDistance(posts[i], means[j]);
                    if (distance < curMinDistance) {
                        dirty = true;
                        curMinDistance = distance;
                        posts[i].cluster = j;
                    }
                }
            }
            if (!dirty) {
                converged = true;
                break;
            }
            for (var i = 0; i < means.length; i = i + 1) {
                sumX[i] = 0;
                sumY[i] = 0;
                clusterSizes[i] = 0;
            }
            for (var i = 0; i < posts.length; i = i + 1) {
                sumX[posts[i].cluster] = sumX[posts[i].cluster] + posts[i].longitude;
                sumY[posts[i].cluster] = sumY[posts[i].cluster] + posts[i].latitude;
                clusterSizes[posts[i].cluster] = clusterSizes[posts[i].cluster] + 1;
            }
            for (var i = 0; i < means.length; i = i + 1) {
                if (clusterSizes[i] != 0) {
                    means[i].longitude = sumX[i] / clusterSizes[i];
                    means[i].latitude = sumY[i] / clusterSizes[i];
                } else {
                    means[i].longitude = Math.random() * 360 - 180;
                    means[i].latitude = Math.random() * 170 - 85;
                }
            }
            loopCount = loopCount + 1;
            if (loopCount > MAX_LOOP_COUNT) {
                converged = true;
            }
        }

        for (var i = 0; i < clusterSizes.length; i++) {
            if (clusterSizes[i] > 0) {
                console.log(i + " " + clusterSizes[i]);
            }
        }

        for (var i = 0; i < posts.length; i = i + 1) {
            clusterContents[posts[i].cluster].push(i);
        }
    }

    function hash(booga) {
        if (booga == undefined)
            return undefined;
        return "point" + booga.longitude + "_" + booga.latitude;
    }

    function reset() {
        means = new Array();
        distances = {};
        clusterContents = new Array();
        for (var i = 0; i < MEAN_COUNT; i = i + 1) {
            mean = {};
            mean.longitude = Math.random() * 360 - 180;
            mean.latitude = Math.random() * 170 - 85;
            means[i] = mean;
            clusterContents[i] = new Array();
        }
        for (var i = 0; i < posts.length; i = i + 1) {
            distances[hash(posts[i])] = 999999999999999999;
        }
    }

    function draw() {
        reset();
        var clusterStart = (new Date()).getTime();
        cluster();
        var clusterDuration = (new Date()).getTime() - clusterStart;
        console.log("Duration: " + clusterDuration);
    }

    function removePopups() {
        var pops = map.popups;
        for (var a = 0; a < pops.length; a++) {
            map.removePopup(map.popups[a]);
        }
    }

    function buildPopUp(key, lonloat) {
        return function (e) {
            removePopups();
            var post = {
                content: posts[clusterContents[key][0]].content,
                cluster: key
            };
            var popup = newPopUp(lonloat, post);
            map.addPopup(popup);
        };
    }



    function placeMark(key) {
        var icon = Math.floor(Math.random() * icons.length);
        var px = means[key].longitude;
        var py = means[key].latitude;
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

            var toReplace = new Array();
            for (var key in posts) {
                if (post.longitude != 0 && post.latitude != 0) {
                    toReplace.push(posts[key]);
                }
            }
            posts = toReplace;
            draw();
            for (var i = 0; i < means.length; i = i + 1) {
                if (clusterSizes[i] > 0) {
                    placeMark(i);
                }
            }


            connect();
        }
    });

</script>

<script src="<c:url value="/resources/sockjs-0.3.4.js" />"></script>
<script src="<c:url value="/resources/stomp.js" />"></script>
<script type="text/javascript">
    var stompClient = null;

    function setConnected(connected) {
    }

    function connect() {
        var socket = new SockJS('<c:url value="/hello" />');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function (frame) {
            setConnected(true);
            console.log('Connected: ' + frame);
            stompClient.subscribe('/app/post/${account.username}', function (greeting) {
                var post = JSON.parse(greeting.body);
                showMessage(post);
            });
        });
    }

    function showMessage(message) {
        if ('name' in message)
            return;
        var curmin = 999999999999999999;
        var mkey = means.length;
        for (var i = 0; i < means.length; i++) {
            var dist = computeDistance(means[i], message);
            if (dist < curmin) {
                curmin = dist;
                mkey = i;
            }
        }
        
        if(clusterSizes[mkey] == 0)
            placeMark(mkey);

        clusterSizes[mkey]++;
        message.cluster = mkey;
        clusterContents[mkey].push(posts.length);
        posts.push(message);
        var lonlat = new OpenLayers.LonLat(message.longitude, message.latitude);
        lonlat.transform(new OpenLayers.Projection("EPSG:4326"), new OpenLayers.Projection("EPSG:900913"));

        var post = {
            content: message.content,
            cluster: mkey
        };
        var popup = newPopUp(lonlat, post);
        map.addPopup(popup);
    }
</script>