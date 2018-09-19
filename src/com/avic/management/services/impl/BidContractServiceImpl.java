package com.avic.management.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.management.mappers.BidContractFileMapper;
import com.avic.management.mappers.BidContractMapper;
import com.avic.management.mappers.BidProjSupplierMapper;
import com.avic.management.models.BidContract;
import com.avic.management.models.BidContractFile;
import com.avic.management.services.BidContractService;

@Service
public class BidContractServiceImpl implements BidContractService {

    @Autowired
    BidContractFileMapper bidContractFileMapper;
    
    @Autowired
    BidProjSupplierMapper bidProjSupplierMapper;
    @Autowired
    BidContractMapper bidContractMapper;
    
    @Override
    public List<BidContractFile> queryContractFileList(String projId, String supCode) {
        return bidContractFileMapper.queryContractFileList(projId, supCode);
    }

    @Override
    public BidContractFile queryContractFileById(String projId, String supCode, String fileId) {
        return bidContractFileMapper.queryContractFileById(projId, supCode, fileId);
    }
    
    @Transactional
    @Override
    public void updateContractStatus(String projId, String supCode, int contractStatus, String contractRemark) {
        bidProjSupplierMapper.updateSupplierContractStatus(projId, supCode, contractStatus, contractRemark);
        if (contractStatus == 3) {
            bidContractMapper.updateContractSignDate(projId, supCode);
        }
    }

    @Transactional
    @Override
    public void insertContract(BidContract c) {
        bidContractMapper.insertContract(c);
        bidProjSupplierMapper.updateSupplierContract(c.getProjId(), c.getSupCode());
    }
    
    @Override
    public BidContract queryContractByProj(String projId, String supCode) {
        return bidContractMapper.queryContractByProj(projId, supCode);
    }
}
