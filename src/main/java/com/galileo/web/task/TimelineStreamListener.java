/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.galileo.web.task;

import com.galileo.web.account.PlaceRepository;
import com.galileo.web.account.Post;
import com.galileo.web.account.PostRepository;
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
public class TimelineStreamListener implements StreamListener {

    private final String username;
    final PostRepository postRepository;
    final PlaceRepository placeRepository;
    final SimpMessagingTemplate simpMessagingTemplate;

    public TimelineStreamListener(String username, PostRepository postRepository, PlaceRepository placeRepository, SimpMessagingTemplate simpMessagingTemplate) {
        this.username = username;
        this.postRepository = postRepository;
        this.placeRepository = placeRepository;
        this.simpMessagingTemplate = simpMessagingTemplate;
    }

    @Override
    public void onTweet(Tweet tweet) {
        String place = tweet.getPlace();
        if (place != null) {
            try {
                JSONArray array = new JSONArray(place);
                array = array.getJSONArray(0);
                array = array.getJSONArray(0);
                double lng = array.getDouble(0);
                double lat = array.getDouble(1);
                System.out.println(lng + lat + "");
                postRepository.createPost(new Post(username, tweet.getUser().getScreenName(), tweet.getText(), lng, lat, null));
                simpMessagingTemplate.convertAndSend("/app/post/" + username, new Post(username, tweet.getUser().getScreenName(), tweet.getText(), lng, lat, null));

            } catch (Exception ex) {
                Logger.getLogger(TweetAfterConnectInterceptor.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            place = tweet.getUser().getLocation();
            if (place != null && !place.trim().isEmpty()) {
                try {
                    double[] coord = placeRepository.findCoordForPlace(place.trim());
                    if (coord != null) {
                        postRepository.createPost(new Post(username, tweet.getUser().getScreenName(), tweet.getText(), coord[0], coord[1], null));
                        simpMessagingTemplate.convertAndSend("/app/post/" + username, new Post(username, tweet.getUser().getScreenName(), tweet.getText(), coord[0], coord[1], null));
                    } else {
                        postRepository.createPost(new Post(username, tweet.getUser().getScreenName(), tweet.getText(), null, null, place));
                        simpMessagingTemplate.convertAndSend("/app/post/" + username, new Post(username, tweet.getUser().getScreenName(), tweet.getText(), null, null, place));
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
