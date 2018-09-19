package com.avic.management.services;

import java.util.List;

import com.avic.management.models.Quote;

public interface QuoteService {
	/**
	 * 查询报价单供应商信息
	 * @return 
	 */
	public List<Quote> queryQuoteBySupID(Quote quote);
}
