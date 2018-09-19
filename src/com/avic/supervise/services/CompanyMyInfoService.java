package com.avic.supervise.services;

import com.avic.supervise.models.CompanyMyInfo;



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
	/**
	 * ��ѯ��½�û���Ӧ��ҵ��id�ж�����ҵ����Ա����ƽ̨����Ա
	 * @return 
	 */
	public CompanyMyInfo queryParentCompanyID(CompanyMyInfo companyMyInfo);
	/**
	 * ��ѯ���Ϲ�����Ϣ
	 * @return 
	 */
	public CompanyMyInfo queryCompanyMyInfoByCompanyID(CompanyMyInfo companyMyInfo);
	/**
	 * ���
	 * @return 
	 */
	public void check(CompanyMyInfo companyMyInfo);
	/**
	 *����ID
	 * @return 
	 */
	public String queryCompanyIndex();
	
	/**
	 * ������ҵ����
	 * @return 
	 */
	public void addCompanyMyInfo(CompanyMyInfo companyMyInfo);
	/**
	 * ���
	 * @return 
	 */
	public void checkSupInfo(String id,String valid);
}