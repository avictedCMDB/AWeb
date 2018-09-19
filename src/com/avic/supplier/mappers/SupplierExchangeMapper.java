package com.avic.supplier.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.supplier.models.SupplierCodeList;
import com.avic.supplier.models.SupplierExchange;
import com.avic.supplier.models.SupplierStatement;

@Repository
public interface SupplierExchangeMapper {
	
	public List<SupplierExchange> queryExchangeOrderList(
			SupplierExchange supplierExchange);

	public Integer queryExchangeOrderListCount(SupplierExchange supplierExchange);
	
	public List<SupplierCodeList> queryExchangeOrderStatusList();
	
	
	public List<SupplierExchange> queryExchangeOrderDetailed(SupplierExchange supplierExchange);
	
	public void updateExchangeOrderStatus(SupplierExchange supplierExchange);
	
}