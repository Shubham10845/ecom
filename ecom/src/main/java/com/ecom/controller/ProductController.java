package com.ecom.controller;

import com.ecom.model.Product;
import com.ecom.service.ProductService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.websocket.server.PathParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

// Current Project
@RestController
public class ProductController {
    @Autowired
    ProductService productService;
    @GetMapping("/products")
    public List<Product> getProducts() {
        List<Product> productList = productService.getAllProducts();
        return productList;
    }
    @GetMapping("/products/{productId}")
    public Product getProductById(@PathVariable("productId") Long productId) {
        return productService.getProductById(productId);
    }

    @PostMapping(value = "/products/{categoryTitle}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public String addProduct(@PathVariable("categoryTitle") String categoryTitle,
                             @RequestParam("files") MultipartFile files[],
                             @RequestParam("productJSON") String productJSON) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            Product product = objectMapper.readValue(productJSON, Product.class);
            productService.insertProduct(product, files, categoryTitle);
        } catch (Exception e) {
            throw new RuntimeException();
        }
        return "product added";
    }
}
