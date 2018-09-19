package com.avic.supervise.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supervise.mappers.SupMapper;
import com.avic.supervise.models.SupArea;
import com.avic.supervise.models.SupInfo;
import com.avic.supervise.services.SupService;

@Service
public class SupServiceImpl implements SupService {
    
    @Autowired
    SupMapper supMapper;
    
    private static List<SupInfo> list = null;
    
    static long time = 0;

    @Override
    public List<SupInfo> getSupList() {
        if (System.currentTimeMillis() - time > 3600 * 1000 || list == null) {
            list = supMapper.querySupInfoList();
            time = System.currentTimeMillis();
        }
        return list;
    }
    
    @Override
    public String getSupName(int supId) {
        for (SupInfo i : getSupList()) {
            if (i.getSupId() == supId) {
                return i.getSupName();
            }
        }
        
        return null;
    }
    
    @Override
    public SupInfo getSup(int supId) {
        for (SupInfo i : getSupList()) {
            if (i.getSupId() == supId) {
                return i;
            }
        }
        
        return null;
    }

    @Override
    public List<SupArea> getSupArea(int supId, int parent) {
        return supMapper.querySupArea(supId, parent);
    }
}
