package com.avic.supplier.services;

import java.util.List;

import com.avic.supplier.models.SupArea;


public interface SupAreaService {
	/**
	 * ��ѯ��Ӧ����Ϣ
	 * @return 
	 */
	public List<SupArea> queryAreas(SupArea supArea);
	/**
	 * ��ѯ��Ӧ����Ϣ
	 * @return 
	 */
	public List<SupArea> querySubAreas(SupArea supArea);
}
