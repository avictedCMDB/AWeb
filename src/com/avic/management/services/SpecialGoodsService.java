package com.avic.management.services;

import java.util.List;
import java.util.Map;

import com.avic.management.models.SpecialGoodsBean;

public interface SpecialGoodsService {
	/**
	 * ��ȡ��Ӧ���б�
	 */
	public List<SpecialGoodsBean> supSelectDoInitData(SpecialGoodsBean sgBean);
	
	/**
	 * ���滻����Ϣ
	 */
	public String doSaveInTables(Map<String, String> paramMap,String[]auditImages);
	
	/**
	 * ��ȡ������Ӧ������
	 */
	public int getRelationShipSupCount(SpecialGoodsBean sgBean);
}