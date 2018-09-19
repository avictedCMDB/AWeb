package com.avic.supplier.controllers;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.avic.common.constants.SessionKeys;
import com.avic.supplier.models.Supplier;
import com.avic.supplier.services.SupplierService;

@Controller
@RequestMapping("/index")
public class IndexController {
    protected static final Log logger = LogFactory.getLog(IndexController.class);
    @Autowired
	SupplierService supplierService;
    
    @RequestMapping("")
    public String index(Map<String, Object> map,HttpSession httpSession) {
    	logger.info("供应商主页");
		String supID = (String)httpSession.getAttribute(SessionKeys.SUP_ID);
		Supplier supplier = new Supplier();
		supplier = supplierService.querySupplierMainCount(supID);
		map.put("supplier", supplier);
        return "index";
    }
}
