package com.avic.management.services;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avic.management.models.BidProjSupplier;

public interface BidSupplierService {
    public int querySupplierCount(String userId, String projId, String projName, String supName, String publishTime, int projType, int auditStatus);
    public List<BidProjSupplier> querySupplierList(String userId, String projId, String projName, String supName, String publishTime, int projType, int auditStatus, int page, int size);

    public BidProjSupplier queryProjSupplier(String projId, String supCode);
    public void updateSupplierAudit(BidProjSupplier sup);
    
    public boolean existsBidNum(String projId, String bidNum);
    
    public List<BidProjSupplier> querySupInfoByProj(String projId);
    public List<BidProjSupplier> queryAuditPassSupByProj(String projId, String supName);

    public void updateSupplierTrialBan(String projId, String supCode, int ban);
    public void updateSupplierRealBan(String projId, String supCode, int ban);
    
    public List<BidProjSupplier> queryQuateSupplier(String projId);
    public BidProjSupplier queryAwardSupplier(String projId);
    
    public int querySupplierContractCount(String userId, String projId, String projName, int contractStatus, String startTime, String endTime);
    public List<BidProjSupplier> querySupplierContractList(String userId, String projId, String projName, int contractStatus, String startTime, String endTime, int page, int size);
    

    public List<BidProjSupplier> queryLoginSupplier(String projId, int type);

}
