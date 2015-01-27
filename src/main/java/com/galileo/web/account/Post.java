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
public class Post {

    String username;
    String content;

    public Post(String username, String content) {
        this.username = username;
        this.content = content;
    }

    Post() {
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

}
