package com.avic.management.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.SupAreaMapper;
import com.avic.management.models.SupArea;
import com.avic.management.services.SupAreaService;

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

    @Override
    public List<SupArea> queryAllAreas(String supId) {
        return supAreaMapper.queryAllAreas(supId);
    }
    
    @Override
    public String queryAreaNameById(String areaId) {
        SupArea area = supAreaMapper.queryAreaById("1", areaId);
        
        return area == null ? null : area.getSupAreaName();
    }

}
