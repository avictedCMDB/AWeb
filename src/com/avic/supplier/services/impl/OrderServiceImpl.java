package com.avic.supplier.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.common.exceptions.ServiceException;
import com.avic.management.models.OrderContract;
import com.avic.supplier.mappers.OrderMapper;
import com.avic.supplier.models.Order;
import com.avic.supplier.services.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
    protected static final Log logger = LogFactory.getLog(OrderServiceImpl.class);
    
    @Autowired
    OrderMapper orderMapper;

    @Transactional
    @Override
    public void addOrder(Order order) throws ServiceException {
        logger.info("添加订单");
        
        try {
            orderMapper.insertOrder(order);
            
            orderMapper.batchInsertOrderSnapshot(order.getSnapshots());
            
        } catch (Exception e) {
            logger.error("添加订单失败", e);
            throw new ServiceException(e);
        }
        
    }
    
    @Override
    public String getOrderIndex() throws ServiceException {
        logger.info("获取订单序列");
        return orderMapper.queryOrderIndex();
    }
    
    @Override
    public Order getOrderDetail(String orderId) throws ServiceException {
        logger.info("获取订单详情-orderId["+orderId+"]");
        Order order = orderMapper.queryOrderDetail(orderId);
        
        if (order != null) {
            order.setSnapshots(orderMapper.queryOrderSnapshot(orderId));
        }
        return order;
    }

	@Override
	public OrderContract queryOrderContract(String orderId) {
		// TODO Auto-generated method stub
		return orderMapper.queryOrderContract(orderId);
	}

	@Override
	public void updateContract(OrderContract orderContract) {
		// TODO Auto-generated method stub
		orderMapper.updateContract(orderContract);
	}
}
