package com.avic.market.services.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.common.exceptions.ServiceException;
import com.avic.market.mappers.OrderMapper;
import com.avic.market.models.Order;
import com.avic.market.models.UPDQuiteInfo;
import com.avic.market.services.OrderService;

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
            
            if (order.getImgs() != null) {
                for (String i : order.getImgs()) {
                    orderMapper.insertOrderImage(i, order.getOrderId());
                }
            }
            
            if (order.getContract() != null) {
                order.getContract().setOrderId(order.getOrderId());
                
                orderMapper.insertContract(order.getContract());
            }
            
        } catch (Exception e) {
            logger.error("添加订单失败", e);
            throw new ServiceException(e);
        }
        
    }
    
    @Override
    public String getOrderIndex() throws ServiceException {
        logger.info("获取订单序列");
        return "D" + orderMapper.queryOrderIndex();
    }
    
    @Override
    public Order getOrderDetail(String orderId) throws ServiceException {
        logger.info("获取订单详情-orderId["+orderId+"]");
        Order order = orderMapper.queryOrderDetail(orderId);
        
        if (order != null) {
            order.setSnapshots(orderMapper.queryOrderSnapshot(orderId));
            order.setImgs(orderMapper.queryOrderImage(orderId));
        }
        return order;
    }
    @Transactional
    @Override
    public void updateOrderStatus(String orderId, int status) throws ServiceException {

        try {
            orderMapper.updateOrderStatus(orderId, status);
        } catch (Exception e) {
            throw new ServiceException(e);
        }
    }
    
    @Override
    public int getGoodsSum(String orderId) throws ServiceException {
        return orderMapper.queryGoodsSum(orderId);
    }
    
    @Override
    public String getUserCompanyName(String userId) throws ServiceException {
        return orderMapper.queryUserCompanyName(userId);
    }
    
    @Override
    public String getUserContactNum(String userId) throws ServiceException {
        return orderMapper.queryUserContactNum(userId);
    }
    
    @Override
    public void updateCompareOrderId(List<String> cids, String orderId) throws ServiceException {
        List<String> filtered = new ArrayList<String>();
        for (String i : cids) {
            if (StringUtils.isNotEmpty(i)) {
                filtered.add(i);
            }
        }
        
        if (filtered.size() > 0) {
            orderMapper.updateCompareOrderId(filtered, orderId);
        }
    }
	@Override
	public void updateOrderIDForQuiteInfo(UPDQuiteInfo uPDQuiteInfo) {
		orderMapper.updateOrderIDForQuiteInfo(uPDQuiteInfo);
	}
	
	@Override
	public double queryOrderAmount() {
	    return orderMapper.queryOrderAmount();
	}
	
	@Override
	public int queryOrderCount() {
	    return orderMapper.queryOrderCount();
	}
}
