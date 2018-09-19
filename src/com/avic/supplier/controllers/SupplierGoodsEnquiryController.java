package com.avic.supplier.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.rmi.RemoteException;
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
import com.avic.common.shortMessage.ShortMessageUtils;
import com.avic.supplier.models.SupplierGoodsEnquiry;
import com.avic.supplier.services.SupplierGoodsEnquiryService;

@Controller
@RequestMapping("/goodsEnquiry")
public class SupplierGoodsEnquiryController {
	
	protected static final Log logger = LogFactory.getLog(SupplierGoodsEnquiryController.class);
	
	@Autowired
	SupplierGoodsEnquiryService supplierGoodsEnquiryService;
	
    @RequestMapping("")
    public String index(Map<String, Object> map,HttpSession httpSession,
    		@ModelAttribute("supplierGoodsEnquiry") SupplierGoodsEnquiry supplierGoodsEnquiry) throws UnsupportedEncodingException {
    	String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
    	supplierGoodsEnquiry.setSupId(supId);
    	List<SupplierGoodsEnquiry> supplierGoodsEnquiryList = supplierGoodsEnquiryService.queryGoodsEnquiry(supplierGoodsEnquiry);
    	map.put("supplierGoodsEnquiryList", supplierGoodsEnquiryList);
    	map.put("supplierGoodsEnquiryParam", supplierGoodsEnquiry);
    	//分页
    	String page = String.valueOf(supplierGoodsEnquiry.getPage());
        int total = supplierGoodsEnquiryService.queryGoodsEnquiryCount(supplierGoodsEnquiry);

        int pages = (int) Math.ceil((double) total / supplierGoodsEnquiry.getPageSize());
        map.put("page", page);
        map.put("total", total);
        map.put("pages", pages);
        map.put("pageAction","supplier/goodsEnquiry?"
        		+ "&enquiryStatus="+(supplierGoodsEnquiry.getEnquiryStatus() == null ?"":supplierGoodsEnquiry.getEnquiryStatus())
        		+ "&goodsName="+URLEncoder.encode((supplierGoodsEnquiry.getGoodsName() == null ?"":supplierGoodsEnquiry.getGoodsName()),"GBK")
        		+ "&enquiryDateStar="+(supplierGoodsEnquiry.getEnquiryDateStar() == null ?"":supplierGoodsEnquiry.getEnquiryDateStar())
        		+ "&enquiryDateEnd="+(supplierGoodsEnquiry.getEnquiryDateEnd() == null ?"":supplierGoodsEnquiry.getEnquiryDateEnd())
        		+ "&superOfferDateStar="+(supplierGoodsEnquiry.getSuperOfferDateStar() == null ?"":supplierGoodsEnquiry.getSuperOfferDateStar())
        		+ "&superOfferDateEnd="+(supplierGoodsEnquiry.getSuperOfferDateEnd() == null ?"":supplierGoodsEnquiry.getSuperOfferDateEnd())
        		+ "&priceValidDate="+(supplierGoodsEnquiry.getPriceValidDate() == null ?"":supplierGoodsEnquiry.getPriceValidDate())
                + "&page=%PAGE%");
    	return "order/supplier_enquiry";
    }

    
    @RequestMapping("/updateGoodsEnquiry")
    @ResponseBody
    public Object updateGoodsEnquiry(Map<String, Object> map,HttpSession httpSession,
    		@RequestParam("id") String id,
    		@RequestParam("status") String status,
    		@RequestParam("price") String price) throws RemoteException {
    	String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
    	SupplierGoodsEnquiry supplierGoodsEnquiry = new SupplierGoodsEnquiry();
    	supplierGoodsEnquiry.setSupId(supId);
    	supplierGoodsEnquiry.setId(id);
    	supplierGoodsEnquiry.setGoodsPriceAfter(price);
    	supplierGoodsEnquiry.setEnquiryStatus(status);
    	supplierGoodsEnquiryService.updateGoodsEnquiry(supplierGoodsEnquiry);
    	//发送短信
    	supplierGoodsEnquiry.setId(id);
    	List<SupplierGoodsEnquiry> supplierGoodsEnquiryList = supplierGoodsEnquiryService.queryGoodsEnquiry(supplierGoodsEnquiry);
    	String smsContent = "";
    	if ("1".equals(status)) {
			smsContent = supplierGoodsEnquiryList.get(0).getContactName()+ "您好， 商品（"+supplierGoodsEnquiryList.get(0).getGoodsName()+
			"） 型号 （"+supplierGoodsEnquiryList.get(0).getGoodsModel()+"）已提供最新报价，请查看。";
		}else {
			smsContent = supplierGoodsEnquiryList.get(0).getContactName()+ "您好， 商品（"+supplierGoodsEnquiryList.get(0).getGoodsName()+
			"） 型号 （"+supplierGoodsEnquiryList.get(0).getGoodsModel()+"）已拒绝报价，请查看。";
		}
    	ShortMessageUtils.sendSMS(new String[]{supplierGoodsEnquiryList.get(0).getContactTel()}, smsContent);
    	logger.info("询价成功，发送短信。电话："+supplierGoodsEnquiryList.get(0).getContactTel()+" 内容:"+smsContent);
    	return "0";
    }
    @RequestMapping("/enquiryPricePage/{id}")
    public String enquiryPricePage(Map<String, Object> map,HttpSession httpSession,
    		@PathVariable("id") String id) {
    	SupplierGoodsEnquiry supplierGoodsEnquiry = new SupplierGoodsEnquiry();
    	String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
    	supplierGoodsEnquiry.setSupId(supId);
    	supplierGoodsEnquiry.setId(id);
    	List<SupplierGoodsEnquiry> supplierGoodsEnquiryList = supplierGoodsEnquiryService.queryGoodsEnquiry(supplierGoodsEnquiry);
    	map.put("supplierGoodsEnquiry", supplierGoodsEnquiryList.get(0));
    	return "order/supplier_enquiry_price";
    }
    
}
