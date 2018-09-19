package com.avic.market.services;

import com.avic.common.exceptions.ServiceException;
import com.avic.market.models.SettleData;

public interface SettleService {
    public void insertSettleData(SettleData data) throws ServiceException;
}
