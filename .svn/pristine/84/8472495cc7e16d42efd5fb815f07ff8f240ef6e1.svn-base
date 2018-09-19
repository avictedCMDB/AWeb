package com.avic.supervise.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.constants.SessionKeys;
import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.supervise.models.EnterpriseSupMapping;
import com.avic.supervise.models.User;
import com.avic.supervise.services.SupervisePartnerService;

@Controller
@RequestMapping("/partner")
@Transactional
public class SupervisePartnerController {

	static final int PAGE_SIZE = 10; // 每页显示多少条

	protected static final Log logger = LogFactory
			.getLog(SupervisePartnerController.class);

	@Autowired
	SupervisePartnerService supervisePartnerService;

	@RequestMapping("")
	public String index(
			@ModelAttribute("enterpriseSupMapping") EnterpriseSupMapping enterpriseSupMapping,
			HttpServletRequest req, Map<String, Object> map,
			HttpSession httpSession) throws UnsupportedEncodingException {
		logger.info("查询合作供应商列表");
		User user = (User) httpSession.getAttribute(SessionKeys.LOGIN_SUPERVISE);

		String page = req.getParameter("page");
		String companyId = user.getCompanyId();
		enterpriseSupMapping.setCompanyId(companyId);
		int pageNum = 1;

		if (StringUtils.isNumeric(page)) {
			pageNum = Integer.parseInt(page);
		}

		// enterpriseSupMapping.setUserID(user.getUserId());

		// 查询数量
		int total = supervisePartnerService
				.queryEnterpriseSupMappingCount(enterpriseSupMapping);

		int pages = (int) Math.ceil((double) total / PAGE_SIZE);

		if (pageNum > pages) {
			pageNum = pages;
		}

		enterpriseSupMapping.setPage(pageNum);
		enterpriseSupMapping.setPageSize(PAGE_SIZE);
		List<EnterpriseSupMapping> enterpriseSupMappingList = supervisePartnerService
				.queryEnterpriseSupMappingList(enterpriseSupMapping);
		enterpriseSupMapping.setPage(1);
		List<EnterpriseSupMapping> supInfoList = supervisePartnerService.querySupInfo(enterpriseSupMapping);
		int supPageNum = 1;
		Integer supTotal = supervisePartnerService.querySupInfoCount(enterpriseSupMapping);
		int supPages = (int) Math.ceil((double) supTotal / PAGE_SIZE);
		if (supPageNum > supPages) {
			supPageNum = supPages;
		}
		map.put("supInfoList", supInfoList);
		map.put("enterpriseSupMappingList", enterpriseSupMappingList);
		map.put("enterpriseSupMappingParam", enterpriseSupMapping);
		map.put("page", pageNum);
		map.put("total", total);
		map.put("supPages", supPages);
		map.put("supPageNum", supPageNum);
		map.put("supTotal", supTotal);
		map.put("pages", pages);
		map.put("pageAction",
				"supervise/partner?page=%PAGE%"
						+ "&supName="
						+ URLEncoder.encode(
								enterpriseSupMapping.getSupName() == null ? ""
										: enterpriseSupMapping.getSupName(),
								"GBK")
						+ "&contactPerson="
						+ URLEncoder.encode(enterpriseSupMapping
								.getContactPerson() == null ? ""
								: enterpriseSupMapping.getContactPerson(),
								"GBK")
						+ "&contactNum="
						+ URLEncoder.encode(enterpriseSupMapping
								.getContactNum() == null ? ""
								: enterpriseSupMapping.getContactNum(), "GBK"));
		return "companyInfo/supervise_partner";
	}

	@RequestMapping("/updateIfBuilding")
	@ResponseBody
	public Object updateIfBuilding(@RequestParam("id") String id, @RequestParam("ifBuilding") String ifBuilding,HttpSession httpSession)
			throws NoSuchSupplierException, ServiceExecutionFailedException {
		EnterpriseSupMapping enterpriseSupMapping = new EnterpriseSupMapping();
		enterpriseSupMapping.setId(id);
		enterpriseSupMapping.setIfBuilding(ifBuilding);
		supervisePartnerService.updateIfBuilding(enterpriseSupMapping);
		return "1";
	}
	
	@RequestMapping("/deleteSupMapping")
	@ResponseBody
	public Object deleteSupMapping(@RequestParam("id") String id,HttpSession httpSession)
			throws NoSuchSupplierException, ServiceExecutionFailedException {
		EnterpriseSupMapping enterpriseSupMapping = new EnterpriseSupMapping();
		enterpriseSupMapping.setId(id);
		supervisePartnerService.deleteSupMapping(enterpriseSupMapping);
		return "1";
	}
	
	@RequestMapping("/insertPartener")
	@ResponseBody
	public Object insertPartener(@RequestParam("supIds") String supIds,HttpSession httpSession)
			throws NoSuchSupplierException, ServiceExecutionFailedException {
		User user = (User) httpSession.getAttribute(SessionKeys.LOGIN_SUPERVISE);
		String supId[] = supIds.split(",");
		for (int i = 0; i < supId.length; i++) {
			EnterpriseSupMapping enterpriseSupMapping = new EnterpriseSupMapping();
			enterpriseSupMapping.setSupInfoId(supId[i]);
			enterpriseSupMapping.setCompanyId(user.getCompanyId());
			supervisePartnerService.insertPartener(enterpriseSupMapping);
		}
		
		return "1";
	}
	
	@RequestMapping("/querySup")
	@ResponseBody
	public Object querySup(@RequestParam("supNameParam") String supNameParam,@RequestParam("page") String page,HttpSession httpSession)
			throws NoSuchSupplierException, ServiceExecutionFailedException {
		User user = (User) httpSession.getAttribute(SessionKeys.LOGIN_SUPERVISE);
		EnterpriseSupMapping enterpriseSupMapping = new EnterpriseSupMapping();
		enterpriseSupMapping.setSearchSupName(supNameParam);
		enterpriseSupMapping.setCompanyId(user.getCompanyId());
		enterpriseSupMapping.setPage(Integer.valueOf(page));
		Integer supTotal = supervisePartnerService.querySupInfoCount(enterpriseSupMapping);
		int supPages = (int) Math.ceil((double) supTotal / PAGE_SIZE);
		List<EnterpriseSupMapping> supInfoList = supervisePartnerService.querySupInfo(enterpriseSupMapping);
		JSONArray json = new JSONArray();
        for(EnterpriseSupMapping sup : supInfoList){
            JSONObject jo = new JSONObject();
            jo.put("supName", sup.getSupName() == null ? "": sup.getSupName());
            jo.put("contactPerson", sup.getContactPerson() == null ? "": sup.getContactPerson());
            jo.put("contactNum", sup.getContactNum()  == null ? "": sup.getContactNum());
            jo.put("id", sup.getSupInfoId());
            json.add(jo);
        }
        JSONObject jo = new JSONObject();
        jo.put("page", page);
        jo.put("supPages", supPages);
        json.add(jo);
		return json;
	}

}
