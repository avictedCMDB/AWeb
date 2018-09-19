package com.avic.management.mappers;

import org.springframework.stereotype.Repository;

import com.avic.management.models.SettleData;


@Repository
public interface SettleMapper {
    public void insertSettleData(SettleData data);
}
