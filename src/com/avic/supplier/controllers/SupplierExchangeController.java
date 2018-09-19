package com.avic.supplier.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.constants.SessionKeys;
import com.avic.supplier.models.SupplierAddress;
import com.avic.supplier.models.SupplierCodeList;
import com.avic.supplier.models.SupplierExchange;
import com.avic.supplier.models.SupplierGoodsImage;
import com.avic.supplier.services.SupplierAddressService;
import com.avic.supplier.services.SupplierExchangeService;
import com.avic.supplier.services.SupplierGoodsInfoService;
import com.avic.supplier.services.SupplierOrderService;

@Controller
@RequestMapping("/exchange")
public class SupplierExchangeController {

	protected static final Log logger = LogFactory
			.getLog(SupplierExchangeController.class);
	
	@Autowired
	SupplierExchangeService supplierExchangeService;
	
    @Autowired
    SupplierAddressService supplierAddressService;
	
    @Autowired
	SupplierOrderService supplierOrderService;
    
    @Autowired
	SupplierGoodsInfoService supplierGoodsInfoService;
	/**
	 * 页面初始化方法
	 * 
	 * @param map
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("")
	public String index(Map<String, Object> map,
			@ModelAttribute("SupplierExchange") SupplierExchange supplierOrderParam,
			HttpSession httpSession) throws UnsupportedEncodingException {
		logger.info("供应商换货信息管理");
		if (supplierOrderParam.getExchangeStatus() == null) {
			supplierOrderParam.setExchangeStatus("");
		}
		//从session获取userid
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        supplierOrderParam.setSupId(supId);
        List<SupplierExchange> ordersList = supplierExchangeService.queryExchangeOrderList(supplierOrderParam);
        //订单状态初始化结果集
        List<SupplierCodeList> ordersStatusList = supplierExchangeService.queryExchangeOrderStatusList();
        map.put("ordersList", ordersList);//查询结果集
        map.put("orderQuery", supplierOrderParam);//查询条件回显
        map.put("ordersStatusList", ordersStatusList);//订单状态列表结果集
        //分页信息
		String page = String.valueOf(supplierOrderParam.getPage());
		
        int total = supplierExchangeService.queryExchangeOrderListCount(supplierOrderParam);

        int pages = (int) Math.ceil((double) total / supplierOrderParam.getPageSize());
        
        map.put("page", page);
        map.put("total", total);
        map.put("pages", pages);
        map.put("pageAction","supplier/exchange?"
        		+ "&exchangeTimeStar="+(supplierOrderParam.getExchangeTimeStar() == null ? "":supplierOrderParam.getExchangeTimeStar())
        		+ "&exchangeTimeEnd="+(supplierOrderParam.getExchangeTimeEnd() == null ? "":supplierOrderParam.getExchangeTimeEnd())
        		+ "&exchangeId="+(supplierOrderParam.getExchangeId() == null ? "":supplierOrderParam.getExchangeId())
        		+ "&companyname="+URLEncoder.encode((supplierOrderParam.getCompanyname() == null ? "":supplierOrderParam.getCompanyname()),"GBK")
        		+ "&orderId="+(supplierOrderParam.getOrderId() == null ? "":supplierOrderParam.getOrderId())
        		+ "&exchangeStatus="+(supplierOrderParam.getExchangeStatus() == null ? "":supplierOrderParam.getExchangeStatus())
                + "&page=%PAGE%");
		return "order/supplier_exchange";
	}
	
	/**
	 * 页面初始化方法
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/exchangeConfirmPage/{exchangeId}")
	public String exchangeConfirmPage(Map<String, Object> map,
			@PathVariable("exchangeId") String exchangeId,
			HttpSession httpSession) {
		logger.info("供应商换货信息审核页面");
		//从session获取userid
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        //获取供应商地址
        SupplierAddress supplierAddress = new SupplierAddress();
        supplierAddress.setSupId(supId);
      //传统供应商默认地址为晨光地址
		if ("1".equals(httpSession.getAttribute(SessionKeys.SUP_TYPE).toString())) {
			// 设置为晨光地址
			supplierAddress.setAreSupId("1");
			
		}else {
			supplierAddress.setAreSupId(supId);
		}
        List<SupplierAddress> supplierAddressList = supplierAddressService.querySupplierAddressList(supplierAddress);
        map.put("supplierAddressList", supplierAddressList);
        // 获取商品信息
        SupplierExchange supplierExchange = new SupplierExchange();
        supplierExchange.setSupId(supId);
        supplierExchange.setExchangeId(exchangeId);
        List<SupplierExchange> result = supplierExchangeService.queryExchangeOrderDetailed(supplierExchange);
        map.put("supplierExchangeList", result);
        map.put("exchangeId", exchangeId);
		return "order/supplier_exchange_confirm";
	}
	
	/**
	 * 供应商商品审核确认
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/exchangeConfirm")
	@ResponseBody
	public Object exchangeConfirm(@RequestParam("exchangeStatus") String exchangeStatus,
			@RequestParam("supplierAddressId") String supplierAddressId,
			@RequestParam("supCheckInfo") String supCheckInfo,
			@RequestParam("exchangeId") String exchangeId,
			HttpSession httpSession) {
		logger.info("供应商换货信息审核确认");
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		SupplierExchange supplierExchange = new SupplierExchange();
		supplierExchange.setExchangeId(exchangeId);
		supplierExchange.setSupplierAddressId(supplierAddressId);
		supplierExchange.setSupCheckInfo(supCheckInfo);
		supplierExchange.setExchangeStatus(exchangeStatus);
		supplierExchange.setSupId(supId);
		supplierExchangeService.updateExchangeOrderStatus(supplierExchange);
		return "0";
	}
	/**
	 * 供应商商品收货确认
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/exchangeDelivery")
	@ResponseBody
	public Object exchangeDelivery(@RequestParam("exchangeStatus") String exchangeStatus,
			@RequestParam("exchangeId") String exchangeId,
			HttpSession httpSession) {
		logger.info("供应商商品收货确认");
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		SupplierExchange supplierExchange = new SupplierExchange();
		supplierExchange.setExchangeId(exchangeId);
		supplierExchange.setExchangeStatus(exchangeStatus);
		supplierExchange.setSupId(supId);
		supplierExchangeService.updateExchangeOrderStatus(supplierExchange);
		return "0";
	}
	/**
	 * 页面初始化方法
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/queryDetailed/{exchangeId}")
	public String queryDetailed(Map<String, Object> map,
			@PathVariable("exchangeId") String exchangeId,
			HttpSession httpSession) {
		logger.info("供应商换货信息审核页面");
		//从session获取userid
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        //获取换货信息
        SupplierExchange supplierExchangeDetailed = new SupplierExchange();
        supplierExchangeDetailed.setSupId(supId);
        supplierExchangeDetailed.setExchangeId(exchangeId);
        List<SupplierExchange> ordersList = supplierExchangeService.queryExchangeOrderList(supplierExchangeDetailed);
        
        map.put("supplierExchangeDetailed", ordersList.get(0));
        // 获取商品信息
        SupplierExchange supplierExchange = new SupplierExchange();
        supplierExchange.setSupId(supId);
        supplierExchange.setExchangeId(exchangeId);
        List<SupplierExchange> resultList = supplierExchangeService.queryExchangeOrderDetailed(supplierExchange);
        //查询附件
        SupplierGoodsImage supplierGoodsImage = new SupplierGoodsImage();
        supplierGoodsImage.setBusinessId(exchangeId);
        supplierGoodsImage.setBusinessType("1");
        List<SupplierGoodsImage> imageList = supplierGoodsInfoService.queryImage(supplierGoodsImage);
        map.put("imageList", imageList);
        map.put("supplierExchangeList", resultList);
        map.put("exchangeId", exchangeId);
		return "order/supplier_exchange_check";
	}
	
	/**
	 * 页面初始化方法
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/exchangeSendPage/{exchangeId}")
	public String exchangeSendPage(Map<String, Object> map,
			@PathVariable("exchangeId") String exchangeId,
			HttpSession httpSession) {
		logger.info("供应商换货发货信息审核页面");
		//从session获取userid
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        //获取换货信息
        SupplierExchange supplierExchangeDetailed = new SupplierExchange();
        supplierExchangeDetailed.setSupId(supId);
        supplierExchangeDetailed.setExchangeId(exchangeId);
        List<SupplierExchange> ordersList = supplierExchangeService.queryExchangeOrderList(supplierExchangeDetailed);
        
        map.put("supplierExchangeDetailed", ordersList.get(0));
        // 获取商品信息
        SupplierExchange supplierExchange = new SupplierExchange();
        supplierExchange.setSupId(supId);
        supplierExchange.setExchangeId(exchangeId);
        List<SupplierExchange> resultList = supplierExchangeService.queryExchangeOrderDetailed(supplierExchange);
        map.put("supplierExchangeList", resultList);
        map.put("exchangeId", exchangeId);
        //获取物流信息
        
		return "order/supplier_exchange_send";
	}
    /**
     * 发货
     * @param map
     * @return
     */
    @RequestMapping("/exchaneGoodsSend/{exchangeId}")
    public String exchaneGoodsSend(Map<String, Object> map,@PathVariable("exchangeId") String exchangeId,@ModelAttribute("SupplierExchange") SupplierExchange supplierOrderParam,
    		HttpSession httpSession) {
        logger.info("换货发货");
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        supplierOrderParam.setSupId(supId);
        supplierOrderParam.setExchangeStatus("5");
        supplierOrderParam.setExchangeId(exchangeId);
        supplierExchangeService.updateExchangeOrderStatus(supplierOrderParam);
        return "redirect:/supplier/exchange";
    }
    /**
     * 返回方法
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/back")
    public String backSupplierAddress(Map<String, Object> map) {
        logger.info("返回换货管理");
        return "redirect:/supplier/exchange";
    }
}
