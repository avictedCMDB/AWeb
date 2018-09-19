package com.avic.management.services.impl;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.UserMapper;
import com.avic.management.services.UserService;
import com.avic.passport.models.User;

@Service
public class UserServiceImpl implements UserService {
    protected static final Log logger = LogFactory.getLog(UserServiceImpl.class);

    @Autowired
    UserMapper userMapper;

	@Override
	public void changePassword(User user) {
		userMapper.changePassword(user);
	}

	@Override
	public int selectUserByPassword(User user) {
		return userMapper.selectUserByPassword(user);
	}

	@Override
	public com.avic.management.models.User queryUserById(String userId) {
	    return userMapper.queryUserById(userId);
	}
}
