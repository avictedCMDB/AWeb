package com.avic.supplier.controllers;

import java.util.ArrayList;
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
import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.supplier.models.SupArea;
import com.avic.supplier.models.SupplierAddress;
import com.avic.supplier.services.SupAreaService;
import com.avic.supplier.services.SupplierAddressService;
import com.avic.supplier.utils.CodeConstants;

@Controller
@RequestMapping("/address")
public class SupplierAddressController {
    protected static final Log logger = LogFactory.getLog(SupplierAddressController.class);
    
    @Autowired
    SupplierAddressService supplierAddressService;
    
    @Autowired
	SupAreaService areaService;
    /**
     * 页面初始化方法
     * @param map
     * @return
     */
    @RequestMapping("")
    public String index(Map<String, Object> map,HttpSession httpSession) {
        logger.info("供应商地址库管理信息");
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
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
        //分页信息
		String page = String.valueOf(supplierAddress.getPage());
		
        int total = supplierAddressService.querySupplierAddressListCount(supplierAddress);

        int pages = (int) Math.ceil((double) total / supplierAddress.getPageSize());
        
        map.put("page", page);
        map.put("total", total);
        map.put("pages", pages);
        map.put("pageAction","supplier/address"
                + "?page=%PAGE%");
        return "address/supplier_address";
    }
    /**
     * 删除地址
     * @param map
     * @param supAddressId
     * @return
     */
    @RequestMapping("/delete/{supAddressId}")
    public String deleteAddress(Map<String, Object> map,@PathVariable("supAddressId")String supAddressId) {
        logger.info("删除地区");
        supplierAddressService.deleteSupplierAddress(supAddressId);
        return "redirect:/supplier/address";
    }
    /**
     * 设置为默认地址
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/setDefault/{addressID}")
    public String querySupplierAddress(Map<String, Object> map,@PathVariable("addressID")String addressID,HttpSession httpSession) {
    	logger.info("供应商地址库查看");
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
    	SupplierAddress unDefParam =  new SupplierAddress();
    	// 清空已设置的默认地址
    	unDefParam.setIfDefault(CodeConstants.NO_DEFAULT);
    	unDefParam.setSupId(supId);
    	supplierAddressService.updateSupplierAddress(unDefParam);
    	//设置默认地址
    	SupplierAddress defParam =  new SupplierAddress();
    	defParam.setIfDefault(CodeConstants.IS_DEFAULT);
    	defParam.setSupAddressId(addressID);
    	supplierAddressService.updateSupplierAddress(defParam);
        return "redirect:/supplier/address";
    }
    /**
     * 迁移新增画面
     * @param map
     * @return
     */
    @RequestMapping("/insertPage")
    public String insertSupplierAddressPage(Map<String, Object> map,HttpSession httpSession) {
        logger.info("新增地区页面");
        // 取得地区信息
		SupArea supArea = new SupArea();
		supArea.setSupID(httpSession.getAttribute(SessionKeys.SUP_ID).toString());
		supArea.setSupType(httpSession.getAttribute(SessionKeys.SUP_TYPE).toString());
		// 加载地区信息
		List<SupArea> areas = areaService.queryAreas(supArea);
		map.put("areasList", areas);
        map.put("processType", "insert");
        return "address/supplier_address_add";
    }
    /**
     * 迁移修改画面
     * @param map
     * @return
     */
    @RequestMapping("/updatePage/{addressID}")
    public String updateSupplierAddressPage(Map<String, Object> map,@PathVariable("addressID")String addressID,HttpSession httpSession) {
        logger.info("修改地区页面");
        map.put("processType", "update");
        SupplierAddress supplierAddress = supplierAddressService.querySupplierAddress(addressID);
        map.put("supplierAddress", supplierAddress);
        map.put("supAddressId", addressID);
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        // 取得一级地区信息
		SupArea supArea = new SupArea();
		supArea.setSupID(httpSession.getAttribute(SessionKeys.SUP_ID).toString());
		supArea.setSupType(httpSession.getAttribute(SessionKeys.SUP_TYPE).toString());
		// 加载地区信息
		List<SupArea> areas = areaService.queryAreas(supArea);
		map.put("areasList", areas);
		//取得二级地区信息
		SupArea supAreaSub = new SupArea();
		supAreaSub.setSupID(supId);
		supAreaSub.setSupType(httpSession.getAttribute(SessionKeys.SUP_TYPE).toString());
		supAreaSub.setSupParentArea(supplierAddress.getSupAreaLevelOne());
		List<SupArea> supAreaSubList = areaService.querySubAreas(supAreaSub);
		map.put("areasSubList", supAreaSubList);
		//取得三级地区信息
		SupArea supAreaLast = new SupArea();
		supAreaLast.setSupID(supId);
		supAreaLast.setSupType(httpSession.getAttribute(SessionKeys.SUP_TYPE).toString());
		supAreaLast.setSupParentArea(supplierAddress.getSupAreaLevelTwo());
		List<SupArea> supAreaLastList = areaService.querySubAreas(supAreaLast);
		map.put("areasLastList", supAreaLastList);
        return "address/supplier_address_add";
    }
    /**
     * 新增地区保存
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/insert")
    public String insertSupplierAddress(@ModelAttribute("supplierAddress") SupplierAddress supplierAddress,HttpSession httpSession) {
        logger.info("新增地区保存");
        // 添加供应商
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        supplierAddress.setSupId(supId);
        supplierAddressService.insertSupplierAddress(supplierAddress);
        return "redirect:/supplier/address";
    }
    /**
     * 修改地区保存
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/update")
    public String updateSupplierAddress(@ModelAttribute("supplierAddress") SupplierAddress supplierAddress,HttpSession httpSession) {
        logger.info("修改地区");
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        if (CodeConstants.IS_DEFAULT.equals(supplierAddress.getIfDefault())) {
        	SupplierAddress unDefParam =  new SupplierAddress();
        	// 清空已设置的默认地址
        	unDefParam.setIfDefault(CodeConstants.NO_DEFAULT);
        	unDefParam.setSupId(supId);
        	supplierAddressService.updateSupplierAddress(unDefParam);
		}
        supplierAddress.setSupId(supId);
        supplierAddressService.updateSupplierAddress(supplierAddress);
        return "redirect:/supplier/address";
    }
    /**
     * 返回方法
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/back")
    public String backSupplierAddress(Map<String, Object> map) {
        logger.info("返回地区");
        return "redirect:/supplier/address";
    }
    
	@RequestMapping("/loadSubArea")
	@ResponseBody
	public Object loadSubArea(@RequestParam("parentId") String parentId,
			HttpSession httpSession)
			throws NoSuchSupplierException, ServiceExecutionFailedException {
		SupArea supArea = new SupArea();
		supArea.setSupParentArea(parentId);
		supArea.setSupID(httpSession.getAttribute(SessionKeys.SUP_ID).toString());
		supArea.setSupType(httpSession.getAttribute(SessionKeys.SUP_TYPE).toString());
		// 加载地区信息
		List<SupArea> areas = new ArrayList<SupArea>();
		areas = areaService.querySubAreas(supArea);
		return areas;
	}
    
}
