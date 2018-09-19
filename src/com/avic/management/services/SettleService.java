package com.avic.management.services;

import com.avic.common.exceptions.ServiceException;
import com.avic.management.models.SettleData;

public interface SettleService {
    public void insertSettleData(SettleData data) throws ServiceException;
}
