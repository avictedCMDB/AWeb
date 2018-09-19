package com.avic.market.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.common.exceptions.ServiceException;
import com.avic.market.mappers.SettleMapper;
import com.avic.market.models.SettleData;
import com.avic.market.services.SettleService;

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
