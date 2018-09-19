package com.avic.supplier.services.impl;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supplier.mappers.SupplierMapper;
import com.avic.supplier.models.Supplier;
import com.avic.supplier.services.SupplierService;


@Service
public class SupplierServiceImpl implements SupplierService {
    protected static final Log logger = LogFactory.getLog(SupplierServiceImpl.class);

    @Autowired
    SupplierMapper supplierMapper;

	@Override
	public Supplier querySupplierMainCount(String supID) {
		return supplierMapper.querySupplierMainCount(supID);
	}




}
