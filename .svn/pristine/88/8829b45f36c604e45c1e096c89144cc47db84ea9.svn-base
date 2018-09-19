package com.avic.management.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.QuoteMapper;
import com.avic.management.models.Quote;
import com.avic.management.services.QuoteService;

@Service
public class QuoteServiceImpl implements QuoteService {
    protected static final Log logger = LogFactory.getLog(QuoteServiceImpl.class);

    @Autowired
    QuoteMapper quoteMapper;

	@Override
	public List<Quote> queryQuoteBySupID(Quote quote) {
		return quoteMapper.queryQuoteBySupID(quote);
	}



}
