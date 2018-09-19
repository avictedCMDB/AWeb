package com.avic.management.services;

import java.util.List;
import java.util.Map;

import com.avic.management.models.OrderExchangeBean;

public interface OrderExchangeService {
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
	 * ���滻����Ϣ
	 */
	public String doSaveInTables(List<OrderExchangeBean> oeBeanList,Map<String, String> paramMap);
}
