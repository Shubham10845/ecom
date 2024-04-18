package com.ecom.repository;

import com.ecom.model.ProductReview;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;

@Repository
public class ProductReviewRepository {
    String INSERT_PRODUCT_REVIEW= "INSERT INTO shop.product_review (productId, parentId, title, rating, published, createdAt, publishedAt, content)" +
                                  " VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    @Autowired
    private final JdbcTemplate jdbcTemplate;

    public ProductReviewRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    public void insertProductReview(ProductReview productReview, Long productId) {
        jdbcTemplate.update(INSERT_PRODUCT_REVIEW,
                productId, null, productReview.getTitle(),
                productReview.getRating(), 0, productReview.getCreatedAt(), null, productReview.getContent());
    }
}
