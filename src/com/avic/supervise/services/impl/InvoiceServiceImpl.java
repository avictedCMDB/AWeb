package com.avic.supervise.services.impl;

import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.common.exceptions.ServiceException;
import com.avic.supervise.mappers.InvoiceMapper;
import com.avic.supervise.mappers.OrderMapper;
import com.avic.supervise.models.ImageInfo;
import com.avic.supervise.models.Invoice;
import com.avic.supervise.models.OrderSnapshot;
import com.avic.supervise.models.VatInfo;
import com.avic.supervise.services.InvoiceService;

@Service
public class InvoiceServiceImpl implements InvoiceService {
    
    @Autowired
    InvoiceMapper invoiceMapper;
    
    @Autowired
    OrderMapper orderMapper;

    @Override
    public int getInvoiceCount(String timeStart, String timeEnd, String orderId, String companyId, String invoiceStatus) throws ServiceException {

        if (!StringUtils.isEmpty(timeStart)) {
            timeStart += " 00:00:00";
        }
        
        if (!StringUtils.isEmpty(timeEnd)) {
            timeEnd += " 23:59:59";
        }
        return invoiceMapper.queryInvoiceCount(timeStart, timeEnd, orderId, companyId, invoiceStatus);
    }
    
    @Override
    public double getInvoiceStat(String timeStart, String timeEnd, String orderId, String companyId, String invoiceStatus)
            throws ServiceException {
        if (!StringUtils.isEmpty(timeStart)) {
            timeStart += " 00:00:00";
        }
        
        if (!StringUtils.isEmpty(timeEnd)) {
            timeEnd += " 23:59:59";
        }
        return invoiceMapper.queryInvoiceStat(timeStart, timeEnd, orderId, companyId, invoiceStatus);
    }

    @Override
    public List<Invoice> getInvoiceList(String timeStart, String timeEnd, String orderId, String companyId, String invoiceStatus, int page, int size) throws ServiceException {

        if (!StringUtils.isEmpty(timeStart)) {
            timeStart += " 00:00:00";
        }
        
        if (!StringUtils.isEmpty(timeEnd)) {
            timeEnd += " 23:59:59";
        }
        
        if (page < 1) {
            page = 1;
        }
        
        int start = (page - 1) * size + 1;
        int end  = start + size - 1;
        
        return invoiceMapper.queryInvoiceList(timeStart, timeEnd, orderId, companyId, invoiceStatus, start, end);
    }
    
    @Override
    public Invoice getInvoiceDetail(String orderId) throws ServiceException {
        return invoiceMapper.queryInvoiceDetail(orderId);
    }
    
    @Transactional
    @Override
    public void updateOrderInvoice(Invoice invoice) throws ServiceException {
        try {
            invoiceMapper.updateOrderInvoice(invoice, Arrays.asList(invoice.getOrderId().split(",")));
        } catch(Exception e) {
            throw new ServiceException(e);
        }
    }
    @Override
    public VatInfo getDefaultVat(String userId) throws ServiceException {
        return invoiceMapper.queryDefaultVat(userId);
    }

    @Override
    public List<OrderSnapshot> getInvoiceSnapshot(List<String> orderIds) throws ServiceException {
        return orderMapper.queryInvoiceSnapshot(orderIds);
	}
    
    @Override
    public void doNoInvoice(List<String> orderIds) throws ServiceException {
    	invoiceMapper.doNoInvoice(orderIds);
    }
    
	@Override
	public List<VatInfo> queryVatInfoList(VatInfo vatInfo) {
		return invoiceMapper.queryVatInfoList(vatInfo);
	}

	@Override
	public int queryVatInfoCount(VatInfo vatInfo) {
		return invoiceMapper.queryVatInfoCount(vatInfo);
	}

	@Override
	public List<ImageInfo> queryImageInfo(ImageInfo imageInfo) {
		return invoiceMapper.queryImageInfo(imageInfo);
	}

	@Override
	public void updateVatInfo(VatInfo vatInfo) {
		invoiceMapper.updateVatInfo(vatInfo);
	}

}
