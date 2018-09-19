package com.avic.management.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.SysCompanyHisMapper;
import com.avic.management.models.SysCompanyHis;
import com.avic.management.services.SysCompanyHisService;

@Service
public class SysCompanyHisServiceImpl implements SysCompanyHisService {
    
    @Autowired
    SysCompanyHisMapper sysCompanyHisMapper;

    @Override
    public SysCompanyHis queryCompanyHisBySupId(String supId) {
        return sysCompanyHisMapper.queryCompanyHisBySupId(supId);
    }

}
