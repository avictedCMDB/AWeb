package com.avic.management.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.SupUserMapper;
import com.avic.management.models.SupUser;
import com.avic.management.services.SupUserService;

@Service
public class SupUserServiceImpl implements SupUserService {

    @Autowired
    SupUserMapper supUserMapper;
    
    @Override
    public SupUser querySupUserBySupId(String supId) {
        return supUserMapper.querySupUserBySupId(supId);
    }

}
