package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.Quote;

@Repository
public interface QuoteMapper {
	/**
	 * ��ѯ���۵���Ӧ����Ϣ
	 * @return 
	 */
	public List<Quote> queryQuoteBySupID(Quote quote);
}
