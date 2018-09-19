package com.avic.management.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.Order;
import com.avic.management.models.OrderContract;
import com.avic.management.models.OrderSnapshot;
import com.avic.management.models.QuoteSnapshot;

@Repository
public interface OrderMapper {
	/**
	 * ��ѯ������Ϣ
	 */
	public List<Order> queryOrders(Order order);
	
	/**
	 * ����������Ϣ
	 */
	public List<Order> queryOrdersAllData(Order order);
	
	/**
	 * ��ѯ��������
	 */
	public int queryOrdersListCount(Order order);
	
	/**
	 * ��ȡ����״̬�б�
	 */
	public List<Order> getOrderStatusList();
	
	/**
	 * ȷ���ջ�
	 */
	public void doReceived(String order_id);
	
	/**
	 * ȡ������
	 */
	public void orderCancel(String order_id);
	
	/**
	 * ɾ������������
	 */
	public void deleteT_ORDER(String order_id);
	
	/**
	 * ɾ���������ձ�����
	 */
	public void deleteT_ORDER_SNAPSHOT(String order_id);
	
	/**
	 * ��ѯ���۵���Ʒ�б�
	 */
	public List<QuoteSnapshot> queryQuoteSnapshot(QuoteSnapshot quoteSnapshot);
	
	/**
	 * ���ݶ���ID��ѯ������Ϣ
	 */
	public Order queryOrderInfoByOrderId(Order order);
	
	// ===========================================================================
	//                         ����֧������ʹ��
    // ===========================================================================
	public int queryPaymentOrderCount(@Param("companyId") String companyId, @Param("supId") int supId, @Param("orderId") String orderId, @Param("orderStatus") int orderStatus, @Param("goodsName") String goodsName);
    public List<Order> queryPaymentOrderList(@Param("companyId") String companyId, @Param("supId") int supId, @Param("orderId") String orderId, @Param("orderStatus") int orderStatus, @Param("goodsName") String goodsName, @Param("start") int start, @Param("end") int end);
    public List<OrderSnapshot> queryPaymentOrderSnapshot(@Param("list") List<String> orderIds);
    public Order queryOrderById(@Param("orderId") String orderId);
    public void updateOrderPayStatus(@Param("orderId") String orderId);
    public void updateOrderStatus(@Param("orderId") String orderId, @Param("status") int status);
    public int queryGoodsSum(@Param("orderId") String orderId);
    public String queryUserCompanyName(@Param("userId") String userId);
    public String queryUserContactNum(@Param("userId") String userId);
    
    public void insertContract(OrderContract orderContract);
    public void updateContract(OrderContract orderContract);
    public OrderContract queryOrderContract(String orderId);
}