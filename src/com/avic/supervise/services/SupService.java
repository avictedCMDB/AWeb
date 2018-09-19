package com.avic.supervise.services;

import java.util.List;

import com.avic.supervise.models.SupArea;
import com.avic.supervise.models.SupInfo;

public interface SupService {
    public List<SupInfo> getSupList();
    public String getSupName(int supId);
    public SupInfo getSup(int supId);
    public List<SupArea> getSupArea(int supId, int parent);
}