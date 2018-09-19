package com.avic.management.services.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.common.exceptions.ServiceException;
import com.avic.management.controllers.OrderCpiController;
import com.avic.management.mappers.OrderMapper;
import com.avic.management.models.Order;
import com.avic.management.models.OrderContract;
import com.avic.management.models.OrderSnapshot;
import com.avic.management.models.QuoteSnapshot;
import com.avic.management.services.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
    protected static final Log logger = LogFactory.getLog(OrderServiceImpl.class);

    @Autowired
    OrderMapper orderMapper;

	@Override
	public List<Order> queryOrders(Order order) {
		return orderMapper.queryOrders(order);
	}
	
	@Override
	public List<Order> queryOrdersAllData(Order order) {
		return orderMapper.queryOrdersAllData(order);
	}
	
	@Override
	public int queryOrdersListCount(Order order) {
		return orderMapper.queryOrdersListCount(order);
	}
	
	@Override
	public List<Order> getOrderStatusList() {
		return orderMapper.getOrderStatusList();
	}
	
	@Override
	public String doReceived(String order_id) {
		String result = "ok";
		try {
			orderMapper.doReceived(order_id);
		} catch (Exception e) {
			result="error";
			throw new ServiceException(e);
		}
		return result;
	}
	
	@Override
	@Transactional
	public String orderCancel(HttpServletRequest req, HttpSession httpSession, Map<String, String> paramMap) {
		String result = "ok";
		try {
			String sup_type = paramMap.get("sup_type");
			if("0".equals(sup_type)){//��ͳ��Ӧ�̵���Ʒ�����ȡ�������� ���߽ӿ�
				//1.���ù�Ӧ��ȡ�������ӿڣ����¿�棩
				OrderCpiController occ = new OrderCpiController();
				occ.orderCancel(paramMap.get("order_id"), paramMap.get("sup_id"), paramMap.get("sup_order_id"), req, httpSession);
			}
			//2.���¶�����״̬Ϊȡ������
			orderMapper.orderCancel(paramMap.get("order_id"));
		} catch (Exception e) {
			result="error";
			throw new ServiceException(e);
		}
		return result;
	}
	
	@Override
	@Transactional
	public String orderDel(HttpServletRequest req, HttpSession httpSession, Map<String, String> paramMap) {
		String result = "ok";
		try {
			//1.ɾ������������
			orderMapper.deleteT_ORDER(paramMap.get("order_id"));
			//2.ɾ���������ձ�����
			orderMapper.deleteT_ORDER_SNAPSHOT(paramMap.get("order_id"));
		} catch (Exception e) {
			result="error";
			throw new ServiceException(e);
		}
		return result;
	}
    // ===========================================================================
    //                         财务支付管理使用
    // ===========================================================================
	@Override
	public int getPaymentOrderCount(String companyId, int supId, String orderId, int orderStatus, String goodsName) {
	    return orderMapper.queryPaymentOrderCount(companyId, supId, orderId, orderStatus, goodsName);
	}
	@Override
	public List<Order> getPaymentOrderList(String companyId, int supId, String orderId, int orderStatus, String goodsName, int page, int size) {
	    
	    if (page < 1) {
            page = 1;
        }
        
        int start = (page - 1) * size + 1;
        int end  = start + size - 1;
        
        
	    List<Order> list = orderMapper.queryPaymentOrderList(companyId, supId, orderId, orderStatus, goodsName, start, end);
	    
	    if (list != null) {
    	    List<String> orderIds = new ArrayList<String>();
    	    
    	    for (Order i : list) {
    	        orderIds.add(i.getOrder_id());
    	    }
    	    
    	    List<OrderSnapshot> snapshots = orderMapper.queryPaymentOrderSnapshot(orderIds);
    	    
    	    Map<String, List<OrderSnapshot>> map = new HashMap<String, List<OrderSnapshot>>();
    	    
    	    for (OrderSnapshot i : snapshots) {
    	        if (!map.containsKey(i.getOrderId())) {
    	            map.put(i.getOrderId(), new ArrayList<OrderSnapshot>());
    	        }
    	        
    	        map.get(i.getOrderId()).add(i);
    	    }
    	    
    	    for (Order i : list) {
    	        i.setSnapshots(map.get(i.getOrder_id()));
    	    }
	    }
	    
	    
	    return list;
	}
	
	@Override
	public Order getOrderById(String orderId) {
	    return orderMapper.queryOrderById(orderId);
	}
	
	@Transactional
	@Override
	public void updateOrderPayStatus(String orderId) throws ServiceException {
	    try {
	        orderMapper.updateOrderPayStatus(orderId);
	    } catch (Exception e) {
	        throw new ServiceException(e);
	    }
	}
    @Transactional
	@Override
	public void updateOrderStatus(String orderId, int status) throws ServiceException {

        try {
            orderMapper.updateOrderStatus(orderId, status);
        } catch (Exception e) {
            throw new ServiceException(e);
        }
	}
    
    @Override
    public int getGoodsSum(String orderId) throws ServiceException {
        return orderMapper.queryGoodsSum(orderId);
    }
    
    @Override
    public String getUserCompanyName(String userId) throws ServiceException {
        return orderMapper.queryUserCompanyName(userId);
    }
    
    @Override
    public String getUserContactNum(String userId) throws ServiceException {
        return orderMapper.queryUserContactNum(userId);
    }

	@Override
	public List<QuoteSnapshot> queryQuoteSnapshot(QuoteSnapshot quoteSnapshot) {
		return orderMapper.queryQuoteSnapshot(quoteSnapshot);
	}

	@Override
	public Order queryOrderInfoByOrderId(Order order) {
		return orderMapper.queryOrderInfoByOrderId(order);
	}

	@Override
	public void insertContract(OrderContract orderContract) {
		orderMapper.insertContract(orderContract);
	}

	@Override
	public OrderContract queryOrderContract(String orderId) {
		// TODO Auto-generated method stub
		return orderMapper.queryOrderContract(orderId);
	}

	@Override
	public void updateContract(OrderContract orderContract) {
		// TODO Auto-generated method stub
		orderMapper.updateContract(orderContract);
	}
}