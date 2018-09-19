package com.avic.management.services;

import java.util.List;

import com.avic.management.models.BidContract;
import com.avic.management.models.BidContractFile;

public interface BidContractService {
    public List<BidContractFile> queryContractFileList(String projId, String supCode);
    public BidContractFile queryContractFileById(String projId, String supCode, String fileId);

    public void updateContractStatus(String projId, String supCode, int contractStatus, String contractRemark);
    
    public BidContract queryContractByProj(String projId, String supCode);
    public void insertContract(BidContract c);
}
