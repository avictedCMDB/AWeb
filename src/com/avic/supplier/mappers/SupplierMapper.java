package com.avic.supplier.mappers;


import org.springframework.stereotype.Repository;

import com.avic.supplier.models.Supplier;


@Repository
public interface SupplierMapper {
	/**
	 * ��ѯ��ҳͳ������
	 * @return 
	 */
	public Supplier querySupplierMainCount(String supID);
}
