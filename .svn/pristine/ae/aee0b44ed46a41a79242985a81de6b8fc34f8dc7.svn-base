package com.avic.market.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.market.models.BidSupplierQuota;

@Repository
public interface BidSupplierQuotaMapper {
    public List<BidSupplierQuota> querySupplierQuota(@Param("projId") String projId, @Param("supCode") String supCode, @Param("quotaType") int quotaType);
    public List<BidSupplierQuota> queryTrialQuotaRank(@Param("projId") String projId);
    public List<BidSupplierQuota> queryRealQuotaRank(@Param("projId") String projId);
    
    public void insertSupplierQuota(BidSupplierQuota quota);
    
}
