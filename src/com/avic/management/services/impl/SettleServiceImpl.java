package com.avic.management.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.common.exceptions.ServiceException;
import com.avic.management.mappers.SettleMapper;
import com.avic.management.models.SettleData;
import com.avic.management.services.SettleService;

@Service
public class SettleServiceImpl implements SettleService {
    
    @Autowired
    SettleMapper settleMapper;

    @Transactional
    @Override
    public void insertSettleData(SettleData data) throws ServiceException {
        try {
            settleMapper.insertSettleData(data);
        } catch (Exception e) {
            throw new ServiceException(e);
        }
    }

}
