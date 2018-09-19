package com.avic.management.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.PageNotFoundException;
import com.avic.common.utils.Permission;
import com.avic.management.models.Order;
import com.avic.management.models.OrderExchangeBean;
import com.avic.management.services.OrderExchangeService;
import com.avic.management.services.OrderService;
import com.avic.market.cpi.CpiService;
import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.market.models.AfsApplyCreate;
import com.avic.market.models.AsCustomerDto;
import com.avic.market.models.AsDetailDto;
import com.avic.market.models.AsPickwareDto;
import com.avic.market.models.AsReturnwareDto;
import com.avic.passport.models.User;

@Controller
@RequestMapping("/orderExchange")
@Transactional
public class OrderExchangeController {
    protected static final Log logger = LogFactory.getLog(OrderExchangeController.class);
    
    @Autowired
    OrderExchangeService orderExchangeService;
    @Autowired
    OrderService orderService;
    
    @RequestMapping("")
    public String index(HttpServletRequest request,
    		HttpSession httpSession, Map<String, Object> map) {
        logger.info("����-����");
        
        try {
        	@SuppressWarnings("unused")
			User user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
        } catch (Exception e) {
            return "redirect:/passport/login";
        }
        
        String order_id = request.getParameter("o");
        if (StringUtils.isEmpty(order_id)) {
            throw new PageNotFoundException();
        }
        
//      ��ȡҪ������������Ϣ
        OrderExchangeBean order = orderExchangeService.getOrderDetail(order_id);
        if (order_id == null) {
            throw new PageNotFoundException();
        }
        
        String sup_id = order.getSup_id();
        map.put("order", order);
        request.setAttribute("order_id", order_id);
        request.setAttribute("sup_id", sup_id);
        return "management_order_exchange";
    }
    
    @RequestMapping("/orderSelect")
    public String orderSelectDoInit(@ModelAttribute("order") OrderExchangeBean query_items,
    		HttpServletRequest request, Map<String, Object> map) {
        logger.info("����-����-ѡ����Ʒ��ת");
//      �������
        String order_id = request.getParameter("o");
        request.setAttribute("order_id", order_id);
        return "management_order_select";
    }
    
    @RequestMapping("/orderSelectData")
    @ResponseBody
    public Object orderSelectDoInitData(@RequestParam("order_id")String order_id,
    		@RequestParam("goods_name")String goods_name) {
    	logger.info("����-����-ѡ����Ʒ��ȡ�б�");
    	
    	OrderExchangeBean oeBean = new OrderExchangeBean();
    	oeBean.setOrder_id(order_id);
    	oeBean.setGoods_name(goods_name);
    	
//      ��ȡ������Ʒ�б�
    	List<OrderExchangeBean> orderGoodsList = orderExchangeService.orderSelectDoInit(oeBean);
    	if (orderGoodsList == null) {
    		throw new PageNotFoundException();
    	}
    	
    	return orderGoodsList;
    }
    
    @RequestMapping("/orderSelectMain")
    @ResponseBody
    public Object orderSelectMainDoInit(@RequestParam("order_id")String order_id, 
    	@RequestParam("sup_goods_id")String sup_goods_id){
    	logger.info("����-����-��ҳ�������Ʒ��Ϣ");
    	
    	OrderExchangeBean oeBean = new OrderExchangeBean();
//      �������
    	if (StringUtils.isEmpty(order_id)) {
    		throw new PageNotFoundException();
    	}
    	
    	oeBean.setOrder_id(order_id);
    	oeBean.setSup_goods_id(sup_goods_id);
    	
//      ��ȡ������Ʒ�б�
    	List<OrderExchangeBean> orderGoodsList = orderExchangeService.orderSelectMainDoInit(oeBean);
    	if (orderGoodsList == null) {
    		throw new PageNotFoundException();
    	}
    	
    	return orderGoodsList;
    }
    
    @RequestMapping(value = "/doSave", method ={RequestMethod.POST})
    @ResponseBody
    public Object doSave(HttpSession httpSession,
    		@RequestBody List<OrderExchangeBean> oeBeanList,
    		@RequestParam("order_id")String order_id,
    		@RequestParam("sup_id")String sup_id,
    		@RequestParam("remark")String remark,
    		@RequestParam("exchange_amount")String exchange_amount,
    		@RequestParam("exchange_price")String exchange_price,
    		@RequestParam("imgCount")String imgCount,
    		@RequestParam("imgPaths")String imgPaths,
    		@RequestParam("exchange_price_init")String exchange_price_init)
            throws Exception{
    	User user = null;
    	try {
			user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
        } catch (Exception e) {
            return "redirect:/passport/login";
        }
        
        String user_id = user.getUserId();
    	String result = "ok";
    	Map<String, String> map = new HashMap<String, String>();
    	
        //���󾩶�������� start
        if("4".equals(sup_id)){
        	 Order order = new Order();
             order.setOrder_id(order_id);
             order = orderService.queryOrderInfoByOrderId(order);
     		//��ѯ������ ��ȡ��Ӧ��id
     		int supID = Integer.parseInt(sup_id);
     		for (OrderExchangeBean orderExchangeBean : oeBeanList) {
     			//������񵥲���
         		//��ȡ ��Ӧ�̶���id
         		Map<String, Object> param = new HashMap<String, Object>();
//         		AfsApplyCreate applyCreate = new AfsApplyCreate();
//         		applyCreate.setJdOrderId(Long.parseLong(order.getSup_order_id()));
//         		applyCreate.setCustomerExpect("20");
        		param.put("jdOrderId", order.getSup_order_id());
        		param.put("customerExpect", "20");
        		param.put("questionDesc", remark);
         		//�ͻ���Ϣʵ��
//         		AsCustomerDto customer = new AsCustomerDto();
//         		customer.setCustomerContactName(order.getAddrName());
//         		customer.setCustomerEmail(order.getAddrEmail());
//         		customer.setCustomerMobilePhone(order.getAddrPhone());
//         		customer.setCustomerPostcode(order.getAddrZip());
//         		customer.setCustomerTel(order.getAddrTel());
        		//�ͻ���Ϣʵ��
       		 Map<String, Object> customer = new HashMap<String, Object>();
       		 if(! "null".equals(order.getAddrName()) && order.getAddrName() != null ){
       			 customer.put("customerContactName", order.getAddrName());
       		 }    		 
       		 if(! "null".equals(order.getAddrTel()) && order.getAddrTel() != null && ! "null".equals(order.getAddrPhone()) && order.getAddrPhone() != null){
       			 customer.put("customerTel", order.getAddrTel());
       			 customer.put("customerMobilePhone", order.getAddrPhone());
       		 }else if(! "null".equals(order.getAddrPhone()) && order.getAddrPhone() != null && ("null".equals(order.getAddrTel()) || order.getAddrTel() == null)){
       			 customer.put("customerMobilePhone", order.getAddrPhone());
       			 customer.put("customerTel",order.getAddrPhone());
       		 }else{
       			 customer.put("customerMobilePhone", order.getAddrTel());
       			 customer.put("customerTel",order.getAddrTel());
       		 }
       		 if(! "null".equals(order.getAddrEmail()) && order.getAddrEmail() != null ){
       			 customer.put("customerEmail", order.getAddrEmail());
       		 }
       		 if(! "null".equals(order.getAddrZip()) && order.getAddrZip() != null ){
       			 customer.put("customerPostcode", order.getAddrZip());
       		 } 
       		 param.put("asCustomerDto", customer);
     		//ȡ����Ϣʵ��
    		 Map<String, Object> pickware = new HashMap<String, Object>();
    		 pickware.put("pickwareType", "4");
    		 pickware.put("pickwareProvince", order.getAddrProv());
    		 pickware.put("pickwareCity", order.getAddrCity());
    		 pickware.put("pickwareCounty", order.getAddrTown());
    		 pickware.put("pickwareVillage", order.getAddrDist());
    		 pickware.put("pickwareAddress", order.getAddrDetail());
    		 param.put("asPickwareDto", pickware);
     		//������Ϣʵ��
    		 Map<String, Object> returnware = new HashMap<String, Object>();
    		 returnware.put("returnwareType", "10");
    		 returnware.put("returnwareProvince", order.getAddrProv());
    		 returnware.put("returnwareCity", order.getAddrCity());
    		 returnware.put("returnwareCounty", order.getAddrTown());
    		 returnware.put("returnwareVillage", order.getAddrDist());
    		 returnware.put("returnwareAddress", order.getAddrDetail()); 
    		 param.put("asReturnwareDto", returnware);
     		//���뵥��ϸ
     		Map<String, Object> detail = new HashMap<String, Object>();
     		detail.put("skuId", orderExchangeBean.getSup_goods_id());
     		detail.put("skuNum", orderExchangeBean.getBuy_num());
     		param.put("asDetailDto", detail);
//         		//���뵥��ϸ
//         		AsDetailDto detail = new AsDetailDto();
//         		detail.setSkuId(order.getSupGoodsID());
//         		detail.setSkuNum(exchange_amount);
//         		//ȡ����Ϣʵ��
//         		AsPickwareDto pickware = new AsPickwareDto();
//         		pickware.setPickwareType(4);//4Ϊ����ȡ��
//         		pickware.setPickwareAddress(order.getAddrDetail());
//         		pickware.setPickwareCity(Integer.parseInt(order.getAddrCity()));
//         		pickware.setPickwareCounty(Integer.parseInt(order.getAddrTown()));
//         		pickware.setPickwareProvince(Integer.parseInt(order.getAddrProv()));
//         		pickware.setPickwareVillage(Integer.parseInt(order.getAddrDist()));
//         		//������Ϣʵ��
//         		AsReturnwareDto returnware = new AsReturnwareDto();
//         		//TODO ��Ӫ����  10��Ӫ 20������
//         		returnware.setReturnwareType(10);//��Ӫ����  ����������
//         		returnware.setReturnwareAddress(order.getAddrDetail());
//         		returnware.setReturnwareCity(Integer.parseInt(order.getAddrCity()));
//         		returnware.setReturnwareCounty(Integer.parseInt(order.getAddrTown()));
//         		returnware.setReturnwareProvince(Integer.parseInt(order.getAddrProv()));
//         		returnware.setReturnwareVillage(Integer.parseInt(order.getAddrDist()));
//         		applyCreate.setAsCustomerDto(customer);
//         		applyCreate.setAsDetailDto(detail);
//         		applyCreate.setAsPickwareDto(pickware);
//         		applyCreate.setAsReturnwareDto(returnware);
//         		try {
//         			//Map<String, Object> r = CpiService.getInstance().afterSaleAfsApplyCreate(supID, applyCreate);
//         		} catch (NoSuchSupplierException e) {
//         			e.printStackTrace();
//         		} catch (ServiceExecutionFailedException e) {
//         			e.printStackTrace();
//         		}
         		//���󾩶�������� end
    			try {
    				Map<String, Object> r = CpiService.getInstance().afterSaleAfsApplyCreate(supID, param);
    				JSONObject jsonObj = JSONObject.fromObject(r);
    				if(!jsonObj.getBoolean("success")){
    					result="failed";
    					map.put("result", result);
    					map.put("msg", "�ύʧ��,"+jsonObj.getString("resultMessage"));
    					return map;
    				}
    			} catch (NoSuchSupplierException e) {
    				result="failed";
					map.put("result", result);
					map.put("msg", "�ύʧ��,"+e.getMessage().split(":")[1]);
					return map;
    			} catch (ServiceExecutionFailedException e) {
    				result="failed";
					map.put("result", result);
					map.put("msg", "�ύʧ��,"+e.getMessage().split(":")[1]);
					return map;
    			}
			}
     		
        }
        Map<String, String> paramMap = new HashMap<String, String>();
    	paramMap.put("order_id", order_id);
    	paramMap.put("sup_id", sup_id);
    	paramMap.put("remark", java.net.URLDecoder.decode(remark , "UTF-8"));
    	paramMap.put("exchange_amount", exchange_amount);
    	paramMap.put("exchange_price", exchange_price);
    	paramMap.put("user_id", user_id);
    	paramMap.put("imgCount", imgCount);
    	paramMap.put("imgPaths", imgPaths);
    	paramMap.put("exchange_price_init", exchange_price_init);
        result = orderExchangeService.doSaveInTables(oeBeanList,paramMap);
        
        map.put("result", result);
        return map;
    }
}