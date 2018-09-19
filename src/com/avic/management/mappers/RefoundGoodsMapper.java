package com.avic.management.mappers;

import org.springframework.stereotype.Repository;

import com.avic.management.models.RefoundGoods;

@Repository
public interface RefoundGoodsMapper {
	
	/**
	 * …æ≥˝ÕÀªı…Ã∆∑
	 */
	public void delRefoundGoods(RefoundGoods refoundGoods);
}
