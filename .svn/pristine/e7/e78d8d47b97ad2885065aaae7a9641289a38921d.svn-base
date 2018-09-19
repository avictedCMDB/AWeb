package com.avic.management.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.Permission;
import com.avic.management.models.Exchange;
import com.avic.management.models.ExchangeGoods;
import com.avic.management.models.Order;
import com.avic.management.models.Refound;
import com.avic.management.models.RefoundGoods;
import com.avic.management.models.Services;
import com.avic.management.services.CommonService;
import com.avic.management.services.ExchangeGoodsService;
import com.avic.management.services.ExchangeService;
import com.avic.management.services.OrderService;
import com.avic.management.services.RefoundGoodsService;
import com.avic.management.services.RefoundService;
import com.avic.management.services.ServicesService;
import com.avic.market.cpi.CpiService;
import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.passport.models.User;

@Controller
@RequestMapping("/services")
@Transactional
public class ServicesController {
    protected static final Log logger = LogFactory.getLog(ServicesController.class);
    static final int PAGE_SIZE = 5; //每页显示多少条
    @Autowired
    CommonService commonService;
    @Autowired
    ServicesService servicesService;
    @Autowired
    ExchangeService exchangeService;
    @Autowired
    RefoundService refoundService;
    @Autowired
    ExchangeGoodsService exchangeGoodsService;
    @Autowired
    RefoundGoodsService refoundGoodsService;
    @Autowired
    OrderService orderService;
    
    @RequestMapping("exchangeServices")
    public String exchangeServices(@ModelAttribute("services") Services services,HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
    	 logger.info("换货服务单查询。。");
         User user = new User();
         try {
         	user = Permission.check(httpSession,UserRole.BUY,UserRole.CLIENT);
 		} catch (UserNotLoginException e) {
 			return "redirect:/passport/login";
 		} catch (NoPermissionException e){
 			return "redirect:/passport/login";
 		}
 		
        List<Services> servicesList = new ArrayList<Services>();
         servicesList = servicesService.queryExchangeServices(services);
         
         map.put("service", services);
         map.put("services", servicesList);
         return "services/service";
    }
    
    @RequestMapping("refoundServices")
    public String refoundServices(@ModelAttribute("services") Services services,HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
    	 logger.info("退货服务单查询。。");
         User user = new User();
         try {
         	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
 		} catch (UserNotLoginException e) {
 			return "redirect:/passport/login";
 		} catch (NoPermissionException e){
 			return "redirect:/passport/login";
 		}
 		
         List<Services> servicesList = new ArrayList<Services>();
         servicesList = servicesService.queryRefoundServices(services);
         
         map.put("service", services);
         map.put("services", servicesList);
         return "services/service";
    }
    
    
    @RequestMapping("auditCancle")
    @ResponseBody
    public Object auditCancle(@ModelAttribute("services") Services services,HttpSession httpSession) {
        logger.info("取消服务单");
        Map<String, String> map = new HashMap<String, String>();
        User user = new User();
        try {
        	user = Permission.check(httpSession, UserRole.BUY,UserRole.CLIENT);
		} catch (UserNotLoginException e) {
			return "redirect:/passport/login";
		} catch (NoPermissionException e){
			return "redirect:/passport/login";
		}
		int supID = Integer.parseInt(services.getSupID());
		//调用取消申请服务单接口
		Map<String, Object> auditMap = new HashMap<String, Object>();
		ArrayList<String> al = new ArrayList<String>();
		al.add(services.getServicesID());
		Map<String, Object> r;
		auditMap.put("serviceIdList", al);
		auditMap.put("approveNotes", "取消服务单");
		try {
			r = CpiService.getInstance().auditCancel(supID, auditMap);
		} catch (NoSuchSupplierException e) {
			e.printStackTrace();
			map.put("status", "fail");
			return map;
		} catch (ServiceExecutionFailedException e) {
			e.printStackTrace();
			map.put("status", "fail");
			return map;
		}
		boolean rlt = (Boolean) r.get("success");
		boolean result = (Boolean) r.get("result");
		if(r!=null && rlt && result){
			//修改服务单 取消申请状态
			servicesService.updateServices(services);
			//TODO exchangeOrRefound 换货或退货单修改价格和数量
			String exchangeOrRefound = services.getExchangeOrRefound();
			String goodsNum = "";
			String goodsPrice = "";
			if("20170228165128000068".equals(user.getCompanyId())){
				goodsPrice = services.getGoodsPriceInit();
			}else{
				goodsPrice = services.getGoodsPrice();
			}
			String typeID = services.getTypeID();
			if("1".equals(exchangeOrRefound)){
				
				//根据typeID 查询换货单 信息
				Exchange e = new Exchange();
				e.setExchangeID(typeID);
				e = exchangeService.queryExchangePriceAndAmountByExchangeID(e);
				goodsNum = "1";//services.getExchangeNum();//jd服务单多少商品就生成多少服务单 每个服务单就一个商品
				int exchangeNum = 0;
				double exchangePrice = 0;
				exchangeNum = Integer.parseInt(e.getExchangeAmount()) - Integer.parseInt(goodsNum);
				exchangePrice = Double.parseDouble(e.getExchangePrice()) - Double.parseDouble(goodsPrice)*Integer.parseInt(goodsNum);
				//修改换货单价格数量
				e.setExchangeAmount(exchangeNum+"");
				e.setExchangePrice(exchangePrice+"");
				exchangeService.updateOrderExchangePriceAndAmount(e);
				// DEL 商品
				String supGoodsID = services.getSupGoodsID();
				ExchangeGoods exchangeGoods = new ExchangeGoods();
				exchangeGoods.setExchangeID(typeID);
				exchangeGoods.setSupGoodsID(supGoodsID);
				//exchangeGoodsService.delExchangeGoods(exchangeGoods);
				
			}else{
				//根据typeID 查询退货单 信息
				Refound re = new Refound();
				re.setRefoundID(typeID);
				re = refoundService.queryRefoundPriceAndAmountByRefoundID(re);
				goodsNum = "1";//services.getRefoundNum();//jd服务单多少商品就生成多少服务单 每个服务单就一个商品
				int refoundNum = 0;
				double refoundPrice = 0;
				refoundNum = Integer.parseInt(re.getRefoundAmount()) - Integer.parseInt(goodsNum);
				refoundPrice = Double.parseDouble(re.getRefoundPrice()) - Double.parseDouble(goodsPrice)*Integer.parseInt(goodsNum);
				//修改退货单价格数量
				re.setRefoundAmount(refoundNum+"");
				re.setRefoundPrice(refoundPrice+"");
				refoundService.updateOrderRefoundPriceAndAmount(re);
				// DEL 商品
				String supGoodsID = services.getSupGoodsID();
				RefoundGoods refoundGoods = new RefoundGoods();
				refoundGoods.setRefoundID(typeID);
				refoundGoods.setSupGoodsID(supGoodsID);
				//refoundGoodsService.delRefoundGoods(refoundGoods);
			}
			orderService.doReceived(services.getOrderID());
		}else{
			map.put("status", "fail");
			if(r.containsKey("msg")){
				map.put("msg", r.get("msg").toString());
			}else if(r.containsKey("resultMessage")){
				map.put("msg", r.get("resultMessage").toString());
			}
			
			return map;
		}
		map.put("status", "success");
		return map;
    }
}
