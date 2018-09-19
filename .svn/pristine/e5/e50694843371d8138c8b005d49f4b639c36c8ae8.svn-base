package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.OffStandardRequire;
import com.avic.management.models.SupGoods;
import com.avic.management.models.SupInfo;

@Repository
public interface OffStandardRequireMapper {
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
	
	
	public void updateSpecial(OffStandardRequire offStandardRequire);
	
	
	public void cancleReason(OffStandardRequire offStandardRequire);
	
	public OffStandardRequire getOffStandardRequireByID(OffStandardRequire offStandardRequire);
}
