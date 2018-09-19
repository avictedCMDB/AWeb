package com.avic.supplier.controllers;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.avic.supplier.models.SupplierGoodsInfo;

@Controller
@RequestMapping("/supplierMyinfo")
public class SupplierMyinfoController {
	
	/**
	 * 供应商企业信息
	 * 
	 * @param map
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("page1")
	public String page1(Map<String, Object> map,HttpSession httpSession,
			@ModelAttribute("supplierGoodsInfo") SupplierGoodsInfo supplierGoodsInfo) throws UnsupportedEncodingException {
		return "supplierMyinfo/supplier_myinfo";
	}
	/**
	 * 商品回收站页面初始化方法
	 * 
	 * @param map
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("page2")
	public String page2(Map<String, Object> map,HttpSession httpSession,
			@ModelAttribute("supplierGoodsInfo") SupplierGoodsInfo supplierGoodsInfo) throws UnsupportedEncodingException {
		return "supplierMyinfo/supplier_myinfo02";
	}

}
