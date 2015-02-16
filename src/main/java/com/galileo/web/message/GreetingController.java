/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.galileo.web.message;

import com.galileo.web.account.FollowRepository;
import java.security.Principal;
import java.util.List;
import javax.inject.Inject;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SubscribeMapping;
import org.springframework.stereotype.Controller;

/**
 *
 * @author Olayinka
 */
@Controller
public class GreetingController {

    @Inject
    SimpMessagingTemplate simpMessagingTemplate;
    @Inject
    FollowRepository followRepository;

    @MessageMapping("/post")
    public void simple(Principal currentUser, HelloMessage message) {
        List<String> followers = followRepository.findFollowersByUsername(currentUser.getName());
        for (String follower : followers) {
            simpMessagingTemplate.convertAndSend("/app/post/" + follower, message);
        }
    }

    @SubscribeMapping("/post/{username}")
    public HelloMessage broadCast(Principal currentUser, @DestinationVariable String username) {
        if (!currentUser.getName().equals(username)) {
            return null;
        }
        HelloMessage message = new HelloMessage();
        message.setName(username);
        return message;
    }

    @SubscribeMapping("/search/{term}")
    public HelloMessage broadCastSearch(Principal currentUser, @DestinationVariable String term) {
        return null;
    }

}
