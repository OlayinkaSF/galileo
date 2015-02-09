<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


<link rel="import" href="https://cdn.rawgit.com/OlayinkaSF/olayinkasf.github.io/master/polymer/components/core-icon-button/core-icon-button.html">
<link rel="import" href="https://cdn.rawgit.com/OlayinkaSF/olayinkasf.github.io/master/polymer/components/core-toolbar/core-toolbar.html">
<link rel="import" href="https://cdn.rawgit.com/OlayinkaSF/olayinkasf.github.io/master/polymer/components/core-menu/core-submenu.html">
<link rel="import" href="https://cdn.rawgit.com/OlayinkaSF/olayinkasf.github.io/master/polymer/components/core-input/core-input.html">
<link rel="import" href="https://cdn.rawgit.com/OlayinkaSF/olayinkasf.github.io/master/polymer/components/paper-input/paper-input-decorator.html">




<style>    
    #core_card {
        position: relative;
        border-radius: 2px;
        box-shadow: rgba(0, 0, 0, 0.0980392) 0px 2px 4px, rgba(0, 0, 0, 0.0980392) 0px 0px 3px;
        left: 0px;
        top: 0px;
        margin: 10%;
        vertical-align: middle;
        padding: 50px;
        background-color: rgb(255, 255, 255);
    }
    .input {
        display: table;
        position: relative;
        min-width: 250px;
        width: 70%;
        padding: 5px;
    }
    input:-webkit-autofill {
        color: #fff !important;
        background-color: rgba(0,0,0,0) !important;
    }

</style>



<c:url value="/signup" var="signupUrl" />
<form:form id="signup" action="${signupUrl}" method="post" modelAttribute="signupForm">
    <core-card id="core_card" layout vertical center>
        <div class="formInfo">
            <s:bind path="*">
                <c:choose>
                    <c:when test="${status.error}">
                        <div class="error">Unable to sign up. Please fix the errors below and resubmit.</div>
                    </c:when>
                </c:choose>                     
            </s:bind>
            <c:if test="${not empty message}">
                <div class="${message.type.cssClass}">${message.text}</div>
            </c:if>
        </div>
        <div class="input">
            <paper-input-decorator label="First Name"  layout vertical>
                <form:label path="firstName">First Name <form:errors path="firstName" cssClass="error" /></form:label>
                <form:input path="firstName" is="core-input" />
            </paper-input-decorator>
        </div>

        <div class="input">
            <paper-input-decorator label="Last Name"  layout vertical>
                <form:label path="lastName">Last Name <form:errors path="lastName" cssClass="error" /></form:label>
                <form:input path="lastName" is="core-input" />
            </paper-input-decorator>
        </div>

        <div class="input">
            <paper-input-decorator label="Username"  layout vertical>
                <form:label path="username">Username <form:errors path="username" cssClass="error" /></form:label>
                <form:input path="username" is="core-input" />
            </paper-input-decorator>
        </div>

        <div class="input">
            <paper-input-decorator label="Password"  layout vertical>
                <form:label path="password">Password (at least 6 characters) <form:errors path="password" cssClass="error" /></form:label>
                <form:password path="password" is="core-input" />
            </paper-input-decorator>
        </div>

        <core-icon-button icon="launch" type="submit" id="core_icon_button" theme="core-light-theme" raised>  Sign In</core-icon-button>
        <input hidden="true" type="submit" />

        <h3>Sign up via a provider:</h3>
        <p>(Uses SocialAuthenticationFilter)</p>

        <!-- TWITTER SIGNIN -->
        <p><a href="<c:url value="/auth/twitter"/>"><img src="<c:url value="/resources/social/twitter/sign-in-with-twitter-d.png"/>" border="0"/></a></p>

        <!-- FACEBOOK SIGNIN -->
        <p><a href="<c:url value="/auth/facebook"/>"><img src="<c:url value="/resources/social/facebook/sign-in-with-facebook.png"/>" border="0"/></a><br/></p>

    </core-card>

</form:form>
