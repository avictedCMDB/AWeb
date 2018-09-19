package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.QuoteDetail;

@Repository
public interface QuoteDetailMapper {
	/**
	 * 查询报价单供应商以及商品信息
	 * @return 
	 */
	public List<QuoteDetail> queryQuoteDetailByRequireID(QuoteDetail quoteDetail);
}
