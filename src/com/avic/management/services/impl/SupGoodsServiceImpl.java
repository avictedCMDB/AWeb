package com.avic.management.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.SupGoodsMapper;
import com.avic.management.models.SupGoods;
import com.avic.management.services.SupGoodsService;

@Service
public class SupGoodsServiceImpl implements SupGoodsService {
    protected static final Log logger = LogFactory.getLog(SupGoodsServiceImpl.class);

    @Autowired
    SupGoodsMapper supGoodsMapper;

	@Override
	public SupGoods queryGoods(SupGoods supGoods) {
		return supGoodsMapper.queryGoods(supGoods);
	}

	@Override
	public List<SupGoods> queryGoodsList(SupGoods supGoods) {
		return supGoodsMapper.queryGoodsList(supGoods);
	}

	@Override
	public List<SupGoods> queryGoodsSupList(SupGoods supGoods) {
		return supGoodsMapper.queryGoodsSupList(supGoods);
	}


}
