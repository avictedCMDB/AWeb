package com.avic.management.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.management.mappers.ExchangeMapper;
import com.avic.management.mappers.InvoiceMapper;
import com.avic.management.mappers.RefoundMapper;
import com.avic.management.models.Exchange;
import com.avic.management.models.Invoice;
import com.avic.management.models.OrderSnapshot;
import com.avic.management.models.Refound;
import com.avic.management.services.ExchangeService;
import com.avic.management.services.InvoiceService;
import com.avic.management.services.RefoundService;

@Service
public class RefoundServiceImpl implements RefoundService {
    protected static final Log logger = LogFactory.getLog(RefoundServiceImpl.class);

    @Autowired
    RefoundMapper refoundMapper;

	@Override
	public List<Refound> queryRefound(Refound refound) {
		return refoundMapper.queryRefound(refound);
	}

	@Override
	public void updateOrderRefoundStatus(Refound refound) {
		refoundMapper.updateOrderRefoundStatus(refound);
	}

	@Override
	public int queryOrderRefoundReceiptCount(Refound refound) {
		return refoundMapper.queryOrderRefoundReceiptCount(refound);
	}

	@Override
	public void updateOrderStatusByRefoundID(Refound refound) {
		refoundMapper.updateOrderStatusByRefoundID(refound);
	}

	@Override
	public Refound queryRefoundByID(Refound refound) {
		return refoundMapper.queryRefoundByID(refound);
	}

	@Override
	public List<OrderSnapshot> queryOrderSnapshotsByRefoundID(
			Refound refound) {
		return refoundMapper.queryOrderSnapshotsByRefoundID(refound);
	}

	@Override
	public void updateOrderRefoundExpressInfo(Refound refound) {
		refoundMapper.updateOrderRefoundExpressInfo(refound);
	}

	@Override
	public int queryRefoundCount(Refound refound) {
		return refoundMapper.queryRefoundCount(refound);
	}

	@Override
	public Refound queryRefoundPriceAndAmountByRefoundID(Refound refound) {
		return refoundMapper.queryRefoundPriceAndAmountByRefoundID(refound);
	}

	@Override
	public void updateOrderRefoundPriceAndAmount(Refound refound) {
		refoundMapper.updateOrderRefoundPriceAndAmount(refound);
	}


}
