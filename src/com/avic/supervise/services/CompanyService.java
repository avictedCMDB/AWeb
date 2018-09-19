package com.avic.supervise.services;

import java.util.List;

import com.avic.supervise.models.Company;
import com.avic.supervise.models.SupplierRecommend;

public interface CompanyService {
	/**
	 *查询合作采购单位
	 * @return 
	 */
	public List<Company> queryCooperateCompany(Company company);
	/**
	 *查询所有无合作的采购单位 
	 * @return 
	 */
	public List<Company> queryNoCooperateCompany(Company company);
	/**
	 *查询合作采购单位数量
	 * @return 
	 */
	public int getCompanyCount(Company company);
	/**
	 *添加合作采购单位
	 * @return 
	 */
	public void addCompanyMapping(Company company);
	/**
	 *删除合作单位
	 * @return 
	 */
	public void delCommpanyMapping(Company company);
}
