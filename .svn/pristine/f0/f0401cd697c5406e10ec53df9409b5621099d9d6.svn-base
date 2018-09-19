package com.avic.supplier.controllers;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.RandomUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.exceptions.ServiceException;
import com.avic.supplier.models.SupCategory;
import com.avic.supplier.services.DemoService;

@Controller
@RequestMapping("/demo")
public class DemoController {
    protected static final Log logger = LogFactory.getLog(DemoController.class);
    
    @Autowired
    DemoService demoService;

    @RequestMapping("")
    public String index() {
        logger.info("供应商Demo bla bla");
        return "demo";
        
    }
    
    @RequestMapping("/query/{sup:.*}")
    public String query(@PathVariable("sup") String sup, Map<String, Object> map) {
        logger.info("供应商Demo query");
        
        map.put("list", demoService.testQueryCatList(Integer.parseInt(sup)));
        
        return "list";
        
    }
    
    @RequestMapping("/txsucc")
    @ResponseBody
    public Object txsucc(String sup) {
        logger.info("供应商Demo tx succ");
        
        SupCategory cat = new SupCategory();
        cat.setSupCatId(RandomUtils.nextInt(10000000, 99999999));
        cat.setSupCatName("分类" + cat.getSupCatId());
        cat.setSupId(Integer.parseInt(sup));
        
        Map<String, String> result = new HashMap<String, String>();
        
        try {
            demoService.testInsertSucc(cat);
            result.put("result", "ok");
        } catch (ServiceException e) {
            logger.error("供应商Demo tx error", e);
            result.put("result", "failed");
        }
        
        return result;
        
    }
    
    @RequestMapping("/txfail")
    @ResponseBody
    public Object txfail(String sup) {
        int catId = RandomUtils.nextInt(10000000, 99999999);
        logger.info("供应商Demo tx fail with id : " + catId);
        
        SupCategory cat = new SupCategory();
        cat.setSupCatId(catId);
        cat.setSupCatName("分类" + cat.getSupCatId());
        cat.setSupId(Integer.parseInt(sup));
        
        Map<String, String> result = new HashMap<String, String>();
        
        try {
            demoService.testInsertFailed(cat);
            result.put("result", "ok");
        } catch (ServiceException e) {
            logger.error("供应商Demo tx error", e);
            result.put("result", "failed");
        }
        
        return result;
        
    }
}
