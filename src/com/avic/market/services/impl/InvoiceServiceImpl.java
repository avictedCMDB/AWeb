package com.avic.market.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.common.exceptions.ServiceException;
import com.avic.market.mappers.InvoiceMapper;
import com.avic.market.models.Invoice;
import com.avic.market.models.VatInfo;
import com.avic.market.services.InvoiceService;

@Service
public class InvoiceServiceImpl implements InvoiceService {
    protected static final Log logger = LogFactory.getLog(InvoiceServiceImpl.class);
    
    @Autowired
    InvoiceMapper invoiceMapper;

    @Override
    public List<Invoice> getUserInvoice(String userId) throws ServiceException {
        logger.info("获取用户地址Service-userId["+userId+"]");
        return invoiceMapper.queryUserInvoice(userId);
    }

    @Override
    public void addInvoice(Invoice invoice) throws ServiceException {
        logger.info("添加发票");
        
        try {
            if (invoiceMapper.queryDefaultInvoiceCount(invoice.getUserId()) > 0) {
                invoiceMapper.updateInvoice(invoice);
            } else {
                invoice.setIfDefault("1");
                invoiceMapper.insertInvoice(invoice);
            }
        } catch (Exception e) {
            logger.error("添加发票失败", e);
            throw new ServiceException(e);
        }

    }
    
    @Override
    public Invoice getDefaultUserInvoice(String userId) throws ServiceException {
        logger.info("获取默认普票Service-userId["+userId+"]");
        return invoiceMapper.queryDefaultUserInvoice(userId);
    }
    
    @Override
    public VatInfo getUserVat(String userId) throws ServiceException {
        logger.info("获取默认增票Service-userId["+userId+"]");
        return invoiceMapper.queryUserVat(userId);
    }

    @Override
    public void updateVat(VatInfo vat) throws ServiceException {
        invoiceMapper.updateVat(vat);
    }
}
