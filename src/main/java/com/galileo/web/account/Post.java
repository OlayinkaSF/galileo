/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.galileo.web.account;

import java.sql.Date;
import org.android.json.JSONException;
import org.android.json.JSONObject;

/**
 *
 * @author Olayinka
 */
public class Post {

    String username;
    String owner;
    String content;
    Double longitude;
    Double latitude;
    String place;
    Date timeOfPost;

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }
    
    

    
    
    public Post(String username, String owner, String content, Double longitude, Double latitude, String place) {
        this.username = username;
        this.owner = owner;
        this.content = content;
        this.longitude = longitude;
        this.latitude = latitude;
        this.place = place;
    }

    public Date getTimeOfPost() {
        return timeOfPost;
    }

    public void setTimeOfPost(Date timeOfPost) {
        this.timeOfPost = timeOfPost;
    }

    
   

    Post() {
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
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

    public JSONObject toJSONObject() throws JSONException {
        JSONObject object = new JSONObject();
        object.put("username", username);
        object.put("owner", owner);
        object.put("content", content);
        object.put("longitude", longitude);
        object.put("latitude", latitude);
        object.put("place", place);
        return object;
    }

}
