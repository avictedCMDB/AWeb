package com.avic.supervise.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.supervise.models.CompanyInfo;

@Repository
public interface CompanyInfoMapper {
	/**
	 *��ѯ��˾
	 * @return 
	 */
	public List<CompanyInfo> queryCompanyInfoList(CompanyInfo companyInfo);
	
	/**
	 *��ѯ��˾
	 * @return 
	 */
	public CompanyInfo queryCompanyInfo(CompanyInfo companyInfo);
	
	/**
	 *��ѯ��˾����
	 * @return 
	 */
	public int getCompanyInfoCount(CompanyInfo companyInfo);
	
	/**
	 * �޸Ĺ�˾��Ϣ
	 */
	public void updateCompanyInfo(CompanyInfo companyInfo);
	
	/**
	 * ���ӹ�˾��Ϣ
	 */
	public void addCompanyInfo(CompanyInfo companyInfo);
	
	/**
	 * ɾ����˾��Ϣ
	 */
	public void deleteCompany(CompanyInfo companyInfo);
	
	/**
	 * ɾ����Ӧ����Ϣ
	 */
	public void deleteSupInfo(CompanyInfo companyInfo);
	/**
	 *���ݹ�˾���Ʋ�ѯ��˾
	 * @return 
	 */
	public int getCompanyInfoCountByCompanyName(CompanyInfo companyInfo);
	
	/**
	 *��ѯ�ɹ���λ
	 * @return 
	 */
	public List<CompanyInfo> querySupplierCompanyInfoList(CompanyInfo companyInfo);
	
	/**
	 *����ID
	 * @return 
	 */
	public String getSeqID();
	
	/**
	 *��ѯ�ɹ���λ����
	 * @return 
	 */
	public List<CompanyInfo> queryDepartments(CompanyInfo companyInfo);
	
	/**
	 *��ѯ��ҵ����
	 * @return 
	 */
	public List<CompanyInfo> queryOrganizationDepartments(CompanyInfo companyInfo);
	
	/**
	 *��ѯ��˾����
	 * @return 
	 */
	public int getSupplierCompanyInfoCount(CompanyInfo companyInfo);
	
	/**
	 *��ѯ�������û�����
	 * @return 
	 */
	public int queryOrganizationUserCount(CompanyInfo companyInfo);
	
	/**
	 *��ѯ��˾�²�������
	 * @return 
	 */
	public int queryOrganizationDepartmentCount(CompanyInfo companyInfo);
	
	/**
	 * ɾ�������Լ��Ӳ�����Ϣ
	 */
	public void deleteCompanyDepartments(CompanyInfo companyInfo);
	
	/**
	 * �޸���֯��������Ա����
	 */
	public void updateSupUserPassword(@Param(value="password")String password,@Param(value="supID")String supID);
	
}