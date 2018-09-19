package com.avic.supplier.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.supplier.models.SupplierAddress;
import com.avic.supplier.models.SupplierExpress;


@Repository
public interface SupplierExpressMapper {
	/**
	 * 查询地址列表
	 * @return 
	 */
	public List<SupplierExpress> querySupplierExpressList(SupplierExpress supplierExpress);
	
	
	public Integer querySupplierExpressListCount(SupplierExpress supplierExpress);
	/**
	 * 查看地址
	 * @return 
	 */
	public SupplierExpress querySupplierExpress(@Param("expressId") String expressId);
	
	/**
	 * 更改信息
	 * @return 
	 */
	public void updateSupplierExpress(SupplierExpress supplierExpress);
//	
//	/**
//	 * 查询供应商主键
//	 * @return
//	 */
//	public String querySupplierIndex();
	
	/**
	 * 删除地址
	 * @return 
	 */
	public void deleteSupplierExpress(@Param("expressId") String expressId);
	
	/**
	 * 添加地址
	 * @return 
	 */
	public void insertSupplierExpress(SupplierExpress supplierExpress);
}
