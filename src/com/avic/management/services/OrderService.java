package com.avic.management.services;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.avic.common.exceptions.ServiceException;
import com.avic.management.models.Order;
import com.avic.management.models.OrderContract;
import com.avic.management.models.QuoteSnapshot;

public interface OrderService {
	/**
	 * 查询订单信息
	 */
	public List<Order> queryOrders(Order order);
	/**
	 * 导出订单信息
	 */
	public List<Order> queryOrdersAllData(Order order);
	
	/**
	 * 查询订单数量
	 */
	public int queryOrdersListCount(Order order);
	/**
	 * 获取订单状态列表
	 */
	public List<Order> getOrderStatusList();
	
	/**
	 * 确认收货
	 */
	public String doReceived(String order_id);
	
	/**
	 * 取消订单
	 */
	public String orderCancel(HttpServletRequest req,HttpSession httpSession,Map<String, String> paramMap);
	
	/**
	 * 删除订单
	 */
	public String orderDel(HttpServletRequest req,HttpSession httpSession,Map<String, String> paramMap);
	/**
	 * 根据订单ID查询订单信息
	 */
	public Order queryOrderInfoByOrderId(Order order);
	/**
	 * 查询报价单商品列表
	 */
	public List<QuoteSnapshot> queryQuoteSnapshot(QuoteSnapshot quoteSnapshot);
    // ===========================================================================
    //                         财务支付管理使用
    // ===========================================================================
	public int getPaymentOrderCount(String companyId, int supId, String orderId, int orderStatus, String goodsName);
    public List<Order> getPaymentOrderList(String companyId, int supId, String orderId, int orderStatus, String goodsName, int page, int size);
    public Order getOrderById(String orderId);
    public void updateOrderPayStatus(String orderId) throws ServiceException;
    public void updateOrderStatus(String orderId, int status) throws ServiceException;
    public int getGoodsSum(String orderId) throws ServiceException;
    public String getUserCompanyName(String userId) throws ServiceException;
    public String getUserContactNum(String userId) throws ServiceException;
    
    //**************
    public void insertContract(OrderContract orderContract);
    public void updateContract(OrderContract orderContract);
    public OrderContract queryOrderContract(String orderId);
}
