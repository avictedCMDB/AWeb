package com.avic.management.services;

import java.util.List;

import com.avic.management.models.Exchange;
import com.avic.management.models.Invoice;
import com.avic.management.models.OrderSnapshot;

public interface ExchangeService {
	/**
	 * 查询换货单列表
	 * @return 
	 */
	public List<Exchange> queryExchange(Exchange exchange);
	/**
	 * 确认收获
	 * @return 
	 */
	public void updateOrderExchangeStatus(Exchange exchange);
	/**
	 * 查询退货单待收获数量
	 * @return 
	 */
	public int queryOrderExchangeReceiptCount(Exchange exchange);
	/**
	 * 修改订单状态为确认收获
	 * @return 
	 */
	public void updateOrderStatusByExchangeID(Exchange exchange);
	/**
	 * 查询换货单详情
	 * @return 
	 */
	public Exchange queryExchangeByID(Exchange exchange);
	/**
	 * 查询换货单商品详情
	 * @return 
	 */
	public List<OrderSnapshot> queryOrderSnapshotsByOrderID(Exchange exchange);
	/**
	 * 修改换货单快递信息
	 * @return 
	 */
	public void updateOrderExchangeExpressInfo(Exchange exchange);
	/**
	 * 查询换货单数量
	 * @return 
	 */
	public int queryExchangeCount(Exchange exchange);
	/**
	 * 查询换货单数量和金额
	 * @return 
	 */
	public Exchange queryExchangePriceAndAmountByExchangeID(Exchange exchange);
	
	/**
	 * 修改换货单数量和金额
	 * @return 
	 */
	public void updateOrderExchangePriceAndAmount(Exchange exchange);
}
