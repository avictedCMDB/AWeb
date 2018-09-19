package com.avic.supervise.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.beans.ResultObject;
import com.avic.market.cpi.CpiService;
import com.avic.supervise.services.SupService;

@Controller
@RequestMapping("/sync")
public class SyncController {
    @Autowired
    SupService supService;
    @RequestMapping("")
    public String index(Map<String, Object> map) {
        map.put("sups", supService.getSupList());
        return "data/sync";
    }
    
    
    @ResponseBody
    @RequestMapping("/submit")
    public ResultObject submit(@RequestParam("sup") int sup, @RequestParam("skus") String skus) {
        String[] pairs = skus.split(",");
        List<Map<String, String>> data = new ArrayList<Map<String, String>>();
        
        for (String i : pairs) {
            if (StringUtils.isEmpty(i)) {
                continue;
            }
            Map<String, String> r = new HashMap<String, String>();
            r.put("code", i);
            r.put("result", "1");
            String[] pair = i.split("\\|");
            
            if (pair.length != 2 || !StringUtils.isNumeric(pair[0])) {
                r.put("msg", "²ÎÊý´íÎó");
            } else {
                
                try {
                    CpiService.getInstance().syncSingleGoods(sup, Integer.parseInt(pair[0]), pair[1]);
                    r.put("result", "0");
                } catch (Exception e) {
                    r.put("msg", e.getMessage());
                }
            }
            
            data.add(r);
        }
        
        return new ResultObject(ResultObject.OK, data);
    }
}
