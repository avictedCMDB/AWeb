package com.avic.supplier.services;

import com.avic.supplier.models.SupplierUser;

public interface SupplierSupUserService {

	/**
	 * ��ѯ�˻���Ϣ
	 * @return 
	 */
	public SupplierUser queryLoginUser(SupplierUser supplierUser);
	
	public void updateSupPassWord(String password,String supId);
	
	public SupplierUser queryUserById(String userId);
	
	public SupplierUser queryCompUser(String code);
}
