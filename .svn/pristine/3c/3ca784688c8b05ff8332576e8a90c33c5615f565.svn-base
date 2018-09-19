package com.avic.management.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.BidSupplierQuota;

@Repository
public interface BidSupplierQuotaMapper {
    public List<BidSupplierQuota> queryQuotaListByProj(@Param("projId") String projId, @Param("name") String name, @Param("type") int type);
}
