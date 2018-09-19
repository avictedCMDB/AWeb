package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.OffStandardRequire;
import com.avic.management.models.SupGoods;
import com.avic.management.models.SupInfo;

@Repository
public interface OffStandardRequireMapper {
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
	
	
	public void updateSpecial(OffStandardRequire offStandardRequire);
	
	
	public void cancleReason(OffStandardRequire offStandardRequire);
	
	public OffStandardRequire getOffStandardRequireByID(OffStandardRequire offStandardRequire);
}
