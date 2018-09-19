package com.avic.market.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.beans.ResultObject;
import com.avic.common.constants.UserRole;
import com.avic.common.utils.Permission;
import com.avic.market.utils.DataCache;

@Controller
@RequestMapping("/my")
public class MyController {

	@Autowired
	DataCache dataCache;
	
	@RequestMapping("")
	public String index (HttpSession session) {
        Permission.check(session, UserRole.BUY, UserRole.CLIENT);
		return "my/index";
	}
	

	@RequestMapping("get_cart_count")
	@ResponseBody
	public ResultObject getCartCount (HttpSession session) {
		return new ResultObject(ResultObject.OK, dataCache.cartNum(session));
	}
	
}
