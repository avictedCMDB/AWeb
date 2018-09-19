package com.avic.supervise.services.impl;


import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supervise.mappers.SuperviseProductCompareMapper;
import com.avic.supervise.models.SuperviseProductCompare;
import com.avic.supervise.services.SuperviseProductCompareService;





@Service
public class SuperviseProductCompareServiceImpl implements SuperviseProductCompareService {
    protected static final Log logger = LogFactory.getLog(SuperviseProductCompareServiceImpl.class);

    @Autowired
    SuperviseProductCompareMapper productCompareMapper;

	@Override
	public SuperviseProductCompare queryProductCompare(SuperviseProductCompare productCompare) {
		return productCompareMapper.queryProductCompare(productCompare);
	}

	@Override
	public void addProductCompare(SuperviseProductCompare productCompare) {
		productCompareMapper.addProductCompare(productCompare);
	}

	@Override
	public void updateProductCompare(SuperviseProductCompare productCompare) {
		productCompareMapper.updateProductCompare(productCompare);
	}

	@Override
	public List<SuperviseProductCompare> queryProductCompares(
			SuperviseProductCompare productCompare) {
		return productCompareMapper.queryProductCompares(productCompare);
	}

	@Override
	public void delProductCompare(SuperviseProductCompare productCompare) {
		productCompareMapper.delProductCompare(productCompare);
	}

	@Override
	public int queryProductCompareCount(SuperviseProductCompare productCompare) {
		return productCompareMapper.queryProductCompareCount(productCompare);
	}

    
}
