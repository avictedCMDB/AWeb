package com.avic.supplier.services;

import java.util.List;

import com.avic.supplier.models.SupArea;


public interface SupAreaService {
	/**
	 * 查询供应商信息
	 * @return 
	 */
	public List<SupArea> queryAreas(SupArea supArea);
	/**
	 * 查询供应商信息
	 * @return 
	 */
	public List<SupArea> querySubAreas(SupArea supArea);
}
