package com.ecom.controller;

import com.ecom.model.ProductReview;
import com.ecom.service.ProductReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ReviewController {
    @Autowired
    ProductReviewService productReviewService;
    @PostMapping("/review/{productId}")
    public String addReview(@PathVariable("productId") Long productId, @RequestBody ProductReview productReview) {
        productReviewService.addReview(productId, productReview);
        return "Review added";
    }
}
