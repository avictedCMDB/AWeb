package com.avic.market.controllers;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.avic.market.models.Goods;
import com.avic.market.services.GoodsService;

@Controller
@RequestMapping("/campaign")
public class CampaignController {
    
    @Autowired
    GoodsService goodsService;
    
    @RequestMapping("/aug")
    public String aug(Map<String, Object> map) {
        String path = CampaignController.class.getResource("/").getPath();
        String file = (path.replace("/build/classes", "").replace("%20"," ").replace("classes/", "") + "campaign.properties");
        
        Properties prop =new Properties();
        FileInputStream in = null;
        try {
            in = new FileInputStream(file);
            prop.load(in);
        } catch (Exception e) {
            return null;
        }
        
        List<String> ids = new ArrayList<String>();
        
        List<String> floor1 = Arrays.asList(prop.getProperty("floor1").split(","));
        List<String> floor2 = Arrays.asList(prop.getProperty("floor2").split(","));
        List<String> floor3 = Arrays.asList(prop.getProperty("floor3").split(","));
        List<String> floor4 = Arrays.asList(prop.getProperty("floor4").split(","));
        List<String> floor5 = Arrays.asList(prop.getProperty("floor5").split(","));
        List<String> floor6 = Arrays.asList(prop.getProperty("floor6").split(","));
        List<String> floor7 = Arrays.asList(prop.getProperty("floor7").split(","));
        
        ids.addAll(floor1);
        ids.addAll(floor2);
        ids.addAll(floor3);
        ids.addAll(floor4);
        ids.addAll(floor5);
        ids.addAll(floor6);
        ids.addAll(floor7);
        
        
        List<Goods> goods = goodsService.getGoodsListByIds(4, ids);
        
        List<Goods> goods1 = new ArrayList<Goods>();
        List<Goods> goods2 = new ArrayList<Goods>();
        List<Goods> goods3 = new ArrayList<Goods>();
        List<Goods> goods4 = new ArrayList<Goods>();
        List<Goods> goods5 = new ArrayList<Goods>();
        List<Goods> goods6 = new ArrayList<Goods>();
        List<Goods> goods7 = new ArrayList<Goods>();
        
        
        for (Goods i : goods) {
            if (floor1.contains(i.getSupGoodsId())) {
                goods1.add(i);
            } else if (floor2.contains(i.getSupGoodsId())) {
                goods2.add(i);
            } else if (floor3.contains(i.getSupGoodsId())) {
                goods3.add(i);
            } else if (floor4.contains(i.getSupGoodsId())) {
                goods4.add(i);
            } else if (floor5.contains(i.getSupGoodsId())) {
                goods5.add(i);
            } else if (floor6.contains(i.getSupGoodsId())) {
                goods6.add(i);
            } else if (floor7.contains(i.getSupGoodsId())) {
                goods7.add(i);
            }
        }
        
        map.put("goods1", goods1);
        map.put("goods2", goods2);
        map.put("goods3", goods3);
        map.put("goods4", goods4);
        map.put("goods5", goods5);
        map.put("goods6", goods6);
        map.put("goods7", goods7);
        
        return "campaign/aug";
    }
}
