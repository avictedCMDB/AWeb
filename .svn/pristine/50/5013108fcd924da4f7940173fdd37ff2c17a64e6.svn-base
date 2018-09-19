package com.avic.supplier.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supplier.mappers.SupplierAddressMapper;
import com.avic.supplier.mappers.SupplierExpressMapper;
import com.avic.supplier.models.SupplierExpress;
import com.avic.supplier.services.SupplierExpressService;
import com.avic.supplier.utils.CodeConstants;

@Service
public class SupplierExpressServiceImpl implements SupplierExpressService
{
    protected static final Log logger = LogFactory.getLog(SupplierExpressServiceImpl.class);
    
    @Autowired
    SupplierExpressMapper supplierExpressMapper;
    
    @Autowired
    SupplierAddressMapper supplierAddressMapper;

   	@Override
   	public List<SupplierExpress> querySupplierExpressList(SupplierExpress supplierExpress) {
   		return supplierExpressMapper.querySupplierExpressList(supplierExpress);
   	}

   	@Override
   	public void deleteSupplierExpress(String expressId) {
   		String [] expressIds = expressId.split(",");
   		for (int i = 0; i < expressIds.length; i++) {
   			supplierExpressMapper.deleteSupplierExpress(expressIds[i]);
   		}
   	}

   	@Override
   	public void updateSupplierExpress(SupplierExpress supplierExpress) {
   		// 如果修改为默认地址则清空以前的默认地址
   		if (CodeConstants.IS_DEFAULT.equals(supplierExpress.getIfDefault())) {
   			SupplierExpress unParam = new SupplierExpress();
   			unParam.setSupId(supplierExpress.getSupId());
   			unParam.setIfDefault(CodeConstants.NO_DEFAULT);
   			supplierExpressMapper.updateSupplierExpress(unParam);
		}
   		//清空 供应商ID
   		supplierExpress.setSupId(null);
   		supplierExpressMapper.updateSupplierExpress(supplierExpress);
   	}

	@Override
	public void insertSupplierExpress(SupplierExpress supplierExpress) {
		// 判断是否为默认地址
		if (CodeConstants.IS_DEFAULT.equals(supplierExpress.getIfDefault())) {
        	// 清空已设置的默认地址
        	SupplierExpress unParam = new SupplierExpress();
   			unParam.setSupId(supplierExpress.getSupId());
   			unParam.setIfDefault(CodeConstants.NO_DEFAULT);
   			supplierExpressMapper.updateSupplierExpress(unParam);
		}
		String index = supplierAddressMapper.querySupplierIndex();
		supplierExpress.setExpressId(index);
		supplierExpressMapper.insertSupplierExpress(supplierExpress);
	}

	@Override
	public SupplierExpress querySupplierExpress(String expressId) {
		return supplierExpressMapper.querySupplierExpress(expressId);
	}

	@Override
	public Integer querySupplierExpressListCount(SupplierExpress supplierExpress) {
		return supplierExpressMapper.querySupplierExpressListCount(supplierExpress);
	}

}
