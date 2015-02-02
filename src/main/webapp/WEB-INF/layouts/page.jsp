<?xml version="1.0" encoding="UTF-8" ?>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page session="false" %>
<html>
    <head>

        <title>Polymer, The Rock!</title>
        <meta name="viewport"
              content="width=device-width, minimum-scale=1.0, initial-scale=1.0, user-scalable=yes" />
        <script src="https://cdn.rawgit.com/OlayinkaSF/olayinkasf.github.io/master/polymer/components/webcomponentsjs/webcomponents.js">
        </script>
        <link rel="stylesheet" href="<c:url value="/resources/page.css" />" type="text/css" media="screen" />
        <link rel="stylesheet" href="<c:url value="/resources/messages/messages.css" />" type="text/css" media="screen" />
        <link rel="stylesheet" href="<c:url value="/resources/map.css" />" type="text/css" media="screen" />
        <link rel="import" href="https://cdn.rawgit.com/OlayinkaSF/olayinkasf.github.io/master/polymer/components/font-roboto/roboto.html" />
        <link rel="import" href="https://cdn.rawgit.com/OlayinkaSF/olayinkasf.github.io/master/polymer/components/core-scaffold/core-scaffold.html">
        <link rel="import" href="https://cdn.rawgit.com/OlayinkaSF/olayinkasf.github.io/master/polymer/components/core-header-panel/core-header-panel.html">
        <link rel="import" href="https://cdn.rawgit.com/OlayinkaSF/olayinkasf.github.io/master/polymer/components/core-menu/core-menu.html">
        <link rel="import" href="https://cdn.rawgit.com/OlayinkaSF/olayinkasf.github.io/master/polymer/components/core-item/core-item.html">
        <link rel="import" href="https://cdn.rawgit.com/OlayinkaSF/olayinkasf.github.io/master/polymer/components/core-icon-button/core-icon-button.html">
        <link rel="import" href="https://cdn.rawgit.com/OlayinkaSF/olayinkasf.github.io/master/polymer/components/core-toolbar/core-toolbar.html">
        <link rel="import" href="https://cdn.rawgit.com/OlayinkaSF/olayinkasf.github.io/master/polymer/components/core-menu/core-submenu.html">
        <link rel="import" href="<c:url value="/resources/element/m-toolbar.html"/>">
        <link rel="icon" href="/favicon.ico" type="image/x-icon" />
        <style>    
            html,body {
                height: 100%;
                margin: 0;
                background-color: #E5E5E5;
                font-family: 'RobotoDraft', sans-serif;
            }
            #core_scaffold {
                position: absolute;
                top: 0px;
                right: 0px;
                bottom: 0px;
                left: 0px;
                width: 100%;
                height: 100%;
            }
            #core_header_panel {
                background-color: rgb(255, 255, 255);
            }
            #core_toolbar {
                color: rgb(255, 255, 255);
                background-color: rgb(79, 125, 201);
            }
            #core_menu {
                font-size: 16px;
            }
            #content {
                width: 100%;
                height: 100%;
                display: block;
                left: 0px;
                top: 0px;
                position: absolute;
            }
        </style>
        <script>
            function gloat(){
                console.log("gloating");
            }
        </script>
    </head>
    <body unresolved>

    <core-scaffold id="core_scaffold">
        <tiles:insertTemplate template="menu.jsp" />
        <!-- flex makes the bar span across the top of the main content area -->
        <m-toolbar id="core_toolbar1" tool flex>
        </m-toolbar>
        <div id="content">
            <tiles:insertAttribute name="content" />
        </div>
    </core-scaffold>
</body>
</html>
