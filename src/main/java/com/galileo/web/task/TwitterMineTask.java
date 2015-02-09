/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.galileo.web.task;

/**
 *
 * @author Olayinka
 */
import com.galileo.web.account.Connection;
import com.galileo.web.account.ConnectionRepository;
import com.galileo.web.account.PlaceRepository;
import com.galileo.web.account.PostRepository;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.inject.Inject;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.social.twitter.api.StreamListener;
import org.springframework.social.twitter.api.Twitter;
import org.springframework.social.twitter.api.UserStreamParameters;
import org.springframework.social.twitter.api.impl.TwitterTemplate;
import org.springframework.stereotype.Service;

@Service
@EnableScheduling
@PropertySource("classpath:/com/galileo/web/config/application.properties")
public final class TwitterMineTask {

    @Inject
    ConnectionRepository connectionRepository;
    @Inject
    PostRepository postRepository;
    @Inject
    PlaceRepository placeRepository;
    
    @Inject
    SimpMessagingTemplate simpMessagingTemplate;

    String twitterAppKey;
    String twitterAppSecret;
    final Set<String> twitterTasks = new HashSet<>(10000);
    private long run = 0;

    @Inject
    public void setEnvironement(Environment env) {
        this.twitterAppKey = env.getRequiredProperty("twitter.appKey");
        this.twitterAppSecret = env.getRequiredProperty("twitter.appSecret");
    }

    @Scheduled(initialDelay = 0, fixedDelay = 1 * 60 * 60 * 1000)
    public void run() {
        System.out.println("Updating twitter timeline listeners: run " + (++run));
        List<Connection> connections = connectionRepository.findAllConnectionsForProvider("twitter");
        for (Connection conn : connections) {
            try {
                String user = conn.getProviderUserId();
                if (!twitterTasks.contains(user)) {
                    Twitter twitter = new TwitterTemplate(twitterAppKey, twitterAppSecret, conn.getAccessToken(), conn.getSecret());
                    update(twitter, conn.getUserId());
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    public void update(Object object, String userId) {
        Twitter twitter = (Twitter) object;
        if (twitter instanceof Twitter) {
            UserStreamParameters streamParameters = new UserStreamParameters();
            streamParameters.with(UserStreamParameters.WithOptions.FOLLOWINGS);
            streamParameters.includeReplies(true);
            twitter.streamingOperations().filter(
                    "days",
                    new ArrayList<StreamListener>(
                            Arrays.asList(
                                    new TimelineStreamListener(userId, postRepository, placeRepository,simpMessagingTemplate)
                            )
                    ));
            synchronized (twitterTasks) {
                twitterTasks.add(twitter.userOperations().getProfileId() + "");
            }
        }
    }
}
