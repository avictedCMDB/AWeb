package com.avic.management.services;

import java.util.List;

import com.avic.management.models.Services;


public interface ServicesService {
	 /**
	 * 换货服务单
	 */
	public List<Services> queryExchangeServices(Services services);
	
	/**
	 * 退货服务单
	 */
	public List<Services> queryRefoundServices(Services services);
	
	/**
	 * 修改服务单
	 * @return 
	 */
	public void updateServices(Services services);
}
