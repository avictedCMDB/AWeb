package com.avic.supplier.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.supplier.models.SupplierCodeList;
import com.avic.supplier.models.SupplierReturn;

@Repository
public interface SupplierReturnMapper {

	public List<SupplierReturn> queryRerurnOrderList(SupplierReturn supplierReturn);
	
	public Integer queryRerurnOrderListCount(SupplierReturn supplierReturn);
	
	public List<SupplierCodeList> queryReturnStatusList();
	
	public List<SupplierReturn> queryReturnOrderDetailed(SupplierReturn supplierReturn);
	
	public void updateReturnOrderStatus(SupplierReturn supplierReturn) ;
	
}
