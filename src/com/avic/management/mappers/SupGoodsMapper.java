package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.SupGoods;

@Repository
public interface SupGoodsMapper {
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
