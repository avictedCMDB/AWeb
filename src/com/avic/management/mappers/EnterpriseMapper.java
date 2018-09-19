package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.Enterprise;

@Repository
public interface EnterpriseMapper {
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
