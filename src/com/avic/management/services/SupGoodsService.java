package com.avic.management.services;

import java.util.List;

import com.avic.management.models.SupGoods;

public interface SupGoodsService {
	/**
	 * 查询商品信息
	 * @return 
	 */
	public SupGoods queryGoods(SupGoods supGoods);
	/**
	 * 查询商品信息列表
	 * @return 
	 */
	public List<SupGoods> queryGoodsList(SupGoods supGoods);
	/**
	 * 查询非标商品供应商列表
	 * @return 
	 */
	public List<SupGoods> queryGoodsSupList(SupGoods supGoods);
}
