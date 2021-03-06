package com.avic.management.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
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
import com.avic.management.models.OrderRefoundBean;
import com.avic.management.services.OrderRefoundService;
import com.avic.management.services.OrderService;
import com.avic.market.cpi.CpiService;
import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.passport.models.User;

@Controller
@RequestMapping("/orderRefound")
@Transactional
public class OrderRefoundController {
    protected static final Log logger = LogFactory.getLog(OrderRefoundController.class);
    
    @Autowired
    OrderRefoundService orderRefoundService;
    @Autowired
    OrderService orderService;
    
    @RequestMapping("")
    public String index(HttpServletRequest request,
    		HttpSession httpSession, Map<String, Object> map) {
        logger.info("订单-退货");
        
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
        
//      获取要退货单基本信息
        OrderRefoundBean order = orderRefoundService.getOrderDetail(order_id);
        if (order_id == null) {
            throw new PageNotFoundException();
        }
        
        String sup_id = order.getSup_id();
        map.put("order", order);
        request.setAttribute("order_id", order_id);
        request.setAttribute("sup_id", sup_id);
        return "management_order_refound";
    }
    
    @RequestMapping("/orderSelect")
    public String orderSelectDoInit(@ModelAttribute("order") OrderRefoundBean query_items,
    		HttpServletRequest request, Map<String, Object> map) {
        logger.info("订单-退货-选择商品");
        
        OrderRefoundBean oeBean = new OrderRefoundBean();
//      订单编号
        String order_id = request.getParameter("o");
        if(order_id ==null || "".equals(order_id)){//为空说明是页面查询，否则为跳转查询
        	order_id = query_items.getOrder_id();
        }
        String goods_name = query_items.getGoods_name();
        
        if (StringUtils.isEmpty(order_id)) {
            throw new PageNotFoundException();
        }
        
        oeBean.setOrder_id(order_id);
        oeBean.setGoods_name(goods_name);
        
//      获取订单商品列表
        List<OrderRefoundBean> orderGoodsList = orderRefoundService.orderSelectDoInit(oeBean);
        if (orderGoodsList == null) {
            throw new PageNotFoundException();
        }
        
        map.put("oglist", orderGoodsList);
        request.setAttribute("goods_name", goods_name);
        request.setAttribute("order_id", order_id);
        return "management_order_select";
    }
    
    @RequestMapping("/orderSelectMain")
    @ResponseBody
    public Object orderSelectMainDoInit(@RequestParam("order_id")String order_id, 
    	@RequestParam("sup_goods_id")String sup_goods_id){
    	logger.info("订单-退货-主页面回显商品信息");
    	
    	OrderRefoundBean oeBean = new OrderRefoundBean();
//      订单编号
    	if (StringUtils.isEmpty(order_id)) {
    		throw new PageNotFoundException();
    	}
    	
    	oeBean.setOrder_id(order_id);
    	oeBean.setSup_goods_id(sup_goods_id);
    	
//      获取订单商品列表
    	List<OrderRefoundBean> orderGoodsList = orderRefoundService.orderSelectMainDoInit(oeBean);
    	if (orderGoodsList == null) {
    		throw new PageNotFoundException();
    	}
    	
    	return orderGoodsList;
    }
    
    @RequestMapping(value = "/doSave", method ={RequestMethod.POST})
    @ResponseBody
    public Object doSave(HttpSession httpSession,
    		@RequestBody List<OrderRefoundBean> oeBeanList,
    		@RequestParam("order_id")String order_id,
    		@RequestParam("sup_id")String sup_id,
    		@RequestParam("remark")String remark,
    		@RequestParam("refound_amount")String refound_amount,
    		@RequestParam("refound_price")String refound_price,
    		@RequestParam("imgCount")String imgCount,
    		@RequestParam("imgPaths")String imgPaths,
    		@RequestParam("refound_price_init")String refound_price_init)
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
    	
        
      //请求京东申请服务单 start
        if("4".equals(sup_id)){
        	Order order = new Order();
            order.setOrder_id(order_id);
            order = orderService.queryOrderInfoByOrderId(order);
    		//查询换货单 获取供应商id
    		int supID = Integer.parseInt(sup_id);
    		for (OrderRefoundBean orderRefoundBean : oeBeanList) {
    			//申请服务单参数
        		//获取 供应商订单id
        	    Map<String, Object> param = new HashMap<String, Object>();
//        		AfsApplyCreate applyCreate = new AfsApplyCreate();
//        		applyCreate.setJdOrderId(Long.parseLong(order.getSup_order_id()));
//        		applyCreate.setCustomerExpect("10");
        		param.put("jdOrderId", order.getSup_order_id());
        		param.put("customerExpect", "10");
        		param.put("questionDesc", remark);
        		//客户信息实体
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
//        		AsCustomerDto customer = new AsCustomerDto();
//        		customer.setCustomerContactName(order.getAddrName());
//        		customer.setCustomerEmail(order.getAddrEmail());
//        		customer.setCustomerMobilePhone(order.getAddrPhone());
//        		customer.setCustomerPostcode(order.getAddrZip());
//        		if(! "null".equals(order.getAddrTel()) && order.getAddrTel() != null ){
//            		customer.setCustomerTel(order.getAddrTel());    			
//        		}
//        		applyCreate.setAsCustomerDto(customer);
        		//取件信息实体
        		 Map<String, Object> pickware = new HashMap<String, Object>();
        		 pickware.put("pickwareType", "4");
        		 pickware.put("pickwareProvince", order.getAddrProv());
        		 pickware.put("pickwareCity", order.getAddrCity());
        		 pickware.put("pickwareCounty", order.getAddrTown());
        		 pickware.put("pickwareVillage", order.getAddrDist());
        		 pickware.put("pickwareAddress", order.getAddrDetail());
        		 param.put("asPickwareDto", pickware);
//        		AsPickwareDto pickware = new AsPickwareDto();
//        		pickware.setPickwareType(4);//4为上门取件
//        		pickware.setPickwareAddress(order.getAddrDetail());
//        		pickware.setPickwareCity(Integer.parseInt(order.getAddrCity()));
//        		pickware.setPickwareCounty(Integer.parseInt(order.getAddrTown()));
//        		pickware.setPickwareProvince(Integer.parseInt(order.getAddrProv()));
//        		pickware.setPickwareVillage(Integer.parseInt(order.getAddrDist()));
//        		applyCreate.setAsPickwareDto(pickware);
        		//返件信息实体
//         		AsReturnwareDto returnware = new AsReturnwareDto();
//         		returnware.setReturnwareAddress(order.getAddrDetail());
//         		returnware.setReturnwareCity(order.getAddrCity());
//         		returnware.setReturnwareCounty(order.getAddrTown());
//         		returnware.setReturnwareProvince(order.getAddrProv());
//         		returnware.setReturnwareVillage(order.getAddrDist());
        		 Map<String, Object> returnware = new HashMap<String, Object>();
        		 returnware.put("returnwareType", "10");
        		 returnware.put("returnwareProvince", order.getAddrProv());
        		 returnware.put("returnwareCity", order.getAddrCity());
        		 returnware.put("returnwareCounty", order.getAddrTown());
        		 returnware.put("returnwareVillage", order.getAddrDist());
        		 returnware.put("returnwareAddress", order.getAddrDetail()); 
        		 param.put("asReturnwareDto", returnware);

//        		//TODO 自营配送  10自营 20第三方
//        		returnware.setReturnwareType(10);//自营配送  第三方配送
//        		applyCreate.setAsReturnwareDto(returnware);
        		
        		//申请单明细
        		Map<String, Object> detail = new HashMap<String, Object>();
        		detail.put("skuId", orderRefoundBean.getSup_goods_id());
        		detail.put("skuNum", orderRefoundBean.getBuy_num());
        		param.put("asDetailDto", detail);
//        		AsDetailDto detail = new AsDetailDto();
//        		detail.setSkuId(order.getSupGoodsID());
//        		detail.setSkuNum(refound_amount);
//        		applyCreate.setAsDetailDto(detail);

        		
        		try {
        			Map<String, Object> orderResult = new HashMap<String, Object>();
    				orderResult =  CpiService.getInstance().selectOrder(supID, order.getSup_order_id());
    				JSONObject orderOb=JSONObject.fromObject(orderResult.get("result"));
    				if(orderOb.containsKey("cOrder")){
    					JSONArray subOrderInfo= orderOb.getJSONArray("cOrder");
    					if(subOrderInfo.size() != 0){
    						for (int i = 0; i < subOrderInfo.size(); i++) {
    							JSONObject subOrderObject=JSONObject.fromObject(subOrderInfo.getString(i));
    							JSONArray skuJsonObj= subOrderObject.getJSONArray("sku");
    							for (int j = 0; j < skuJsonObj.size(); j++) {
    								JSONObject nameObj=JSONObject.fromObject(skuJsonObj.getString(j));
    								if(detail.get("skuId").toString().equals(nameObj.get("skuId").toString())){
    									param.put("jdOrderId", subOrderObject.getString("jdOrderId"));
    									break;
    								}
    							}
    						}   				       				
    					}					
    				}      			        			
        			Map<String, Object> r = CpiService.getInstance().afterSaleAfsApplyCreate(supID, param);
        			JSONObject jsonObj = JSONObject.fromObject(r);
    				if(!jsonObj.getBoolean("success")){
    					result="failed";
    					map.put("result", result);
    					map.put("msg", "提交失败,"+jsonObj.getString("resultMessage"));
    					return map;
    				}
        		} catch (NoSuchSupplierException e) {
        			result="failed";
					map.put("result", result);
					map.put("msg", "提交失败,"+e.getMessage().split(":")[1]);
					return map;
        		} catch (ServiceExecutionFailedException e) {
        			result="failed";
					map.put("result", result);
					map.put("msg", "提交失败,"+e.getMessage().split(":")[1]);
					return map;
        		}
            }
    		//请求京东申请服务单 end
			}
        Map<String, String> paramMap = new HashMap<String, String>();
    	paramMap.put("order_id", order_id);
    	paramMap.put("sup_id", sup_id);
    	paramMap.put("remark", java.net.URLDecoder.decode(remark , "UTF-8"));
    	paramMap.put("refound_amount", refound_amount);
    	paramMap.put("refound_price", refound_price);
    	paramMap.put("user_id", user_id);
    	paramMap.put("imgCount", imgCount);
    	paramMap.put("imgPaths", imgPaths);
    	paramMap.put("refound_price_init", refound_price_init);
        result = orderRefoundService.doSaveInTables(oeBeanList,paramMap);
        map.put("result", result);
        return map;
    }
}