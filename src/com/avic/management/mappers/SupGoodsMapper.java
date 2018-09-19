package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.SupGoods;

@Repository
public interface SupGoodsMapper {
	/**
	 * ��ѯ��Ʒ��Ϣ
	 * @return 
	 */
	public SupGoods queryGoods(SupGoods supGoods);
	
	/**
	 * ��ѯ��Ʒ��Ϣ�б�
	 * @return 
	 */
	public List<SupGoods> queryGoodsList(SupGoods supGoods);
	/**
	 * ��ѯ�Ǳ���Ʒ��Ӧ���б�
	 * @return 
	 */
	public List<SupGoods> queryGoodsSupList(SupGoods supGoods);
}