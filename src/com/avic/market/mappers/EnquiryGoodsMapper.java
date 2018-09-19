package com.avic.market.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.market.models.EnquiryGoods;

@Repository
public interface EnquiryGoodsMapper {
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
