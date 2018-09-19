package com.avic.market.services;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avic.common.exceptions.ServiceException;
import com.avic.market.models.Order;
import com.avic.market.models.OrderSnapshot;
import com.avic.market.models.UPDQuiteInfo;

public interface OrderService {
    public void addOrder(Order order) throws ServiceException;
    public String getOrderIndex() throws ServiceException;
    public Order getOrderDetail(String orderId) throws ServiceException;
    public void updateOrderStatus(String orderId, int status) throws ServiceException;
    public int getGoodsSum(String orderId) throws ServiceException;
    public String getUserCompanyName(String userId) throws ServiceException;
    public String getUserContactNum(String userId) throws ServiceException;
    public void updateCompareOrderId(List<String> cids, String orderId) throws ServiceException;
    public void updateOrderIDForQuiteInfo(UPDQuiteInfo uPDQuiteInfo);
    public int queryOrderCount();
    public double queryOrderAmount();
}