package com.avic.management.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.BidSupplierQuotaMapper;
import com.avic.management.models.BidSupplierQuota;
import com.avic.management.services.BidQuotaService;

@Service
public class BidQuotaServiceImpl implements BidQuotaService {
    
    @Autowired
    BidSupplierQuotaMapper bidSupplierQuotaMapper;

    @Override
    public List<BidSupplierQuota> queryQuotaListByProj(String projId, String name, int type) {
        return bidSupplierQuotaMapper.queryQuotaListByProj(projId, name, type);
    }

}
