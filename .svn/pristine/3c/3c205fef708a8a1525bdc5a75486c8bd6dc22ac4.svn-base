package com.avic.market.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.market.mappers.SupplierMapper;
import com.avic.market.models.Supplier;
import com.avic.market.services.SupplierService;

@Service
public class SupplierServiceImpl implements SupplierService {
    
    @Autowired
    SupplierMapper supplierMapper;

    @Override
    public List<Supplier> getNewTraSup() {
        return supplierMapper.queryNewTraSup();
    }

    @Override
    public List<Supplier> getRecommandTraSup() {
        return supplierMapper.queryRecommandTraSup();
    }

    @Override
    public List<Supplier> getRecommandSup(int num) {
        return supplierMapper.queryRecommandSup(num);
    }
    
    @Override
    public List<Supplier> getMyTraSup(String compId) {
        return supplierMapper.queryMyTraSup(compId);
    }
    
    @Override
    public boolean checkNeedCA(String comp, String sup) {
        return supplierMapper.queryMappingSupCount(comp, sup) > 0;
    }
}
