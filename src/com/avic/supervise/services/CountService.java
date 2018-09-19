package com.avic.supervise.services;

import java.util.List;

import com.avic.common.exceptions.ServiceException;
import com.avic.supervise.models.Company;
import com.avic.supervise.models.Count;
import com.avic.supervise.models.Invoice;

public interface CountService {
	/**
	 * ��ѯͳ�ƹ�Ӧ������
	 * @return 
	 */
	public List<Count> queryCountBySupID(Count count);
	/**
	 * ��ѯͳ�ƹ�Ӧ���˿�����
	 * @return 
	 */
	public List<Count> queryRefundCountBySupID(Count count);
	
	/**
	 * ��ѯͳ����ҵ��λ����
	 * @return 
	 */
	public List<Count> queryCountByCompanyID(Count count);
	/**
	 * ��ѯͳ����ҵ��λ�˿�����
	 * @return 
	 */
	public List<Count> queryRefundCountByCompanyID(Count count);
	/**
	 * ��ѯͳ��������ҵ����
	 * @return 
	 */
	public List<Count> queryCountSupAll(Count count);
	/**
	 * ��ѯͳ�����е�λ����
	 * @return 
	 */
	public List<Count> queryCountCompanyAll(Count count);
	/**
	 * ��ѯͳ�����е�λ�˿�����
	 * @return 
	 */
	public List<Count> queryRefundCountCompanyAll(Count count);
	/**
	 * ��ѯ���е�λ
	 * @return 
	 */
	public List<Company> queryCompany();
	/**
	 * ��ѯͳ��������ҵ�˿�����
	 * @return 
	 */
	public List<Count> queryRefundCountSupAll(Count count);
}