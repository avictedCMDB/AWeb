package com.avic.supplier.services;

import com.avic.supplier.models.SupplierUser;

public interface SupplierGoodsOnlineService {

	/**
	 * 查询账户信息
	 * @return 
	 */
	public SupplierUser queryLoginUser(SupplierUser supplierUser);
}
