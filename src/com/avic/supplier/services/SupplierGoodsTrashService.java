package com.avic.supplier.services;

import com.avic.supplier.models.SupplierGoodsInfo;

public interface SupplierGoodsTrashService {

	/**
	 * 查询商品信息
	 * @return 
	 */
	public SupplierGoodsInfo query(SupplierGoodsInfo supplierGoodsInfo);
}
