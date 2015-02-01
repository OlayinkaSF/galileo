/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.galileo.web.account;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import javax.inject.Inject;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Olayinka
 */
@Repository
public class JdbcPlaceRepository implements PlaceRepository {

    private final JdbcTemplate jdbcTemplate;

    @Inject
    public JdbcPlaceRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public double[] findCoordForPlace(String place) {
        double[] ret = null;
        try {
            ret = jdbcTemplate.queryForObject("select longitude, latitude from place where lower(name) = lower(?)", new RowMapper<double[]>() {

                @Override
                public double[] mapRow(ResultSet rs, int i) throws SQLException {
                    return new double[]{rs.getDouble("longitude"), rs.getDouble("latitude")};
                }
            }, place);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return ret;
    }

    @Override
    public int updatePlace(String trim, double aDouble, double aDouble0) {
        try {

            int ret = 0;
            try {
                ret = jdbcTemplate.update(
                        "insert into Place values (?, ?, lower(?))",
                        aDouble, aDouble0, trim
                );
            } catch (DataAccessException ex) {
                jdbcTemplate.update("update post set longitude = ?, latitude = ? where place = lower(?)",
                        aDouble, aDouble0, trim
                );
            }
            return ret;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            throw ex;
        }
    }

}
