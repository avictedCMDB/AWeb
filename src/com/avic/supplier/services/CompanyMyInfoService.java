package com.avic.supplier.services;

import com.avic.supplier.models.CompanyMyInfo;


public interface CompanyMyInfoService {
	/**
	 * 查询资料管理信息
	 * @return 
	 */
	public CompanyMyInfo queryCompanyMyInfo(CompanyMyInfo companyMyInfo);
	
	/**
	 * 修改资料管理信息
	 * @return 
	 */
	public void updateCompanyMyInfo(CompanyMyInfo companyMyInfo);
	/**
	 * 修改资料管理信息
	 * @return 
	 */
	public void updateCompanyMyInfo2(CompanyMyInfo companyMyInfo);
}
