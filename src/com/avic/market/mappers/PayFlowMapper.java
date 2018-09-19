package com.avic.market.mappers;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.market.models.PayFlow;


@Repository
public interface PayFlowMapper {
    public void insertPayFlow(PayFlow payFlow);
    public PayFlow queryPayFlow(@Param("payFlow") String payFlow);
    public void updatePayFlow(PayFlow payFlow);
    public PayFlow queryOrderPayFlow(@Param("orderId") String orderId);
}
