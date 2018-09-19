package com.avic.management.services;

import java.util.List;

import com.avic.management.models.OffStandardRequire;
import com.avic.management.models.SupGoods;
import com.avic.management.models.SupInfo;

public interface OffStandardRequireService {
	/**
	 * ��ѯ�Ǳ�׼��Ʒ�б�
	 * @return 
	 */
	public List<OffStandardRequire> queryOffStandardRequires(OffStandardRequire offStandardRequire);
	/**
	 * ��ѯ�Ǳ�׼��Ʒ
	 * @return 
	 */
	public List<SupGoods> queryGoodsByGoodsIDS(OffStandardRequire offStandardRequire);
	/**
	 * ��ѯ�Ǳ�׼��Ӧ��
	 * @return 
	 */
	public List<SupInfo> querySupInfosBySupIDS(OffStandardRequire offStandardRequire);
	/**
	 * ��ѯ�Ǳ�׼��Ʒ����
	 * @return 
	 */
	public int queryOffStandardRequiresCount(OffStandardRequire offStandardRequire);
	/**
	 * ��ѯ�Ƿ���������ļ�
	 * @return 
	 */ 
	public int queryFileEx(OffStandardRequire offStandardRequire);
	/**
	 * �����Ʒ���Ƿ����
	 * @return 
	 */
	public int checkGoodsName(String goodsName);
	
	public void deleteSpecial(OffStandardRequire offStandardRequire);
	
	
	public String updateSpecial(OffStandardRequire offStandardRequire,String[] auditImages);
	
	
	public void cancleReason(OffStandardRequire offStandardRequire);
	
	public OffStandardRequire getOffStandardRequireByID(OffStandardRequire offStandardRequire);
}