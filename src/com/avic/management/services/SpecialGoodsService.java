package com.avic.management.services;

import java.util.List;
import java.util.Map;

import com.avic.management.models.SpecialGoodsBean;

public interface SpecialGoodsService {
	/**
	 * 获取供应商列表
	 */
	public List<SpecialGoodsBean> supSelectDoInitData(SpecialGoodsBean sgBean);
	
	/**
	 * 保存换货信息
	 */
	public String doSaveInTables(Map<String, String> paramMap,String[]auditImages);
	
	/**
	 * 获取合作供应商数量
	 */
	public int getRelationShipSupCount(SpecialGoodsBean sgBean);
}
