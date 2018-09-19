package com.avic.supervise.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.OrderContract;
import com.avic.supervise.models.Order;
import com.avic.supervise.models.OrderSnapshot;

@Repository
public interface OrderMapper {
    public int queryManageOrderCount(@Param("supId") int supId, @Param("orderId") String orderId, @Param("goodsName") String goodsName, @Param("companyName") String companyName, @Param("timeStart") String timeStart, @Param("timeEnd") String timeEnd, @Param("orderStatus") int orderStatus, @Param("supType") int supType,@Param("companyId") String companyId);
    public List<Order> queryManageOrderList(@Param("supId") int supId, @Param("orderId") String orderId, @Param("goodsName") String goodsName, @Param("companyName") String companyName, @Param("timeStart") String timeStart, @Param("timeEnd") String timeEnd, @Param("orderStatus") int orderStatus, @Param("supType") int supType, @Param("start") int start, @Param("end") int end,@Param("companyId") String companyId);
    public List<Order> getManageOrderListAllData(@Param("supId") int supId, @Param("orderId") String orderId, @Param("goodsName") String goodsName, @Param("companyName") String companyName, @Param("timeStart") String timeStart, @Param("timeEnd") String timeEnd, @Param("orderStatus") int orderStatus, @Param("supType") int supType,@Param("companyId") String companyId);
    public Order queryManageOrderStat(@Param("supId") int supId, @Param("orderId") String orderId, @Param("goodsName") String goodsName, @Param("companyName") String companyName, @Param("timeStart") String timeStart, @Param("timeEnd") String timeEnd, @Param("orderStatus") int orderStatus, @Param("supType") int supType,@Param("companyId") String companyId);
    public double queryManageOrderRefund(@Param("supId") int supId, @Param("orderId") String orderId, @Param("goodsName") String goodsName, @Param("companyName") String companyName, @Param("timeStart") String timeStart, @Param("timeEnd") String timeEnd, @Param("orderStatus") int orderStatus, @Param("supType") int supType,@Param("companyId") String companyId);
    public List<OrderSnapshot> queryMultiOrderSnapshot(@Param("list") List<String> orderIds);
    public Order queryOrderDetail(@Param("orderId") String orderId);
    public List<OrderSnapshot> queryOrderSnapshot(@Param("orderId") String orderId);
    public void updateOrderStatus(@Param("orderId") String orderId, @Param("status") int status);
    public List<String> queryOrderImage(@Param("orderId")String orderId);
    public List<OrderSnapshot> queryInvoiceSnapshot(@Param("list") List<String> orderIds);
    public void deleteOrderById(@Param("orderId") String orderId);
    public void deleteOrderSnapshot(@Param("orderId") String orderId);
    public OrderContract queryOrderContract(String orderId);
	/**
	 * ȡ������
	 */
	public void orderCancel(String order_id);
}