<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/spring-social/social/tags" prefix="social" %>

<core-header-panel mode="seamed" id="core_header_panel" navigation flex>
    <core-toolbar id="core_toolbar"></core-toolbar>
    <core-menu valueattr="label" id="core_menu" theme="core-light-theme">

        <h4><a href="<c:url value="/connect"/>">Connections</a></h4>

        <h4><a href="<c:url value="/twitter"/>">Twitter</a></h4>
        <social:connected provider="twitter">
            <a href="<c:url value="/twitter"/>"><core-item id="core_item" icon="settings" label="User Profile" horizontal center layout></core-item></a>
            <a href="<c:url value="/twitter/timeline"/>"><core-item id="core_item" icon="settings" label="Timeline" horizontal center layout></core-item></a>
            <a href="<c:url value="/twitter/map"/>"><core-item id="core_item" icon="settings" label="Timeline Map" horizontal center layout></core-item></a>
            <a href="<c:url value="/twitter/friends"/>"><core-item id="core_item" icon="settings" label="Friends" horizontal center layout></core-item></a>
            <a href="<c:url value="/twitter/followers"/>"><core-item id="core_item" icon="settings" label="Followers" horizontal center layout></core-item></a>
            <a href="<c:url value="/twitter/messages"/>"><core-item id="core_item" icon="settings" label="Messages" horizontal center layout></core-item></a>
            <a href="<c:url value="/twitter/trends"/>"><core-item id="core_item" icon="settings" label="Trends" horizontal center layout></core-item></a>
                </social:connected>

        <h4><a href="<c:url value="/facebook"/>">Facebook</a></h4>
        <social:connected provider="facebook">
            <a href="<c:url value="/facebook"/>"><core-item id="core_item" icon="settings" label="User Profile" horizontal center layout></core-item></a>
            <a href="<c:url value="/facebook/feed"/>"><core-item id="core_item" icon="settings" label="Feed" horizontal center layout></core-item></a>
            <a href="<c:url value="/facebook/friends"/>"><core-item id="core_item" icon="settings" label="Friends" horizontal center layout></core-item></a>
            <a href="<c:url value="/facebook/albums"/>"><core-item id="core_item" icon="settings" label="Albums" horizontal center layout></core-item></a>
                </social:connected>
    </core-menu>
</core-header-panel>
