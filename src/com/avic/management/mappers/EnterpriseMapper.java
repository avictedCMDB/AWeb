package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.Enterprise;

@Repository
public interface EnterpriseMapper {
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
