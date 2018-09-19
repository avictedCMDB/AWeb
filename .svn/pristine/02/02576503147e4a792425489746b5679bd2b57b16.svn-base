package com.avic.supervise.services;

import java.util.List;

import com.avic.supervise.models.SupplierRecommend;

public interface SupplierRecommendService {
	/**
	 *查询推荐供应商
	 * @return 
	 */
	public List<SupplierRecommend> querySupplierRecommends(SupplierRecommend supplierRecommend);
	/**
	 *查询推荐供应商数量
	 * @return 
	 */
	public int querySupplierRecommendsCount(SupplierRecommend supplierRecommend);
	/**
	 *取消推荐供应商
	 * @return 
	 */
	public void setIfRecommend(SupplierRecommend supplierRecommend);
	/**
	 *查询推荐供应商
	 * @return 
	 */
	public SupplierRecommend getSupInfoBySupID(SupplierRecommend supplierRecommend);
	/**
	 * 修改推荐供应商推荐时间
	 * @return 
	 */
	public void updateSupInfoDate(SupplierRecommend supplierRecommend);
	/**
	 *查询推荐供应商扩展数量
	 * @return 
	 */
	public int getSupInfoExtBySupID(SupplierRecommend supplierRecommend);
	
	/**
	 * 修改推荐供应商扩展图片
	 * @return 
	 */
	public void updateSuperviseRecommendExtPic(SupplierRecommend supplierRecommend);
	/**
	 * 添加推荐供应商扩展图片
	 * @return 
	 */
	public void addSupInfoExt(SupplierRecommend supplierRecommend);
	/**
	 *查询供应商扩展信息图片路径 
	 * @return 
	 */
	public String getSupInfoExtImgPath(SupplierRecommend supplierRecommend);
}
