package com.avic.management.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.management.models.QuoteDetail;

@Repository
public interface QuoteDetailMapper {
	/**
	 * ��ѯ���۵���Ӧ���Լ���Ʒ��Ϣ
	 * @return 
	 */
	public List<QuoteDetail> queryQuoteDetailByRequireID(QuoteDetail quoteDetail);
}
