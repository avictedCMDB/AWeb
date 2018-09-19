package com.avic.supervise.services;

import java.util.List;

import com.avic.supervise.models.Contract;

public interface ContractService {
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