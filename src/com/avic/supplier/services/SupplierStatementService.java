package com.avic.supplier.services;

import java.util.List;

import com.avic.supplier.models.SupplierStatement;

public interface SupplierStatementService {
	
	public List<SupplierStatement> queryStatmentList(SupplierStatement supplierStatement);
	
	public Integer queryStatmentListCount(SupplierStatement supplierStatement);
	
	public List<SupplierStatement> queryStatmentListDetailed(SupplierStatement supplierStatement);

}
