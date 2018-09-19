package com.avic.market.services;

import java.util.List;

import com.avic.market.models.EnquiryGoods;

public interface EnquiryGoodsService {
	/**
	 *  添加询价信息
	 * @param enquiryGoods
	 * @return
	 */
    public void addEnquiryGoods(EnquiryGoods enquiryGoods);
    /**
	 *  查询是否可以询价
	 * @param enquiryGoods
	 * @return
	 */
    public int canEnquiry(EnquiryGoods enquiryGoods);
}
