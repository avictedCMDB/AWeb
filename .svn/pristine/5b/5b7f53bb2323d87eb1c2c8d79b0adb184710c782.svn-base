package com.avic.supplier.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supplier.mappers.SupAreaMapper;
import com.avic.supplier.models.SupArea;
import com.avic.supplier.services.SupAreaService;


@Service
public class SupAreaServiceImpl implements SupAreaService {
    protected static final Log logger = LogFactory.getLog(SupAreaServiceImpl.class);

    @Autowired
    SupAreaMapper supAreaMapper;

	@Override
	public List<SupArea> queryAreas(SupArea supArea) {
		//传统供应商默认地址为晨光地址
		if ("1".equals(supArea.getSupType())) {
			// 设置为晨光地址
			supArea.setSupID("1");
			
		}
		return supAreaMapper.queryAreas(supArea);
	}

	@Override
	public List<SupArea> querySubAreas(SupArea supArea) {
		//传统供应商默认地址为晨光地址
		if ("1".equals(supArea.getSupType())) {
			// 设置为晨光地址
			supArea.setSupID("1");
			
		}
		return supAreaMapper.querySubAreas(supArea);
	}



}
