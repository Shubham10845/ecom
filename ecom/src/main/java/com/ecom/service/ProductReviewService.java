package com.ecom.service;

import com.ecom.model.ProductReview;
import com.ecom.repository.ProductReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class ProductReviewService {

    @Autowired
    ProductReviewRepository productReviewRepository;
    public void addReview(Long productId, ProductReview productReview) {
        // Get current date and time
        LocalDateTime date = LocalDateTime.now();
        productReview.setCreatedAt(date);
        // Add review to the product
        productReviewRepository.insertProductReview(productReview, productId);
    }
}
