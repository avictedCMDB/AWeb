package com.avic.management.services;

import java.util.List;

import com.avic.management.models.BidProjSupplier;
import com.avic.management.models.BidSupplierQuota;

public interface BidQuotaService {
    public List<BidSupplierQuota> queryQuotaListByProj(String projId, String name, int type);
}
