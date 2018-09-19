package com.avic.supplier.mappers;

import org.springframework.stereotype.Repository;

import com.avic.supplier.models.CompanyMyInfo;


@Repository
public interface CompanyMyInfoMapper {

	/**
	 * ��ѯ���Ϲ�����Ϣ
	 * @return 
	 */
	public CompanyMyInfo queryCompanyMyInfo(CompanyMyInfo companyMyInfo);
	
	/**
	 * �޸����Ϲ�����Ϣ
	 * @return 
	 */
	public void updateCompanyMyInfo(CompanyMyInfo companyMyInfo);
	

	/**
	 * �޸����Ϲ�����Ϣ
	 * @return 
	 */
	public void updateCompanyMyInfo2(CompanyMyInfo companyMyInfo);
}
