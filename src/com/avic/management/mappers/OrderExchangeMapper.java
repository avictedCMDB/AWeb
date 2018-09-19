package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.OrderExchangeBean;

@Repository
public interface OrderExchangeMapper {
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
	 * 获取换货编码
	 */
	public OrderExchangeBean getExchangeId();
	
	/**
	 * 更新订单表状态为申请换货
	 */
	public void updateT_ORDER(OrderExchangeBean oeBean);
	
	/**
	 * 插入换货主表
	 */
	public void InsertT_ORDER_EXCHANGE(OrderExchangeBean oeBean);
	
	/**
	 * 插入换货商品表记录
	 */
	public void InsertT_EXCHANGE_GOODS(OrderExchangeBean oeBean);
	
	/**
	 * 更新订单快照表商品的退货状态
	 */
	public void updateT_ORDER_SNAPSHOT(OrderExchangeBean oeBean);
	
	/**
	 * 附件图片表
	 */
	public void InsertT_IMAGE_INFO(OrderExchangeBean oeBean);
	
	/**
	 * 获取供应商联系方式
	 */
	public String getContact_num(String sup_id);
}
