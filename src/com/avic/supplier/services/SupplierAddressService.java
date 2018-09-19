package com.avic.supplier.services;

import java.util.List;

import com.avic.supplier.models.SupplierAddress;

public interface SupplierAddressService {
	
	/**
	 * ��ѯ��ַ�б�
	 * @return 
	 */
	public List<SupplierAddress> querySupplierAddressList(SupplierAddress supplierAddress);
	
	public Integer querySupplierAddressListCount(SupplierAddress supplierAddress);
	
	/**
	 * �鿴��ַ
	 * @return 
	 */
	public SupplierAddress querySupplierAddress(String supAddressId);
	
	/**
	 * ɾ����ַ
	 * @return 
	 */
	public void deleteSupplierAddress(String supAddressId);
	/**
	 * ����Ĭ�ϵ�ַ
	 * @return 
	 */
	public void updateSupplierAddress(SupplierAddress supplierAddress);
	/**
	 * ���ӵ�ַ
	 * @return 
	 */
	public void insertSupplierAddress(SupplierAddress supplierAddress);
	
	/**
	 * ��ѯ��Ӧ������
	 * @return
	 */
	public String querySupplierIndex();
	
}