package com.avic.management.services.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.CommonMapper;
import com.avic.management.services.CommonService;

@Service
public class CommonServiceImpl implements CommonService {
    protected static final Log logger = LogFactory.getLog(CommonServiceImpl.class);

    @Autowired
    CommonMapper commonMapper;

	@Override
	public String queryIndex() {
		return commonMapper.queryIndex();
	}



}
