package com.avic.management.services;

import java.util.List;

import com.avic.management.models.Invoice;

public interface InvoiceService {
	/**
	 * 查询发票信息
	 * @return 
	 */
	public List<Invoice> queryInvoices(Invoice invoice);
	/**
	 * 根据发票id查询发票信息
	 * @return 
	 */
	public Invoice queryInvoiceByInvoiceID(Invoice invoice);
	/**
	 * 添加发票信息
	 * @return 
	 */
	public void addInvoice(Invoice invoice);
	/**
	 * 修改发票信息
	 * @return 
	 */
	public void updateInvoice(Invoice invoice);
	/**
	 * 设置默认发票
	 * @return 
	 */
	public void setDefault(Invoice invoice);
	/**
	 * 取消其他默认发票
	 * @return 
	 */
	public void setOtherDefault(Invoice invoice);
	/**
	 * 删除发票信息
	 * @return 
	 */
	public void deleteInvoice(Invoice invoice);
	/**
	 * 查询发票列表数量
	 * @return 
	 */
	public int queryInvoiceCount(Invoice invoice);
	
	public int checkInvoiceEx(Invoice invoice);
}
