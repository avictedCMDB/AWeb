package com.avic.management.services;

import java.util.List;

import com.avic.management.models.OffStandardRequire;
import com.avic.management.models.SupGoods;
import com.avic.management.models.SupInfo;

public interface OffStandardRequireService {
	/**
	 * 查询非标准商品列表
	 * @return 
	 */
	public List<OffStandardRequire> queryOffStandardRequires(OffStandardRequire offStandardRequire);
	/**
	 * 查询非标准商品
	 * @return 
	 */
	public List<SupGoods> queryGoodsByGoodsIDS(OffStandardRequire offStandardRequire);
	/**
	 * 查询非标准供应商
	 * @return 
	 */
	public List<SupInfo> querySupInfosBySupIDS(OffStandardRequire offStandardRequire);
	/**
	 * 查询非标准商品数量
	 * @return 
	 */
	public int queryOffStandardRequiresCount(OffStandardRequire offStandardRequire);
	/**
	 * 查询是否存在下载文件
	 * @return 
	 */ 
	public int queryFileEx(OffStandardRequire offStandardRequire);
	/**
	 * 检查商品名是否存在
	 * @return 
	 */
	public int checkGoodsName(String goodsName);
	
	public void deleteSpecial(OffStandardRequire offStandardRequire);
	
	
	public String updateSpecial(OffStandardRequire offStandardRequire,String[] auditImages);
	
	
	public void cancleReason(OffStandardRequire offStandardRequire);
	
	public OffStandardRequire getOffStandardRequireByID(OffStandardRequire offStandardRequire);
}
