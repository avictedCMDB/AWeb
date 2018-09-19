package com.avic.supplier.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.supplier.models.SupplierContract;

@Repository
public interface SupplierContractMapper {
    public List<SupplierContract> selectContractFile(@Param("projId") String projId, @Param("supCode") String supCode);
    public int selectMaxVersion(@Param("projId") String projId, @Param("supCode") String supCode);
    public void insertContract(SupplierContract supplierContract);
    public void deleteContractByProjIdAndSupCode(@Param("projId") String projId, @Param("supCode") String supCode);
    public SupplierContract selectContractFileById(@Param("projId") String projId, @Param("supCode") String supCode, @Param("fileId") String fileId);
    
    public void updateContractStatus(@Param("projId") String projId, @Param("supCode") String supCode);
}
