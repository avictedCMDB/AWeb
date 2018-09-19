package com.avic.market.services;

import java.util.List;

import com.avic.market.models.BidProjSupplier;
import com.avic.market.models.BidSupplierQuota;

public interface BidQuotaService {

    public BidProjSupplier getSupplier(String projId, String supCode);
    public void joinSupplier(String projId, String supCode);
    
    public void updateSupplierTrialThreshold(String projId, String supCode, int val);
    public void updateSupplierRealThreshold(String projId, String supCode, int val);
    
    public List<BidSupplierQuota> getTrialSupplierQuota(String projId, String supCode);
    public List<BidSupplierQuota> getRealSupplierQuota(String projId, String supCode);
    
    public List<BidSupplierQuota> getTrialQuotaRank(String projId);
    public List<BidSupplierQuota> getRealQuotaRank(String projId);
    
    public void quota(BidSupplierQuota quota);
    
    public void updateTrialLoginStatus(String projId, String supCode);
    public void updateRealLoginStatus(String projId, String supCode);
}
