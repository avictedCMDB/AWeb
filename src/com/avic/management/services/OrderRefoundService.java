package com.avic.management.services;

import java.util.List;
import java.util.Map;

import com.avic.management.models.OrderRefoundBean;

public interface OrderRefoundService {
	/**
	 * 获取要换货单基本信息
	 */
	public OrderRefoundBean getOrderDetail(String order_id);
	
	/**
	 * 获取订单商品列表
	 */
	public List<OrderRefoundBean> orderSelectDoInit(OrderRefoundBean oeBean);
	
	/**
	 * 换货主页获取订单商品列表
	 */
	public List<OrderRefoundBean> orderSelectMainDoInit(OrderRefoundBean oeBean);
	
	
	/**
	 * 保存换货信息
	 */
	public String doSaveInTables(List<OrderRefoundBean> oeBeanList,Map<String, String> paramMap);
}
