package com.avic.management.services.impl;


import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.ProductCompareMapper;
import com.avic.management.models.ProductCompare;
import com.avic.management.services.ProductCompareService;

@Service
public class ProductCompareServiceImpl implements ProductCompareService {
    protected static final Log logger = LogFactory.getLog(ProductCompareServiceImpl.class);

    @Autowired
    ProductCompareMapper productCompareMapper;

	@Override
	public ProductCompare queryProductCompare(ProductCompare productCompare) {
		return productCompareMapper.queryProductCompare(productCompare);
	}

	@Override
	public void addProductCompare(ProductCompare productCompare) {
		productCompareMapper.addProductCompare(productCompare);
	}

	@Override
	public void updateProductCompare(ProductCompare productCompare) {
		productCompareMapper.updateProductCompare(productCompare);
	}

	@Override
	public List<ProductCompare> queryProductCompares(
			ProductCompare productCompare) {
		return productCompareMapper.queryProductCompares(productCompare);
	}

	@Override
	public void delProductCompare(ProductCompare productCompare) {
		productCompareMapper.delProductCompare(productCompare);
	}

	@Override
	public int queryProductCompareCount(ProductCompare productCompare) {
		return productCompareMapper.queryProductCompareCount(productCompare);
	}

	@Override
	public List<ProductCompare> queryCompareIDS(ProductCompare productCompare) {
		return productCompareMapper.queryCompareIDS(productCompare);
	}

	@Override
	public List<ProductCompare> queryAuditProductCompares(
			ProductCompare productCompare) {
		return productCompareMapper.queryAuditProductCompares(productCompare);
	}

	@Override
	public int queryAuditProductCompareCount(ProductCompare productCompare) {
		return productCompareMapper.queryAuditProductCompareCount(productCompare);
	}

	@Override
	public int queryCompareIDSCountByOrderID(ProductCompare productCompare) {
		return productCompareMapper.queryCompareIDSCountByOrderID(productCompare);
	}

    
}
