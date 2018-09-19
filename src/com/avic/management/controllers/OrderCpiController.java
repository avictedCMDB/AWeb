package com.avic.management.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.Permission;
import com.avic.management.models.OrderCpi;
import com.avic.management.services.CommonService;
import com.avic.market.cpi.CpiService;
import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.passport.models.User;

@Controller
@RequestMapping("/ordercpi")
public class OrderCpiController {
    protected static final Log logger = LogFactory.getLog(OrderCpiController.class);
    
    @Autowired
    CommonService commonService;
    
    
    @SuppressWarnings("unchecked")
	@RequestMapping("")
    @ResponseBody
    public Object index(@RequestParam("orderID")String orderID,@RequestParam("supID")String supID,@RequestParam("supOrderId")String supOrderId,HttpServletRequest req,HttpSession httpSession) {
        logger.info("订单管理-查看物流信息");
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		List<OrderCpi> rltOrderCpies = new ArrayList<OrderCpi>();
		List<OrderCpi> orderCpies= new ArrayList<OrderCpi>();
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> orderResult = new HashMap<String, Object>();
		try {
			if("2".equals(supID)){
				orderResult =  CpiService.getInstance().selectOrder(Integer.parseInt(supID), supOrderId);
				JSONObject orderOb=JSONObject.fromObject(orderResult.get("result"));
				if(orderOb.containsKey("cOrder")){
					JSONArray subOrderInfo= orderOb.getJSONArray("cOrder");				
					if(subOrderInfo.size() != 0){
						JSONObject subOrderObject=JSONObject.fromObject(subOrderInfo.getString(0));
				        if (subOrderObject.has("supplierOrderId")) {
				        	supOrderId = subOrderObject.getString("supplierOrderId");	
				        	result = CpiService.getInstance().trackInfo(Integer.parseInt(supID), orderID, supOrderId);
							//TODO 解析result 转换为对象
							System.out.println("获得的快递信息报文："+result.get("result"));
							JSONObject ob=JSONObject.fromObject(result.get("result"));
							JSONArray array = new JSONArray();
							array=ob.getJSONArray("orderTrack");
							orderCpies = (List<OrderCpi>)JSONArray.toCollection(array, OrderCpi.class);
							System.out.println("快递内容："+orderCpies.get(0).getContent());
							return orderCpies;
				        }					
					}					
				}							
			}else if("4".equals(supID)){
				orderResult =  CpiService.getInstance().selectOrder(Integer.parseInt(supID), supOrderId);
				JSONObject orderOb=JSONObject.fromObject(orderResult.get("result"));
				if(orderOb.containsKey("cOrder")){
					JSONArray subOrderInfo= orderOb.getJSONArray("cOrder");
					if(subOrderInfo.size() != 0){
						for (int i = 0; i < subOrderInfo.size(); i++) {
							OrderCpi orderCpi = new OrderCpi();
							List<String> names = new ArrayList<String>();
							JSONObject subOrderObject=JSONObject.fromObject(subOrderInfo.getString(i));
							JSONArray skuJsonObj= subOrderObject.getJSONArray("sku");
							for (int j = 0; j < skuJsonObj.size(); j++) {
								JSONObject nameObj=JSONObject.fromObject(skuJsonObj.getString(j));
								names.add(nameObj.getString("name"));
							}
							orderCpi.setNames(names);
							if (subOrderObject.has("jdOrderId")) {
						        	supOrderId = subOrderObject.getString("jdOrderId");	
						        	result = CpiService.getInstance().trackInfo(Integer.parseInt(supID), orderID, supOrderId);
									//TODO 解析result 转换为对象
									System.out.println("获得的快递信息报文："+result.get("result"));
									JSONObject ob=JSONObject.fromObject(result.get("result"));
									JSONArray array = new JSONArray();
									array=ob.getJSONArray("orderTrack");
									orderCpies = (List<OrderCpi>)JSONArray.toCollection(array, OrderCpi.class);
									orderCpi.setOrderCpis(orderCpies);
									rltOrderCpies.add(orderCpi);
						     }	
						}
						
				       				
					}					
				}else{
					OrderCpi orderCpi = new OrderCpi();
					List<String> names = new ArrayList<String>();
					JSONArray skuJsonObj= orderOb.getJSONArray("sku");
					for(int i =0;i<skuJsonObj.size();i++){
						JSONObject nameObj=JSONObject.fromObject(skuJsonObj.getString(i));
						names.add(nameObj.getString("name"));						
					}
					orderCpi.setNames(names);
					result = CpiService.getInstance().trackInfo(Integer.parseInt(supID), orderID, supOrderId);
					//TODO 解析result 转换为对象
					System.out.println("获得的快递信息报文："+result.get("result"));
					JSONObject ob=JSONObject.fromObject(result.get("result"));
					JSONArray array = new JSONArray();
					array=ob.getJSONArray("orderTrack");
					orderCpies = (List<OrderCpi>)JSONArray.toCollection(array, OrderCpi.class);
					orderCpi.setOrderCpis(orderCpies);
					rltOrderCpies.add(orderCpi);
				}				
			}else{
				//String subOrderId= subOrderInfo.getString("supplierOrderId");
				result = CpiService.getInstance().trackInfo(Integer.parseInt(supID), orderID, supOrderId);	
				//TODO 解析result 转换为对象
				System.out.println("获得的快递信息报文："+result.get("result"));
				JSONObject ob=JSONObject.fromObject(result.get("result"));
				JSONArray array = new JSONArray();
				array=ob.getJSONArray("track");
				rltOrderCpies = (List<OrderCpi>)JSONArray.toCollection(array, OrderCpi.class);
			}			
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (NoSuchSupplierException e) {
			e.printStackTrace();
		} catch (ServiceExecutionFailedException e) {
			e.printStackTrace();
		}
		
        return rltOrderCpies;
    }
    
    @SuppressWarnings("unchecked")
	@RequestMapping("/orderCancel")
    @ResponseBody
    public Object orderCancel(String orderID,String supID,String supOrderId,HttpServletRequest req,HttpSession httpSession) {
    	logger.info("订单管理-取消订单");
		@SuppressWarnings("unused")
		User user = new User();
    	try {
    		user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
    	} catch (UserNotLoginException e) {
    		return "redirect:/passport/login";
    	} catch (NoPermissionException e){
    		return "redirect:/passport/login";
    	}
    	
    	//调用供应商的取消订单接口
    	try {
    		//无论是否调用成功都继续执行
    		CpiService.getInstance().orderCancel(Integer.parseInt(supID), orderID, supOrderId);
    	} catch (NumberFormatException e) {
    		e.printStackTrace();
    	} catch (NoSuchSupplierException e) {
    		e.printStackTrace();
    	} catch (ServiceExecutionFailedException e) {
    		e.printStackTrace();
    	}
    	return null;
    }
}
