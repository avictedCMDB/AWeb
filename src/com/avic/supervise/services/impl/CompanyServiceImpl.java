package com.avic.supervise.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supervise.mappers.CompanyMapper;
import com.avic.supervise.mappers.SupplierRecommendMapper;
import com.avic.supervise.models.Company;
import com.avic.supervise.models.SupplierRecommend;
import com.avic.supervise.services.CompanyService;
import com.avic.supervise.services.SupplierRecommendService;

@Service
public class CompanyServiceImpl implements CompanyService {
    protected static final Log logger = LogFactory.getLog(CompanyServiceImpl.class);

    @Autowired
    CompanyMapper companyMapper;

	@Override
	public List<Company> queryCooperateCompany(Company company) {
		return companyMapper.queryCooperateCompany(company);
	}

	@Override
	public List<Company> queryNoCooperateCompany(Company company) {
		return companyMapper.queryNoCooperateCompany(company);
	}

	@Override
	public int getCompanyCount(Company company) {
		return companyMapper.getCompanyCount(company);
	}

	@Override
	public void delCommpanyMapping(Company company) {
		companyMapper.delCommpanyMapping(company);
	}

	@Override
	public void addCompanyMapping(Company company) {
		companyMapper.addCompanyMapping(company);
	}
    

}
