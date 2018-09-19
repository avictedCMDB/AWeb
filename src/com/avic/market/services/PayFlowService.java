package com.avic.market.services;

import com.avic.common.exceptions.ServiceException;
import com.avic.market.models.PayFlow;

public interface PayFlowService {
    public void insertPayFlow(PayFlow payFlow) throws ServiceException;
    public PayFlow getPayFlowByNo(String payFlow) throws ServiceException;
    public void updatePayFlow(PayFlow payFlow) throws ServiceException;
    public PayFlow getPayFlowByOrderId(String orderId) throws ServiceException;
}
