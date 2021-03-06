package com.avic.supplier.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supplier.mappers.SupplierExchangeMapper;
import com.avic.supplier.mappers.SupplierOrderMapper;
import com.avic.supplier.mappers.SupplierReturnMapper;
import com.avic.supplier.models.SupplierCodeList;
import com.avic.supplier.models.SupplierExchange;
import com.avic.supplier.models.SupplierOrder;
import com.avic.supplier.models.SupplierReturn;
import com.avic.supplier.services.SupplierExchangeService;
import com.avic.supplier.services.SupplierReturnService;

@Service
public class SupplierReturnServiceImpl implements SupplierReturnService{
	
    protected static final Log logger = LogFactory.getLog(SupplierReturnServiceImpl.class);
    
    @Autowired
    SupplierReturnMapper supplierReturnMapper;
    
	@Autowired
    SupplierOrderMapper supplierOrderMapper;

	@Override
	public List<SupplierReturn> queryRerurnOrderList(
			SupplierReturn supplierReturn) {
		return supplierReturnMapper.queryRerurnOrderList(supplierReturn);
	}

	@Override
	public List<SupplierCodeList> queryReturnStatusList() {
		return supplierReturnMapper.queryReturnStatusList();
	}

	@Override
	public List<SupplierReturn> queryReturnOrderDetailed(
			SupplierReturn supplierReturn) {
		return supplierReturnMapper.queryReturnOrderDetailed(supplierReturn);
	}

	@Override
	public void updateReturnOrderStatus(SupplierReturn supplierReturn) {
		supplierReturnMapper.updateReturnOrderStatus(supplierReturn);
		List<SupplierReturn> list = supplierReturnMapper.queryRerurnOrderList(supplierReturn);
		SupplierOrder supplierOrder = new SupplierOrder();
		supplierOrder.setOrderId(list.get(0).getOrderId());
		if ("4".equals(supplierReturn.getRefoundStatus())) {
			supplierOrder.setOrderStatus("9");
			supplierOrderMapper.updateOrderStatus(supplierOrder);
		}else {
//			supplierOrder.setOrderStatus("8");
		}
//		supplierOrderMapper.updateOrderStatus(supplierOrder);
	}

	@Override
	public Integer queryRerurnOrderListCount(SupplierReturn supplierReturn) {
		return supplierReturnMapper.queryRerurnOrderListCount(supplierReturn);
	}
	
	
	

}
