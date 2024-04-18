package com.ecom.repository;

import com.ecom.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class UserRepository {
    private final JdbcTemplate jdbcTemplate;
    @Autowired
    public UserRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public void insertUser(User user) {
        String sql = "INSERT INTO user (firstName, middleName, lastName, mobile, email, passwordHash, admin, vendor, registeredAt, intro, profile) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        jdbcTemplate.update(sql, user.getFirstName(), user.getMiddleName(), user.getLastName(),
                user.getMobile(), user.getEmail(), user.getPasswordHash(),
                user.isAdmin(), user.isVendor(), user.getRegisteredAt(),
                user.getIntro(), user.getProfile());
    }
}
