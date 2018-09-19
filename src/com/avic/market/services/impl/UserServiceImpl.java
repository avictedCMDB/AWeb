package com.avic.market.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.market.mappers.UserMapper;
import com.avic.market.models.User;
import com.avic.market.services.UserService;

@Service
public class UserServiceImpl implements UserService {
    
    @Autowired
    UserMapper userMapper;

    @Override
    public User getUserById(String userId) {
        return userMapper.queryUserById(userId);
    }

    @Override
    public User getUserAndCompanyById(String userId) {
        return userMapper.queryUserAndCompanyById(userId);
    }
}
