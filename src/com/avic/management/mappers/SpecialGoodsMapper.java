package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.SpecialGoodsBean;

@Repository
public interface SpecialGoodsMapper {
	/**
	 * ��ȡ��Ӧ���б�
	 */
	public List<SpecialGoodsBean> supSelectDoInitData(SpecialGoodsBean sgBean);
	
	/**
	 * ����Ǳ�׼�������
	 */
	public void InsertT_OFF_STANDARD_REQUIRE(SpecialGoodsBean sgBean);
	
	/**
	 * ����ͼƬ��
	 */
	public void InsertT_IMAGE_INFO(SpecialGoodsBean sgBean);
	
	/**
	 * ��ȡ������Ӧ������
	 */
	public int getRelationShipSupCount(SpecialGoodsBean sgBean);
	
	public void deleteSpecialImage(SpecialGoodsBean sgBean);
}