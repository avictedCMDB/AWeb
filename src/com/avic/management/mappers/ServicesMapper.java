package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.Services;


@Repository
public interface ServicesMapper {
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
