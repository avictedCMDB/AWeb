package com.avic.market.services.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.common.exceptions.ServiceException;
import com.avic.market.mappers.CategoryMapper;
import com.avic.market.models.MarketCategory;
import com.avic.market.models.SysCategory;
import com.avic.market.services.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {
    protected static final Log logger = LogFactory.getLog(CategoryServiceImpl.class);

    @Autowired
    CategoryMapper categoryMapper;
    
    @Override
    public List<SysCategory> getSysCatTree() throws ServiceException {
        logger.info("��ѯϵͳ������");
        List<SysCategory> list = categoryMapper.querySysCatTree();
        
        List<SysCategory> tree = new ArrayList<SysCategory>();
        
        SysCategory level1 = null, level2 = null;
        
        for (SysCategory i : list) {
            if (i.getSysCatLevel() == 1) {
                level1 = i;
                level1.setChildCategory(new ArrayList<SysCategory>());
                tree.add(level1);
            } else if (i.getSysCatLevel() == 2) {
                level2 = i;
                level2.setChildCategory(new ArrayList<SysCategory>());
                level1.getChildCategory().add(level2);
            } else {
                level2.getChildCategory().add(i);
            }
        }
        
        
        return tree;
    }
    
    @Override
    public List<MarketCategory> getMarketCatTree() throws ServiceException {
        List<MarketCategory> list = categoryMapper.queryMarketCatList();
        
        List<MarketCategory> tree = new ArrayList<MarketCategory>();
        
        MarketCategory level1 = null, level2 = null;
        
        for (MarketCategory i : list) {
            if (i.getMarketCatLevel() == 1) {
                level1 = i;
                level1.setSubs(new ArrayList<MarketCategory>());
                MarketCategory all = new MarketCategory();
                all.setMarketCatId("");
                all.setMarketCatName("");
                all.setParentId(i.getMarketCatId());
                all.setSubs(new ArrayList<MarketCategory>());
                level1.getSubs().add(all);
                tree.add(level1);
            } else if (i.getMarketCatLevel() == 2) {
                level2 = i;
                level2.setSubs(new ArrayList<MarketCategory>());
                level1.getSubs().add(level2);
            } else {
                level2.getSubs().add(i);
            }
        }
        
        
        return tree;
    }

    @Override
    public List<MarketCategory> getMarketCatByParent(String parent) throws ServiceException {
        return categoryMapper.queryMarketCatByParent(parent);
    }
}