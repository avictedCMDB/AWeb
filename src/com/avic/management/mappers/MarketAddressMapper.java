package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.MarketAddress;

@Repository
public interface MarketAddressMapper {
	/**
	 * ��ѯ��ַ�б�
	 * @return 
	 */
	public List<MarketAddress> queryMarketAddressList(MarketAddress marketAddress);
	/**
	 * ɾ����ַ
	 * @return 
	 */
	public void deleteMarketAddress(MarketAddress marketAddress);
	/**
	 * ����Ĭ�ϵ�ַ
	 * @return 
	 */
	public void setDefault(MarketAddress marketAddress);
	/**
	 * ���ӵ�ַ
	 * @return 
	 */
	public void addMarketAddress(MarketAddress marketAddress);
	/**
	 * �޸ĵ�ַ
	 * @return 
	 */
	public void updateMarketAddress(MarketAddress marketAddress);
	/**
	 * ����Ĭ�ϵ�ַ
	 * @return 
	 */
	public void setOtherDefault(MarketAddress marketAddress);
	/**
	 * ��ѯ�Ƿ���Ĭ�ϵ�ַ
	 * @return 
	 */
	public int queryContantDefault();
	/**
	 * ���ݵ�ַid��ѯ��ַ��Ϣ
	 * @return 
	 */
	public MarketAddress queryMarketAddressByAddressID(MarketAddress marketAddress);
	/**
	 * ��ѯ��ַ�б���������
	 * @return 
	 */
	public int queryMarketAddressCount(MarketAddress marketAddress);

}