package com.avic.management.services;

import java.util.List;

import com.avic.management.models.Enterprise;

public interface EnterpriseService {
	/**
	 * 查询询价列表
	 * @return 
	 */
	public List<Enterprise> queryEnterprises(Enterprise enterprise);
	
	/**
	 * 查询询价数量
	 * @return 
	 */
	public int queryEnterpriseCount(Enterprise enterprise);
	/**
	 * 删除询价商品
	 * @return 
	 */
	public void deleteEnterpriseGood(Enterprise enterprise);
}
