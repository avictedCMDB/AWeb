package com.avic.supervise.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.supervise.models.Company;
import com.avic.supervise.models.SupplierRecommend;

@Repository
public interface CompanyMapper {
	/**
	 *��ѯ�����ɹ���λ
	 * @return 
	 */
	public List<Company> queryCooperateCompany(Company company);
	/**
	 *��ѯ�����޺����Ĳɹ���λ 
	 * @return 
	 */
	public List<Company> queryNoCooperateCompany(Company company);
	/**
	 *��ѯ�����ɹ���λ����
	 * @return 
	 */
	public int getCompanyCount(Company company);
	/**
	 *��Ӻ����ɹ���λ
	 * @return 
	 */
	public void addCompanyMapping(Company company);
	
	/**
	 *ɾ��������λ
	 * @return 
	 */
	public void delCommpanyMapping(Company company);
}
