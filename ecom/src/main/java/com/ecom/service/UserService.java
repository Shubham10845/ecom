package com.ecom.service;

import com.ecom.model.User;
import com.ecom.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Random;

@Service
public class UserService {
    @Autowired
    UserRepository userRepository;
    public String getUser() {
        return "user details";
    }
    public void insertUser(User user) {
        Random randome = new Random();
        user.setId(randome.nextLong());
        userRepository.insertUser(user);
    }
}
