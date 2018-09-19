package com.avic.market.services;

import java.util.List;

import com.avic.market.models.Supplier;

public interface SupplierService {
    public List<Supplier> getNewTraSup();
    public List<Supplier> getRecommandTraSup();
    public List<Supplier> getRecommandSup(int sup);
    public List<Supplier> getMyTraSup(String compId);
    
    public boolean checkNeedCA(String comp, String sup);
}
