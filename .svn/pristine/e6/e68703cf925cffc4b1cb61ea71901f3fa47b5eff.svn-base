package com.avic.supplier.services.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supplier.mappers.SupplierExchangeMapper;
import com.avic.supplier.mappers.SupplierInfoExtMapper;
import com.avic.supplier.models.SupplierInfoExt;
import com.avic.supplier.services.SupplierInfoExtService;
@Service
public class SupplierInfoExtServiceImpl implements SupplierInfoExtService{
    @Autowired
    SupplierInfoExtMapper supplierInfoExtMapper;
	
	protected static final Log logger = LogFactory
	.getLog(SupplierInfoExtServiceImpl.class);
	
	@Override
	public SupplierInfoExt querySupplierInfoExt(SupplierInfoExt supplierInfoExt) {
		return supplierInfoExtMapper.querySupplierInfoExt(supplierInfoExt);
	}

	@Override
	public void saveSupplierInfoExt(SupplierInfoExt supplierInfoExt) {
		supplierInfoExtMapper.saveSupplierInfoExt(supplierInfoExt);
	}

}
