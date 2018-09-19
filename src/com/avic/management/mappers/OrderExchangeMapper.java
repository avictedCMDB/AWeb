package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.OrderExchangeBean;

@Repository
public interface OrderExchangeMapper {
	/**
	 * ��ȡҪ������������Ϣ
	 */
	public OrderExchangeBean getOrderDetail(String order_id);
	
	/**
	 * ��ȡ������Ʒ�б�
	 */
	public List<OrderExchangeBean> orderSelectDoInit(OrderExchangeBean oeBean);
	
	/**
	 * ������ҳ��ȡ������Ʒ�б�
	 */
	public List<OrderExchangeBean> orderSelectMainDoInit(OrderExchangeBean oeBean);
	
	/**
	 * ��ȡ��������
	 */
	public OrderExchangeBean getExchangeId();
	
	/**
	 * ���¶�����״̬Ϊ���뻻��
	 */
	public void updateT_ORDER(OrderExchangeBean oeBean);
	
	/**
	 * ���뻻������
	 */
	public void InsertT_ORDER_EXCHANGE(OrderExchangeBean oeBean);
	
	/**
	 * ���뻻����Ʒ����¼
	 */
	public void InsertT_EXCHANGE_GOODS(OrderExchangeBean oeBean);
	
	/**
	 * ���¶������ձ���Ʒ���˻�״̬
	 */
	public void updateT_ORDER_SNAPSHOT(OrderExchangeBean oeBean);
	
	/**
	 * ����ͼƬ��
	 */
	public void InsertT_IMAGE_INFO(OrderExchangeBean oeBean);
	
	/**
	 * ��ȡ��Ӧ����ϵ��ʽ
	 */
	public String getContact_num(String sup_id);
}