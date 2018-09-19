package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.Services;


@Repository
public interface ServicesMapper {
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
