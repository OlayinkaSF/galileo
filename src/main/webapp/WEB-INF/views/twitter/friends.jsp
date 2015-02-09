<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%@ page session="false" %>

<script src="http://platform.twitter.com/anywhere.js?id=7yWLgCOuQhIpPyffm0o2Vg&v=1" type="text/javascript"></script>
<script type="text/javascript">
    twttr.anywhere(function (T) {
        T(".feed").linkifyUsers();
    });
</script>

<h3>Your Twitter Friends</h3>

<ul class="imagedList">
    <c:forEach items="${profiles}" var="profile">
        <li class="imagedItem">
            <a href="http://twitter.com/<c:out value="${profile.screenName}" />">
                <core-item id="core_item" icon="<c:if test="${not empty profile.profileImageUrl}">   <c:out value="${profile.profileImageUrl}"/>                           </c:if>"                           label="${profile.screenName}" horizontal center layout></core-item></a>
            </li>
    </c:forEach>
</ul>