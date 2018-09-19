package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.ProductCompare;

@Repository
public interface ProductCompareMapper {
	/**
	 * 查询比对信息列表
	 * @return 
	 */
	public List<ProductCompare> queryProductCompares(ProductCompare productCompare);
	/**
	 * 查询比对信息
	 * @return 
	 */
	public ProductCompare queryProductCompare(ProductCompare productCompare);
	/**
	 * 添加比对信息
	 * @return 
	 */
	public void addProductCompare(ProductCompare productCompare);
	/**
	 * 修改比对信息
	 * @return 
	 */
	public void updateProductCompare(ProductCompare productCompare);
	/**
	 * 删除比对信息
	 * @return 
	 */
	public void delProductCompare(ProductCompare productCompare);
	/**
	 * 查询比对商品列表数量
	 * @return 
	 */
	public int queryProductCompareCount(ProductCompare productCompare);
	/**
	 * 根据订单ID查询比对ID
	 * @return 
	 */
	public List<ProductCompare> queryCompareIDS(ProductCompare productCompare);
	/**
	 * 查询审核比对信息列表
	 * @return 
	 */
	public List<ProductCompare> queryAuditProductCompares(ProductCompare productCompare);
	/**
	 * 查询审核比对商品列表数量
	 * @return 
	 */
	public int queryAuditProductCompareCount(ProductCompare productCompare);
	/**
	 * 查询是否存在比对ID
	 * @return 
	 */
	public int queryCompareIDSCountByOrderID(ProductCompare productCompare);
}
