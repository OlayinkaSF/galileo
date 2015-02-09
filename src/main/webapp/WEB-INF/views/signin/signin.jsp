<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%@ taglib uri="http://www.springframework.org/spring-social/facebook/tags" prefix="facebook" %>
<%@ page session="false" %>


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
        width: 65%;
        padding: 5px;
    }
    input:-webkit-autofill {
        color: #fff !important;
        background-color: rgba(0,0,0,0) !important;
    }

</style>


<form id="form" action="<c:url value="/signin/authenticate" />" method="POST" onsubmit>
    <core-card id="core_card" layout vertical center>
        <div class="formInfo">
            <c:if test="${param.error eq 'bad_credentials'}">
                <div class="error">
                    Your sign in information was incorrect.
                    Please try again or <a href="<c:url value="/signup" />">sign up</a>.
                </div>
            </c:if>
            <c:if test="${param.error eq 'multiple_users'}">
                <div class="error">
                    Multiple local accounts are connected to the provider account.
                    Try again with a different provider or with your username and password.
                </div>
            </c:if>
        </div>
        <div id="div1" class="input">
            <paper-input-decorator label="Login" layout vertical>
                <input id="login" placeholder="Login" name="j_username" is="core-input" type="text" size="25" <c:if test="${not empty signinErrorMessage}">value="${SPRING_SECURITY_LAST_USERNAME}"</c:if> />
                </paper-input-decorator>
            </div>
            <div id="div2" class="input">
                <paper-input-decorator label="Password" layout vertical>
                    <input id="input" name="j_password" id="password" size="25" placeholder="Password" type="password" is="core-input">
                </paper-input-decorator>
            </div>
            <core-icon-button icon="launch" type="submit" id="core_icon_button" theme="core-light-theme" raised>  Sign In</core-icon-button>
            <input hidden="true" type="submit" />
            <p>Or you can <a href="<c:url value="/signup"/>">signup</a> with a new account.</p>

        <h3>Sign in via a provider:</h3>
        <p>(Uses SocialAuthenticationFilter)</p>

        <!-- TWITTER SIGNIN -->
        <p><a href="<c:url value="/auth/twitter"/>"><img src="<c:url value="/resources/social/twitter/sign-in-with-twitter-d.png"/>" border="0"/></a></p>

        <!-- FACEBOOK SIGNIN -->
        <p><a href="<c:url value="/auth/facebook"/>"><img src="<c:url value="/resources/social/facebook/sign-in-with-facebook.png"/>" border="0"/></a><br/></p>

    </core-card>
</form>
