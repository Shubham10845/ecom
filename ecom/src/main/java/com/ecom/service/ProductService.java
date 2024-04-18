package com.ecom.service;

import com.ecom.model.Product;
import com.ecom.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

@Service
public class ProductService {
    String imageUrl = "C:/Users/SShukla/Desktop/Learning/EcomImages/ProductImage/";

    @Autowired
    ProductRepository productRepository;


    public void insertProduct(Product product, MultipartFile[] files, String categoryTitle) {
        LocalDateTime date = LocalDateTime.now();
        product.setCreatedAt(date);
        Random randome = new Random();
        product.setId(randome.nextLong());
        String imagePath = uploadProductImage(imageUrl, product.getId(), files);
        productRepository.insertProduct(product,categoryTitle);
    }

    public String uploadProductImage(String imageUrl, Long productId, MultipartFile[] files) {
        String uploadDir = imageUrl + productId + "/";
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        for (MultipartFile file : files) {
            try {
                String fileName = file.getOriginalFilename();
                File destFile = new File(uploadDir + fileName);
                file.transferTo(destFile);
            } catch (IOException e) {
                e.printStackTrace();
                return "Error uploading file: " + e.getMessage();
            }
        }
        return uploadDir;
    }
    public List<Product> getAllProducts() {
        return productRepository.laodAllProducts();
    }

    public Product getProductById(Long productId) {
        return productRepository.getProductById(productId);
    }
}
