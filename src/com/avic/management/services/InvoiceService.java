package com.avic.management.services;

import java.util.List;

import com.avic.management.models.Invoice;

public interface InvoiceService {
	/**
	 * ��ѯ��Ʊ��Ϣ
	 * @return 
	 */
	public List<Invoice> queryInvoices(Invoice invoice);
	/**
	 * ���ݷ�Ʊid��ѯ��Ʊ��Ϣ
	 * @return 
	 */
	public Invoice queryInvoiceByInvoiceID(Invoice invoice);
	/**
	 * ���ӷ�Ʊ��Ϣ
	 * @return 
	 */
	public void addInvoice(Invoice invoice);
	/**
	 * �޸ķ�Ʊ��Ϣ
	 * @return 
	 */
	public void updateInvoice(Invoice invoice);
	/**
	 * ����Ĭ�Ϸ�Ʊ
	 * @return 
	 */
	public void setDefault(Invoice invoice);
	/**
	 * ȡ������Ĭ�Ϸ�Ʊ
	 * @return 
	 */
	public void setOtherDefault(Invoice invoice);
	/**
	 * ɾ����Ʊ��Ϣ
	 * @return 
	 */
	public void deleteInvoice(Invoice invoice);
	/**
	 * ��ѯ��Ʊ�б�����
	 * @return 
	 */
	public int queryInvoiceCount(Invoice invoice);
	
	public int checkInvoiceEx(Invoice invoice);
}