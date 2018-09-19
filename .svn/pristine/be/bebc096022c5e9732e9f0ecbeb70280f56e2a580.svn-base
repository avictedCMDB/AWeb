package com.avic.market.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.market.models.Invoice;
import com.avic.market.models.VatInfo;

@Repository
public interface InvoiceMapper {
    public List<Invoice> queryUserInvoice(@Param("userId") String userId);
    public int queryDefaultInvoiceCount(@Param("userId") String userId);
    public void insertInvoice(Invoice invoice);
    public void updateInvoice(Invoice invoice);
    
    public Invoice queryDefaultUserInvoice(@Param("userId") String userId);
    public VatInfo queryUserVat(@Param("userId") String userId);
    
    public void updateVat(VatInfo vat);
}
