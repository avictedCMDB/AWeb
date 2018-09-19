package com.avic.market.controllers;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/index")
public class IndexController {
    protected static final Log logger = LogFactory.getLog(IndexController.class);
    
    
    @RequestMapping("")
    public String index(Map<String, Object> map) {
        logger.info("Æ½Ì¨Ê×Ò³");
        return "index";
    }
}
