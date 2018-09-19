package com.avic.supervise.services.bid;

import java.util.List;

import com.avic.management.models.BidSupplierQuota;

public interface BidQuotaService {
    public List<BidSupplierQuota> queryQuotaListByProj(String projId, int type);
}
