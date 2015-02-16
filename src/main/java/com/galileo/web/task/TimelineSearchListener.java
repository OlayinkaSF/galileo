/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.galileo.web.task;

import com.galileo.web.account.PlaceRepository;
import com.galileo.web.account.Post;
import com.galileo.web.message.HelloMessage;
import com.galileo.web.twitter.TweetAfterConnectInterceptor;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.android.json.JSONArray;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.social.twitter.api.StreamDeleteEvent;
import org.springframework.social.twitter.api.StreamListener;
import org.springframework.social.twitter.api.StreamWarningEvent;
import org.springframework.social.twitter.api.Tweet;

/**
 *
 * @author Olayinka
 */
public class TimelineSearchListener implements StreamListener {

    private final String username;
    final PlaceRepository placeRepository;
    final SimpMessagingTemplate simpMessagingTemplate;
    final String term;

    public TimelineSearchListener(String username, PlaceRepository placeRepository, SimpMessagingTemplate simpMessagingTemplate, String term) {
        this.username = username;
        this.placeRepository = placeRepository;
        this.simpMessagingTemplate = simpMessagingTemplate;
        this.term = term;
    }

    @Override
    public void onTweet(Tweet tweet) {
        System.out.println("received for " + term);
        String place = tweet.getPlace();
        if (place != null) {
            try {
                JSONArray array = new JSONArray(place);
                array = array.getJSONArray(0);
                array = array.getJSONArray(0);
                double lng = array.getDouble(0);
                double lat = array.getDouble(1);
                System.out.println(lng + lat + "");
                simpMessagingTemplate.convertAndSend("/app/search/" + term, new Post(username, tweet.getUser().getScreenName(), tweet.getText(), lng, lat, null));
            } catch (Exception ex) {
                Logger.getLogger(TweetAfterConnectInterceptor.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            place = tweet.getUser().getLocation();
            if (place != null && !place.trim().isEmpty()) {
                try {
                    double[] coord = placeRepository.findCoordForPlace(place.trim());
                    if (coord != null) {
                        simpMessagingTemplate.convertAndSend("/app/search/" + term, new Post(username, tweet.getUser().getScreenName(), tweet.getText(), coord[0], coord[1], null));
                    } else {
                        simpMessagingTemplate.convertAndSend("/app/search/" + term, new Post(username, tweet.getUser().getScreenName(), tweet.getText(), null, null, place));
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
        HelloMessage message = new HelloMessage();
        message.setName(tweet.getText());
    }

    @Override
    public void onDelete(StreamDeleteEvent sde) {
    }

    @Override
    public void onLimit(int i) {
        System.out.println(i + " Limit exceeded");
    }

    @Override
    public void onWarning(StreamWarningEvent swe) {
        System.out.println(swe.getMessage());
    }
}
