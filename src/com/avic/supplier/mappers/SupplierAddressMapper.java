package com.avic.supplier.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.supplier.models.SupCategory;
import com.avic.supplier.models.SupplierAddress;


@Repository
public interface SupplierAddressMapper {
	/**
	 * 查询地址列表
	 * @return 
	 */
	public List<SupplierAddress> querySupplierAddressList(SupplierAddress supplierAddress);
	
	public Integer querySupplierAddressListCount(SupplierAddress supplierAddress);
	
	/**
	 * 查看地址
	 * @return 
	 */
	public SupplierAddress querySupplierAddress(@Param("supAddressId") String supAddressId);
	
	/**
	 * 查询供应商主键
	 * @return
	 */
	public String querySupplierIndex();
	
	/**
	 * 删除地址
	 * @return 
	 */
	public void deleteSupplierAddress(@Param("supAddressId") String supAddressId);
	/**
	 * 设置默认地址
	 * @return 
	 */
	public void updateSupplierAddress(SupplierAddress supplierAddress);
	/**
	 * 添加地址
	 * @return 
	 */
	public void insertSupplierAddress(SupplierAddress supplierAddress);
}
