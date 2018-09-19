package com.avic.management.mappers;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.BidContract;

@Repository
public interface BidContractMapper {
    public BidContract queryContractByProj(@Param("projId") String projId, @Param("supCode") String supCode);
    public void insertContract(BidContract c);
    public void updateContractSignDate(@Param("projId") String projId, @Param("supCode") String supCode);
}
