package com.avic.management.services.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.ExchangeGoodsMapper;
import com.avic.management.models.ExchangeGoods;
import com.avic.management.services.ExchangeGoodsService;

@Service
public class ExchangeGoodsServiceImpl implements ExchangeGoodsService {
    protected static final Log logger = LogFactory.getLog(ExchangeGoodsServiceImpl.class);

    @Autowired
    ExchangeGoodsMapper exchangeGoodsMapper;

	@Override
	public void delExchangeGoods(ExchangeGoods exchangeGoods) {
		exchangeGoodsMapper.delExchangeGoods(exchangeGoods);
	}


    
}
