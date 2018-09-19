package com.avic.supplier.services;

import com.avic.common.exceptions.ServiceException;
import com.avic.management.models.OrderContract;
import com.avic.supplier.models.Order;

public interface OrderService {
    public void addOrder(Order order) throws ServiceException;
    public String getOrderIndex() throws ServiceException;
    public Order getOrderDetail(String orderId) throws ServiceException;
    public OrderContract queryOrderContract(String orderId);
    public void updateContract(OrderContract orderContract);
}
