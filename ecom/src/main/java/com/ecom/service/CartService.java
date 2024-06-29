package com.ecom.service;

import com.ecom.model.Cart;
import com.ecom.model.CartAddress;
import com.ecom.repository.CartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
public class CartService {
    @Autowired
    CartRepository cartRepository;

    public void addToCart(Long userId, Long productId, CartAddress cartAddress){
        // If cart not exist of user then create cart and then add product to cart
        String cartSession = cartRepository.getCartSession(userId);
        if(cartSession == null){
            String cartSessionId = generateUniqueId();
            String token = generateUniqueId();
            LocalDateTime createdAt = LocalDateTime.now();
            cartRepository.createCart(userId,cartSessionId,token,createdAt,cartAddress);
        }

        LocalDateTime cartItemCreatedAt = LocalDateTime.now();
        cartRepository.addProductToCartItem(userId,productId,cartItemCreatedAt);
    }

    private String generateUniqueId(){
        UUID uuid = UUID.randomUUID();
        return uuid.toString();
    }

    public Cart getCartAndItems(Long userId){
        return cartRepository.getCartAndItems(userId);
    }
}
