package com.ecom.controller;

import com.ecom.model.Cart;
import com.ecom.model.CartAddress;
import com.ecom.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class CartController {
    @Autowired
    CartService cartService;

    // Test this controller code is written
    @PostMapping("/cart/{userId}/{productId}")
    public String addCart(@RequestBody CartAddress cartAddress,
                          @PathVariable("userId") Long userId,
                          @PathVariable("productId") Long productId) {
        System.out.println("Cart Controller started");
        cartService.addToCart(userId,productId,cartAddress);
        return "cart added";
    }

    @GetMapping("/cart/{userId}")
    public Cart getCart(@PathVariable("userId") Long userId) {
        return cartService.getCartAndItems(userId);
    }
}
