package com.avic.management.services;

import com.avic.management.models.CompanyMyInfo;

public interface CompanyMyInfoService {
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
