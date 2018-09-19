package com.avic.management.services;

import java.util.List;
import java.util.Map;

import com.avic.management.models.OrderExchangeBean;

public interface OrderExchangeService {
	/**
	 * 获取要换货单基本信息
	 */
	public OrderExchangeBean getOrderDetail(String order_id);
	
	/**
	 * 获取订单商品列表
	 */
	public List<OrderExchangeBean> orderSelectDoInit(OrderExchangeBean oeBean);
	
	/**
	 * 换货主页获取订单商品列表
	 */
	public List<OrderExchangeBean> orderSelectMainDoInit(OrderExchangeBean oeBean);
	
	
	/**
	 * 保存换货信息
	 */
	public String doSaveInTables(List<OrderExchangeBean> oeBeanList,Map<String, String> paramMap);
}
