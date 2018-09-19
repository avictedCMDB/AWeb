package com.avic.market.mappers;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.market.models.BidProjSupplier;

@Repository
public interface BidProjSupplierMapper {
    public BidProjSupplier querySupplierById(@Param("projId") String projId, @Param("supCode") String supCode);
    public void insertProjSupplier(BidProjSupplier sup);
    
    public void updateTrialThreshold(@Param("projId") String projId, @Param("supCode") String supCode, @Param("val") int val);
    public void updateRealThreshold(@Param("projId") String projId, @Param("supCode") String supCode, @Param("val") int val);
    
    public void updateTrialQuota(@Param("projId") String projId, @Param("supCode") String supCode, @Param("quota") int quota, @Param("round") int round);
    public void updateRealQuota(@Param("projId") String projId, @Param("supCode") String supCode, @Param("quota") int quota, @Param("round") int round);
    
    public BidProjSupplier queryAwardSupplier(@Param("projId") String projId);
    
    public void updateTrialLoginStatus(@Param("projId") String projId, @Param("supCode") String supCode);
    public void updateRealLoginStatus(@Param("projId") String projId, @Param("supCode") String supCode);
}
