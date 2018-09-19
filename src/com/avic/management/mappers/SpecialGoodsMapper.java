package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.SpecialGoodsBean;

@Repository
public interface SpecialGoodsMapper {
	/**
	 * 获取供应商列表
	 */
	public List<SpecialGoodsBean> supSelectDoInitData(SpecialGoodsBean sgBean);
	
	/**
	 * 插入非标准件需求表
	 */
	public void InsertT_OFF_STANDARD_REQUIRE(SpecialGoodsBean sgBean);
	
	/**
	 * 附件图片表
	 */
	public void InsertT_IMAGE_INFO(SpecialGoodsBean sgBean);
	
	/**
	 * 获取合作供应商数量
	 */
	public int getRelationShipSupCount(SpecialGoodsBean sgBean);
	
	public void deleteSpecialImage(SpecialGoodsBean sgBean);
}