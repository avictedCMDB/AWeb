package com.avic.management.services;

import java.util.List;

import com.avic.management.models.Invoice;
import com.avic.management.models.VatSpecial;

public interface VatSpecialService {
	/**
	 * ��ѯ��Ʊ��Ϣ
	 * @return 
	 */
	public VatSpecial queryVatSpecial(VatSpecial vatSpecial);
	
	/**
	 * ������Ʊ��Ϣ
	 * @return 
	 */
	public void addVat(VatSpecial vatSpecial);
	/**
	 * �޸���Ʊ��Ϣ
	 * @return 
	 */
	public void updateVat(VatSpecial vatSpecial);
	/**
	 * ɾ����Ʊ��Ϣ
	 * @return 
	 */
	public void deleteVat(VatSpecial vatSpecial);
	/**
	 * ���ҵ��ͼƬid
	 * @return 
	 */
	public String queryVatIndex();
	/**
	 * �����Ʊ���״̬
	 * @return 
	 */
	public String queryVatStatus(VatSpecial vatSpecial);
	/**
	 * �޸���Ʊ״̬
	 * @return 
	 */
	public void updateVatAuditStatus(VatSpecial vatSpecial);
}