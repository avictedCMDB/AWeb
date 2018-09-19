package com.avic.supplier.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supplier.mappers.CompanyInfoMapper;
import com.avic.supplier.models.CompanyInfo;
import com.avic.supplier.services.CompanyInfoService;

@Service
public class CompanyInfoServiceImpl implements CompanyInfoService {
    
    @Autowired
    CompanyInfoMapper companyInfoMapper;

    @Override
    public CompanyInfo queryCompanyInfoById(String companyId) {
        return companyInfoMapper.queryCompanyInfoById(companyId);
    }

    @Override
    public CompanyInfo queryCompanyInfoByCode(String companyCode) {
        return companyInfoMapper.queryCompanyInfoByCode(companyCode);
    }

}
