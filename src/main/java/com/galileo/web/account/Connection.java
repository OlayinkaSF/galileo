/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.galileo.web.account;

/**
 *
 * @author Olayinka
 */
public class Connection {

    String refreshToken;
    String accessToken;
    String secret;
    String userId;
    String providerUserId;

    public Connection(String refreshToken, String accessToken, String secret, String userId, String providerUserId) {
        this.refreshToken = refreshToken;
        this.accessToken = accessToken;
        this.secret = secret;
        this.userId = userId;
        this.providerUserId = providerUserId;
    }

    Connection() {
    }

    public String getRefreshToken() {
        return refreshToken;
    }

    public void setRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getSecret() {
        return secret;
    }

    public void setSecret(String secret) {
        this.secret = secret;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getProviderUserId() {
        return providerUserId;
    }

    public void setProviderUserId(String providerUserId) {
        this.providerUserId = providerUserId;
    }

}
