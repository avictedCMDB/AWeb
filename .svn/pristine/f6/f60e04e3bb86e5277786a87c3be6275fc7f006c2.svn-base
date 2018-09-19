package com.avic.supervise.services.impl.bid;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.management.models.BidProjSupplier;
import com.avic.supervise.mappers.bid.BidProjSupplierMapper;
import com.avic.supervise.services.bid.BidSupplierService;



@Service
public class BidSupplierServiceImpl implements BidSupplierService {
    
    @Autowired
    BidProjSupplierMapper bidProjSupplierMapper;

    @Override
    public int querySupplierCount(String userId, String projId, String projName, String supName, String publishTime, int projType, int auditStatus) {
        return bidProjSupplierMapper.querySupplierCount(userId, projId, projName, supName, publishTime, projType, auditStatus);
    }

    @Override
    public List<BidProjSupplier> querySupplierList(String userId, String projId, String projName, String supName, String publishTime,
            int projType, int auditStatus, int page, int size) {
        if (page < 1) {
            page = 1;
        }
        
        int start = (page - 1) * size + 1;
        int end  = start + size - 1;
        return bidProjSupplierMapper.querySupplierList(userId, projId, projName, supName, publishTime, projType, auditStatus, start, end);
    }

    @Override
    public BidProjSupplier queryProjSupplier(String projId, String supCode) {
        return bidProjSupplierMapper.queryProjSupplier(projId, supCode);
    }
    
    @Override
    public boolean existsBidNum(String projId, String bidNum) {
        return bidProjSupplierMapper.queryBidNumCount(projId, bidNum) > 0;
    }
    
    @Transactional
    @Override
    public void updateSupplierAudit(BidProjSupplier sup) {
        bidProjSupplierMapper.updateSupplierAudit(sup);
    }
    
    @Override
    public List<BidProjSupplier> querySupInfoByProj(String projId) {
        return bidProjSupplierMapper.querySupInfoByProj(projId);
    }
    
    @Override
    public List<BidProjSupplier> queryAuditPassSupByProj(String projId, String supName) {
        return bidProjSupplierMapper.queryAuditPassSupByProj(projId, supName);
    }
    
    @Override
    public void updateSupplierRealBan(String projId, String supCode, int ban) {
        bidProjSupplierMapper.updateSupplierRealBan(projId, supCode, ban);
    }
    
    @Override
    public void updateSupplierTrialBan(String projId, String supCode, int ban) {
        bidProjSupplierMapper.updateSupplierTrialBan(projId, supCode, ban); 
    }
    
    @Override
    public List<BidProjSupplier> queryQuateSupplier(String projId) {
        return bidProjSupplierMapper.queryQuateSupplier(projId);
    }
    
    @Override
    public BidProjSupplier queryAwardSupplier(String projId) {
        return bidProjSupplierMapper.queryAwardSupplier(projId);
    }
    
    @Override
    public int querySupplierContractCount(String userId, String projId, String projName, int contractStatus, String startTime, String endTime) {
        return bidProjSupplierMapper.querySupplierContractCount(userId, projId, projName, contractStatus, startTime, endTime);
    }
    
    @Override
    public List<BidProjSupplier> querySupplierContractList(String userId, String projId, String projName, int contractStatus, String startTime,
            String endTime, int page, int size) {
        if (page < 1) {
            page = 1;
        }
        
        int start = (page - 1) * size + 1;
        int end  = start + size - 1;
        return bidProjSupplierMapper.querySupplierContractList(userId, projId, projName, contractStatus, startTime, endTime, start, end);
    }
    public List<BidProjSupplier> queryLoginSupplier(String projId, int type) {
        if (type == 2) {
            return bidProjSupplierMapper.queryRealLoginSupplier(projId);
        } else {
            return bidProjSupplierMapper.queryTrialLoginSupplier(projId);
        }
    }
}
