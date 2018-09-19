package com.avic.market.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.market.models.Contract;
import com.avic.market.models.Order;
import com.avic.market.models.OrderSnapshot;
import com.avic.market.models.UPDQuiteInfo;

@Repository
public interface OrderMapper {
    public void insertOrder(Order order);
    public void batchInsertOrderSnapshot(List<OrderSnapshot> list);
    public String queryOrderIndex();
    public Order queryOrderDetail(@Param("orderId") String orderId);
    public List<OrderSnapshot> queryOrderSnapshot(@Param("orderId") String orderId);
    public void updateOrderStatus(@Param("orderId") String orderId, @Param("status") int status);
    public int queryGoodsSum(@Param("orderId") String orderId);
    public String queryUserCompanyName(@Param("userId") String userId);
    public void insertOrderImage(@Param("img")String img, @Param("orderId") String orderId);
    public List<String> queryOrderImage(@Param("orderId")String orderId);
    public String queryUserContactNum(@Param("userId") String userId);
    public void updateCompareOrderId(@Param("list") List<String> list, @Param("orderId")String orderId);
    public void insertContract(Contract contract);
    public void updateOrderIDForQuiteInfo(UPDQuiteInfo uPDQuiteInfo);
    /**
	 * 查询京东换货单列表 
	 */
	public List<Order> queryJDOrderForExchangeInfos(Order order);
	/**
	 * 查询京东退货单列表 
	 */
	public List<Order> queryJDOrderForRefoundInfos(Order order);
	
	/**
	 * 根据京东服务单状态更新换货单状态
	 */
	public void updExchangeStatusByJDStatus(Order order);
	
	/**
	 * 根据京东服务单状态更新退货单状态
	 */
	public void updRefoundStatusByJDStatus(Order order);
	
	public int queryOrderCount();
	public double queryOrderAmount();
}
