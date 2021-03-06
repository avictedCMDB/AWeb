package com.avic.supervise.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supervise.mappers.CompanyMyInfoMapper;
import com.avic.supervise.models.CompanyMyInfo;
import com.avic.supervise.services.CompanyMyInfoService;



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

	@Override
	public CompanyMyInfo queryParentCompanyID(CompanyMyInfo companyMyInfo) {
		return companyMyInfoMapper.queryParentCompanyID(companyMyInfo);
	}

	@Override
	public CompanyMyInfo queryCompanyMyInfoByCompanyID(
			CompanyMyInfo companyMyInfo) {
		return companyMyInfoMapper.queryCompanyMyInfoByCompanyID(companyMyInfo);
	}

	@Override
	public void check(CompanyMyInfo companyMyInfo) {
		companyMyInfoMapper.check(companyMyInfo);
	}

	@Override
	public String queryCompanyIndex() {
		return companyMyInfoMapper.queryCompanyIndex();
	}

	@Override
	public void addCompanyMyInfo(CompanyMyInfo companyMyInfo) {
		companyMyInfoMapper.addCompanyMyInfo(companyMyInfo);
	}

	public void checkSupInfo(String id,String valid) {
		companyMyInfoMapper.checkSupInfo(id,valid);
	}

}
