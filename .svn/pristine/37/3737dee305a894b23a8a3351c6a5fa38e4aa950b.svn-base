package com.avic.management.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.ServicesMapper;
import com.avic.management.models.Services;
import com.avic.management.services.ServicesService;

@Service
public class ServicesServiceImpl implements ServicesService {
    protected static final Log logger = LogFactory.getLog(ServicesServiceImpl.class);

    @Autowired
    ServicesMapper servicesMapper;

	@Override
	public void updateServices(Services services) {
		servicesMapper.updateServices(services);
	}

	@Override
	public List<Services> queryExchangeServices(Services services) {
		return servicesMapper.queryExchangeServices(services);
	}

	@Override
	public List<Services> queryRefoundServices(Services services) {
		return servicesMapper.queryRefoundServices(services);
	}

}