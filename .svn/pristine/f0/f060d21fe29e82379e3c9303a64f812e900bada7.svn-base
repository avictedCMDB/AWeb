package com.avic.supplier.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supplier.mappers.SupplierStatementMapper;
import com.avic.supplier.models.SupplierStatement;
import com.avic.supplier.services.SupplierStatementService;

@Service
public class SupplierStatementServiceImpl implements SupplierStatementService{

    protected static final Log logger = LogFactory.getLog(SupplierStatementServiceImpl.class);
    
    @Autowired
    SupplierStatementMapper supplierStatementMapper;
	
	@Override
	public List<SupplierStatement> queryStatmentList(
			SupplierStatement supplierStatement) {
		return supplierStatementMapper.queryStatmentList(supplierStatement);
	}

	@Override
	public List<SupplierStatement> queryStatmentListDetailed(
			SupplierStatement supplierStatement) {
		return supplierStatementMapper.queryStatmentListDetailed(supplierStatement);
	}

	@Override
	public Integer queryStatmentListCount(SupplierStatement supplierStatement) {
		return supplierStatementMapper.queryStatmentListCount(supplierStatement);
	}

}
