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
package com.galileo.web.account;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class JdbcPostRepository implements PostRepository {

    private final JdbcTemplate jdbcTemplate;
    private final PasswordEncoder passwordEncoder;

    @Inject
    public JdbcPostRepository(JdbcTemplate jdbcTemplate, PasswordEncoder passwordEncoder) {
        this.jdbcTemplate = jdbcTemplate;
        this.passwordEncoder = passwordEncoder;
    }

    @Transactional
    @Override
    public void createPost(Post post) {
        jdbcTemplate.update(
                "insert into Post (username, owner, content, longitude, latitude, place) values (?, ?, ?, ?, ?, lower(?))",
                post.getUsername(), post.getOwner(), post.getContent(), post.getLongitude(), post.getLatitude(), post.getPlace()
        );
    }

    @Override
    public List<Post> findPostByUsername(String postname) {
        return jdbcTemplate.query("select * from Post where username = ?",
                new String[]{postname},
                new RowMapper<Post>() {
                    @Override
                    public Post mapRow(ResultSet rs, int rowNum) throws SQLException {
                        Post post = new Post();
                        post.setUsername(rs.getString("username"));
                        post.setOwner(rs.getString("owner"));
                        post.setContent(rs.getString("content"));
                        post.setLongitude(rs.getDouble("longitude"));
                        post.setLatitude(rs.getDouble("latitude"));
                        post.setPlace(rs.getString("place"));
                        return post;
                    }
                });
    }

}
