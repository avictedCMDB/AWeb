package com.avic.management.services;

import java.util.List;

import com.avic.management.models.Services;


public interface ServicesService {
	 /**
	 * ��������
	 */
	public List<Services> queryExchangeServices(Services services);
	
	/**
	 * �˻�����
	 */
	public List<Services> queryRefoundServices(Services services);
	
	/**
	 * �޸ķ���
	 * @return 
	 */
	public void updateServices(Services services);
}
