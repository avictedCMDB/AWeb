package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.Exchange;
import com.avic.management.models.Invoice;
import com.avic.management.models.OrderSnapshot;

@Repository
public interface ExchangeMapper {
	/**
	 * ��ѯ�������б�
	 * @return 
	 */
	public List<Exchange> queryExchange(Exchange exchange);
	
	/**
	 * ȷ���ջ�
	 * @return 
	 */
	public void updateOrderExchangeStatus(Exchange exchange);
	/**
	 * ��ѯ�˻������ջ�����
	 * @return 
	 */
	public int queryOrderExchangeReceiptCount(Exchange exchange);
	/**
	 * �޸Ķ���״̬Ϊȷ���ջ�
	 * @return 
	 */
	public void updateOrderStatusByExchangeID(Exchange exchange);
	/**
	 * ��ѯ����������
	 * @return 
	 */
	public Exchange queryExchangeByID(Exchange exchange);
	/**
	 * ��ѯ��������Ʒ����
	 * @return 
	 */
	public List<OrderSnapshot> queryOrderSnapshotsByOrderID(Exchange exchange);
	/**
	 * �޸Ļ����������Ϣ
	 * @return 
	 */
	public void updateOrderExchangeExpressInfo(Exchange exchange);
	/**
	 * ��ѯ����������
	 * @return 
	 */
	public int queryExchangeCount(Exchange exchange);
	
	/**
	 * ��ѯ�����������ͽ��
	 * @return 
	 */
	public Exchange queryExchangePriceAndAmountByExchangeID(Exchange exchange);
	
	/**
	 * �޸Ļ����������ͽ��
	 * @return 
	 */
	public void updateOrderExchangePriceAndAmount(Exchange exchange);
}
