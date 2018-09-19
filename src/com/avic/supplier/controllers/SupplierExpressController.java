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
     * ҳ���ʼ������
     * @param map
     * @return
     */
    @RequestMapping("")
    public String index(Map<String, Object> map,HttpSession httpSession) {
        logger.info("��ݹ�˾������Ϣ");
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        SupplierExpress supplierExpress = new SupplierExpress();
        supplierExpress.setSupId(supId);
        List<SupplierExpress> supplierExpressList = supplierExpressService.querySupplierExpressList(supplierExpress);
        map.put("supplierExpressList", supplierExpressList);
        //��ҳ��Ϣ
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
     * ɾ����ַ
     * @param map
     * @param supAddressId
     * @return
     */
    @RequestMapping("/delete/{expressId}")
    public String deleteAddress(Map<String, Object> map,@PathVariable("expressId")String expressId) {
        logger.info("ɾ������");
        supplierExpressService.deleteSupplierExpress(expressId);
        return "redirect:/supplier/express";
    }
    /**
     * Ǩ����������
     * @param map
     * @return
     */
    @RequestMapping("/insertPage")
    public String insertSupplierAddressPage(Map<String, Object> map) {
        logger.info("��������ҳ��");
        map.put("processType", "insert");
        return "express/supplier_express_add";
    }
    /**
     * Ǩ���޸Ļ���
     * @param map
     * @return
     */
    @RequestMapping("/updatePage/{expressId}")
    public String updateSupplierAddressPage(Map<String, Object> map,@PathVariable("expressId")String expressId) {
        logger.info("�޸ĵ���ҳ��");
        map.put("processType", "update");
        SupplierExpress supplierExpress = supplierExpressService.querySupplierExpress(expressId);
        map.put("supplierExpress", supplierExpress);
        return "express/supplier_express_add";
    }
    /**
     * ������������
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/insert")
    public String insertSupplierAddress(@ModelAttribute("supplierExpress") SupplierExpress supplierExpress,HttpSession httpSession) {
        logger.info("������������");
        // ��ӹ�Ӧ��
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        supplierExpress.setSupId(supId);
        supplierExpressService.insertSupplierExpress(supplierExpress);
        return "redirect:/supplier/express";
    }
    /**
     * �޸ĵ�������
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/update")
    public String updateSupplierAddress(@ModelAttribute("supplierExpress") SupplierExpress supplierExpress,HttpSession httpSession) {
        logger.info("�޸ĵ���");
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        supplierExpress.setSupId(supId);
        supplierExpressService.updateSupplierExpress(supplierExpress);
        return "redirect:/supplier/express";
    }
    /**
     * ���ط���
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/back")
    public String backSupplierAddress(Map<String, Object> map) {
        logger.info("���ص���");
        return "redirect:/supplier/express";
    }
    
}
