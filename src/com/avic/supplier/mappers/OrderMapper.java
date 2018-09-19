package com.avic.supplier.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.OrderContract;
import com.avic.supplier.models.Order;
import com.avic.supplier.models.OrderSnapshot;


@Repository
public interface OrderMapper {
    public void insertOrder(Order order);
    public void batchInsertOrderSnapshot(List<OrderSnapshot> list);
    public String queryOrderIndex();
    public Order queryOrderDetail(@Param("orderId") String orderId);
    public List<OrderSnapshot> queryOrderSnapshot(@Param("orderId") String orderId);
    public OrderContract queryOrderContract(String orderId);
    public void updateContract(OrderContract orderContract);
}
