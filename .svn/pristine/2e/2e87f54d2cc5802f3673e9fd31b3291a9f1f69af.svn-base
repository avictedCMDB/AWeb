package com.avic.management.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.CompanyMyInfoMapper;
import com.avic.management.models.CompanyMyInfo;
import com.avic.management.services.CompanyMyInfoService;

@Service
public class CompanyMyInfoServiceImpl implements CompanyMyInfoService {
    
    @Autowired
    CompanyMyInfoMapper companyMyInfoMapper;

	@Override
	public CompanyMyInfo queryCompanyMyInfo(CompanyMyInfo companyMyInfo) {
		return companyMyInfoMapper.queryCompanyMyInfo(companyMyInfo);
	}

	@Override
	public void updateCompanyMyInfo(CompanyMyInfo companyMyInfo) {
		companyMyInfoMapper.updateCompanyMyInfo(companyMyInfo);
	}

	@Override
	public void updateCompanyMyInfo2(CompanyMyInfo companyMyInfo) {
		companyMyInfoMapper.updateCompanyMyInfo2(companyMyInfo);
	}


}
