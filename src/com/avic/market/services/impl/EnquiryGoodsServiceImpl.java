package com.avic.market.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.avic.market.mappers.EnquiryGoodsMapper;
import com.avic.market.models.EnquiryGoods;
import com.avic.market.services.EnquiryGoodsService;

@Service
public class EnquiryGoodsServiceImpl implements EnquiryGoodsService {
    protected static final Log logger = LogFactory.getLog(EnquiryGoodsServiceImpl.class);

    @Autowired
    EnquiryGoodsMapper enquiryGoodsMapper;

	@Override
	public void addEnquiryGoods(EnquiryGoods enquiryGoods) {
		enquiryGoodsMapper.addEnquiryGoods(enquiryGoods);
	}

	@Override
	public int canEnquiry(EnquiryGoods enquiryGoods) {
		return enquiryGoodsMapper.canEnquiry(enquiryGoods);
	}
    
    
}
