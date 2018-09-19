package com.avic.supervise.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.supervise.models.Contract;

@Repository
public interface ContractMapper {
	/**
	 *查询合同
	 * @return 
	 */
	public List<Contract> queryContract(Contract contract);
	/**
	 *查询合同数量
	 * @return 
	 */
	public int queryContractCount(Contract contract);
	
	/**
	 * 获取订单状态列表
	 */
	public List<Contract> getOrderStatusList();
	
	/**
	 * 获取合同路径
	 */
	public String getFilePath(String contract_code);
}