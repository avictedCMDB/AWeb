package com.avic.supervise.services;

import java.util.List;

import com.avic.common.exceptions.ServiceException;
import com.avic.supervise.models.ImageInfo;
import com.avic.supervise.models.Invoice;
import com.avic.supervise.models.OrderSnapshot;
import com.avic.supervise.models.VatInfo;

public interface InvoiceService {
    public int getInvoiceCount(String timeStart, String timeEnd, String orderId, String companyId, String invoiceStatus) throws ServiceException;
    public double getInvoiceStat(String timeStart, String timeEnd, String orderId, String companyId, String invoiceStatus) throws ServiceException;
    public List<Invoice> getInvoiceList(String timeStart, String timeEnd, String orderId, String companyId, String invoiceStatus, int page, int size) throws ServiceException;
    public Invoice getInvoiceDetail(String orderId) throws ServiceException;
    public void updateOrderInvoice(Invoice invoice) throws ServiceException;
    public VatInfo getDefaultVat(String userId) throws ServiceException;
    
    public List<OrderSnapshot> getInvoiceSnapshot(List<String> orderIds) throws ServiceException;
    
    public void doNoInvoice(List<String> orderIds) throws ServiceException;
    
    public List<VatInfo> queryVatInfoList(VatInfo vatInfo) ;
    public int queryVatInfoCount(VatInfo vatInfo) ;
    
    public List<ImageInfo> queryImageInfo(ImageInfo imageInfo);;
    
    public void updateVatInfo(VatInfo vatInfo);
}
