package com.avic.supplier.controllers;

import java.net.URLEncoder;
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

import com.avic.common.constants.SessionKeys;
import com.avic.supplier.models.SupplierAddress;
import com.avic.supplier.models.SupplierExpress;
import com.avic.supplier.services.SupplierExpressService;

@Controller
@RequestMapping("/express")
public class SupplierExpressController {
    protected static final Log logger = LogFactory.getLog(SupplierExpressController.class);
    
    @Autowired
    SupplierExpressService supplierExpressService;
    /**
     * 页面初始化方法
     * @param map
     * @return
     */
    @RequestMapping("")
    public String index(Map<String, Object> map,HttpSession httpSession) {
        logger.info("快递公司管理信息");
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        SupplierExpress supplierExpress = new SupplierExpress();
        supplierExpress.setSupId(supId);
        List<SupplierExpress> supplierExpressList = supplierExpressService.querySupplierExpressList(supplierExpress);
        map.put("supplierExpressList", supplierExpressList);
        //分页信息
        String page = String.valueOf(supplierExpress.getPage());
        
        int total = supplierExpressService.querySupplierExpressListCount(supplierExpress);

        int pages = (int) Math.ceil((double) total / supplierExpress.getPageSize());
        
        map.put("page", page);
        map.put("total", total);
        map.put("pages", pages);
        map.put("pageAction","supplier/express?"
                + "page=%PAGE%");
        return "express/supplier_express";
    }
    /**
     * 删除地址
     * @param map
     * @param supAddressId
     * @return
     */
    @RequestMapping("/delete/{expressId}")
    public String deleteAddress(Map<String, Object> map,@PathVariable("expressId")String expressId) {
        logger.info("删除地区");
        supplierExpressService.deleteSupplierExpress(expressId);
        return "redirect:/supplier/express";
    }
    /**
     * 迁移新增画面
     * @param map
     * @return
     */
    @RequestMapping("/insertPage")
    public String insertSupplierAddressPage(Map<String, Object> map) {
        logger.info("新增地区页面");
        map.put("processType", "insert");
        return "express/supplier_express_add";
    }
    /**
     * 迁移修改画面
     * @param map
     * @return
     */
    @RequestMapping("/updatePage/{expressId}")
    public String updateSupplierAddressPage(Map<String, Object> map,@PathVariable("expressId")String expressId) {
        logger.info("修改地区页面");
        map.put("processType", "update");
        SupplierExpress supplierExpress = supplierExpressService.querySupplierExpress(expressId);
        map.put("supplierExpress", supplierExpress);
        return "express/supplier_express_add";
    }
    /**
     * 新增地区保存
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/insert")
    public String insertSupplierAddress(@ModelAttribute("supplierExpress") SupplierExpress supplierExpress,HttpSession httpSession) {
        logger.info("新增地区保存");
        // 添加供应商
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        supplierExpress.setSupId(supId);
        supplierExpressService.insertSupplierExpress(supplierExpress);
        return "redirect:/supplier/express";
    }
    /**
     * 修改地区保存
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/update")
    public String updateSupplierAddress(@ModelAttribute("supplierExpress") SupplierExpress supplierExpress,HttpSession httpSession) {
        logger.info("修改地区");
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        supplierExpress.setSupId(supId);
        supplierExpressService.updateSupplierExpress(supplierExpress);
        return "redirect:/supplier/express";
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
        return "redirect:/supplier/express";
    }
    
}
