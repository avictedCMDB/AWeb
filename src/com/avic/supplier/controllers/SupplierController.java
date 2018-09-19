package com.avic.supplier.controllers;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.avic.supplier.models.Supplier;
import com.avic.supplier.services.SupplierService;

@Controller
@RequestMapping("/main")
public class SupplierController {
	
	protected static final Log logger = LogFactory.getLog(SupplierController.class);
	
	@Autowired
	SupplierService supplierService;

	/**
	 * 页面初始化方法
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("")
	public String main(Map<String, Object> map,HttpSession httpSession) {
		logger.info("供应商主页");
		String supID = (String)httpSession.getAttribute("supId");
		Supplier supplier = new Supplier();
		supplier = supplierService.querySupplierMainCount(supID);
		map.put("supplier", supplier);
		return "index";
	}
	
}
