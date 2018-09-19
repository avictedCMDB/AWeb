package com.avic.supervise.services;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.avic.common.exceptions.ServiceException;
import com.avic.management.models.OrderContract;
import com.avic.supervise.models.Order;

public interface OrderService {
    public int getManageOrderCount(int supId, String orderId, String goodsName, String companyName, String timeStart, String timeEnd, int orderStatus, int supType,String companyId) throws ServiceException;
    public Order getManageOrderStat(int supId, String orderId, String goodsName, String companyName, String timeStart, String timeEnd, int orderStatus, int supType,String companyId) throws ServiceException;
    public List<Order> getManageOrderList(int supId, String orderId, String goodsName, String companyName, String timeStart, String timeEnd, int orderStatus, int supType, int page, int size,String companyId) throws ServiceException;
    public List<Order> getManageOrderListAllData(int supId, String orderId, String goodsName, String companyName, String timeStart, String timeEnd, int orderStatus, int supType,String companyId) throws ServiceException;
    public Order getOrderDetail(String orderId) throws ServiceException;
    public void updateOrderStatus(String orderId, int status) throws ServiceException;
    public void deleteOrder(String orderId) throws ServiceException;
    public OrderContract queryOrderContract(String orderId);
	/**
	 * È¡Ïû¶©µ¥
	 */
	public String orderCancel(HttpServletRequest req,HttpSession httpSession,Map<String, String> paramMap);
}
