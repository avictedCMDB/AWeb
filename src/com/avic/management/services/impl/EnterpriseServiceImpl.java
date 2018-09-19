package com.avic.management.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.EnterpriseMapper;
import com.avic.management.models.Enterprise;
import com.avic.management.services.EnterpriseService;

@Service
public class EnterpriseServiceImpl implements EnterpriseService {
    protected static final Log logger = LogFactory.getLog(EnterpriseServiceImpl.class);

    @Autowired
    EnterpriseMapper enterpriseMapper;

	@Override
	public List<Enterprise> queryEnterprises(Enterprise enterprise) {
		return enterpriseMapper.queryEnterprises(enterprise);
	}

	@Override
	public int queryEnterpriseCount(Enterprise enterprise) {
		return enterpriseMapper.queryEnterpriseCount(enterprise);
	}

	@Override
	public void deleteEnterpriseGood(Enterprise enterprise) {
		enterpriseMapper.deleteEnterpriseGood(enterprise);
	}


    
}
