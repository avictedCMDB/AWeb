package com.avic.market.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.market.models.Supplier;

@Repository
public interface SupplierMapper {
    public List<Supplier> querySupplierList();
    public void updateSupplierToken(Supplier supplier);
    public Supplier querySupplierById(@Param("supId") int supiId);
    public List<Supplier> queryNewTraSup();
    public List<Supplier> queryRecommandTraSup();
    public List<Supplier> queryRecommandSup(@Param("num") int num);
    public List<Supplier> queryMyTraSup(@Param("compId") String compId);
    public int queryMappingSupCount(@Param("comp") String comp, @Param("sup") String sup);
}
