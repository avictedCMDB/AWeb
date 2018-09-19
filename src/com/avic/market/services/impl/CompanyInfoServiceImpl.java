package com.avic.market.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.market.mappers.CompanyInfoMapper;
import com.avic.market.models.CompanyInfo;
import com.avic.market.services.CompanyInfoService;

@Service
public class CompanyInfoServiceImpl implements CompanyInfoService {
    
    @Autowired
    CompanyInfoMapper companyInfoMapper;

    @Override
    public List<CompanyInfo> getCompanyList() {
        return companyInfoMapper.queryCompanyList();
    }

    @Override
    public int queryCompanyCount() {
        return companyInfoMapper.queryCompanyCount();
    }
}
