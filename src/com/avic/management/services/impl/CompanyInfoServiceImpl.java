package com.avic.management.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.CompanyInfoMapper;
import com.avic.management.models.CompanyInfo;
import com.avic.management.services.CompanyInfoService;

@Service
public class CompanyInfoServiceImpl implements CompanyInfoService {
    
    @Autowired
    CompanyInfoMapper companyInfoMapper;

    @Override
    public CompanyInfo queryCompanyInfoById(String id) {
        return companyInfoMapper.queryCompanyInfoById(id);
    }

    @Override
    public CompanyInfo queryCompanyInfoByCode(String code) {
        return companyInfoMapper.queryCompanyInfoByCode(code);
    }

}
