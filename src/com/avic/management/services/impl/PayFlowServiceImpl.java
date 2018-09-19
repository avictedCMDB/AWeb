package com.avic.management.services.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.common.exceptions.ServiceException;
import com.avic.management.mappers.PayFlowMapper;
import com.avic.management.models.PayFlow;
import com.avic.management.services.PayFlowService;

@Service
public class PayFlowServiceImpl implements PayFlowService {
    protected static final Log logger = LogFactory.getLog(PayFlowServiceImpl.class);
    
    @Autowired
    PayFlowMapper payFlowMapper;

    @Transactional
    @Override
    public void insertPayFlow(PayFlow payFlow) throws ServiceException {
    	logger.info("插入支付流水");
        try {
            payFlowMapper.insertPayFlow(payFlow);
        } catch (Exception e) {
        	 logger.error("插入支付流水失败", e);
            throw new ServiceException(e);
        }
    }
    
    @Override
    public PayFlow getPayFlowByNo(String payFlow) throws ServiceException {
        return payFlowMapper.queryPayFlow(payFlow);
    }
    
    @Override
    public void updatePayFlow(PayFlow payFlow) throws ServiceException {
        logger.info("更新支付流水");
        try {
            payFlowMapper.updatePayFlow(payFlow);
        } catch (Exception e) {
            logger.error("更新支付流水失败", e);
            throw new ServiceException(e);
        }
    }
    
    @Override
    public PayFlow getPayFlowByOrderId(String orderId) throws ServiceException {
        return payFlowMapper.queryOrderPayFlow(orderId);
    }

}
