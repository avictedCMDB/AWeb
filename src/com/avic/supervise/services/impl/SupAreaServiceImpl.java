package com.avic.supervise.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supervise.mappers.bid.SupAreaMapper;
import com.avic.supervise.services.SupAreaService;
import com.avic.management.models.SupArea;




@Service
public class SupAreaServiceImpl implements SupAreaService {
    protected static final Log logger = LogFactory.getLog(SupAreaServiceImpl.class);

    @Autowired
    SupAreaMapper supAreaMapper;

	@Override
	public List<SupArea> queryAreas(SupArea supArea) {
		return supAreaMapper.queryAreas(supArea);
	}

	@Override
	public List<SupArea> querySubAreas(SupArea supArea) {
		return supAreaMapper.querySubAreas(supArea);
	}

	
}
