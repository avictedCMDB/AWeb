package com.avic.supplier.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.supplier.mappers.BidContractMapper;
import com.avic.supplier.mappers.SupplierContractMapper;
import com.avic.supplier.mappers.SupplierProjectMapper;
import com.avic.supplier.models.BidContract;
import com.avic.supplier.models.SupplierContract;
import com.avic.supplier.services.SupplierContractService;

@Service
public class SupplierContractServiceImpl implements SupplierContractService {

    @Autowired
    SupplierContractMapper supplierContractMapper;
    
    @Autowired
    SupplierProjectMapper supplierProjectMapper;
    
    @Autowired
    BidContractMapper bidContractMapper;
    @Override
    public List<SupplierContract> selectContractFile(String projId, String supCode) {
        return supplierContractMapper.selectContractFile(projId, supCode);
    }

    @Override
    public int selectMaxVersion(String projId, String supCode) {
        return supplierContractMapper.selectMaxVersion(projId, supCode);
    }
    
    @Transactional
    @Override
    public void updateContract(BidContract c) {
        supplierContractMapper.updateContractStatus(c.getProjId(), c.getSupCode());
        bidContractMapper.updateContract(c);
    }
    @Override
    public SupplierContract selectContractFileById(String projId, String supCode, String fileId) {
        return supplierContractMapper.selectContractFileById(projId, supCode, fileId);
    }
    
    @Override
    public BidContract selectContract(String projId, String supCode) {
        return bidContractMapper.queryContractByProj(projId, supCode);
    }
}
