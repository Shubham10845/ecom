package com.ecom.controller;

import com.ecom.model.User;
import com.ecom.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.annotation.RequestScope;

@RestController
public class UserController {
    @Autowired
    UserService userService;

    @GetMapping("/users")
    public String getUsers() {
        return "users list";
    }

    @PostMapping("/users")
    public String addUser(@RequestBody User user) {
        userService.insertUser(user);
        return "user added";
    }

//    @RequestParam @RequestBody @RequestMapping @RequestAttribute @RequestHeader @RequestPart @RequestScope
}
