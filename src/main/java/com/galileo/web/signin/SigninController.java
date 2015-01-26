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
package com.galileo.web.signin;

import com.galileo.web.account.Account;
import com.galileo.web.account.AccountRepository;
import javax.inject.Inject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SigninController {

    private final AccountRepository accountRepository;

    @Inject
    public SigninController(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
    }

    @RequestMapping(value = "/signin/authenticate", method = RequestMethod.POST)
    public void signin(String username, String password) {
        Account account = accountRepository.findAccountByUsername(username, password);
        if (account != null) {
            SignInUtils.signin(username);
        }
    }

    @RequestMapping(value = "/signin", method = RequestMethod.GET)
    public void signin() {

    }
}
