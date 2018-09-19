package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.OrderRefoundBean;

@Repository
public interface OrderRefoundMapper {
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
	 * 获取换货编码
	 */
	public OrderRefoundBean getRefoundId();
	
	/**
	 * 更新订单表状态为申请换货
	 */
	public void updateT_ORDER(OrderRefoundBean oeBean);
	
	/**
	 * 插入换货主表
	 */
	public void InsertT_ORDER_REFOUND(OrderRefoundBean oeBean);
	
	/**
	 * 插入换货商品表记录
	 */
	public void InsertT_REFOUND_GOODS(OrderRefoundBean oeBean);
	
	/**
	 * 更新订单快照表商品的退货状态
	 */
	public void updateT_ORDER_SNAPSHOT(OrderRefoundBean oeBean);
	
	/**
	 * 附件图片表
	 */
	public void InsertT_IMAGE_INFO(OrderRefoundBean oeBean);
}
