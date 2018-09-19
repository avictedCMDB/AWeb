package com.avic.supervise.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.supervise.models.CompanyInfo;

@Repository
public interface CompanyInfoMapper {
	/**
	 *查询公司
	 * @return 
	 */
	public List<CompanyInfo> queryCompanyInfoList(CompanyInfo companyInfo);
	
	/**
	 *查询公司
	 * @return 
	 */
	public CompanyInfo queryCompanyInfo(CompanyInfo companyInfo);
	
	/**
	 *查询公司数量
	 * @return 
	 */
	public int getCompanyInfoCount(CompanyInfo companyInfo);
	
	/**
	 * 修改公司信息
	 */
	public void updateCompanyInfo(CompanyInfo companyInfo);
	
	/**
	 * 添加公司信息
	 */
	public void addCompanyInfo(CompanyInfo companyInfo);
	
	/**
	 * 删除公司信息
	 */
	public void deleteCompany(CompanyInfo companyInfo);
	
	/**
	 * 删除供应商信息
	 */
	public void deleteSupInfo(CompanyInfo companyInfo);
	/**
	 *根据公司名称查询公司
	 * @return 
	 */
	public int getCompanyInfoCountByCompanyName(CompanyInfo companyInfo);
	
	/**
	 *查询采购单位
	 * @return 
	 */
	public List<CompanyInfo> querySupplierCompanyInfoList(CompanyInfo companyInfo);
	
	/**
	 *声称ID
	 * @return 
	 */
	public String getSeqID();
	
	/**
	 *查询采购单位部门
	 * @return 
	 */
	public List<CompanyInfo> queryDepartments(CompanyInfo companyInfo);
	
	/**
	 *查询企业部门
	 * @return 
	 */
	public List<CompanyInfo> queryOrganizationDepartments(CompanyInfo companyInfo);
	
	/**
	 *查询公司数量
	 * @return 
	 */
	public int getSupplierCompanyInfoCount(CompanyInfo companyInfo);
	
	/**
	 *查询部门下用户数量
	 * @return 
	 */
	public int queryOrganizationUserCount(CompanyInfo companyInfo);
	
	/**
	 *查询公司下部门数量
	 * @return 
	 */
	public int queryOrganizationDepartmentCount(CompanyInfo companyInfo);
	
	/**
	 * 删除部门以及子部门信息
	 */
	public void deleteCompanyDepartments(CompanyInfo companyInfo);
	
	/**
	 * 修改组织机构管理员密码
	 */
	public void updateSupUserPassword(@Param(value="password")String password,@Param(value="supID")String supID);
	
}
