package com.avic.supplier.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.constants.SessionKeys;
import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.supplier.models.SupArea;
import com.avic.supplier.services.SupAreaService;

@Controller
@RequestMapping("/delivery")
public class SupplierDeliveryController {
	
	protected static final Log logger = LogFactory
			.getLog(SupplierDeliveryController.class);
	
	@Autowired
	SupAreaService areaService;

	/**
	 * 页面初始化方法
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("")
	public String index(Map<String, Object> map,HttpSession httpSession) {
		logger.info("供应商发货信息管理");
		// 取得地区信息
		SupArea supArea = new SupArea();
		supArea.setSupID(httpSession.getAttribute(SessionKeys.SUP_ID).toString());
		// 加载地区信息
		List<SupArea> areas = areaService.queryAreas(supArea);
		map.put("areasList", areas);
		return "order/supplier_delivery";
	}
	@RequestMapping("/loadSubArea")
	@ResponseBody
	public Object loadSubArea(@RequestParam("parentId") String parentId,
			HttpSession httpSession)
			throws NoSuchSupplierException, ServiceExecutionFailedException {
		SupArea supArea = new SupArea();
		supArea.setSupParentArea(parentId);
		supArea.setSupID(httpSession.getAttribute(SessionKeys.SUP_ID).toString());
		// 加载地区信息
		List<SupArea> areas = new ArrayList<SupArea>();
		areas = areaService.querySubAreas(supArea);
		return areas;
	}
}
