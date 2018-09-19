package com.avic.supplier.services;

import java.util.List;

import com.avic.supplier.models.BidContract;
import com.avic.supplier.models.SupplierContract;

public interface SupplierContractService {
    public List<SupplierContract> selectContractFile(String projId, String supCode);
    public int selectMaxVersion(String projId, String supCode);
    public void updateContract(BidContract c);
    public SupplierContract selectContractFileById(String projId, String supCode, String fileId);
    public BidContract selectContract(String projId, String supCode);
}
