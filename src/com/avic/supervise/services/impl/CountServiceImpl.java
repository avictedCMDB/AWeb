package com.avic.supervise.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supervise.mappers.CountMapper;
import com.avic.supervise.models.Company;
import com.avic.supervise.models.Count;
import com.avic.supervise.services.CountService;

@Service
public class CountServiceImpl implements CountService {
    
    @Autowired
    CountMapper countMapper;

	@Override
	public List<Count> queryCountBySupID(Count count) {
		return countMapper.queryCountBySupID(count);
	}
	@Override
	public List<Count> queryRefundCountBySupID(Count count) {
		return countMapper.queryRefundCountBySupID(count);
	}

	@Override
	public List<Count> queryCountByCompanyID(Count count) {
		return countMapper.queryCountByCompanyID(count);
	}
	@Override
	public List<Count> queryRefundCountByCompanyID(Count count) {
		return countMapper.queryRefundCountByCompanyID(count);
	}
	@Override
	public List<Count> queryCountSupAll(Count count) {
		return countMapper.queryCountSupAll(count);
	}

	@Override
	public List<Count> queryCountCompanyAll(Count count) {
		return countMapper.queryCountCompanyAll(count);
	}
	@Override
	public List<Count> queryRefundCountCompanyAll(Count count) {
		return countMapper.queryRefundCountCompanyAll(count);
	}
	@Override
	public List<Company> queryCompany() {
		return countMapper.queryCompany();
	}

	@Override
	public List<Count> queryRefundCountSupAll(Count count) {
		return countMapper.queryRefundCountSupAll(count);
	}
}
