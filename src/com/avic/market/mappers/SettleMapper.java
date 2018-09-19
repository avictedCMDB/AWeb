package com.avic.market.mappers;

import org.springframework.stereotype.Repository;

import com.avic.market.models.SettleData;



@Repository
public interface SettleMapper {
    public void insertSettleData(SettleData data);
}
