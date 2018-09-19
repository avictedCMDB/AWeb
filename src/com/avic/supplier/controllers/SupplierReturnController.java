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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.constants.SessionKeys;
import com.avic.supplier.models.SupplierAddress;
import com.avic.supplier.models.SupplierCodeList;
import com.avic.supplier.models.SupplierGoodsImage;
import com.avic.supplier.models.SupplierReturn;
import com.avic.supplier.services.SupplierAddressService;
import com.avic.supplier.services.SupplierGoodsInfoService;
import com.avic.supplier.services.SupplierReturnService;

@Controller
@RequestMapping("/return")
public class SupplierReturnController {
	
	protected static final Log logger = LogFactory
	.getLog(SupplierReturnController.class);
	
	@Autowired
	SupplierReturnService supplierRerurnService;
	
    @Autowired
    SupplierAddressService supplierAddressService;
    
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
			@ModelAttribute("SupplierReturn") SupplierReturn supplierReturnParam,
			HttpSession httpSession) throws UnsupportedEncodingException {
		if (supplierReturnParam.getRefoundStatus() == null) {
			supplierReturnParam.setRefoundStatus("");
		}
		//从session获取userid
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        supplierReturnParam.setSupId(supId);
        List<SupplierReturn> ordersList = supplierRerurnService.queryRerurnOrderList(supplierReturnParam);
        //订单状态初始化结果集
        List<SupplierCodeList> ordersStatusList = supplierRerurnService.queryReturnStatusList();
        map.put("ordersList", ordersList);//查询结果集
        map.put("orderQuery", supplierReturnParam);//查询条件回显
        map.put("ordersStatusList", ordersStatusList);//订单状态列表结果集
        //分页信息
        String page = String.valueOf(supplierReturnParam.getPage());
        int total = supplierRerurnService.queryRerurnOrderListCount(supplierReturnParam);

        int pages = (int) Math.ceil((double) total / supplierReturnParam.getPageSize());
        
        map.put("page", page);
        map.put("total", total);
        map.put("pages", pages);
        map.put("pageAction","supplier/return?"
        		+ "&refoundDateStar="+(supplierReturnParam.getRefoundDateStar() == null ?"":supplierReturnParam.getRefoundDateStar())
        		+ "&refoundDateEnd="+(supplierReturnParam.getRefoundDateEnd() == null ?"":supplierReturnParam.getRefoundDateEnd())
        		+ "&companyname="+URLEncoder.encode((supplierReturnParam.getCompanyname() == null ?"":supplierReturnParam.getCompanyname()),"GBK")
        		+ "&refoundId="+(supplierReturnParam.getRefoundId() == null ?"":supplierReturnParam.getRefoundId())
        		+ "&orderId="+(supplierReturnParam.getOrderId() == null ?"":supplierReturnParam.getOrderId())
        		+ "&refoundStatus="+(supplierReturnParam.getRefoundStatus() == null ?"":supplierReturnParam.getRefoundStatus())
                + "&page=%PAGE%");
		return "order/supplier_rerurn";
	}
	
	/**
	 * 页面初始化方法
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/returnConfirmPage/{refoundId}")
	public String exchangeConfirmPage(Map<String, Object> map,
			@PathVariable("refoundId") String refoundId,
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
        SupplierReturn supplierReturn = new SupplierReturn();
        supplierReturn.setSupId(supId);
        supplierReturn.setRefoundId(refoundId);
        List<SupplierReturn> result = supplierRerurnService.queryReturnOrderDetailed(supplierReturn);
        map.put("supplierReturnList", result);
        map.put("refoundId", refoundId);
		return "order/supplier_rerurn_confirm";
	}

	/**
	 * 供应商商品审核确认
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/returnConfirm")
	@ResponseBody
	public Object exchangeConfirm(@RequestParam("refoundStatus") String refoundStatus,
			@RequestParam("supplierAddressId") String supplierAddressId,
			@RequestParam("supCheckInfo") String supCheckInfo,
			@RequestParam("refoundId") String refoundId,
			HttpSession httpSession) {
		logger.info("供应商换货信息审核确认");
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		SupplierReturn supplierReturn = new SupplierReturn();
		supplierReturn.setRefoundId(refoundId);
		supplierReturn.setRefoundStatus(refoundStatus);
		supplierReturn.setSupCheckInfo(supCheckInfo);
		supplierReturn.setSupplierAddressId(supplierAddressId);
		supplierReturn.setSupId(supId);
		supplierRerurnService.updateReturnOrderStatus(supplierReturn);
		return "0";
	}
	/**
	 * 供应商商品收货确认
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/returnDelivery")
	@ResponseBody
	public Object exchangeDelivery(@RequestParam(value = "refoundstatus",required = false) String refoundStatus,
			@RequestParam(value = "refoundId",required = false) String refoundId,
			HttpSession httpSession) {
		logger.info("供应商商品收货确认");
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		SupplierReturn supplierReturn = new SupplierReturn();
		supplierReturn.setRefoundId(refoundId);
		supplierReturn.setRefoundStatus(refoundStatus);
		supplierReturn.setSupId(supId);
		supplierRerurnService.updateReturnOrderStatus(supplierReturn);
		return "0";
	}
	/**
	 * 查看页面初始化方法
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/returnDetailedPage/{refoundId}")
	public String returnDetailedPage(Map<String, Object> map,
			@PathVariable("refoundId") String refoundId,
			HttpSession httpSession) {
		logger.info("供应商换货信息审核页面");
		//从session获取userid
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        // 获取商品信息
        SupplierReturn supplierReturn = new SupplierReturn();
        supplierReturn.setSupId(supId);
        supplierReturn.setRefoundId(refoundId);
        List<SupplierReturn> result = supplierRerurnService.queryReturnOrderDetailed(supplierReturn);
        //获取商品基本信息
        List<SupplierReturn> supplierReturnList = supplierRerurnService.queryRerurnOrderList(supplierReturn);
        map.put("supplierReturn", supplierReturnList.get(0));
        //查询附件
        SupplierGoodsImage supplierGoodsImage = new SupplierGoodsImage();
        supplierGoodsImage.setBusinessId(refoundId);
        supplierGoodsImage.setBusinessType("2");
        List<SupplierGoodsImage> imageList = supplierGoodsInfoService.queryImage(supplierGoodsImage);
        map.put("imageList", imageList);
        map.put("supplierReturnList", result);
        map.put("refoundId", refoundId);
		return "order/supplier_rerurn_check";
	}
    /**
     * 返回方法
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/back")
    public String backSupplierAddress(Map<String, Object> map) {
        logger.info("返回退货管理");
        return "redirect:/supplier/return";
    }
	
}
