package com.avic.supervise.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.supervise.models.Company;
import com.avic.supervise.models.Count;
import com.avic.supervise.models.Invoice;

@Repository
public interface CountMapper {
	/**
	 * 查询统计供应商数据
	 * @return 
	 */
	public List<Count> queryCountBySupID(Count count);
	/**
	 * 查询统计供应商退款数据
	 * @return 
	 */
	public List<Count> queryRefundCountBySupID(Count count);	
	/**
	 * 查询统计企业单位数据
	 * @return 
	 */
	public List<Count> queryCountByCompanyID(Count count);
	/**
	 * 查询统计企业单位数据
	 * @return 
	 */
	public List<Count> queryRefundCountByCompanyID(Count count);
	/**
	 * 查询统计所有企业数据
	 * @return 
	 */
	public List<Count> queryCountSupAll(Count count);
	/**
	 * 查询统计所有单位数据
	 * @return 
	 */
	public List<Count> queryCountCompanyAll(Count count);
	/**
	 * 查询统计所有单位退款数据
	 * @return 
	 */
	public List<Count> queryRefundCountCompanyAll(Count count);
	/**
	 * 查询所有单位
	 * @return 
	 */
	public List<Company> queryCompany();
	/**
	 * 查询统计所有供应商退货数据.
	 * @return 
	 */
	public List<Count> queryRefundCountSupAll(Count count);
}
