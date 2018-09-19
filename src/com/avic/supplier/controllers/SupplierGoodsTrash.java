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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.avic.common.constants.SessionKeys;
import com.avic.supplier.models.Supplier;
import com.avic.supplier.models.SupplierGoodsInfo;
import com.avic.supplier.services.SupplierGoodsInfoService;
import com.avic.supplier.services.SupplierService;

@Controller
@RequestMapping("/goodsTrash")
public class SupplierGoodsTrash {
	
	protected static final Log logger = LogFactory.getLog(SupplierGoodsTrash.class);
	
	@Autowired
	SupplierService supplierService;
	
	@Autowired
	SupplierGoodsInfoService supplierGoodsInfoService;

	/**
	 * ��Ʒ����վҳ���ʼ������
	 * 
	 * @param map
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("")
	public String main(Map<String, Object> map,HttpSession httpSession,
			@ModelAttribute("supplierGoodsInfo") SupplierGoodsInfo supplierGoodsInfo) throws UnsupportedEncodingException {
		String supId = (String)httpSession.getAttribute(SessionKeys.SUP_ID);
		supplierGoodsInfo.setSupId(supId);
		supplierGoodsInfo.setDeleteFlag("1");
		List<SupplierGoodsInfo> supplierGoodsInfoList = supplierGoodsInfoService
				.querySupplierGoodsInfoList(supplierGoodsInfo);
		map.put("supplierGoodsInfoList", supplierGoodsInfoList);
		List<SupplierGoodsInfo> bankNameList = supplierGoodsInfoService
				.querySupplierGoodsInfoBrandNameList(supplierGoodsInfo);
		map.put("bankNameList", bankNameList);
		map.put("queryParam", supplierGoodsInfo);
		//��ҳ��Ϣ
        String page = String.valueOf(supplierGoodsInfo.getPage());
        int total = supplierGoodsInfoService.querySupplierGoodsInfoListCount(supplierGoodsInfo);

        int pages = (int) Math.ceil((double) total / supplierGoodsInfo.getPageSize());
        
        map.put("page", page);
        map.put("total", total);
        map.put("pages", pages);
        map.put("pageAction","supplier/goodsTrash?"
        		+ "&brandName="+(supplierGoodsInfo.getBrandName() == null ?"":supplierGoodsInfo.getBrandName())
        		+ "&goodsName="+URLEncoder.encode((supplierGoodsInfo.getGoodsName() == null ?"":supplierGoodsInfo.getGoodsName()),"GBK")
        		+ "&goodsDesc="+URLEncoder.encode((supplierGoodsInfo.getGoodsDesc() == null ?"":supplierGoodsInfo.getGoodsDesc()),"GBK")
                + "&page=%PAGE%");
		return "goods/supplier_goods_trash";
	}
	/**
	 * ������ԭ
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/updateGoodsReturnDelete")
	public String updateDeleteFlag(Map<String, Object> map,
			@RequestParam("goodsIds") String goodsIds,
			HttpSession httpSession) {
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		String goodsIdsList[] = goodsIds.split(",");
		for (int i = 0; i < goodsIdsList.length; i++) {
			SupplierGoodsInfo supplierGoodsInfo = new SupplierGoodsInfo();
			supplierGoodsInfo.setSupId(supId);
			supplierGoodsInfo.setSupGoodsId(goodsIdsList[i]);
			supplierGoodsInfo.setDeleteFlag("0");
			supplierGoodsInfoService.updateDeleteFlag(supplierGoodsInfo);
		}
		return "redirect:/supplier/goodsTrash";
	}
	
}