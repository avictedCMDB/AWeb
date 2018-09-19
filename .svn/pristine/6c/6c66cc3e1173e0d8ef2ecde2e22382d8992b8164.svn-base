package com.avic.management.services.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.RefoundGoodsMapper;
import com.avic.management.models.RefoundGoods;
import com.avic.management.services.RefoundGoodsService;

@Service
public class RefoundGoodsServiceImpl implements RefoundGoodsService {
    protected static final Log logger = LogFactory.getLog(RefoundGoodsServiceImpl.class);

    @Autowired
    RefoundGoodsMapper refoundGoodsMapper;

	@Override
	public void delRefoundGoods(RefoundGoods refoundGoods) {
		refoundGoodsMapper.delRefoundGoods(refoundGoods);
	}


    
}
