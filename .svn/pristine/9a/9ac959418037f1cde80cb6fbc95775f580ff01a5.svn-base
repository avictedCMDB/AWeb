package com.avic.supervise.services.impl.bid;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.models.BidSupplierQuota;
import com.avic.supervise.mappers.bid.BidSupplierQuotaMapper;
import com.avic.supervise.services.bid.BidQuotaService;


@Service
public class BidQuotaServiceImpl implements BidQuotaService {
    
    @Autowired
    BidSupplierQuotaMapper bidSupplierQuotaMapper;

    @Override
    public List<BidSupplierQuota> queryQuotaListByProj(String projId, int type) {
        return bidSupplierQuotaMapper.queryQuotaListByProj(projId, type);
    }

}
