package com.avic.supervise.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.supervise.models.Brand;

@Repository
public interface BrandMapper {
	/**
	 *��ѯ�Ƽ�Ʒ��
	 * @return 
	 */
	public List<Brand> queryBrand(Brand brand);
	/**
	 *��ѯ�Ƽ�Ʒ������
	 * @return 
	 */
	public int queryBrandCount(Brand brand);
	/**
	 *ȡ���Ƽ�Ʒ��
	 * @return 
	 */
	public void setIfRecommend(Brand brand);
	
	/**
	 *��ѯ�Ƽ�Ʒ��
	 * @return 
	 */
	public Brand getBrandInfoByBid(Brand brand);
	/**
	 * �޸��Ƽ�Ʒ���Ƽ�ʱ��
	 * @return 
	 */
	public void updateBrandInfoDate(Brand brand);
	
	/**
	 *��ѯ�Ƽ�Ʒ����չ����
	 * @return 
	 */
	public int getBrandInfoExtByBid(Brand brand);
	
	/**
	 * �޸��Ƽ�Ʒ����չͼƬ
	 * @return 
	 */
	public void updateBrandExtPic(Brand brand);
	/**
	 * ����Ƽ�Ʒ����չͼƬ
	 * @return 
	 */
	public void addBrandInfoExt(Brand brand);
	/**
	 *��ѯƷ����չ��ϢͼƬ·�� 
	 * @return 
	 */
	public String getBrandInfoExtImgPath(Brand brand);
}