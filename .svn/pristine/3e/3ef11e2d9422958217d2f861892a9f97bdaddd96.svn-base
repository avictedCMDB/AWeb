package com.avic.supplier.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.avic.common.constants.SessionKeys;
import com.avic.supplier.models.SupplierStatement;
import com.avic.supplier.services.SupplierStatementService;

@Controller
@RequestMapping("/statement")
public class SupplierStatementController {

	protected static final Log logger = LogFactory
	.getLog(SupplierStatementController.class);
	
	@Autowired
	SupplierStatementService supplierStatementService;
	
	/**
	 * 页面初始化方法
	 * 
	 * @param map
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("")
	public String index(Map<String, Object> map,
			@ModelAttribute("SupplierStatement") SupplierStatement supplierStatementParam,
			HttpSession httpSession) throws UnsupportedEncodingException {
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		supplierStatementParam.setSupId(Integer.valueOf(supId));
		List<SupplierStatement> supplierStatementList = supplierStatementService.queryStatmentList(supplierStatementParam);
		map.put("supplierStatementList", supplierStatementList);
		map.put("supplierStatementParam", supplierStatementParam);
		//分页信息
		String page = String.valueOf(supplierStatementParam.getPage());
		
        int total = supplierStatementService.queryStatmentListCount(supplierStatementParam);

        int pages = (int) Math.ceil((double) total / supplierStatementParam.getPageSize());
        
        map.put("page", page);
        map.put("total", total);
        map.put("pages", pages);
        map.put("pageAction","supplier/statement?createTimeStar=" + (supplierStatementParam.getCreateTime()==null?"":supplierStatementParam.getCreateTime()) 
				+ "&createTimeEnd=" + (supplierStatementParam.getCreateTimeEnd()==null?"":supplierStatementParam.getCreateTimeEnd())
				+ "&settleId=" + (supplierStatementParam.getSettleId()==null?"":supplierStatementParam.getSettleId())
                + "&page=%PAGE%");
		return "statement/supplier_statement";
	}
	
	/**
	 * 页面初始化方法
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/queryDetailed/{settleId}")
	public String queryDetailed(Map<String, Object> map,
			@PathVariable("settleId") String settleId,
			HttpSession httpSession) {
		String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
		SupplierStatement supplierStatement = new SupplierStatement();
		supplierStatement.setSupId(Integer.valueOf(supId));
		supplierStatement.setSettleId(settleId);
		List<SupplierStatement> supplierStatementList = supplierStatementService.queryStatmentList(supplierStatement);
		map.put("supplierStatement", supplierStatementList.get(0));
		List<SupplierStatement> supplierStatementDetailedList = supplierStatementService.queryStatmentListDetailed(supplierStatement);
		map.put("supplierStatementDetailedList", supplierStatementDetailedList);
		return "statement/supplier_effective";
	}
}
