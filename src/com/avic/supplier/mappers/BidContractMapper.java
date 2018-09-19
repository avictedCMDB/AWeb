package com.avic.supplier.mappers;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.supplier.models.BidContract;

@Repository
public interface BidContractMapper {
    public BidContract queryContractByProj(@Param("projId") String projId, @Param("supCode") String supCode);
    public void updateContract(BidContract c);
    
}
