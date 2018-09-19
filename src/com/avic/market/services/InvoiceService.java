package com.avic.market.services;

import java.util.List;

import com.avic.common.exceptions.ServiceException;
import com.avic.market.models.Invoice;
import com.avic.market.models.VatInfo;

public interface InvoiceService {
    public List<Invoice> getUserInvoice(String userId) throws ServiceException;
    public void addInvoice(Invoice invoice) throws ServiceException;
    
    public Invoice getDefaultUserInvoice(String userId) throws ServiceException;
    public VatInfo getUserVat(String userId) throws ServiceException;
    
    public void updateVat(VatInfo vat) throws ServiceException;
}
