package com.avic.supervise.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supervise.mappers.ContractMapper;
import com.avic.supervise.models.Contract;
import com.avic.supervise.services.ContractService;

@Service
public class ContractServiceImpl implements ContractService {
	protected static final Log logger = LogFactory.getLog(ContractServiceImpl.class);

    @Autowired
    ContractMapper contractMapper;

	@Override
	public List<Contract> queryContract(Contract contract) {
		return contractMapper.queryContract(contract);
	}

	@Override
	public int queryContractCount(Contract contract) {
		return contractMapper.queryContractCount(contract);
	}
	
	@Override
	public List<Contract> getOrderStatusList() {
		return contractMapper.getOrderStatusList();
	}
	
	@Override
	public String getFilePath(String contract_code){
		return contractMapper.getFilePath(contract_code);
	}
}
