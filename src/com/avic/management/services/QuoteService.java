package com.avic.management.services;

import java.util.List;

import com.avic.management.models.Quote;

public interface QuoteService {
	/**
	 * ��ѯ���۵���Ӧ����Ϣ
	 * @return 
	 */
	public List<Quote> queryQuoteBySupID(Quote quote);
}
