package com.avic.management.services;

import java.util.List;

import com.avic.management.models.Exchange;
import com.avic.management.models.Invoice;
import com.avic.management.models.OrderSnapshot;
import com.avic.management.models.Refound;

public interface RefoundService {
	/**
	 * 查询退货单列表
	 * @return 
	 */
	public List<Refound> queryRefound(Refound refound);
	/**
	 * 确认收获
	 * @return 
	 */
	public void updateOrderRefoundStatus(Refound refound);
	/**
	 * 查询退货单待收获数量
	 * @return 
	 */
	public int queryOrderRefoundReceiptCount(Refound refound);
	/**
	 * 修改订单状态为确认收获
	 * @return 
	 */
	public void updateOrderStatusByRefoundID(Refound refound);
	/**
	 * 查询退货单详情
	 * @return 
	 */
	public Refound queryRefoundByID(Refound refound);
	/**
	 * 查询退货单商品详情
	 * @return 
	 */
	public List<OrderSnapshot> queryOrderSnapshotsByRefoundID(Refound refound);
	/**
	 * 修改退货单快递信息
	 * @return 
	 */
	public void updateOrderRefoundExpressInfo(Refound refound);
	/**
	 * 查询退货单数量
	 * @return 
	 */
	public int queryRefoundCount(Refound refound);
	
	/**
	 * 查询退货单数量和金额
	 * @return 
	 */
	public Refound queryRefoundPriceAndAmountByRefoundID(Refound refound);
	
	/**
	 * 修改退货单数量和金额
	 * @return 
	 */
	public void updateOrderRefoundPriceAndAmount(Refound refound);
}
