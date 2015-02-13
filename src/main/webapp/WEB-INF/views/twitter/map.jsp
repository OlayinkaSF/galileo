<%-- 
    Document   : map
    Created on : Jan 27, 2015, 10:39:20 AM
    Author     : Olayinka
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    var app = {
        helloUrl: '<c:url value="/hello" />',
        subscribeUrl: "/app/post/${account.username}"
    };
</script>
<link rel="import" href="<c:url value="/resources/element/my-map.html"/>">


<my-map></my-map>