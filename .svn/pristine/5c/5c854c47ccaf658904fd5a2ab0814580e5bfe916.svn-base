package com.avic.supplier.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.common.exceptions.ServiceException;
import com.avic.supplier.mappers.CategoryMapper;
import com.avic.supplier.models.SupCategory;
import com.avic.supplier.services.DemoService;

@Service
public class DemoServiceImpl implements DemoService {
    protected static final Log logger = LogFactory.getLog(DemoServiceImpl.class);
    
    @Autowired
    CategoryMapper categoryMapper;

    @Override
    public List<SupCategory> testQueryCatList(int supId) throws ServiceException {
        logger.info("test query ...");

        return categoryMapper.queryCatList(supId);
    }

    @Transactional
    @Override
    public void testInsertSucc(SupCategory cat) throws ServiceException {
        logger.info("test insert ...");
        
        try {
            categoryMapper.insertCategory(cat);
        } catch (Exception e) {
            logger.error("test insert failed", e);
            throw new ServiceException("test insert failed", e);
        }

    }

    @Transactional
    @Override
    public void testInsertFailed(SupCategory cat) throws ServiceException {
        logger.info("test insert ...");
        
        try {
            categoryMapper.insertCategory(cat);
            // failed with duplicate key
            categoryMapper.insertCategory(cat);
        } catch (Exception e) {
            logger.error("test insert failed", e);
            throw new ServiceException("test insert failed", e);
        }
    }

}
