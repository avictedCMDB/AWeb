package com.avic.management.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.management.mappers.ExchangeMapper;
import com.avic.management.mappers.InvoiceMapper;
import com.avic.management.models.Exchange;
import com.avic.management.models.Invoice;
import com.avic.management.models.OrderSnapshot;
import com.avic.management.services.ExchangeService;
import com.avic.management.services.InvoiceService;

@Service
public class ExchangeServiceImpl implements ExchangeService {
    protected static final Log logger = LogFactory.getLog(ExchangeServiceImpl.class);

    @Autowired
    ExchangeMapper exchangeMapper;

	@Override
	public List<Exchange> queryExchange(Exchange exchange) {
		return exchangeMapper.queryExchange(exchange);
	}

	@Override
	@Transactional
	public void updateOrderExchangeStatus(Exchange exchange) {
		exchangeMapper.updateOrderExchangeStatus(exchange);
	}

	@Override
	public int queryOrderExchangeReceiptCount(Exchange exchange) {
		return exchangeMapper.queryOrderExchangeReceiptCount(exchange);
	}

	@Override
	@Transactional
	public void updateOrderStatusByExchangeID(Exchange exchange) {
		exchangeMapper.updateOrderStatusByExchangeID(exchange);
	}

	@Override
	public Exchange queryExchangeByID(Exchange exchange) {
		return exchangeMapper.queryExchangeByID(exchange);
	}

	@Override
	public List<OrderSnapshot> queryOrderSnapshotsByOrderID(Exchange exchange) {
		return exchangeMapper.queryOrderSnapshotsByOrderID(exchange);
	}

	@Override
	public void updateOrderExchangeExpressInfo(Exchange exchange) {
		exchangeMapper.updateOrderExchangeExpressInfo(exchange);
	}

	@Override
	public int queryExchangeCount(Exchange exchange) {
		return exchangeMapper.queryExchangeCount(exchange);
	}

	@Override
	public Exchange queryExchangePriceAndAmountByExchangeID(Exchange exchange) {
		return exchangeMapper.queryExchangePriceAndAmountByExchangeID(exchange);
	}

	@Override
	public void updateOrderExchangePriceAndAmount(Exchange exchange) {
		exchangeMapper.updateOrderExchangePriceAndAmount(exchange);
	}
    

}
