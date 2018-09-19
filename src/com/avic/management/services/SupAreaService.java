package com.avic.management.services;

import java.util.List;

import com.avic.management.models.SupArea;

public interface SupAreaService {
	/**
	 * 查询地区
	 * @return 
	 */
	public List<SupArea> queryAreas(SupArea supArea);
	/**
	 * 查询地区联动根据上级地区ID
	 * @return 
	 */
	public List<SupArea> querySubAreas(SupArea supArea);
	
	public List<SupArea> queryAllAreas(String supId);
	
	public String queryAreaNameById(String areaId);
}
