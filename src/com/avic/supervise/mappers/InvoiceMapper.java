package com.avic.supervise.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.common.exceptions.ServiceException;
import com.avic.supervise.models.ImageInfo;
import com.avic.supervise.models.Invoice;
import com.avic.supervise.models.VatInfo;

@Repository
public interface InvoiceMapper {
    public int queryInvoiceCount(@Param("timeStart") String timeStart, @Param("timeEnd") String timeEnd, @Param("orderId") String orderId, @Param("companyId") String companyId, @Param("invoiceStatus") String invoiceStatus);
    public double queryInvoiceStat(@Param("timeStart") String timeStart, @Param("timeEnd") String timeEnd, @Param("orderId") String orderId, @Param("companyId") String companyId, @Param("invoiceStatus") String invoiceStatus);
    public List<Invoice> queryInvoiceList(@Param("timeStart") String timeStart, @Param("timeEnd") String timeEnd, @Param("orderId") String orderId, @Param("companyId") String companyId, @Param("invoiceStatus") String invoiceStatus, @Param("start") int start, @Param("end") int end);
    public Invoice queryInvoiceDetail(@Param("orderId") String orderId);
    public void updateOrderInvoice(@Param("invoice") Invoice invoice, @Param("orderIds") List<String> orderIds);
    public VatInfo queryDefaultVat(@Param("userId") String userId);
    
    public List<VatInfo> queryVatInfoList(VatInfo vatInfo) ;
    public int queryVatInfoCount(VatInfo vatInfo) ;
    public List<ImageInfo> queryImageInfo(ImageInfo imageInfo);
    
    public void updateVatInfo(VatInfo vatInfo);
    public void doNoInvoice(List<String> orderIds) throws ServiceException;
}
