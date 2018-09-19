package com.avic.management.services.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.avic.management.mappers.ManagementMapper;
import com.avic.management.models.Management;
import com.avic.management.services.ManagementService;

@Service
public class ManagementServiceImpl implements ManagementService {
    protected static final Log logger = LogFactory.getLog(ManagementServiceImpl.class);

    @Autowired
    ManagementMapper managementMapper;

	@Override
	public Management queryManagementCount(Management management) {
		return managementMapper.queryManagementCount(management);
	}

}
