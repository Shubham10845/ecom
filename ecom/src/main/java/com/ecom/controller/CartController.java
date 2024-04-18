package com.ecom.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CartController {
    @PostMapping("/cart")
    public String addCart() {
        return "cart added";
    }

    @GetMapping("/cart")
    public String getCart() {
        return "cart list";
    }
}
