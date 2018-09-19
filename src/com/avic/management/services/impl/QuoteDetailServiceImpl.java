package com.avic.management.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.QuoteDetailMapper;
import com.avic.management.models.QuoteDetail;
import com.avic.management.services.QuoteDetailService;

@Service
public class QuoteDetailServiceImpl implements QuoteDetailService {
    protected static final Log logger = LogFactory.getLog(QuoteDetailServiceImpl.class);

    @Autowired
    QuoteDetailMapper quoteDetailMapper;

	@Override
	public List<QuoteDetail> queryQuoteDetailByRequireID(QuoteDetail quoteDetail) {
		return quoteDetailMapper.queryQuoteDetailByRequireID(quoteDetail);
	}




}
