package com.avic.supervise.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.supervise.models.Contract;

@Repository
public interface ContractMapper {
	/**
	 *��ѯ��ͬ
	 * @return 
	 */
	public List<Contract> queryContract(Contract contract);
	/**
	 *��ѯ��ͬ����
	 * @return 
	 */
	public int queryContractCount(Contract contract);
	
	/**
	 * ��ȡ����״̬�б�
	 */
	public List<Contract> getOrderStatusList();
	
	/**
	 * ��ȡ��ͬ·��
	 */
	public String getFilePath(String contract_code);
}