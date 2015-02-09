/*
 * Copyright 2014 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.galileo.web.twitter;

import com.galileo.web.account.AccountRepository;
import com.galileo.web.account.Post;
import com.galileo.web.account.PostRepository;
import java.security.Principal;
import java.util.List;
import javax.inject.Inject;
import org.android.json.JSONArray;
import org.android.json.JSONException;
import org.springframework.social.connect.web.ProviderSignInUtils;

import org.springframework.social.twitter.api.Twitter;
import org.springframework.social.twitter.api.TwitterProfile;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TwitterTimelineController {

    private final Twitter twitter;
    private final PostRepository postRepository;
    private final ProviderSignInUtils providerSignInUtils = new ProviderSignInUtils();
    private final AccountRepository accountRepository;

    @RequestMapping(value = "/twitter/timeline", method = RequestMethod.GET)
    public String showTimeline(Model model) {
        return showTimeline("Home", model);
    }

    @Inject
    public TwitterTimelineController(Twitter twitter, PostRepository postRepository, AccountRepository accountRepository) {
        this.twitter = twitter;
        this.postRepository = postRepository;
        this.accountRepository = accountRepository;
    }

    @RequestMapping(value = "/twitter/timeline/{timelineType}", method = RequestMethod.GET)
    public String showTimeline(@PathVariable("timelineType") String timelineType, Model model) {
        switch (timelineType) {
            case "Home":
                model.addAttribute("timeline", twitter.timelineOperations().getHomeTimeline());
                break;
            case "User":
                model.addAttribute("timeline", twitter.timelineOperations().getUserTimeline());
                break;
            case "Mentions":
                model.addAttribute("timeline", twitter.timelineOperations().getMentions());
                break;
            case "Favorites":
                model.addAttribute("timeline", twitter.timelineOperations().getFavorites());
                break;
        }
        model.addAttribute("timelineName", timelineType);
        return "twitter/timeline";
    }

    @RequestMapping(value = "/twitter/tweet", method = RequestMethod.POST)
    public String postTweet(String message) {
        twitter.timelineOperations().updateStatus(message);
        return "redirect:/twitter";
    }

    @RequestMapping(value = "/twitter/map", method = RequestMethod.GET)
    public String timeLineMap(Model model, Principal currentUser) {
        model.addAttribute(accountRepository.findAccountByUsername(currentUser.getName()));
        return "twitter/map";
    }

    @ResponseBody
    @RequestMapping(value = "/twitter/map/grab", method = RequestMethod.GET)
    public String timeLineObject(Model model) throws JSONException {
        TwitterProfile profile = twitter.userOperations().getUserProfile();
        model.addAttribute("profile", profile);
        List<Post> posts = postRepository.findPostByUsername(profile.getScreenName());
        JSONArray array = new JSONArray();
        for (Post post : posts) {
            array.put(post.toJSONObject());
        }
        return array.toString();
    }
}
