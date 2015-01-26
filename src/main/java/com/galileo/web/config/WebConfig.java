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
package com.galileo.web.config;

import com.galileo.core.config.AppConfig;
import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.jdbc.core.JdbcTemplate;
import java.util.Properties;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate4.HibernateTransactionManager;
import org.springframework.orm.hibernate4.LocalSessionFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * Main configuration class for the application. Turns on @Component scanning,
 * loads externalized application.properties, and sets up the database.
 *
 * @author Craig Walls
 */
@Configuration
@ComponentScan(basePackages = "com.galileo.web", excludeFilters = {
    @Filter(Configuration.class)})
@EnableTransactionManagement
public class WebConfig extends AppConfig {

    private static final String DATABASE_DRIVER = "jdbc.driverClassName";
    private static final String DATABASE_PASSWORD = "jdbc.password";
    private static final String DATABASE_URL = "jdbc.url";
    private static final String DATABASE_USERNAME = "jdbc.username";

    private static final String HIBERNATE_DIALECT = "hibernate.dialect";
    private static final String HIBERNATE_SHOW_SQL = "hibernate.show_sql";
    private static final String ENTITYMANAGER_PACKAGES_TO_SCAN = "entitymanager.packages.to.scan";
    private static final String HBM2DDL_AUTO = "hibernate.hbm2ddl.auto";

    @Bean
    public DataSource dataSource(Environment env) {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();

        dataSource.setDriverClassName(env.getRequiredProperty(DATABASE_DRIVER));
        dataSource.setUrl(env.getRequiredProperty(DATABASE_URL));
        dataSource.setUsername(env.getRequiredProperty(DATABASE_USERNAME));
        dataSource.setPassword(env.getRequiredProperty(DATABASE_PASSWORD));

        return dataSource;
    }

    @Bean
    public LocalSessionFactoryBean sessionFactory(Environment env) {
        LocalSessionFactoryBean sessionFactoryBean = new LocalSessionFactoryBean();
        sessionFactoryBean.setDataSource(dataSource(env));
        sessionFactoryBean.setPackagesToScan(env.getRequiredProperty(ENTITYMANAGER_PACKAGES_TO_SCAN));
        sessionFactoryBean.setHibernateProperties(hibProperties(env));
        return sessionFactoryBean;
    }

    private Properties hibProperties(Environment env) {
        Properties properties = new Properties();
        properties.put(HIBERNATE_DIALECT, env.getRequiredProperty(HIBERNATE_DIALECT));
        properties.put(HIBERNATE_SHOW_SQL, env.getRequiredProperty(HIBERNATE_SHOW_SQL));
        properties.put(HBM2DDL_AUTO, env.getRequiredProperty(HBM2DDL_AUTO));
        return properties;
    }

    @Bean
    public PlatformTransactionManager transactionManager(Environment env) {
        HibernateTransactionManager transactionManager = new HibernateTransactionManager();
        transactionManager.setSessionFactory(sessionFactory(env).getObject());
        return transactionManager;
    }

    @Bean
    public JdbcTemplate jdbcTemplate(Environment env) {
        return new JdbcTemplate(dataSource(env));
    }

    @Bean
    public PropertySourcesPlaceholderConfigurer propertyPlaceHolderConfigurer() {
        return new PropertySourcesPlaceholderConfigurer();
    }

}
