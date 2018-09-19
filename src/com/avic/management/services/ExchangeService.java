package com.avic.management.services;

import java.util.List;

import com.avic.management.models.Exchange;
import com.avic.management.models.Invoice;
import com.avic.management.models.OrderSnapshot;

public interface ExchangeService {
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