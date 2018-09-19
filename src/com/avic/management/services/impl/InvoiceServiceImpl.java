package com.avic.management.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.InvoiceMapper;
import com.avic.management.models.Invoice;
import com.avic.management.services.InvoiceService;

@Service
public class InvoiceServiceImpl implements InvoiceService {
    protected static final Log logger = LogFactory.getLog(InvoiceServiceImpl.class);

    @Autowired
    InvoiceMapper invoiceMapper;

	@Override
	public List<Invoice> queryInvoices(Invoice invoice) {
		return invoiceMapper.queryInvoices(invoice);
	}

	@Override
	public Invoice queryInvoiceByInvoiceID(Invoice invoice) {
		return invoiceMapper.queryInvoiceByInvoiceID(invoice);
	}

	@Override
	public void addInvoice(Invoice invoice) {
		invoiceMapper.addInvoice(invoice);
	}

	@Override
	public void updateInvoice(Invoice invoice) {
		invoiceMapper.updateInvoice(invoice);
	}

	@Override
	public void setDefault(Invoice invoice) {
		invoiceMapper.setDefault(invoice);
	}

	@Override
	public void setOtherDefault(Invoice invoice) {
		invoiceMapper.setOtherDefault(invoice);
	}

	@Override
	public void deleteInvoice(Invoice invoice) {
		invoiceMapper.deleteInvoice(invoice);
	}

	@Override
	public int queryInvoiceCount(Invoice invoice) {
		return invoiceMapper.queryInvoiceCount(invoice);
	}

	@Override
	public int checkInvoiceEx(Invoice invoice) {
		// TODO Auto-generated method stub
		return invoiceMapper.checkInvoiceEx(invoice);
	}

}