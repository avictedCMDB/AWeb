package com.avic.supervise.services;

import java.util.List;

import com.avic.supervise.models.SupplierRecommend;

public interface SupplierRecommendService {
	/**
	 *��ѯ�Ƽ���Ӧ��
	 * @return 
	 */
	public List<SupplierRecommend> querySupplierRecommends(SupplierRecommend supplierRecommend);
	/**
	 *��ѯ�Ƽ���Ӧ������
	 * @return 
	 */
	public int querySupplierRecommendsCount(SupplierRecommend supplierRecommend);
	/**
	 *ȡ���Ƽ���Ӧ��
	 * @return 
	 */
	public void setIfRecommend(SupplierRecommend supplierRecommend);
	/**
	 *��ѯ�Ƽ���Ӧ��
	 * @return 
	 */
	public SupplierRecommend getSupInfoBySupID(SupplierRecommend supplierRecommend);
	/**
	 * �޸��Ƽ���Ӧ���Ƽ�ʱ��
	 * @return 
	 */
	public void updateSupInfoDate(SupplierRecommend supplierRecommend);
	/**
	 *��ѯ�Ƽ���Ӧ����չ����
	 * @return 
	 */
	public int getSupInfoExtBySupID(SupplierRecommend supplierRecommend);
	
	/**
	 * �޸��Ƽ���Ӧ����չͼƬ
	 * @return 
	 */
	public void updateSuperviseRecommendExtPic(SupplierRecommend supplierRecommend);
	/**
	 * ����Ƽ���Ӧ����չͼƬ
	 * @return 
	 */
	public void addSupInfoExt(SupplierRecommend supplierRecommend);
	/**
	 *��ѯ��Ӧ����չ��ϢͼƬ·�� 
	 * @return 
	 */
	public String getSupInfoExtImgPath(SupplierRecommend supplierRecommend);
}
