package com.avic.supplier.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supplier.mappers.SupplierGoodsEnquiryMapper;
import com.avic.supplier.models.SupplierGoodsEnquiry;
import com.avic.supplier.services.SupplierGoodsEnquiryService;
@Service
public class SupplierGoodsEnquiryServiceImpl implements SupplierGoodsEnquiryService{
	
	protected static final Log logger = LogFactory
	.getLog(SupplierGoodsEnquiryServiceImpl.class);
	
	@Autowired
	SupplierGoodsEnquiryMapper supplierGoodsEnquiryMapper;

	@Override
	public List<SupplierGoodsEnquiry> queryGoodsEnquiry(SupplierGoodsEnquiry supplierGoodsEnquiry) {
		return supplierGoodsEnquiryMapper.queryGoodsEnquiry(supplierGoodsEnquiry);
	}

	@Override
	public void updateGoodsEnquiry(SupplierGoodsEnquiry supplierGoodsEnquiry) {
		supplierGoodsEnquiryMapper.updateGoodsEnquiry(supplierGoodsEnquiry);
	}

	@Override
	public int queryGoodsEnquiryCount(SupplierGoodsEnquiry supplierGoodsEnquiry) {
		return this.supplierGoodsEnquiryMapper.queryGoodsEnquiryCount(supplierGoodsEnquiry);
	}
	
	

}