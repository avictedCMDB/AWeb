package com.avic.management.services;

import java.util.List;

import com.avic.management.models.Enterprise;

public interface EnterpriseService {
	/**
	 * ��ѯѯ���б�
	 * @return 
	 */
	public List<Enterprise> queryEnterprises(Enterprise enterprise);
	
	/**
	 * ��ѯѯ������
	 * @return 
	 */
	public int queryEnterpriseCount(Enterprise enterprise);
	/**
	 * ɾ��ѯ����Ʒ
	 * @return 
	 */
	public void deleteEnterpriseGood(Enterprise enterprise);
}
